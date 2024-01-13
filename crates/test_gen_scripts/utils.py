import random
import string
import os
from hashlib import sha256
from ecdsa import SigningKey, NIST256p, util
from deterministic_generator import generate_next_seed


def generate_deterministic_key(seed: bytes):
    if seed is not None:
        rng = DeterministicPRNG(seed)
    else:
        rng = os.urandom

    sk = SigningKey.generate(curve=NIST256p, entropy=rng)
    return sk


class DeterministicPRNG:
    def __init__(self, seed):
        self.seed = seed

    def __call__(self, n):
        hash_value = sha256(self.seed).digest()
        return hash_value[:n]


def get_good_signature(message: bytes, hash=False):
    sk = generate_deterministic_key(generate_next_seed())
    vk = sk.get_verifying_key()

    signature = (
        sk.sign_deterministic(message, hashfunc=sha256)
        if hash
        else sk.sign_deterministic(message, hashfunc=my_hash)
    )

    (px, py) = (vk.pubkey.point.x(), vk.pubkey.point.y())
    r, s = util.sigdecode_string(signature, sk.curve.order)

    return (px, py, r, s)


def get_raw_signature(message: bytes, sk):
    sk = generate_deterministic_key(generate_next_seed())
    vk = sk.get_verifying_key()
    sig = sk.sign_deterministic(message, hashfunc=sha256)
    (px, py) = (vk.pubkey.point.x(), vk.pubkey.point.y())
    return (sig, px, py)


def get_random_string(a: int, b: int):
    characters = string.ascii_letters + string.digits
    return "".join(random.choice(characters) for _ in range(random.randint(a, b)))


def iterable_as_cairo_array(iterable, name: str = "msg", type: str = "u8") -> str:
    declare = [f"let mut {name}: Array<{type}> = ArrayTrait::new();"]
    lines = [f"{name}.append({b});" for b in iterable]
    return "\n".join(declare + lines) + "\n"


def assert_option_is_some(value: str) -> str:
    return """match {option_value} {{
    Option::Some(_) => (),
    Option::None => assert(false, 'Should be Some')
}};
""".format(
        option_value=value
    )


def assert_option_is_none(value: str) -> str:
    return """match {option_value} {{
    Option::Some(_) => assert(false, 'Should be None!'),
    Option::None => ()
}};
""".format(
        option_value=value
    )


# Dummy hash function returning an object of class IdentityHasher
def my_hash(message=b""):
    return IdentityHasher(message)


class IdentityHasher:
    block_size = 64
    val: bytes

    def __init__(self, val=b"") -> None:
        self.val = val

    def update(self, val):
        self.val += val

    def digest(self):
        return self.val

    def hexdigest(self):
        return self.val.hex()

    @property
    def digest_size(self):
        return len(self.val)

    def copy(self):
        return IdentityHasher(self.val)

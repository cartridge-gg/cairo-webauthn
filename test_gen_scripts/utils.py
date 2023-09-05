import random
import string
from hashlib import sha256
from ecdsa import SigningKey, NIST256p, util
import os

RANDOM_GENERATOR_SEED_BASE = 1

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
    
def generate_next_seed():
    global RANDOM_GENERATOR_SEED_BASE
    RANDOM_GENERATOR_SEED_BASE += 1
    return RANDOM_GENERATOR_SEED_BASE.to_bytes(1, 'big')

def get_good_signature(message: bytes, hash=False):
    sk = generate_deterministic_key(generate_next_seed())
    vk = sk.get_verifying_key()

    signature = (
        sk.sign_deterministic(message, hashfunc=sha256)
        if hash
        else sk.sign(message, hashfunc=my_hash, allow_truncate=False)
    )
    
    (px, py) = (vk.pubkey.point.x(), vk.pubkey.point.y())
    r, s = util.sigdecode_string(signature, sk.curve.order)

    print(s)

    return (px, py, r, s)

def get_raw_signature(message: bytes):
    seed = generate_next_seed()
    sk = generate_deterministic_key(seed)
    vk = sk.get_verifying_key()
    sig = sk.sign(message, hashfunc=sha256)
    (px, py) = (vk.pubkey.point.x(), vk.pubkey.point.y())
    return (sig, px, py)


def get_random_string(a: int, b: int):
    characters = string.ascii_letters + string.digits
    return "".join(random.choice(characters) for _ in range(random.randint(a, b)))


def bytes_as_cairo_array(bytes: bytes, name: str = "msg") -> str:
    declare = [f"let mut {name}: Array<u8> = ArrayTrait::new();"]
    lines = [f"{name}.append({hex(b)});" for b in bytes]
    return "\n".join(declare + lines) + "\n"


# Dummy hash function returning a mock of a digestable object
def my_hash(message):
    return Digestable(message)


class Digestable:
    def __init__(self, val) -> None:
        self.val = val

    def digest(self):
        return self.val

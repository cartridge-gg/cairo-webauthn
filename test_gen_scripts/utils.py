from hashlib import sha256
from ecdsa import SigningKey, NIST256p, util


def get_good_signature(message: bytes, hash=False):
    sk = SigningKey.generate(curve=NIST256p)
    vk = sk.get_verifying_key()

    signature = (
        sk.sign(message, hashfunc=sha256)
        if hash
        else sk.sign(message, hashfunc=my_hash, allow_truncate=False)
    )

    (px, py) = (vk.pubkey.point.x(), vk.pubkey.point.y())
    r, s = util.sigdecode_string(signature, sk.curve.order)

    return (px, py, r, s)


def get_msg_as_cairo_array(msg: bytes) -> str:
    declare = ["let mut msg: Array<u8> = ArrayTrait::new();"]
    lines = [f"msg.append({hex(b)});" for b in msg]
    return "\n".join(declare + lines)


# Dummy hash function returning a mock of a digestable object
def my_hash(message):
    return Digestable(message)


class Digestable:
    def __init__(self, val) -> None:
        self.val = val

    def digest(self):
        return self.val

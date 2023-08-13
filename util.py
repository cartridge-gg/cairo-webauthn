from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import ec

from asn1crypto.core import Sequence, Integer

def decode_der_signature(signature):
    sequence = Sequence.load(signature)
    r = sequence[0].native
    s = sequence[1].native
    return r, s

import hashlib

def hash_message(message: bytes) -> bytes:
    return hashlib.sha256(message).digest()

def bytes_to_int(bytes_value: bytes) -> int:
    return int.from_bytes(bytes_value, 'big')


# Generate a new private key
private_key = ec.generate_private_key(ec.SECP256R1())
public_key = private_key.public_key()


message = b"T"

from cryptography.hazmat.primitives.asymmetric import utils as asym_utils
signature = private_key.sign(message, ec.ECDSA(hashes.SHA256()))
r, s = decode_der_signature(signature)

print()
print(f"Public key: {public_key.public_numbers().x}, {public_key.public_numbers().y}")
print()
print(f"r: {r}, s:{s}")
print()
print(f"msg: {message}")

public_key.verify(signature, message, ec.ECDSA(hashes.SHA256()))  # T

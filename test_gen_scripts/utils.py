from ecdsa import SigningKey, NIST256p, util

def get_good_signature(message: str):
    # 1. Generate keys and sign the message
    sk = SigningKey.generate(curve=NIST256p)
    vk = sk.get_verifying_key()

    signature = sk.sign(
        message, 
        hashfunc=my_hash, 
        allow_truncate=False
    )

    # 2. Extract the public key point
    (px, py) = (vk.pubkey.point.x(), vk.pubkey.point.y())

    # 3. Extract r and s values
    r, s = util.sigdecode_string(signature, sk.curve.order)
    return (px, py, r, s)


# Dummy hash function returning a mock of a digestable object
def my_hash(message):
    return Digestable(message)    

class Digestable:
    def __init__(self, val) -> None:
        self.val = val
    def digest(self):
        return self.val

from starkware.starknet.core.os.transaction_hash.transaction_hash import (
    TransactionHashPrefix,
    calculate_transaction_hash_common
)
from starkware.starknet.definitions.general_config import StarknetChainId
from starkware.starknet.public.abi import get_selector_from_name
from nile.signer import from_call_to_call_array
from ecdsa import SigningKey, NIST256p
from base64 import urlsafe_b64encode
import hashlib

TRANSACTION_VERSION = 1

def from_call_to_call_array(calls):
    """Transform from Call to CallArray."""
    call_array = []
    calldata = []
    for _, call in enumerate(calls):
        assert len(call) == 3, "Invalid call parameters"
        entry = (
            call[0],
            get_selector_from_name(call[1]),
            len(calldata),
            len(call[2]),
        )
        call_array.append(entry)
        calldata.extend(call[2])
    return (call_array, calldata)

def get_transaction_hash(prefix, account, calldata, nonce, max_fee):
    """Compute the hash of a transaction."""
    return calculate_transaction_hash_common(
        tx_hash_prefix=prefix,
        version=TRANSACTION_VERSION,
        contract_address=account,
        entry_point_selector=0,
        calldata=calldata,
        max_fee=max_fee,
        chain_id=StarknetChainId.TESTNET.value,
        additional_data=[nonce],
    )

def bytes_to_base64url(val: bytes) -> str:
    """
    Base64URL-encode the provided bytes
    """
    return urlsafe_b64encode(val).decode("utf-8").replace("=", "")

def sigencode(r, s, order):
    return (r, s)

BASE = 2 ** 86

class WebauthnSigner():
    def __init__(self):
        self.signing_key = SigningKey.generate(curve=NIST256p)
        pt = self.signing_key.verifying_key.pubkey.point
        x0, x1, x2 = split(pt.x())
        y0, y1, y2 = split(pt.y())

        self.public_key = (x0, x1, x2, y0, y1, y2)

    async def send_transaction(self, account, to, selector_name, calldata, nonce=None, max_fee=0):
        return await self.send_transactions(account, [(to, selector_name, calldata)], nonce, max_fee)

    def sign_transaction(self, origin, contract_address, call_array, calldata, nonce, max_fee):
        message_hash = get_transaction_hash(
            TransactionHashPrefix.INVOKE, contract_address, calldata, nonce, max_fee
        )

        challenge_bytes = message_hash.to_bytes(
            32, byteorder="big")
        # We can add arbitrary bytes after the challenge for the RP challenge
        challenge_bytes = challenge_bytes + b"\x00" + b"\x00" + b"\x00" + b"\x00"

        challenge = bytes_to_base64url(challenge_bytes)
        challenge_parts = [int.from_bytes(challenge_bytes[i:i+3], 'big') for i in range(0, len(challenge_bytes), 3)]
        client_data_json = f"""{{"type":"webauthn.get","challenge":"{challenge}","origin":"{origin}","crossOrigin":false}}"""
        client_data_bytes = client_data_json.encode("ASCII")

        client_data_hash = hashlib.sha256()
        client_data_hash.update(client_data_bytes)
        client_data_hash_bytes = client_data_hash.digest()

        client_data_rem = 4 - (len(client_data_bytes) % 4)
        if client_data_rem == 4:
            client_data_rem = 0
        if client_data_rem != 0:
            for _ in range(client_data_rem):
                client_data_bytes = client_data_bytes + b'\x00'

        authenticator_data_bytes = bytes.fromhex("20a97ec3f8efbc2aca0cf7cabb420b4a09d0aec9905466c9adf79584fa75fed30500000000")
        authenticator_data_rem = 4 - len(authenticator_data_bytes) % 4
        if authenticator_data_rem == 4:
            authenticator_data_rem = 0

        (r, s) = self.signing_key.sign(authenticator_data_bytes + client_data_hash_bytes, hashfunc=hashlib.sha256, sigencode=sigencode)
        r0, r1, r2 = split(r)
        s0, s1, s2 = split(s)

        authenticator_data = [int.from_bytes(authenticator_data_bytes[i:i+4], 'big') for i in range(0, len(authenticator_data_bytes), 4)]
        client_data_json = [int.from_bytes(client_data_bytes[i:i+4], 'big') for i in range(0, len(client_data_bytes), 4)]

        challenge_offset_len = 9
        challenge_offset_rem = 0
        challenge_len = len(challenge_parts)
        challenge_rem = len(challenge_parts) % 3

        # the hash and signature are returned for other tests to use
        return [
            r0, r1, r2,
            s0, s1, s2,
            challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem,
            len(client_data_json), client_data_rem, client_data_json,
            len(authenticator_data), authenticator_data_rem, authenticator_data,
        ]

    async def send_transactions(self, account, calls, nonce=None, max_fee=0):
        if nonce is None:
            execution_info = await account.get_nonce().call()
            nonce, = execution_info.result
        
        build_calls = []
        for call in calls:
            build_call = list(call)
            build_call[0] = hex(build_call[0])
            build_calls.append(build_call)

        (call_array, calldata) = from_call_to_call_array(build_calls)

        signature = self.sign_transaction(account.contract_address, call_array, calldata, nonce, max_fee)

        # the hash and signature are returned for other tests to use
        return await account.__execute__(call_array, calldata, nonce).invoke(
            signature=signature
        )

def split(G):
    x = divmod(G, BASE)
    y = divmod(x[0], BASE)

    G0 = x[1]
    G1 = y[1]
    G2 = y[0]

    return (G0, G1, G2)

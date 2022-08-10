from nile.signer import from_call_to_call_array, get_transaction_hash
from fastecdsa import curve, ecdsa, keys
import hashlib

BASE = 2 ** 86

class P256Signer():
    def __init__(self):
        private_key = keys.gen_private_key(curve.P256)
        pt = keys.get_public_key(private_key, curve.P256)
        x0, x1, x2 = split(pt.x)
        y0, y1, y2 = split(pt.y)

        self.public_key = (x0, x1, x2, y0, y1, y2)
        self.private_key = private_key

    async def send_transaction(self, account, to, selector_name, calldata, nonce=None, max_fee=0):
        return await self.send_transactions(account, [(to, selector_name, calldata)], nonce, max_fee)

    def sign_transaction(self, contract_address, call_array, calldata, nonce, max_fee):
        message_hash = get_transaction_hash(
            contract_address, call_array, calldata, nonce, max_fee
        )

        challenge_bytes = message_hash.to_bytes(
            32, byteorder="big")
        challenge = challenge_bytes.hex()
        challenge_parts = [int.from_bytes(challenge_bytes[i:i+4], 'big') for i in range(0, len(challenge_bytes), 4)]
        print("challenge", challenge)
        print("challenge_parts", challenge_parts)
        client_data_json = f"""{{"type":"webauthn.get","challenge":"{message_hash}","origin":"https://cartridge.gg","crossOrigin":false}}"""
        print(client_data_json)
        client_data_bytes = client_data_json.encode()

        client_data_hash = hashlib.sha256()
        client_data_hash.update(client_data_bytes)
        client_data_hash_bytes = client_data_hash.digest()

        client_data_rem = len(client_data_bytes) % 4
        for _ in range(4 - client_data_rem):
            client_data_bytes = client_data_bytes + b'\x00'

        authenticator_data_bytes = bytes.fromhex("20a97ec3f8efbc2aca0cf7cabb420b4a09d0aec9905466c9adf79584fa75fed30500000000")
        authenticator_data_rem = len(authenticator_data_bytes) % 4

        msg_data = authenticator_data_bytes + client_data_hash_bytes
        msg_data_hash = hashlib.sha256()
        msg_data_hash.update(msg_data)
        msg_data_hash_bytes = msg_data_hash.digest()
        print(msg_data_hash_bytes.hex())

        r, s = ecdsa.sign(authenticator_data_bytes + client_data_hash_bytes, self.private_key, curve.P256)
        r0, r1, r2 = split(r)
        s0, s1, s2 = split(s)

        authenticator_data = [int.from_bytes(authenticator_data_bytes[i:i+4], 'big') for i in range(0, len(authenticator_data_bytes), 4)]
        client_data_json = [int.from_bytes(client_data_bytes[i:i+4], 'big') for i in range(0, len(client_data_bytes), 4)]

        print("authenticator_data_len: ", len(authenticator_data), "authenticator_data_rem: ", authenticator_data_rem, "authenticator_data: ", authenticator_data)
        print("client_data_json_len: ", len(client_data_json), "client_data_json_rem: ", client_data_rem, "client_data_json: ", client_data_json)

        challenge_offset_len = 9
        challenge_offset_rem = 1
        challenge_len = len(challenge_parts)
        challenge_rem = len(challenge_parts) % 4

        print("r", r0, r1, r2)
        print("s", s0, s1, s2)

        print("challenge_len", challenge_len, "challenge_rem", challenge_rem)

        # the hash and signature are returned for other tests to use
        return [
            r0, r1, r2,
            s0, s1, s2,
            challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem,
            len(client_data_json), client_data_rem, *client_data_json,
            len(authenticator_data), authenticator_data_rem, *authenticator_data,
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

# 0750abcc093eae5d505d5a09141d53132dda4d1451f68ecaf0dbbc0597b05224
# challenge_parts [122727372, 155102813, 1348295177, 337466131, 769281300, 1375112906, 4040932357, 2544914980]
# 8da09f27898768c8642e82bfb92f072aee8b534e48bfc8b9f80aa190161094a4
# authenticator_data_len:  10 authenticator_data_rem:  1 authenticator_data:  [547978947, 4176460842, 3389847498, 3141667658, 164671177, 2421450441, 2918684036, 4202036947, 83886080, 0]
# client_data_json_len:  39 client_data_json_rem:  2 client_data_json:  [2065855609, 1885676090, 578250082, 1635087464, 1848534885, 1948396578, 1667785068, 1818586727, 1696741922, 808924464, 1633837923, 809055077, 1634022756, 892351844, 895561785, 825504100, 892547379, 845440097, 878981428, 892429878, 946168673, 1714447458, 1650667573, 959930928, 892482100, 573317743, 1919510377, 1847736866, 1752462448, 1933193007, 1667330676, 1919509607, 1697539943, 573317731, 1919906675, 1332898151, 1768825402, 1717660787, 1702690816]
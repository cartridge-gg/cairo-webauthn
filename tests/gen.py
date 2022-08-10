from webauthn.helpers import base64url_to_bytes, bytes_to_base64url, decode_credential_public_key
from pyasn1.codec.der.decoder import decode as der_decoder
from pyasn1.type.univ import Sequence
from pyasn1.type.univ import Integer
from pyasn1.type.namedtype import NamedTypes
from pyasn1.type.namedtype import NamedType
import binascii
import hashlib

BASE = 2 ** 86

class DERSig(Sequence):
    componentType = NamedTypes(
        NamedType('r', Integer()),
        NamedType('s', Integer())
    )

def split(G):
    x = divmod(G, BASE)
    y = divmod(x[0], BASE)

    G0 = x[1]
    G1 = y[1]
    G2 = y[0]

    return (G0, G1, G2)

HEAD = """
%lang starknet
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.alloc import alloc

from src.ec import EcPoint
from src.bigint import BigInt3

from src.webauthn import Webauthn
"""

TEST_CASE = """
@external
func test_{title}{{syscall_ptr : felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}}():
    let public_key_pt = EcPoint(
        BigInt3({x0},{x1},{x2}),
        BigInt3({y0},{y1},{y2}),
    )
    let r = BigInt3({r0},{r1},{r2})
    let s = BigInt3({s0},{s1},{s2})

    let type_offset_len = 2
    let type_offset_rem = 1

    let challenge_offset_len = {challenge_offset_len}
    let challenge_offset_rem = {challenge_offset_rem}
    let challenge_len = {challenge_len}
    let challenge_rem = {challenge_rem}
    let (challenge) = alloc()
{challenge}

    let origin_offset_len = 28
    let origin_offset_rem = 2
    let origin_len = 13
    let (origin) = alloc()
    assert origin[0] = 1752462448
    assert origin[1] = 1933193007
    assert origin[2] = 1668247156
    assert origin[3] = 1919904876
    assert origin[4] = 1701981541
    assert origin[5] = 825454708
    assert origin[6] = 964130678
    assert origin[7] = 779121253
    assert origin[8] = 1986618743
    assert origin[9] = 778264946
    assert origin[10] = 1953655140
    assert origin[11] = 1734684263
    assert origin[12] = 103

    let client_data_json_len = {client_data_json_len}
    let client_data_json_rem = {client_data_json_rem}
    let (client_data_json) = alloc()
{client_data_json}

    let authenticator_data_len = {authenticator_data_len}
    let authenticator_data_rem = {authenticator_data_rem}
    let (authenticator_data) = alloc()
{authenticator_data}

    Webauthn.verify(public_key_pt, r, s,
        type_offset_len, type_offset_rem,
        challenge_offset_len, challenge_offset_rem, challenge_len, challenge_rem, challenge,
        origin_offset_len, origin_offset_rem, origin_len, origin,
        client_data_json_len, client_data_json_rem, client_data_json,
        authenticator_data_len, authenticator_data_rem, authenticator_data
    )

    return ()
end
"""

data = [{
    'pubkey': "pQECAyYgASFYIPofnDyxJWqz1XWBumSQ5qEeUQ3Wfaug1hXgVAoXO0S/Ilggl5qh3cisV9IZ+Y9Z8I1jqMH09TOtRxTwPxc9X4cJpwc=",
    'challenge': b"0x044e3adc845e501b01c6904dd2b0cd0d084bb01240966d39c3165481dfcae65w",
    'authenticator_data': "20a97ec3f8efbc2aca0cf7cabb420b4a09d0aec9905466c9adf79584fa75fed30500000000",
    # {"type":"webauthn.get","challenge":"0x044e3adc845e501b01c6904dd2b0cd0d084bb01240966d39c3165481dfcae65w","origin":"https://controller-e13pt9wwv.preview.cartridge.gg","crossOrigin":false}
    'client_data': "7b2274797065223a22776562617574686e2e676574222c226368616c6c656e6765223a22307830343465336164633834356535303162303163363930346464326230636430643038346262303132343039363664333963333136353438316466636165363577222c226f726967696e223a2268747470733a2f2f636f6e74726f6c6c65722d6531337074397777762e707265766965772e6361727472696467652e6767222c2263726f73734f726967696e223a66616c73657d",
    'signature': "3045022024c32f5128206df9fa8102e0f7a2a908b8cae76fee717d50ecaa95eeb125199302210096f6daa99ca841cc5064d72b1f9d6f11154909cf7b324312b82f2cc8736728c3"
}, {
    'pubkey': "pQECAyYgASFYILy4sqBJQupsn3ttx5Af1lK8i75VKbji6u5EqOVkHzUaIlggABPNyK5iEFpOWlFjtoZuW8rVDoLLTIar7jFXqGIVaZU=",
    'challenge': b"0xb144c903c4d9b0bb5d6526b8ca03380b82a28283562f98f6f14a2298052463",
    'authenticator_data': "20a97ec3f8efbc2aca0cf7cabb420b4a09d0aec9905466c9adf79584fa75fed30500000000",
    'client_data': "7b2274797065223a22776562617574686e2e676574222c226368616c6c656e6765223a2230786231343463393033633464396230626235643635323662386361303333383062383261323832383335363266393866366631346132323938303532343633222c226f726967696e223a2268747470733a2f2f636f6e74726f6c6c65722d6769742d74617272656e63652d656e672d3139352d63726564656e7469616c2d726567697374726174696f6e2d3937363639372e707265766965772e6361727472696467652e6767222c2263726f73734f726967696e223a66616c73657d",
    'signature': "30440220513f88733910b29d0c153d12528efde67c76ad40ebded620295e9b2cbc4df9fb02201b6daf037a627ea8ae446305052c473824c5b88097deb233a30a2ea5236db97a"
}]

output = open("tests/test_webauthn_gen.cairo", "w")

test = HEAD

for i, item in enumerate(data):
    pubkey = decode_credential_public_key(base64url_to_bytes(item["pubkey"]))
    authenticator_data_bytes = bytes.fromhex(item["authenticator_data"])
    client_data_bytes = bytes.fromhex(item["client_data"])
    challenge = item["challenge"]

    x0, x1, x2 = split(int.from_bytes(pubkey.x, "big"))
    y0, y1, y2 = split(int.from_bytes(pubkey.y, "big"))

    client_data_hash = hashlib.sha256()
    client_data_hash.update(client_data_bytes)
    client_data_hash_bytes = client_data_hash.digest()

    client_data_rem = len(client_data_bytes) % 4
    for _ in range(4 - client_data_rem):
        client_data_bytes = client_data_bytes + b'\x00'

    authenticator_data_rem = len(authenticator_data_bytes) % 4

    authenticator_data = [int.from_bytes(authenticator_data_bytes[i:i+4], 'big') for i in range(0, len(authenticator_data_bytes), 4)]
    client_data_json_parts = [int.from_bytes(client_data_bytes[i:i+4], 'big') for i in range(0, len(client_data_bytes), 4)]

    sig, rest = der_decoder(binascii.unhexlify(item["signature"]), asn1Spec=DERSig())
    if len(rest) != 0:
        raise Exception('Bad encoding')

    r0, r1, r2 = split(int(sig['r']))
    s0, s1, s2 = split(int(sig['s']))

    authenticator_data_parts = [int.from_bytes(authenticator_data_bytes[i:i+4], 'big') for i in range(0, len(authenticator_data_bytes), 4)]
    challenge_parts = [int.from_bytes(challenge[i:i+4], 'big') for i in range(0, len(challenge), 4)]

    origin = b'https://controller-e13pt9wwv.preview.cartridge.gg'
    origin_parts = [int.from_bytes(origin[i:i+4], 'big') for i in range(0, len(origin), 4)]
    origin_offset_bytes = client_data_bytes.find(b'"origin":"') + len(b'"origin":"')

    type = b'webauthn.get'
    type_parts = [int.from_bytes(type[i:i+4], 'big') for i in range(0, len(type), 4)]
    type_offset_bytes = client_data_bytes.find(b'"type":"') + len(b'"type":"')

    challenge_offset_bytes = client_data_bytes.find(b'"challenge":"') + len(b'"challenge":"')

    # print("x", x0, x1, x2)
    # print("y", y0, y1, y2)
    # print("r", r0, r1, r2)
    # print("s", s0, s1, s2)
    # print("callenge_rem", (len(item["challenge"]) % 4))
    # print("challenge_parts_len", len(challenge_parts))
    # print("challenge_parts", challenge_parts)
    # print("challenge_offset_len", challenge_offset_bytes // 4)
    # print("challenge_offset_rem", challenge_offset_bytes % 4)
    # print("origin_offset_len", origin_offset_bytes // 4)
    # print("origin_offset_rem", origin_offset_bytes % 4)
    # print("origin_len", len(origin_parts))
    # print("origin", origin_parts)
    # print("type_parts", type_parts)
    # print("type_offset_len", type_offset_bytes // 4)
    # print("type_offset_rem", type_offset_bytes % 4)
    # print("client_dat_json", client_data_bytes)
    # print("client_data_json_parts", client_data_json_parts)
    # print("client_data_json_len", len(client_data_json))
    # print("client_data_json_rem", client_data_rem)
    # print("authenticator_data_parts", authenticator_data_parts)
    # print("authenticator_data_len", len(authenticator_data_parts))
    # print("authenticator_data_rem", authenticator_data_rem)
    # print("\n\n")

    challenge_offset_len = challenge_offset_bytes // 4
    challenge_offset_rem = challenge_offset_bytes % 4
    challenge_len = len(challenge_parts)
    challenge_rem = len(challenge) % 4
    challenge = ""
    for j, c in enumerate(challenge_parts):
        challenge += "    assert challenge[{}] = {}\n".format(j, c)

    client_data_json_len=len(client_data_json_parts)
    client_data_json_rem=client_data_rem
    client_data_json = ""
    for j, c in enumerate(client_data_json_parts):
        client_data_json += "    assert client_data_json[{}] = {}\n".format(j, c)

    authenticator_data_len=len(authenticator_data_parts)
    authenticator_data_rem=authenticator_data_rem
    authenticator_data=""
    for j, c in enumerate(authenticator_data_parts):
        authenticator_data += "    assert authenticator_data[{}] = {}\n".format(j, c)

    test += TEST_CASE.format(
        title=i,
        # expect_revert=expect_revert,
        x0=x0,
        x1=x1,
        x2=x2,
        y0=y0,
        y1=y1,
        y2=y2,
        r0=r0,
        r1=r1,
        r2=r2,
        s0=s0,
        s1=s1,
        s2=s2,
        challenge_offset_len=challenge_offset_len,
        challenge_offset_rem=challenge_offset_rem,
        challenge_len=challenge_len,
        challenge_rem=challenge_rem,
        challenge=challenge,
        client_data_json_len=client_data_json_len,
        client_data_json_rem=client_data_json_rem,
        client_data_json=client_data_json,
        authenticator_data_len=authenticator_data_len,
        authenticator_data_rem=authenticator_data_rem,
        authenticator_data=authenticator_data
    )

output.write(test)
output.close()
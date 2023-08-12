from starkware.starknet.core.os.transaction_hash.transaction_hash import TransactionHashPrefix
from webauthn.helpers import base64url_to_bytes, bytes_to_base64url, decode_credential_public_key, decoded_public_key_to_cryptography, verify_signature
from pyasn1.codec.der.decoder import decode as der_decoder
from pyasn1.codec.der.encoder import encode as der_encoder
from pyasn1.type.univ import Sequence
from pyasn1.type.univ import Integer
from pyasn1.type.namedtype import NamedTypes
from pyasn1.type.namedtype import NamedType
from pyasn1.type import univ

import binascii
import hashlib

from signer import WebauthnSigner, from_call_to_call_array, get_transaction_hash

BASE = 2 ** 86


def ASN1Sequence(*vals):
    seq = univ.Sequence()
    for i in range(len(vals)):
        seq.setComponentByPosition(i, vals[i])
    return seq


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


def combine(G0, G1, G2):
    return ((G2 * BASE) + G1) * BASE + G0


HEAD = """
use core::option::OptionTrait;
use core::result::ResultTrait;

use webauthn::webauthn::verify;
use array::ArrayTrait;
use starknet::secp256r1::Secp256Trait;
use starknet::secp256r1::Secp256r1Point;

"""

TEST_CASE = """
#[test]
#[available_gas(20000000000)]
fn test_{title}() {{
    let public_key_pt: Result<Option<Secp256r1Point>> = Secp256Trait::secp256_ec_new_syscall(0, 0);
    let public_key_pt: Secp256r1Point = public_key_pt.unwrap().unwrap();
    let r : u256 = {param_r};
    let s : u256 = {param_s};

    let type_offset = 9_usize;

    let challenge_offset = {challenge_offset};
    let mut challenge = ArrayTrait::<u8>::new();
{challenge}

    let origin_offset = 91;
    let mut origin = ArrayTrait::<u8>::new();
    origin.append(0x68);
    origin.append(0x74);
    origin.append(0x74);
    origin.append(0x70);
    origin.append(0x73);
    origin.append(0x3A);
    origin.append(0x2F);
    origin.append(0x2F);
    origin.append(0x63);
    origin.append(0x6F);
    origin.append(0x6E);
    origin.append(0x74);
    origin.append(0x72);
    origin.append(0x6F);
    origin.append(0x6C);
    origin.append(0x6C);
    origin.append(0x65);
    origin.append(0x72);
    origin.append(0x2D);
    origin.append(0x65);
    origin.append(0x31);
    origin.append(0x33);
    origin.append(0x70);
    origin.append(0x74);
    origin.append(0x39);
    origin.append(0x77);
    origin.append(0x77);
    origin.append(0x76);
    origin.append(0x2E);
    origin.append(0x70);
    origin.append(0x72);
    origin.append(0x65);
    origin.append(0x76);
    origin.append(0x69);
    origin.append(0x65);
    origin.append(0x77);
    origin.append(0x2E);
    origin.append(0x63);
    origin.append(0x61);
    origin.append(0x72);
    origin.append(0x74);
    origin.append(0x72);
    origin.append(0x69);
    origin.append(0x64);
    origin.append(0x67);
    origin.append(0x65);
    origin.append(0x2E);
    origin.append(0x67);
    origin.append(0x67);

    let mut client_data_json = ArrayTrait::<u8>::new();
{client_data_json}

    let mut authenticator_data = ArrayTrait::<u8>::new();
{authenticator_data}

    let verify_result = verify(public_key_pt, r, s,
        type_offset,
        challenge_offset,
        origin_offset,
        client_data_json,
        challenge,
        origin,
        authenticator_data
    );
    match verify_result {{
        Result::Ok => (),
        Result::Err(m) => assert(false, m)
    }}

    return ();
}}
"""

data = [{
    # b'{"type":"webauthn.get","challenge":"ALFEyQPE2bC7XWUmuMoDOAuCooKDVi-Y9vFKIpgFJGM","origin":"https://controller-git-tarrence-eng-195-credential-registration-976697.preview.cartridge.gg","crossOrigin":false}'
    'pubkey': "pQECAyYgASFYILy4sqBJQupsn3ttx5Af1lK8i75VKbji6u5EqOVkHzUaIlggABPNyK5iEFpOWlFjtoZuW8rVDoLLTIar7jFXqGIVaZU=",
    'challenge': "ALFEyQPE2bC7XWUmuMoDOAuCooKDVi-Y9vFKIpgFJGM",
    'authenticator_data': "20a97ec3f8efbc2aca0cf7cabb420b4a09d0aec9905466c9adf79584fa75fed30500000000",
    'client_data': "7b2274797065223a22776562617574686e2e676574222c226368616c6c656e6765223a22414c464579515045326243375857556d754d6f444f4175436f6f4b4456692d593976464b497067464a474d222c226f726967696e223a2268747470733a2f2f636f6e74726f6c6c65722d6769742d74617272656e63652d656e672d3139352d63726564656e7469616c2d726567697374726174696f6e2d3937363639372e707265766965772e6361727472696467652e6767222c2263726f73734f726967696e223a66616c73657d",
    'signature': "3046022100a6fc623a319a674ed15f72b544b9ddb277ccfa90e1b49269fdb3e4c6c41771ef022100b728edcbd35b9995e0e82b15456960d89b99884dd9aabf36295fd99ad23a9f3c"
}]

output = open("src/tests/webauthn_gen_test.cairo", "w")

test = HEAD

'{"type":"webauthn.get","challenge":"ALFEyQPE2bC7XWUmuMoDOAuCooKDVi-Y9vFKIpgFJGM","origin":"https://controller-git-tarrence-eng-195-credential-registration-976697.preview.cartridge.gg","crossOrigin":false}'

for i, item in enumerate(data):
    pubkey = decode_credential_public_key(base64url_to_bytes(item["pubkey"]))
    authenticator_data_bytes = bytes.fromhex(item["authenticator_data"])
    client_data_bytes = bytes.fromhex(item["client_data"])
    challenge_bytes = base64url_to_bytes(item["challenge"])
    print(challenge_bytes.hex(), challenge_bytes)

    x0, x1, x2 = split(int.from_bytes(pubkey.x, "big"))
    y0, y1, y2 = split(int.from_bytes(pubkey.y, "big"))

    client_data_hash = hashlib.sha256()
    client_data_hash.update(client_data_bytes)
    client_data_hash_bytes = client_data_hash.digest()

    # client_data_rem = 4 - (len(client_data_bytes) % 4)
    # if client_data_rem == 4:
    #     client_data_rem = 0

    # if client_data_rem != 0:
    #     for _ in range(4 - client_data_rem):
    #         client_data_bytes = client_data_bytes + b'\x00'

    # authenticator_data_rem = 4 - len(authenticator_data_bytes) % 4
    # if authenticator_data_rem == 4:
    #     authenticator_data_rem = 0

    # authenticator_data = [int.from_bytes(
    #     authenticator_data_bytes[i:i+4], 'big') for i in range(0, len(authenticator_data_bytes), 4)]
    # client_data_json_parts = [int.from_bytes(
    #     client_data_bytes[i:i+4], 'big') for i in range(0, len(client_data_bytes), 4)]

    sig, rest = der_decoder(binascii.unhexlify(
        item["signature"]), asn1Spec=DERSig())
    if len(rest) != 0:
        raise Exception('Bad encoding')

    param_r = int(sig['r'])
    param_s = int(sig['s'])

    # authenticator_data_parts = [int.from_bytes(
    #     authenticator_data_bytes[i:i+4], 'big') for i in range(0, len(authenticator_data_bytes), 4)]

    for _ in range(32 - len(challenge_bytes)):
        challenge_bytes = challenge_bytes + b'\x00'
    # challenge_parts = [int.from_bytes(challenge[i:i+3], 'big')
    #                    for i in range(0, len(challenge), 3)]

    # origin = b'https://controller-e13pt9wwv.preview.cartridge.gg'
    # origin_parts = [int.from_bytes(origin[i:i+4], 'big')
    #                 for i in range(0, len(origin), 4)]
    origin_offset_bytes = client_data_bytes.find(
        b'"origin":"') + len(b'"origin":"')

    type = b'webauthn.get'
    # type_parts = [int.from_bytes(type[i:i+4], 'big')
    #               for i in range(0, len(type), 4)]
    type_offset_bytes = client_data_bytes.find(b'"type":"') + len(b'"type":"')

    challenge_offset_bytes = client_data_bytes.find(
        b'"challenge":"') + len(b'"challenge":"')

    # challenge_offset_len = challenge_offset_bytes // 4
    # challenge_offset_rem = challenge_offset_bytes % 4
    # challenge_len = len(challenge_parts)
    # challenge_rem = len(challenge) % 3

    challenge = ""
    for c in challenge_bytes:
        challenge += "    challenge.append({});\n".format(c)

    # client_data_json_len = len(client_data_json_parts)
    # client_data_json_rem = client_data_rem
    client_data_json = ""
    for c in client_data_bytes:
        client_data_json += "    client_data_json.append({});\n".format(c)

    # authenticator_data_len = len(authenticator_data_parts)
    # authenticator_data_rem = authenticator_data_rem
    authenticator_data = ""
    for c in authenticator_data_bytes:
        authenticator_data += "    authenticator_data.append({});\n".format(c)

    test += TEST_CASE.format(
        title=i,
        # expect_revert=expect_revert,
        x0=x0,
        x1=x1,
        x2=x2,
        y0=y0,
        y1=y1,
        y2=y2,
        param_r=param_r,
        param_s=param_s,
        challenge_offset=challenge_offset_bytes,
        challenge=challenge,
        client_data_json=client_data_json,
        authenticator_data=authenticator_data
    )

cases = [{
    "origin": "https://controller.cartridge.gg",
    "transaction": (420, [(1234, 'add_public_key', [0])], 0, 0),
}, {
    "origin": "a",
    "transaction": (420, [(1234, 'add_public_key', [0])], 0, 0),
}, {
    "origin": "aa",
    "transaction": (420, [(1234, 'add_public_key', [0])], 0, 0),
}, {
    "origin": "aaa",
    "transaction": (420, [(1234, 'add_public_key', [0])], 0, 0),
}, {
    "origin": "aaaa",
    "transaction": (420, [(1234, 'add_public_key', [0])], 0, 0),
}, {
    "origin": "aaaaa",
    "transaction": (420, [(1234, 'add_public_key', [0])], 0, 0),
}]

for i, case in enumerate(cases):
    signer = WebauthnSigner()

    (contract_address, calls, nonce, max_fee) = case["transaction"]

    build_calls = []
    for call in calls:
        build_call = list(call)
        build_call[0] = hex(build_call[0])
        build_calls.append(build_call)

    (call_array, calldata) = from_call_to_call_array(build_calls)
    message_hash = get_transaction_hash(
        TransactionHashPrefix.INVOKE, contract_address, calldata, nonce, max_fee
    )

    (x0, x1, x2, y0, y1, y2) = signer.public_key
    (r0, r1, r2,
            s0, s1, s2,
            challenge_offset,
            client_data_bytes,
            authenticator_data_bytes
     ) = signer.sign_transaction(case["origin"], contract_address, call_array, calldata, nonce, max_fee)
    
    param_r = combine(r0, r1, r2)
    param_s = combine(s0, s1, s2)

    challenge_bytes = message_hash.to_bytes(
        32, byteorder="big")
    # challenge_parts = [int.from_bytes(
    #     challenge_bytes[i:i+3], 'big') for i in range(0, len(challenge_bytes), 3)]
    challenge = ""
    for c in challenge_bytes:
        challenge += "    challenge.append({});\n".format(c)

    client_data_json = ""
    for c in client_data_bytes:
        client_data_json += "    client_data_json.append({});\n".format(c)

    authenticator_data = ""
    for c in authenticator_data_bytes:
        authenticator_data += "    authenticator_data.append({});\n".format(c)

    challenge_offset_bytes = 36

    test += TEST_CASE.format(
        title="signer_{}".format(i),
        # expect_revert=expect_revert,
        x0=x0,
        x1=x1,
        x2=x2,
        y0=y0,
        y1=y1,
        y2=y2,
        param_r=param_r,
        param_s=param_s,
        challenge_offset=challenge_offset_bytes,
        challenge=challenge,
        client_data_json=client_data_json,
        authenticator_data=authenticator_data
    )


invokes = [{
    "pubkey": "pQECAyYgASFYIBr47ohkRPowA6P7lim1UiuXH57qEg8+rb6zPzSHoM33IlggWknbZgnGuMxKrlSFgeT+L+zPwoBRepj34rxq/oxkOdI=",
    "signature": ["0x0", "0x1d6dd918cd1d34c268295", "0x154d4da8d3cc79014e7b93", "0x957373f5ff88d2d69ee4", "0x304d3a94f27306e32a2186", "0xaaa6c62c6c2ca14c725ea", "0xfc557b7a588de600e1aab", "0x9", "0x0", "0x24", "0x0", "0x7b227479", "0x7065223a", "0x22776562", "0x61757468", "0x6e2e6765", "0x74222c22", "0x6368616c", "0x6c656e67", "0x65223a22", "0x41786c73", "0x504b4231", "0x63357434", "0x52356c53", "0x7135634e", "0x50575969", "0x65416552", "0x56446e33", "0x70774256", "0x59413146", "0x75504522", "0x2c226f72", "0x6967696e", "0x223a2268", "0x74747073", "0x3a2f2f63", "0x6f6e7472", "0x6f6c6c65", "0x722e6361", "0x72747269", "0x6467652e", "0x6767222c", "0x2263726f", "0x73734f72", "0x6967696e", "0x223a6661", "0x6c73657d", "0xa", "0x3", "0x20a97ec3", "0xf8efbc2a", "0xca0cf7ca", "0xbb420b4a", "0x9d0aec9", "0x905466c9", "0xadf79584", "0xfa75fed3", "0x1d000000", "0x0"],
    "transaction_hash": "0x3196c3ca075739b78479952ab970d3d66227807915439f7a70055600d45b8f1",
}]

for i, item in enumerate(invokes):
    # pubkey_bytes = bytes.fromhex(item["pubkey"])
    pubkey_bytes = base64url_to_bytes(item["pubkey"])
    decoded_public_key = decode_credential_public_key(pubkey_bytes)

    sig = [int(part, 16) for part in item["signature"]]

    param_r = combine(sig[1], sig[2], sig[3])
    param_s = combine(sig[4], sig[5], sig[6])

    client_data_json_len = int(sig[9])
    client_data_json_rem = int(sig[10])

    client_data_json_parts = []
    for j in range(11, 11 + client_data_json_len):
        client_data_json_parts.append(int(sig[j]))

    client_data_bytes = b""
    for c in client_data_json_parts:
        client_data_bytes += c.to_bytes(4, "big")

    if client_data_json_rem != 0:
        client_data_bytes = client_data_bytes[:-1 * client_data_json_rem]
    
    client_data_json = ""
    for c in client_data_bytes:
        client_data_json += "    client_data_json.append({});\n".format(c)


    authenticator_data_len = int(sig[11 + client_data_json_len])
    authenticator_data_rem = int(sig[12 + client_data_json_len])

    authenticator_data_bytes = b""
    for j in range(13 + client_data_json_len, 13 + client_data_json_len + authenticator_data_len):
        authenticator_data_bytes += sig[j].to_bytes(4, "big")

    if authenticator_data_rem != 0:
        authenticator_data_bytes = authenticator_data_bytes[:-1 * authenticator_data_rem]
    # print(authenticator_data_bytes.hex(), len(authenticator_data_bytes))
    
    authenticator_data = ""
    for c in authenticator_data_bytes:
        authenticator_data += "    authenticator_data.append({});\n".format(c)

    challenge_bytes = int(item["transaction_hash"], 16).to_bytes(
        32, byteorder="big")
    challenge = bytes_to_base64url(challenge_bytes)

    # challenge_parts = [int.from_bytes(
    #     challenge_bytes[i:i+3], 'big') for i in range(0, len(challenge_bytes), 3)]
    challenge = ""
    for c in challenge_bytes:
        challenge += "    challenge.append({});\n".format(c)

    challenge_offset_bytes = 36

    x0, x1, x2 = split(int.from_bytes(decoded_public_key.x, "big"))
    y0, y1, y2 = split(int.from_bytes(decoded_public_key.y, "big"))

    test += TEST_CASE.format(
        title="invoke_{}".format(i),
        # expect_revert=expect_revert,
        x0=x0,
        x1=x1,
        x2=x2,
        y0=y0,
        y1=y1,
        y2=y2,
        r0=r0,
        param_r=param_r,
        param_s=param_s,
        challenge_offset=challenge_offset_bytes,
        challenge=challenge,
        client_data_json=client_data_json,
        authenticator_data=authenticator_data
    )


output.write(test)
output.close()

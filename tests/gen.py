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

pubkey = decode_credential_public_key(base64url_to_bytes("pQECAyYgASFYIPofnDyxJWqz1XWBumSQ5qEeUQ3Wfaug1hXgVAoXO0S/Ilggl5qh3cisV9IZ+Y9Z8I1jqMH09TOtRxTwPxc9X4cJpwc="))
challenge = b"0x044e3adc845e501b01c6904dd2b0cd0d084bb01240966d39c3165481dfcae65w"
authenticator_data_bytes = bytes.fromhex("20a97ec3f8efbc2aca0cf7cabb420b4a09d0aec9905466c9adf79584fa75fed30500000000")
client_data_bytes = bytes.fromhex("7b2274797065223a22776562617574686e2e676574222c226368616c6c656e6765223a22307830343465336164633834356535303162303163363930346464326230636430643038346262303132343039363664333963333136353438316466636165363577222c226f726967696e223a2268747470733a2f2f636f6e74726f6c6c65722d6531337074397777762e707265766965772e6361727472696467652e6767222c2263726f73734f726967696e223a66616c73657d")
signature = "3045022024c32f5128206df9fa8102e0f7a2a908b8cae76fee717d50ecaa95eeb125199302210096f6daa99ca841cc5064d72b1f9d6f11154909cf7b324312b82f2cc8736728c3"

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
client_data_json = [int.from_bytes(client_data_bytes[i:i+4], 'big') for i in range(0, len(client_data_bytes), 4)]

sig, rest = der_decoder(binascii.unhexlify(signature), asn1Spec=DERSig())
if len(rest) != 0:
    raise Exception('Bad encoding')

r0, r1, r2 = split(int(sig['r']))
s0, s1, s2 = split(int(sig['s']))

authenticator_data_parts = [int.from_bytes(authenticator_data_bytes[i:i+4], 'big') for i in range(0, len(authenticator_data_bytes), 4)]
challenge_parts = [int.from_bytes(challenge[i:i+4], 'big') for i in range(0, len(challenge), 4)]

# {"type":"webauthn.get","challenge":"0x044e3adc845e501b01c6904dd2b0cd0d084bb01240966d39c3165481dfcae65w","origin":"https://controller-e13pt9wwv.preview.cartridge.gg","crossOrigin":false}
origin = b'https://controller-e13pt9wwv.preview.cartridge.gg'
origin_parts = [int.from_bytes(origin[i:i+4], 'big') for i in range(0, len(origin), 4)]
origin_offset_bytes = client_data_bytes.find(b'"origin":"') + len(b'"origin":"')

type = b'webauthn.get'
type_parts = [int.from_bytes(type[i:i+4], 'big') for i in range(0, len(type), 4)]
type_offset_bytes = client_data_bytes.find(b'"type":"') + len(b'"type":"')

challenge_offset_bytes = client_data_bytes.find(b'"challenge":"') + len(b'"challenge":"')

print("x", x0, x1, x2)
print("y", y0, y1, y2)
print("r", r0, r1, r2)
print("s", s0, s1, s2)
print("callenge_rem", 4 - (len(challenge) % 4))
print("challenge_parts_len", len(challenge_parts))
print("challenge_parts", challenge_parts)
print("origin_offset_len", origin_offset_bytes // 4)
print("origin_offset_rem", origin_offset_bytes % 4)
print("origin_len", len(origin_parts))
print("origin", origin_parts)
print("type_parts", type_parts)
print("type_offset_len", type_offset_bytes // 4)
print("type_offset_rem", type_offset_bytes % 4)
print("challenge_offset_len", challenge_offset_bytes // 4)
print("challenge_offset_rem", challenge_offset_bytes % 4)
print("client_dat_json", client_data_bytes)
print("client_data_json_parts", client_data_json)
print("client_data_json_len", len(client_data_json))
print("client_data_json_rem", 4 - client_data_rem)
print("authenticator_data_parts", authenticator_data_parts)
print("authenticator_data_len", len(authenticator_data_parts))
print("authenticator_data_rem", 4 - authenticator_data_rem)

from webauthn.helpers import base64url_to_bytes, bytes_to_base64url, decode_credential_public_key
from pyasn1.codec.der.decoder import decode as der_decoder
from pyasn1.type.univ import Sequence
from pyasn1.type.univ import Integer
from pyasn1.type.namedtype import NamedTypes
from pyasn1.type.namedtype import NamedType
import binascii

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

# request
# {
#     "data": {
#         "beginRegistration": {
#             "publicKey": {
#                 "challenge": "pnmCf/BbS0PvHDG5xYNbvv8rNsX4mWOewp66UgXOMwI=",
#                 "rp": {
#                     "name": "Cartridge",
#                     "icon": "https://cartridge.gg/android-chrome-512x512.png",
#                     "id": "cartridge.gg"
#                 },
#                 "user": {
#                     "name": "vitalik",
#                     "icon": "https://cartridge.gg/android-chrome-512x512.png",
#                     "displayName": "vitalik",
#                     "id": "dml0YWxpaw=="
#                 },
#                 "pubKeyCredParams": [
#                     {
#                         "type": "public-key",
#                         "alg": -7
#                     }
#                 ],
#                 "authenticatorSelection": {
#                     "authenticatorAttachment": "platform",
#                     "residentKey": "preferred",
#                     "userVerification": "required"
#                 },
#                 "timeout": 60000,
#                 "attestation": "none"
#             }
#         }
#     }
# }

# response
# {
#     "id": "wPoJLandf4mte3vo2z0IdCvjz4m-IBkNNMMFxM4WMvYZupeb2lmkTMmua2NOt24NUjfpKWuxd0daOMnT7ZgwtJcbmzADfBC-iLhBwkkqqXo0AmmAKvypSqOSSopXPc5IGzQx5JLRn3ijllFvLnp4Ww",
#     "rawId": "wPoJLandf4mte3vo2z0IdCvjz4m-IBkNNMMFxM4WMvYZupeb2lmkTMmua2NOt24NUjfpKWuxd0daOMnT7ZgwtJcbmzADfBC-iLhBwkkqqXo0AmmAKvypSqOSSopXPc5IGzQx5JLRn3ijllFvLnp4Ww",
#     "type": "public-key",
#     "response": {
#         "attestationObject": "o2NmbXRkbm9uZWdhdHRTdG10oGhhdXRoRGF0YVj0IKl-w_jvvCrKDPfKu0ILSgnQrsmQVGbJrfeVhPp1_tNFAAAAAK3OAAI1vMYKZIsLJfHwVQMAcMD6CS2p3X-JrXt76Ns9CHQr48-JviAZDTTDBcTOFjL2GbqXm9pZpEzJrmtjTrduDVI36SlrsXdHWjjJ0-2YMLSXG5swA3wQvoi4QcJJKql6NAJpgCr8qUqjkkqKVz3OSBs0MeSS0Z94o5ZRby56eFulAQIDJiABIVgg-h-cPLElarPVdYG6ZJDmoR5RDdZ9q6DWFeBUChc7RL8iWCCXmqHdyKxX0hn5j1nwjWOowfT1M61HFPA_Fz1fhwmnBw",
#         "clientDataJSON": "eyJ0eXBlIjoid2ViYXV0aG4uY3JlYXRlIiwiY2hhbGxlbmdlIjoicG5tQ2ZfQmJTMFB2SERHNXhZTmJ2djhyTnNYNG1XT2V3cDY2VWdYT013SSIsIm9yaWdpbiI6Imh0dHBzOi8vY29udHJvbGxlci1lMTNwdDl3d3YucHJldmlldy5jYXJ0cmlkZ2UuZ2ciLCJjcm9zc09yaWdpbiI6ZmFsc2UsIm90aGVyX2tleXNfY2FuX2JlX2FkZGVkX2hlcmUiOiJkbyBub3QgY29tcGFyZSBjbGllbnREYXRhSlNPTiBhZ2FpbnN0IGEgdGVtcGxhdGUuIFNlZSBodHRwczovL2dvby5nbC95YWJQZXgifQ"
#     }
# }

# credential:
# {
#     "ID": "wPoJLandf4mte3vo2z0IdCvjz4m+IBkNNMMFxM4WMvYZupeb2lmkTMmua2NOt24NUjfpKWuxd0daOMnT7ZgwtJcbmzADfBC+iLhBwkkqqXo0AmmAKvypSqOSSopXPc5IGzQx5JLRn3ijllFvLnp4Ww==",
#     "PublicKey": "pQECAyYgASFYIPofnDyxJWqz1XWBumSQ5qEeUQ3Wfaug1hXgVAoXO0S/Ilggl5qh3cisV9IZ+Y9Z8I1jqMH09TOtRxTwPxc9X4cJpwc=",
#     "Transport": null,
#     "Authenticator": {
#         "AAGUID": "rc4AAjW8xgpkiwsl8fBVAw==",
#         "SignCount": 0,
#         "CloneWarning": false
#     },
#     "AttestationType": "none"
# }

pubkey = decode_credential_public_key(base64url_to_bytes("pQECAyYgASFYIPofnDyxJWqz1XWBumSQ5qEeUQ3Wfaug1hXgVAoXO0S/Ilggl5qh3cisV9IZ+Y9Z8I1jqMH09TOtRxTwPxc9X4cJpwc="))
challenge = bytes.fromhex("044e3adc845e501b01c6904dd2b0cd0d084bb01240966d39c3165481dfcae654")
authenticator_data_bytes = bytes.fromhex("20a97ec3f8efbc2aca0cf7cabb420b4a09d0aec9905466c9adf79584fa75fed30500000000")
client_data_bytes = bytes.fromhex("7b2274797065223a22776562617574686e2e676574222c226368616c6c656e6765223a22307830343465336164633834356535303162303163363930346464326230636430643038346262303132343039363664333963333136353438316466636165363577222c226f726967696e223a2268747470733a2f2f636f6e74726f6c6c65722d6531337074397777762e707265766965772e6361727472696467652e6767222c2263726f73734f726967696e223a66616c73657d")
signature = "3045022024c32f5128206df9fa8102e0f7a2a908b8cae76fee717d50ecaa95eeb125199302210096f6daa99ca841cc5064d72b1f9d6f11154909cf7b324312b82f2cc8736728c3"

x0, x1, x2 = split(int.from_bytes(pubkey.x, "big"))
y0, y1, y2 = split(int.from_bytes(pubkey.y, "big"))

client_data_rem = len(client_data_bytes) % 4
for _ in range(4 - client_data_rem):
    client_data_bytes = client_data_bytes + b'\x00'

authenticator_data = [int.from_bytes(authenticator_data_bytes[i:i+4], 'big') for i in range(0, len(authenticator_data_bytes), 4)]
client_data_json = [int.from_bytes(client_data_bytes[i:i+4], 'big') for i in range(0, len(client_data_bytes), 4)]

sig, rest = der_decoder(binascii.unhexlify(signature), asn1Spec=DERSig())
if len(rest) != 0:
    raise Exception('Bad encoding')

r0, r1, r2 = split(int(sig['r']))
s0, s1, s2 = split(int(sig['s']))

print(x0, x1, x2)
print(y0, y1, y2)
print(challenge)
print(authenticator_data)
print(client_data_json)
print(r0, r1, r2)
print(s0, s1, s2)

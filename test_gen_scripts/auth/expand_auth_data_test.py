from hashlib import sha256
from structure import Test, TestFile, TestFileCreatorInterface, SimpleBlock
from utils import bytes_as_cairo_array


class ExpandAuthDataTest(TestFileCreatorInterface):
    def __init__(self) -> None:
        super().__init__()

    def test_file(self, python_source_folder: str) -> TestFile:
        tf = TestFile("expand_auth_data", python_source_folder)
        tf.add_imports(self.get_imports())
        tf.add_blocks(self.get_tests())
        return tf

    def create_expand_test(self, rp_id: bytes, flags: int, sign_count: int, name: str):
        rp_id_hash = sha256(rp_id).digest()
        auth_data = (
            rp_id_hash + flags.to_bytes(1, "big") + sign_count.to_bytes(4, "big")
        )
        text = bytes_as_cairo_array(auth_data, "auth_data")
        text += "let ad_o: Option<AuthenticatorData> = ImplArrayu8TryIntoAuthData::try_into(auth_data);\n"
        text += "let ad = ad_o.unwrap();\n"
        text += f"assert(ad.sign_count == {sign_count}, 'Expected equal! count');\n"
        text += f"assert(ad.flags == {flags}, 'Expected equal! flags');\n\n"
        text += bytes_as_cairo_array(rp_id_hash, "rp_id_hash")
        text += f"assert(ad.rp_id_hash == rp_id_hash, 'Expected equal! arrays');\n"
        return Test(name, text)

    def create_verify_rp_id_hash_test(
        self, rp_id: bytes, flags: int, sign_count: int, name: str
    ):
        rp_id_hash = sha256(rp_id).digest()
        auth_data = (
            rp_id_hash + flags.to_bytes(1, "big") + sign_count.to_bytes(4, "big")
        )
        text = bytes_as_cairo_array(auth_data, "auth_data")
        text += bytes_as_cairo_array(rp_id, "rp_id")
        text += "expand_auth_data_and_verify_rp_id_hash(auth_data, rp_id).unwrap();\n"
        return Test(name, text)

    def get_tests(self):
        cases = [
            (b"relying-party.id", 0b00010101, 13),
            (b"gogiel.srogiel.pl", 0b00011101, 89),
            (b"gogiel.srogiel.pl", 0b0101, 2**20),
            (b"aaaaaaaaaaaaaa", 0b000101011, 19),
        ]
        return [
            self.create_expand_test(rp_id, f, c, f"expand_auth_data_{i}")
            for i, (rp_id, f, c) in enumerate(cases)
        ] + [
            self.create_verify_rp_id_hash_test(rp_id, f, c, f"verify_rp_id_{i}")
            for i, (rp_id, f, c) in enumerate(cases)
        ]

    def get_imports(self):
        return [
            "core::traits::Into",
            "core::option::OptionTrait",
            "result::ResultTrait",
            "webauthn_auth::ecdsa::{verify_ecdsa, verify_hashed_ecdsa, VerifyEcdsaError}",
            "webauthn_auth::types::AuthenticatorData",
            "webauthn_auth::webauthn::ImplArrayu8TryIntoAuthData",
            "webauthn_auth::errors::AuthnErrorIntoFelt252",
            "webauthn_auth::webauthn::expand_auth_data_and_verify_rp_id_hash",
            "starknet::secp256r1::Secp256r1Impl",
            "starknet::secp256r1::Secp256r1Point",
            "starknet::SyscallResultTrait",
            "array::ArrayTrait",
        ]

from hashlib import sha256
from structure import Test, TestFile, TestFileCreatorInterface
from utils import get_raw_signature, bytes_as_cairo_array, get_random_string


class VerifySignatureTest(TestFileCreatorInterface):
    def __init__(self) -> None:
        super().__init__()

    def test_file(self, python_source_folder: str) -> TestFile:
        tf = TestFile("verify_signature", python_source_folder)
        tf.add_imports(self.get_imports())
        tf.add_blocks(self.get_tests())
        return tf

    def create_good_test(self, rp_id: bytes, name: str):
        flags = 0b10100000
        sign_count = 0x0001
        rp_id_hash = sha256(rp_id).digest()
        auth_data = (
            rp_id_hash + flags.to_bytes(1, "big") + sign_count.to_bytes(4, "big")
        )
        hash = sha256(get_random_string(5, 100).encode()).digest()
        (sig, px, py) = get_raw_signature(auth_data + hash)

        text = bytes_as_cairo_array(hash, "hash")
        text += bytes_as_cairo_array(auth_data, "auth_data")
        text += bytes_as_cairo_array(sig, "sig")
        text += (
            "let pk = PublicKey {\n\t x: " + str(px) + ", \n\t y: " + str(py) + "\n};\n"
        )
        text += """match verify_signature(
    hash, auth_data, pk, sig            
) {
    Result::Ok => (),
    Result::Err(e) => {
        assert(false, AuthnErrorIntoFelt252::into(e))
    }
}"""
        return Test(name, text)

    def get_tests(self):
        return [
            self.create_good_test(rp_id, f"verify_signature_{i}")
            for i, rp_id in enumerate(
                get_random_string(5, 100).encode() for _ in range(10)
            )
        ]

    def get_imports(self):
        return [
            "core::traits::Into",
            "result::ResultTrait",
            "core::option::OptionTrait",
            "webauthn_auth::ecdsa::{verify_ecdsa, verify_hashed_ecdsa, VerifyEcdsaError}",
            "webauthn_auth::types::PublicKey",
            "webauthn_auth::webauthn::verify_signature",
            "webauthn_auth::errors::AuthnErrorIntoFelt252",
            "starknet::secp256r1::Secp256r1Impl",
            "starknet::secp256r1::Secp256r1Point",
            "starknet::SyscallResultTrait",
            "array::ArrayTrait",
        ]

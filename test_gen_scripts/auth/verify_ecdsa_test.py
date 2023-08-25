from structure import Test, TestFile, TestFileCreatorInterface, SimpleBlock
from utils import get_good_signature, bytes_as_cairo_array


class VerifyECDSATest(TestFileCreatorInterface):
    # This is the template of the body of the test.
    # When creating the tests that should 'pass' correct values (python generated) for
    # px, py, r and s will be provided.
    # When creating tests that should 'fail' some parameter would be screwed
    # and ok_code and err_code would be adjusted accordingly
    # The verify_hashed_ecdsa function takes an already hashed message.
    # The verify_ecdsa takes raw message (before hashing) and sha256 is used as a hashing function
    # This is why we provide an identity function as a hashing function
    # for the python library.
    TEMPLATE = """let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
    {px},
    {py}
)
    .unwrap_syscall()
    .unwrap();
let r = {r};
let s = {s};
{msg}

match {func_name}(pub_key, msg, r, s) {{
    Result::Ok => {ok_code},
    Result::Err(m) => {err_code}
}}"""

    def __init__(self) -> None:
        super().__init__()

    def test_file(self) -> TestFile:
        tf = TestFile("verify_ecdsa", "verify_ecdsa_test")
        tf.add_imports(self.get_imports())
        tf.add_blocks(self.get_good_tests())
        tf.add_block(self.create_wrong_arguments_test())
        tf.add_block(self.create_invalid_signature_test())
        tf.add_blocks(self.get_good_hashed_tests())
        return tf

    def create_good_test(self, name: str, message: bytes):
        (px, py, r, s) = get_good_signature(message)
        return Test(
            name,
            VerifyECDSATest.TEMPLATE.format(
                px=px,
                py=py,
                r=r,
                s=s,
                msg=f"let msg = {int.from_bytes(message, 'big')};",
                ok_code="()",
                err_code="assert(false, m.into())",
                func_name="verify_hashed_ecdsa",
            ),
        )

    def create_good_test_with_hashing(self, name: str, message: bytes):
        (px, py, r, s) = get_good_signature(message, True)
        return Test(
            name,
            VerifyECDSATest.TEMPLATE.format(
                px=px,
                py=py,
                r=r,
                s=s,
                msg=bytes_as_cairo_array(message),
                ok_code="()",
                err_code="assert(false, m.into())",
                func_name="verify_ecdsa",
            ),
        )

    def create_wrong_arguments_test(self):
        message = b"Not important"
        (px, py, _r, _s) = get_good_signature(message)
        return Test(
            "ecdsa_wrong_arguments",
            VerifyECDSATest.TEMPLATE.format(
                px=px,
                py=py,
                # this values are wrong
                r=0,
                s=0,
                msg=f"let msg = {int.from_bytes(message, 'big')};",
                ok_code="assert(false, 'Should Error!')",
                err_code="""match m {
        VerifyEcdsaError::WrongArgument => (),
        VerifyEcdsaError::InvalidSignature =>assert(false, 'Wrong Error!'),
        VerifyEcdsaError::SyscallError => assert(false, 'Wrong Error!'),
    }""",
                func_name="verify_hashed_ecdsa",
            ),
        )

    def create_invalid_signature_test(self):
        message = b"Not important"
        (px, py, r, s) = get_good_signature(message)
        return Test(
            "ecdsa_invalid_signature",
            VerifyECDSATest.TEMPLATE.format(
                px=px,
                py=py,
                r=r,
                s=s,
                # this hash is wrong
                msg=f"let msg = {111110000011111};",
                ok_code="assert(false, 'Should Error!')",
                err_code="""match m {
        VerifyEcdsaError::WrongArgument => assert(false, 'Wrong Error!'),
        VerifyEcdsaError::InvalidSignature => (),
        VerifyEcdsaError::SyscallError => assert(false, 'Wrong Error!'),
    }""",
                func_name="verify_hashed_ecdsa",
            ),
        )

    def get_imports(self):
        return [
            "core::traits::Into",
            "core::option::OptionTrait",
            "webauthn_auth::ecdsa::{verify_ecdsa, verify_hashed_ecdsa, VerifyEcdsaError}",
            "starknet::secp256r1::Secp256r1Impl",
            "starknet::secp256r1::Secp256r1Point",
            "starknet::SyscallResultTrait",
            "array::ArrayTrait",
        ]

    def get_good_tests(self):
        return [
            self.create_good_test(name, message)
            for name, message in [
                ("verify_ecdsa_short", b"1"),
                ("verify_ecdsa", b"Hello World!"),
                ("verify_ecdsa_long", b"This is a longer message!!!!!!!"),
            ]
        ]

    def get_good_hashed_tests(self):
        return [
            self.create_good_test_with_hashing(f"verify_ecdsa_with_hash_{i}", msg)
            for i, msg in enumerate(
                [
                    b"1",
                    b"Hello World!",
                    b"Long message, long message, long message, massage, message, long quite long"
                    * 20,
                ]
            )
        ]

from ecdsa import SigningKey, NIST256p, util

from structure import Test, TestFile, TestFileCreatorInterface

class VerifyECDSATest(TestFileCreatorInterface):

    # This is the template of the body of the test.
    # When creating the tests that should 'pass' correct values (python generated) for
    # px, py, r and s will be provided.
    # When creating tests that should 'fail' some parameter would be screwed
    # and ok_code and err_code would be adjusted accordingly
    # The verify ecdsa function takes an already hashed message.
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
let msg_hash = {msg_hash};
match verify_ecdsa(pub_key, msg_hash, r, s) {{
    Result::Ok => {ok_code},
    Result::Err(m) => {err_code}
}}"""

    def __init__(self) -> None:
        super().__init__()

    def test_file(self) -> TestFile:
        tf = TestFile('verify_ecdsa', 'verify_ecdsa_test')
        tf.add_imports(self.get_imports())
        tf.add_tests(self.get_good_tests())
        tf.add_test(self.create_wrong_arguments_test())
        tf.add_test(self.create_invalid_signature_test())
        return tf

    def get_good_signature(self, message: str):
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

    def create_good_test(self, name: str, message: str):
        (px, py, r, s) = self.get_good_signature(message)
        return Test(name, VerifyECDSATest.TEMPLATE.format(
            px = px, py = py, 
            r = r, s = s, 
            msg_hash = int.from_bytes(message, 'big'),
            ok_code = '()', err_code = 'assert(false, m.into())'
        ))

    def create_wrong_arguments_test(self):
        message = b'Not important'
        (px, py, _r, _s) = self.get_good_signature(message)
        return Test('ecdsa_wrong_arguments', VerifyECDSATest.TEMPLATE.format(
            px = px, py = py, 
            #this values are wrong
            r = 0, s = 0, 
            msg_hash = int.from_bytes(message, 'big'),
            ok_code = "assert(false, 'Should Error!')", 
            err_code = """match m {
        VerifyEcdsaError::WrongArgument => (),
        VerifyEcdsaError::InvalidSignature =>assert(false, 'Wrong Error!'),
        VerifyEcdsaError::SyscallError => assert(false, 'Wrong Error!'),
    }"""
        ))

    def create_invalid_signature_test(self):
        message = b'Not important'
        (px, py, r, s) = self.get_good_signature(message)
        return Test('ecdsa_invalid_signature', VerifyECDSATest.TEMPLATE.format(
            px = px, py = py, 
            r = r, s = s, 
            #this hash is wrong
            msg_hash = 111110000011111,
            ok_code = "assert(false, 'Should Error!')", 
            err_code = """match m {
        VerifyEcdsaError::WrongArgument => assert(false, 'Wrong Error!'),
        VerifyEcdsaError::InvalidSignature => (),
        VerifyEcdsaError::SyscallError => assert(false, 'Wrong Error!'),
    }"""
        ))


    def get_imports(self):
        return [
            'core::traits::Into',
            'core::option::OptionTrait',
            'webauthn::ecdsa::{verify_ecdsa, VerifyEcdsaError}',
            'starknet::secp256r1::Secp256r1Impl',
            'starknet::secp256r1::Secp256r1Point',
            'starknet::SyscallResultTrait'
        ]

    def get_good_tests(self):
        return [
            self.create_good_test(name, message) 
            for name, message 
            in [
                ('verify_ecdsa_short', b'1'),
                ('verify_ecdsa', b'Hello World!'),
                ('verify_ecdsa_long', b'This is a longer message!!!!!!!')
            ]
        ]

# Dummy hash function returning a mock of a digestable object
def my_hash(message):
    return Digestable(message)    

class Digestable:
    def __init__(self, val) -> None:
        self.val = val
    def digest(self):
        return self.val

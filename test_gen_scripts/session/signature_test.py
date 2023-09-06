from starkware.crypto.signature.fast_pedersen_hash import pedersen_hash;
from utils import iterable_as_cairo_array

from typing import List
from structure import Test, TestFile, TestFileCreatorInterface


class SignatureTest(TestFileCreatorInterface):
    def __init__(self) -> None:
        super().__init__()

    def test_file(self, python_source_folder: str) -> TestFile:
        tf = TestFile("signature", python_source_folder)
        tf.add_imports(self.get_imports())
        tf.add_block(self.get_test())
        return tf

    def get_imports(self):
        return [
            "core::traits::Into",
            "core::option::OptionTrait",
            "array::ArrayTrait",
            "core::pedersen::pedersen",
            "webauthn_session::signature::FeltSpanTryIntoSignature"
        ]
    
    def get_test(self):
        r = 1830
        s = 1863
        session_key = 1918
        session_expires = 1694114435
        root = 1922
        proof_len = 2
        proofs = [i for i in range(proof_len * 2)]
        session_token = [i for i in range(5)]

        sig = [
            0, r, s, session_key, session_expires, root, proof_len, len(proofs)
        ] + proofs + [
            len(session_token)
        ] + session_token

        body = iterable_as_cairo_array(sig, 'sig', 'felt252')
        body += f'FeltSpanTryIntoSignature::try_into(sig.span()).unwrap();'
        return Test('span_into_signature', body)

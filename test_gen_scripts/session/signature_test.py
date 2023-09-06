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
        for name, count, size, token in [
            ('small', 2, 3, 5),
            ('medium', 10, 10, 40),
            ('large', 100, 10, 100)
        ]:
            tf.add_block(self.get_test(name, count, size, token))
        return tf

    def get_imports(self):
        return [
            "core::traits::Into",
            "core::option::OptionTrait",
            "array::ArrayTrait",
            "core::pedersen::pedersen",
            "webauthn_session::signature::FeltSpanTryIntoSignature",
            "webauthn_session::signature::ImplSignatureProofs"
        ]
    
    def get_test(
            self, 
            name,
            number_of_proofs, 
            single_proof_len, 
            session_token_len
        ):
        r = 1830
        s = 1863
        session_key = 1918
        session_expires = 1694114435
        root = 1922
        proofs = [i * 100 for i in range(single_proof_len * number_of_proofs)]
        session_token = [i + 2000 for i in range(session_token_len)]

        sig = [
            0, r, s, session_key, session_expires, root, single_proof_len, len(proofs)
        ] + proofs + [
            len(session_token)
        ] + session_token

        body = iterable_as_cairo_array(sig, 'sig', 'felt252')
        body += iterable_as_cairo_array(proofs, 'proofs', 'felt252')
        body += iterable_as_cairo_array(session_token, 'session_token', 'felt252')
        body += f'let sig = FeltSpanTryIntoSignature::try_into(sig.span()).unwrap();\n'
        body += '\n'.join([
            f"assert({r} == sig.r, 'Expect equal!');",
            f"assert({s} == sig.s, 'Expect equal!');",
            f"assert({session_key} == sig.session_key, 'Expect equal!');",
            f"assert({root} == sig.root, 'Expect equal!');",
            f"assert({number_of_proofs} == sig.proofs.len(), 'Expect equal!');",
            f"assert({session_token_len} == sig.session_token.len(), 'Expect equal!');",
            f"assert({proofs[-1]} == *sig.proofs.at({number_of_proofs - 1}).at({single_proof_len - 1}), 'Expect equal!');",
            f"assert({session_token[-1]} == *sig.session_token.at({session_token_len - 1}), 'Expect equal!');"
        ])
        return Test(f'span_into_signature_{name}', body)

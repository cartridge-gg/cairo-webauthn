from typing import List
from structure import Test, TestFile, TestFileCreatorInterface, SimpleBlock
from utils import iterable_as_cairo_array, assert_option_is_some, assert_option_is_none


class SignatureProofsTest(TestFileCreatorInterface):
    def __init__(self) -> None:
        super().__init__()

    def test_file(self, python_source_folder: str) -> TestFile:
        tf = TestFile("signature_proofs", python_source_folder)
        tf.add_imports(self.get_imports())
        for l in [3, 12, 100]:
            tf.add_block(self.get_test(l))
        return tf

    def get_imports(self):
        return [
            "core::traits::Into",
            "core::option::OptionTrait",
            "array::ArrayTrait",
            "webauthn_session::signature::ImplSignatureProofs",

        ]
    
    def get_test(self, length: int):
        body = iterable_as_cairo_array(bytes([i % 256 for i in range(length)]), 'proofs', 'felt252')
        for proof_size in [i + 1 for i in range(length)]:
            value = f'ImplSignatureProofs::try_new(proofs.span(), {proof_size})'
            if length % proof_size == 0:
                proof_count = length // proof_size
                body += '{\n\t'
                body += '\n\t'.join([
                    f'let option = {value}.unwrap();', 
                    f"assert(option.len() == {proof_count}, 'Wrong length');",
                    f"assert(option.at(0).len() == {proof_size}, 'Wrong length');",
                    f"assert(*option.at(0).at(0) == 0, 'Should equal');",
                    f"assert(*option.at({proof_count - 1}).at(0) == {(length - proof_size) % 255}, 'Should equal');",
                    f"assert(*option.at({proof_count - 1}).at({proof_size - 1}) == {(length - 1) % 255}, 'Should equal');",
                ])
                body += '\n}\n'
            else:
                body += assert_option_is_none(value)
        return Test(f'signature_proofs_{length}', body, length * 100000)

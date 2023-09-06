from typing import List
from structure import Test, TestFile, TestFileCreatorInterface, SimpleBlock
from utils import bytes_as_cairo_array, assert_option_is_some, assert_option_is_none


class SignatureProofsTest(TestFileCreatorInterface):
    def __init__(self) -> None:
        super().__init__()

    def test_file(self, python_source_folder: str) -> TestFile:
        tf = TestFile("signature_proofs", python_source_folder)
        tf.add_imports(self.get_imports())
        for l in [3, 12]:
            tf.add_block(self.get_length_test(l))
        return tf

    def get_imports(self):
        return [
            "core::traits::Into",
            "core::option::OptionTrait",
            "array::ArrayTrait",
            "webauthn_session::signature::ImplSignatureProofs"

        ]
    
    def get_length_test(self, length: int):
        body = bytes_as_cairo_array(bytes([i % 256 for i in range(length)]), 'proofs', 'felt252')
        for i in [i + 1 for i in range(length)]:
            value = f'ImplSignatureProofs::try_new(proofs.span(), {i})'
            if length % i == 0:
                body += '{\n\t'
                body += '\n\t'.join([
                    f'let option = {value}.unwrap();', 
                    f"assert(option.len() == {length // i}, 'Wrong length')"
                ])
                body += '\n}\n'
            else:
                body += assert_option_is_none(value)
        return Test(f'length_{length}', body)

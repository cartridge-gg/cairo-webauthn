from starkware.crypto.signature.fast_pedersen_hash import pedersen_hash;


from typing import List
from structure import Test, TestFile, TestFileCreatorInterface


class MerkleTest(TestFileCreatorInterface):
    def __init__(self) -> None:
        super().__init__()

    def test_file(self, python_source_folder: str) -> TestFile:
        tf = TestFile("merkle", python_source_folder)
        tf.add_imports(self.get_imports())
        tf.add_block(self.get_test())
        return tf

    def get_imports(self):
        return [
            "core::traits::Into",
            "core::option::OptionTrait",
            "array::ArrayTrait",
            "core::pedersen::pedersen",
        ]
    
    def get_test(self):
        (a, b) = (987, 456)
        body = f"assert(pedersen({a}, {b}) == {pedersen_hash(a, b)}, 'Expect equal');\n"
        return Test('merkle', body)

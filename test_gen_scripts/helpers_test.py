from typing import List
from structure import Test, TestFile, TestFileCreatorInterface, SimpleBlock
from utils import get_good_signature


class HelpersTest(TestFileCreatorInterface):
    def __init__(self) -> None:
        super().__init__()

    def test_file(self) -> TestFile:
        tf = TestFile("helpers", "helpers_test")
        tf.add_imports(self.get_imports())
        tf.add_blocks(self.get_extract_tests())
        tf.add_blocks(self.get_r_s_extract_tests())
        # tf.add_blocks(self.get_arrays_equal_tests())
        return tf

    def get_imports(self):
        return [
            "core::traits::Into",
            "core::option::OptionTrait",
            "array::ArrayTrait",
            "webauthn_auth::helpers::extract_u256_from_u8_array",
            "webauthn_auth::helpers::extract_r_and_s_from_array",
        ]

    def get_extract_tests(self):
        cases = [(0, 0), (0, 100), (2**256 - 1, 0), (2**256 - 2, 100), (1, 32)]
        return [
            Test(f"extract_{i}", HelpersTest.generate_good_extract_test(n, o))
            for i, (n, o) in enumerate(cases)
        ]

    def get_r_s_extract_tests(self):
        cases = [
            (0, 0),
            (0, 100),
            (2**256 - 1, 2**256 - 1),
            (2**256 - 2, 2**256 - 1),
            (1, 32),
        ]
        return [
            Test(f"extract_r_s_{i}", HelpersTest.generate_good_r_s_extract_test(r, s))
            for i, (r, s) in enumerate(cases)
        ]

    def get_arrays_equal_tests(self):
        nums = [0, 2**31 - 1, 2**32 - 2**15 - 2**7 - 2**5, 2**256 - 1]
        pairs_to_check = [(a, b) for a in nums for b in nums]
        cases = [((n, m), n == m) for n, m in pairs_to_check]
        return (
            [Test("arrays_equal_empty", HelpersTest.generate_array_empty_test())]
            + [
                Test(
                    f"arrays_equal_{i}", HelpersTest.generate_array_equal_test(a, b, e)
                )
                for i, ((a, b), e) in enumerate(cases)
            ]
            + [
                Test(
                    f"arrays_equal_different_length",
                    HelpersTest.generate_array_equal_test(0, 0, False, 0, 1),
                )
            ]
        )

    def generate_good_extract_test(number, offset) -> str:
        arr_name = "byte_repr"
        text = generate_cairo_array(number, offset, arr_name)
        text += f"""assert(
    extract_u256_from_u8_array(@{arr_name}, {offset}_usize).unwrap()
    == {number}_u256, 
    'Expected equal!'
);"""
        return text

    def generate_good_r_s_extract_test(r, s) -> str:
        arr_name = "byte_repr"
        s_bytes = number_to_b_array(s, 0)
        text = generate_cairo_array(r, 0, arr_name)
        text += "\n".join(append_bytes_to_cairo_arr(arr_name, s_bytes)) + "\n"
        text += f"let (r, s): (u256, u256) = extract_r_and_s_from_array(@{arr_name}).unwrap();\n"
        text += f"assert(r == {r}, 'Expected r equal!');\n"
        text += f"assert(s == {s}, 'Expected s equal!');"
        return text

    def generate_array_equal_test(a, b, should_equal, a_offset=0, b_offset=0):
        text = generate_cairo_array(a, a_offset, "a")
        text += generate_cairo_array(b, b_offset, "b")
        text += f"""assert(arrays_equal(@a, @b) 
    == {'true' if should_equal else 'false'}, 
    'Should {'' if should_equal else 'not'} equal!'
);"""
        return text

    def generate_array_empty_test():
        lines = [
            "let a: Array<u8> = ArrayTrait::new();",
            "let b: Array<u8> = ArrayTrait::new();",
            "assert(arrays_equal(@a, @b), 'Should equal');",
        ]
        return "\n".join(lines)


def byte_array(number: int):
    return number.to_bytes(256 // 8, "big")


def shift_array(array: bytes, offset: int):
    return b"\x00" * offset + array


def number_to_b_array(number, offset=0):
    return shift_array(byte_array(number), offset)


def append_bytes_to_cairo_arr(arr_name: str, bytes: bytes) -> List[str]:
    return [f"{arr_name}.append({hex(b)});" for b in bytes]


def generate_cairo_array(number, offset, arr_name) -> str:
    byte_arr = number_to_b_array(number, offset)
    declare = [f"let mut {arr_name}: Array<u8> = ArrayTrait::new();"]
    appending = append_bytes_to_cairo_arr(arr_name, byte_arr)
    return "\n".join(declare + appending) + "\n"

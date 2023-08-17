from structure import TestSuite
from verify_ecdsa_test import VerifyECDSATest


def main():
    suite = TestSuite("src/tests", "src/tests.cairo")
    suite.add_test_file(VerifyECDSATest().test_file())
    suite.generate(delete_old_tests=True)


if __name__ == "__main__":
    main()

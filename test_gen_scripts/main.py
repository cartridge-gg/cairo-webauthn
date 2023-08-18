from structure import TestSuite
from verify_ecdsa_test import VerifyECDSATest
from helpers_test import HelpersTest
from verify_signature_test import VerifySignatureTest


def main():
    suite = TestSuite("src/tests", "src/tests.cairo")
    suite.add_test_file(VerifyECDSATest().test_file())
    suite.add_test_file(HelpersTest().test_file())
    suite.add_test_file(VerifySignatureTest().test_file())
    suite.generate(delete_old_tests=True)


if __name__ == "__main__":
    main()
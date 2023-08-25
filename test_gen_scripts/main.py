from structure import TestSuite
from verify_ecdsa_test import VerifyECDSATest
from helpers_test import HelpersTest
from verify_signature_test import VerifySignatureTest
from expand_auth_data_test import ExpandAuthDataTest
from webauthn_test import WebauthnTest


def main():
    suite = TestSuite("src/auth/src/tests", "src/auth/src/tests.cairo")
    suite.add_test_file(VerifyECDSATest().test_file())
    suite.add_test_file(HelpersTest().test_file())
    suite.add_test_file(VerifySignatureTest().test_file())
    suite.add_test_file(ExpandAuthDataTest().test_file())
    suite.add_test_file(WebauthnTest().test_file())
    suite.generate(delete_old_tests=True)


if __name__ == "__main__":
    main()

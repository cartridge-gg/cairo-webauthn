from structure import TestSuite
from auth.verify_ecdsa_test import VerifyECDSATest
from auth.helpers_test import HelpersTest
from auth.verify_signature_test import VerifySignatureTest
from auth.expand_auth_data_test import ExpandAuthDataTest
from auth.webauthn_test import WebauthnTest


def main():
    suite = TestSuite("src/auth/src/tests", "src/auth/src/tests.cairo", "test_gen_scripts/auth")
    suite.add_test_file(VerifyECDSATest())
    suite.add_test_file(HelpersTest())
    suite.add_test_file(VerifySignatureTest())
    suite.add_test_file(ExpandAuthDataTest())
    suite.add_test_file(WebauthnTest())
    suite.generate(delete_old_tests=True)


if __name__ == "__main__":
    main()

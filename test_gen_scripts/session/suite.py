from structure import TestSuite
from session.signature_proofs_test import SignatureProofsTest

def get_session_suite():
    suite = TestSuite("src/session/src/tests", "src/session/src/tests.cairo", "test_gen_scripts/session")
    suite.add_test_file(SignatureProofsTest())
    return suite
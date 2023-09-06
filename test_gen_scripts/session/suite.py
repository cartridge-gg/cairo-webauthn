from structure import TestSuite

def get_session_suite():
    suite = TestSuite("src/session/src/tests", "src/session/src/tests.cairo", "test_gen_scripts/session")
    return suite
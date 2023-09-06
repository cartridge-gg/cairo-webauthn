from auth.suite import get_auth_suite
from session.suite import get_session_suite

def main():
    suites = [
        get_auth_suite(),
        get_session_suite()
    ]
    for suite in suites:
        suite.generate(delete_old_tests=True)

if __name__ == "__main__":
    main()

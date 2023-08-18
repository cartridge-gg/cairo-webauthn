# cairo-webauthn

A library for webauthn credential authentication. 
The library is under development.

## Usage
Use the generic function:
```cairo
verify_authentication_assertion<...>(...)
```
You have to provide corresponding trait implementations, used when the assertion ceremony 'communicates' with the 'outside world'. 
See ```src/webauthn.cairo``` for details.
The function is written based on [this specification](https://www.w3.org/TR/webauthn/#sctn-verifying-assertion).

## Development

### Tests
Some of the tests are auto-generated using python scripts.
See the ```test_gen_scripts``` and  for details. 
The tests in ```src/tests/``` which end in ```_gen_test.cairo``` are auto-generated and might be changed by the python script. You can write your tests manually, but make sure the name of the test file doesn't end in ```_gen_test.cairo```, and you place the import "```use ...;```" below the auto-generated imports in ```src/tests.cairo```.

### Python Enviroment

Use pyenv to have specific version of python easily.
We use python3.9

Old setup:

```sh
pip install -r requirements.txt
python test_gen_scripts/main.py
scarb test
```

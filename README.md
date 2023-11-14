# cairo-webauthn

A library for webauthn credential authentication.
The library is under development.

## Project structure
- **account_sdk** - a rust project to export and test functions for interacting with the custom account contract.
- **cairo_client** - a rust project to test cairo code by directly calling cairo functions from rust.
- **cartidge_account** - a cairo project with a custom account contract.
- **src** - a cairo project with backend methods that will allow for various authentication methods in the custom contact.
- **test_gen_scripts** - a python library to programatically generate cryptographic cairo tests.

The project has a global rust workspace.

## account_sdk
This is a rust project, that will eventually be compiled to wasm. It's purpose is to export and test functions for interacting with the custom account contract. The testing framework implemented within uses [dojo/katana](https://github.com/dojoengine/dojo) underneath. Each test starts its own katana network, deploys a contract and performs operations on it. Naturally, you must have `katana` installed to run the tests. You can specify the path to the `katana` executable in the `account_sdk/KatanaConfig.toml` file. Note that if you have `dojo` installed the path can remain simply as `katana`.

### Running the tests
To run the tests you first have to compile (to sierra and casm) the contract in the `cartidge_account` folder:
```bash
cd cartidge_account
scarb build
cd ..
```
After the contract is compiled run the tests using `cargo`:
```bash
cd account_sdk
cargo test
```
The scarb builds the contract and saves the compiled code in the `cartridge_account/target` folder. The tests then fetch (at compile time) the comipled code and deploy it to the local network. Note that obviously the contract needs to be recompiled for any changes to be applied in the compiled code.

## src
This is a cairo project with backend methods that will allow for various authentication methods in the custom contact.
Written based on [this specification](https://www.w3.org/TR/webauthn/).

### Running the tests

Some of the tests are auto-generated using python scripts.
See the `test_gen_scripts` for details.
The tests in `src/tests/` which end in `_gen_test.cairo` are auto-generated and might be changed by the python script. You can write your tests manually, but make sure the name of the test file doesn't end in `_gen_test.cairo`, and you place the import "`use ...;`" below the auto-generated imports in `src/tests.cairo`.

To run the tests:

```shell
scarb test
```

To again generate the tests:

```shell
python test_gen_scripts/main.py
```
## test_gen_scripts
This is a python library to programatically generate cryptographic cairo tests.

### Python Enviroment

Use pyenv to have specific version of python easily.
We use python3.9

```sh
pip install -r requirements.txt
python test_gen_scripts/main.py
```

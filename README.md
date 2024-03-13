# cairo-webauthn

A library for webauthn credential authentication.
The library is under development.

## Project structure
The project consists of several subfolders located in the ```crates``` directory:

- **account_sdk** - a rust project to export and test functions for interacting with the custom account contract.
- **cartidge_account** - a cairo project with a custom account contract.
- **webauthn** - cairo components to use in contracts.

The project has a global rust workspace.

## account_sdk

This is a rust project, that will eventually be compiled to wasm. It's purpose is to export and test functions for interacting with the custom account contract. The testing framework implemented within uses [dojo/katana](https://github.com/dojoengine/dojo) underneath. Each test starts its own katana network, deploys a contract and performs operations on it. Naturally, you must have `katana` installed to run the tests. You can specify the path to the `katana` executable in the `account_sdk/KatanaConfig.toml` file. Note that if you have `dojo` installed and in `PATH` the path can remain simply as `katana`.


### Compiling the cairo code

To build rust you first have to compile cairo. Run

```bash
make
```

in the root directory.

### Building for web assembly

After you've compiled the cairo code you can compile rust to wasm using

```bash
cargo build -p account-sdk --target wasm32-unknown-unknown  --release
```

## Running the tests

Note, that to run the tests you first have to [compile](#compiling-the-cairo-code) (to sierra and casm) the contract in the `cartidge_account` folder.

StarkNet Foundry tests:

```bash
snforge test -p cartridge_account
```

Scarb tests:

```bash
scarb test -p webauthn_*
```

After the contract is compiled run the tests using `cargo`:

```bash
cargo test
```

The scarb builds the contract and saves the compiled code in the `cartridge_account/target` folder. The tests then fetch (at compile time) the comipled code and deploy it to the local network. Note that obviously the contract needs to be recompiled for any changes to be applied in the compiled code.

## webauthn

This is a cairo project with backend methods that will allow for various authentication methods in the custom contact.
Written based on [this specification](https://www.w3.org/TR/webauthn/).

### Running the tests

You can run scarb test to run a few hand-written tests inside each ```auth``` and ```session``` crates. The bulk of the tests are located in the ```tests``` directory. These tests are written in rust and use property based testing provided by the [proptest](https://docs.rs/proptest/latest/proptest/) crate and use [cairo args runner](https://github.com/neotheprogramist/cairo-args-runner) to interface with and call cairo functions. To run these tests ```cd``` to the ```crates/webauthn/tests``` directory and run:
```bash
cargo test
```

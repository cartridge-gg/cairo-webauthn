# Starkli config.
config := --account katana-0 \
	--rpc http://0.0.0.0:5050

# Build files helpers.
build := ./cartridge_account/target/dev/cartridge_account_
sierra := .contract_class.json
artifacts := ./abi/

# Contract params for deploy.
test_pubkey = 0x1234
katana_0 = 0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973

generate_artifacts:
	scarb --manifest-path ./cartridge_account/Scarb.toml build
	mkdir -p ${artifacts}

	jq .abi ${build}Account${sierra} > ${artifacts}account.abi.json
	jq .abi ${build}ERC20${sierra} > ${artifacts}erc20.abi.json

deploy-katana:
	@set -x; \
	erc20_class=$$(starkli class-hash ${build}ERC20${sierra}); \
	account_class=$$(starkli class-hash ${build}Account${sierra}); \
	starkli declare ${build}Account${sierra} ${config}; \
	starkli deploy "$${account_class}" ${test_pubkey} --salt 0x1234 ${config}; \
	starkli declare ${build}ERC20${sierra} ${config}; \
	starkli deploy "$${erc20_class}" str:token str:tkn u256:1 ${katana_0} --salt 0x1234 ${config};

test-session: generate_artifacts
	rm -rf ./account_sdk/log
	cargo test --manifest-path account_sdk/Cargo.toml session -- --nocapture

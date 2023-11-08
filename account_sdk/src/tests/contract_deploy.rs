
use std::sync::Arc;

use starknet::{
    accounts::{Account, ExecutionEncoding, SingleOwnerAccount},
    core::types::{
        contract::{CompiledClass, SierraClass},
        BlockId, BlockTag, FieldElement, FunctionCall,
    },
    macros::selector,
    providers::Provider,
    signers::{LocalWallet, SigningKey},
};

use crate::katana::{RpcClientProvider, KatanaRunnerConfig, KatanaRunner};

#[tokio::test]
async fn test_contract_deploy() {
    // Sierra class artifact. Output of the `starknet-compile` command
    let contract_artifact: SierraClass = serde_json::from_reader(
        std::fs::File::open(
            "../cartridge_account/target/dev/cartridge_account_Account.sierra.json",
        )
        .unwrap(),
    )
    .unwrap();

    // Class hash of the compiled CASM class from the `starknet-sierra-compile` command
    let compiled_class: CompiledClass = serde_json::from_reader(
        std::fs::File::open("../cartridge_account/target/dev/cartridge_account_Account.casm.json")
            .unwrap(),
    )
    .unwrap();
    let compiled_class_hash = compiled_class.class_hash().unwrap();

    let runner = KatanaRunner::new(KatanaRunnerConfig::from_file("KatanaConfig.toml"));

    let provider = runner.get_provider();
    let signing_key = SigningKey::from_secret_scalar(
        FieldElement::from_hex_be("0x1800000000300000180000000000030000000000003006001800006600")
            .unwrap(),
    );
    let signer = LocalWallet::from(signing_key.clone());
    let address = FieldElement::from_hex_be(
        "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973",
    )
    .unwrap();

    let mut account = SingleOwnerAccount::new(
        provider,
        signer,
        address,
        runner.chain_id(),
        ExecutionEncoding::New,
    );

    // `SingleOwnerAccount` defaults to checking nonce and estimating fees against the latest
    // block. Optionally change the target block to pending with the following line:
    account.set_block_id(BlockId::Tag(BlockTag::Pending));

    // We need to flatten the ABI into a string first
    let flattened_class = contract_artifact.flatten().unwrap();

    let declaration = account.declare(Arc::new(flattened_class), compiled_class_hash);

    let result = declaration.send().await.unwrap();

    dbg!(result);

    let hash = FieldElement::from_hex_be(
        "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973",
    )
    .unwrap();
    let _signature = signing_key.sign(&hash).unwrap();

    let call_result = runner.get_provider()
        .call(
            FunctionCall {
                contract_address: address,
                entry_point_selector: selector!("getPublicKey"),
                calldata: vec![],
            },
            BlockId::Tag(BlockTag::Latest),
        )
        .await
        .expect("failed to call contract");

    dbg!(call_result);
}
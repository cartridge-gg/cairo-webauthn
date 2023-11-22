use std::sync::Arc;

use starknet::{
    accounts::{Account, ExecutionEncoding, SingleOwnerAccount},
    core::types::{
        contract::{CompiledClass, SierraClass},
        BlockId, BlockTag, DeclareTransactionResult, FieldElement,
    },
    macros::{felt, selector},
    providers::Provider,
    signers::LocalWallet,
};

use crate::{
    deploy_contract::{account_for_address, CustomContract, CASM_STR, SIERRA_STR},
    deployer::{Declarable, TxConfig},
    providers::{KatanaProvider, KatanaRunner, KatanaRunnerConfig, FEE_TOKEN_ADDRESS, PREFUNDED},
    rpc_provider::RpcClientProvider,
    tests::find_free_port,
};

use starknet::accounts::Call;

#[cfg(test)]
const DEFAULT_UDC_ADDRESS: FieldElement = FieldElement::from_mont([
    15144800532519055890,
    15685625669053253235,
    9333317513348225193,
    121672436446604875,
]);

#[tokio::test]
async fn test_contract_call_problem_2() {
    let runner = KatanaRunner::new(
        KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    );
    let (signing_key, address) = PREFUNDED.clone();
    let provider = RpcClientProvider::from(runner).get_client();

    let signer = LocalWallet::from(signing_key);
    let chain_id = provider.chain_id().await.unwrap();
    dbg!(chain_id);
    let mut prefunded: SingleOwnerAccount<
        starknet::providers::JsonRpcClient<starknet::providers::jsonrpc::HttpTransport>,
        LocalWallet,
    > = SingleOwnerAccount::new(provider, signer, address, chain_id, ExecutionEncoding::New);
    prefunded.set_block_id(BlockId::Tag(BlockTag::Pending));
    // Contract
    let contract_artifact: SierraClass = serde_json::from_str(SIERRA_STR)
        .map_err(|e| e.to_string())
        .unwrap();

    // Class hash of the compiled CASM class from the `starknet-sierra-compile` command
    let compiled_class: CompiledClass = serde_json::from_str(CASM_STR)
        .map_err(|e| e.to_string())
        .unwrap();
    let casm_class_hash = compiled_class
        .class_hash()
        .map_err(|e| e.to_string())
        .unwrap();

    // We need to flatten the ABI into a string first
    let flattened_class = contract_artifact
        .flatten()
        .map_err(|e| e.to_string())
        .unwrap();

    let declaration = prefunded.declare(Arc::new(flattened_class), casm_class_hash);

    let DeclareTransactionResult { class_hash, .. } = declaration.send().await.unwrap();

    let target_deployment_address = class_hash;

    prefunded
        .execute(vec![Call {
            to: *FEE_TOKEN_ADDRESS,
            selector: selector!("transfer"),
            calldata: vec![target_deployment_address, felt!("0x10"), felt!("0x0")],
        }])
        .send()
        .await
        .unwrap();

    let constructor_calldata = vec![PREFUNDED.0.verifying_key().scalar()];
    let calldata = [
        vec![
            class_hash,
            FieldElement::ZERO, // salt
            FieldElement::ZERO, // unique
            FieldElement::from(constructor_calldata.len()),
        ],
        constructor_calldata,
    ]
    .concat();

    prefunded
        .execute(vec![Call {
            calldata,
            selector: selector!("deployContract"),
            to: DEFAULT_UDC_ADDRESS,
        }])
        .send()
        .await
        .unwrap();

    prefunded
        .execute(vec![Call {
            to: target_deployment_address,
            selector: selector!("getPublicKey"),
            calldata: vec![],
        }])
        .send()
        .await
        .unwrap();
}

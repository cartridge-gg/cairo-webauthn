use std::sync::Arc;

use starknet::{
    accounts::Account,
    contract::ContractFactory,
    core::types::{
        contract::{CompiledClass, SierraClass},
        DeclareTransactionResult,
    },
    macros::{felt, selector},
};

use crate::{
    deploy_contract::{CASM_STR, SIERRA_STR},
    providers::{
        katana::KatanaProvider, katana_runner::KatanaRunner, prefunded, PredeployedClientProvider,
    },
};

use starknet::accounts::Call;

#[tokio::test]
async fn test_flow() {
    let runner = KatanaRunner::load();
    let network = KatanaProvider::from(&runner);
    let factory = prefunded(&network).await; // Same as account
    let prefunded = prefunded(&network).await;

    // Contract
    let contract_artifact: SierraClass = serde_json::from_str(SIERRA_STR)
        .map_err(|e| e.to_string())
        .unwrap();
    let compiled_class: CompiledClass = serde_json::from_str(CASM_STR)
        .map_err(|e| e.to_string())
        .unwrap();
    let casm_class_hash = compiled_class
        .class_hash()
        .map_err(|e| e.to_string())
        .unwrap();

    let flattened_class = contract_artifact
        .flatten()
        .map_err(|e| e.to_string())
        .unwrap();

    // Declare
    let declaration = prefunded.declare(Arc::new(flattened_class), casm_class_hash);
    let DeclareTransactionResult { class_hash, .. } = declaration.send().await.unwrap();

    // Deploy
    let contract_factory =
        ContractFactory::new_with_udc(class_hash, factory, network.predeployed_udc().address);

    let deployment = contract_factory.deploy(
        // vec![network.prefounded_account().public_key],
        vec![felt!("2137")],
        felt!("2137"),
        false,
    );
    let deployed_address = deployment.deployed_address();
    deployment.send().await.expect("Unable to deploy contract");

    // Use
    prefunded
        .execute(vec![Call {
            to: deployed_address,
            selector: selector!("getZero"),
            calldata: vec![],
        }])
        .send()
        .await
        .unwrap();
}

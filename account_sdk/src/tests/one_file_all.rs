use std::sync::Arc;

use starknet::{
    accounts::{
        Account, AccountFactory, ExecutionEncoding, OpenZeppelinAccountFactory, SingleOwnerAccount,
    },
    core::types::{
        contract::{CompiledClass, SierraClass},
        BlockId, BlockTag, DeclareTransactionResult, FieldElement,
    },
    macros::selector,
    providers::Provider,
    signers::LocalWallet,
};

use crate::{
    account_factory::AnyAccountFactory,
    deploy_contract::{get_account, CustomContract, CASM_STR, SIERRA_STR},
    deployer::{Declarable, TxConfig},
    katana::{KatanaClientProvider, KatanaRunner, KatanaRunnerConfig},
    rpc_provider::RpcClientProvider,
    tests::{find_free_port, get_key_and_address_devnet},
};

use starknet::accounts::Call;

#[allow(dead_code)]
/// The default UDC address: 0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf.
const DEFAULT_UDC_ADDRESS: FieldElement = FieldElement::from_mont([
    15144800532519055890,
    15685625669053253235,
    9333317513348225193,
    121672436446604875,
]);

#[tokio::test]
async fn test_contract_call_problem_2() {
    // let runner = KatanaRunner::new(
    //     KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    // );
    let (signing_key, address) = get_key_and_address_devnet();
    let provider = KatanaClientProvider::from(&5050).get_client();

    let signer = LocalWallet::from(signing_key);
    let chain_id = provider.chain_id().await.unwrap();
    let mut prefunded =
        SingleOwnerAccount::new(provider, signer, address, chain_id, ExecutionEncoding::New);
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

    // let class_hash = declare_result.class_hash;
    // dbg!(class_hash);

    // let mut factory = OpenZeppelinAccountFactory::new(
    //     class_hash,
    //     starknet::core::chain_id::TESTNET,
    //     signer,
    //     provider.get_client(),
    // )
    // .await
    // .unwrap();
    // factory.set_block_id(BlockId::Tag(BlockTag::Pending));

    // let factory = AnyAccountFactory::OpenZeppelin(factory);

    // // https://github.com/xJonathanLEI/starkli/blob/master/src/subcommands/account/deploy.rs
    // // todo!("Implement starknet::providers::Provider for KatanaClientProvider");
    // let account_deployment = factory.deploy(FieldElement::ZERO);
    // let target_deployment_address = account_deployment.address();

    // dbg!(target_deployment_address);

    // let account = dbg!(get_account(provider, signing_key, address));
    // let _call_result = dbg!(account
    //     .execute(vec![Call {
    //         to: target_deployment_address,
    //         selector: selector!("getPublicKey"),
    //         calldata: vec![],
    //     }])
    //     .send()
    //     .await
    //     .unwrap());
}

// #[tokio::test]
// async fn test_contract_call_problem() {
//     let runner = KatanaRunner::new(
//         KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
//     );
//     let (signing_key, address) = get_key_and_address();

//     let provider = KatanaClientProvider::from(&runner);
//     let _result = deploy_contract(provider, signing_key.clone(), address)
//         .await
//         .unwrap();

//     let call_result = provider
//         .get_client()
//         .call(
//             FunctionCall {
//                 contract_address: address,
//                 entry_point_selector: selector!("getZero"),
//                 calldata: vec![],
//             },
//             BlockId::Tag(BlockTag::Latest),
//         )
//         .await
//         .expect("failed to call contract");
//     assert_eq!(FieldElement::ZERO, call_result[0])
// }

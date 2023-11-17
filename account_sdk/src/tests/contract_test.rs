use cairo_lang_starknet::abi::Contract;
use starknet::{
    core::types::{BlockId, BlockTag, FieldElement, FunctionCall},
    macros::selector,
    providers::Provider,
    signers::SigningKey,
};

use crate::{
    deploy_contract::{declare_and_deploy_contract, deploy_contract, get_account, CustomContract},
    katana::{KatanaClientProvider, KatanaRunner, KatanaRunnerConfig},
    rpc_provider::RpcClientProvider,
    tests::find_free_port, deployer::{Deployable, TxConfig, read_class, Declarable, get_compiled_class_hash},
};

use starknet::accounts::{Account, Call};

fn get_key_and_address() -> (SigningKey, FieldElement) {
    let signing_key = SigningKey::from_secret_scalar(
        FieldElement::from_hex_be("0x1800000000300000180000000000030000000000003006001800006600")
            .unwrap(),
    );
    let address = FieldElement::from_hex_be(
        "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973",
    )
    .unwrap();
    (signing_key, address)
}

#[tokio::test]
async fn test_contract_call_problem_2() {
    let runner = KatanaRunner::new(
        KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    );
    let (signing_key, address) = get_key_and_address();

    let provider = KatanaClientProvider::from(&runner);
    let public_key = signing_key.verifying_key().scalar();
    let custom_contract = CustomContract;
    let account = get_account(provider, signing_key, address);
    let class_hash = provider.get_client().get_class_hash_at(BlockId::Tag(BlockTag::Pending), address).await.unwrap();
    dbg!(class_hash);


    let _result = dbg!(custom_contract.deploy(class_hash, vec![public_key], &account, TxConfig::default()).await);

    let _call_result = account
        .execute(vec![Call {
            to: address,
            selector: selector!("getZero"),
            calldata: vec![],
        }])
        .send()
        .await
        .unwrap();
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

use starknet::{
    accounts::{Account, OpenZeppelinAccountFactory},
    core::types::{BlockId, BlockTag, FieldElement},
    macros::selector,
    providers::Provider,
    signers::{LocalWallet, SigningKey},
};

use crate::{
    account_factory::AnyAccountFactory,
    deploy_contract::get_account,
    katana::{KatanaClientProvider, KatanaRunner, KatanaRunnerConfig},
    rpc_provider::RpcClientProvider,
    tests::find_free_port,
};

use starknet::accounts::Call;

/// The default UDC address: 0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf.
const DEFAULT_UDC_ADDRESS: FieldElement = FieldElement::from_mont([
    15144800532519055890,
    15685625669053253235,
    9333317513348225193,
    121672436446604875,
]);

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
    let signer = LocalWallet::from_signing_key(signing_key.clone());

    let provider = KatanaClientProvider::from(&runner);
    let public_key = signing_key.verifying_key().scalar();
    let account = get_account(provider, signing_key.clone(), address);
    let class_hash = provider
        .get_client()
        .get_class_hash_at(BlockId::Tag(BlockTag::Pending), address)
        .await
        .unwrap();
    dbg!(class_hash);

    let mut factory = OpenZeppelinAccountFactory::new(
        class_hash,
        starknet::core::chain_id::TESTNET,
        signer,
        provider.clone(),
    )
    .await
    .unwrap();
    factory.set_block_id(BlockId::Tag(BlockTag::Pending));

    let factory = AnyAccountFactory::OpenZeppelin(factory);

    // https://github.com/xJonathanLEI/starkli/blob/master/src/subcommands/account/deploy.rs
    // todo!("Implement starknet::providers::Provider for KatanaClientProvider");
    // let account_deployment = factory.deploy(FieldElement::ZERO);
    // let target_deployment_address = account.deploy_account_address()?;

    // dbg!(target_deployment_address);

    let account = get_account(provider, signing_key, address);
    // let _call_result = account
    //     .execute(vec![Call {
    //         to: target_deployment_address,
    //         selector: selector!("getPublicKey"),
    //         calldata: vec![],
    //     }])
    //     .send()
    //     .await
    //     .unwrap();
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

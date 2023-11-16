use starknet::{
    core::types::{BlockId, BlockTag, FieldElement, FunctionCall},
    macros::selector,
    providers::Provider,
    signers::SigningKey,
};

use crate::{
    deploy_contract::deploy_contract,
    katana::{KatanaClientProvider, KatanaRunner, KatanaRunnerConfig},
    rpc_provider::RpcClientProvider,
    tests::find_free_port,
};

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
async fn test_contract_deploy() {
    let runner = KatanaRunner::new(
        KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    );
    let (signing_key, address) = get_key_and_address();

    let provider = KatanaClientProvider::from(&runner);
    let _result = deploy_contract(provider, signing_key.clone(), address)
        .await
        .unwrap();

    let hash = FieldElement::from_hex_be(
        "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973",
    )
    .unwrap();
    let _signature = signing_key.sign(&hash).unwrap();
}

#[tokio::test]
async fn test_contract_call() {
    let runner = KatanaRunner::new(
        KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    );
    let (signing_key, address) = get_key_and_address();

    let provider = KatanaClientProvider::from(&runner);
    let _result = deploy_contract(provider, signing_key.clone(), address)
        .await
        .unwrap();

    let call_result = provider
        .get_client()
        .call(
            FunctionCall {
                contract_address: address,
                entry_point_selector: selector!("setPublicKey2"),
                calldata: vec![],
            },
            BlockId::Tag(BlockTag::Latest),
        )
        .await
        .expect("failed to call contract");
    assert_eq!(
        FieldElement::from_hex_be(
            "0x2b191c2f3ecf685a91af7cf72a43e7b90e2e41220175de5c4f7498981b10053"
        )
        .unwrap(),
        call_result[0]
    )
}

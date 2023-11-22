use starknet::{
    accounts::{Account, Call},
    core::types::{BlockId, BlockTag, FunctionCall},
    macros::{felt, selector},
    providers::Provider,
};

use crate::{
    deploy_contract::declare_and_deploy_contract,
    providers::{
        katana::KatanaProvider, katana_runner::KatanaRunner, prefounded, PredeployedClientProvider,
        PrefoundedClientProvider, RpcClientProvider,
    },
};

#[tokio::test]
#[ignore = "not ready yet"]
async fn test_new_deploy() {
    let runner = KatanaRunner::load();
    let provider = KatanaProvider::from(&runner);
    let prfd_account = provider.prefounded_account();
    declare_and_deploy_contract(
        &provider,
        prfd_account.signing_key(),
        prfd_account.account_address,
        vec![prfd_account.public_key],
    )
    .await
    .unwrap();
}

// Starknet devnet
// cargo run -- --port 1234 --seed 0

#[tokio::test]
async fn test_balance_of() {
    let runner = KatanaRunner::load();
    let network = KatanaProvider::from(&runner);
    let account = prefounded(&network).await;

    let call_result: Vec<starknet::core::types::FieldElement> = network
        .get_client()
        .call(
            FunctionCall {
                contract_address: network.predeployed_fee_token().address,
                entry_point_selector: selector!("balanceOf"),
                calldata: vec![account.address()],
            },
            BlockId::Tag(BlockTag::Latest),
        )
        .await
        .expect("failed to call contract");

    dbg!(call_result);
}

#[tokio::test]
async fn test_balance_of_account() {
    let runner = KatanaRunner::load();
    let network = KatanaProvider::from(&runner);
    let account = prefounded(&network).await;

    let call_result = account
        .execute(vec![Call {
            to: network.predeployed_fee_token().address,
            selector: selector!("balanceOf"),
            calldata: vec![account.address()],
        }])
        .send()
        .await
        .unwrap();

    dbg!(call_result);
}

#[tokio::test]
async fn test_transfer() {
    let runner = KatanaRunner::load();
    let network = KatanaProvider::from(&runner);
    let new_account = felt!("0x78662e7352d062084b0010068b99288486c2d8b914f6e2a55ce945f8792c8b1");
    let account = prefounded(&network).await;

    let call_result = account
        .execute(vec![Call {
            to: network.predeployed_fee_token().address,
            selector: selector!("balanceOf"),
            calldata: vec![new_account],
        }])
        .send()
        .await
        .unwrap();
    dbg!(call_result);

    let call_result = account
        .execute(vec![Call {
            to: network.predeployed_fee_token().address,
            selector: selector!("transfer"),
            calldata: vec![new_account, felt!("0x10"), felt!("0x0")],
        }])
        .send()
        .await
        .unwrap();
    dbg!(call_result);
}

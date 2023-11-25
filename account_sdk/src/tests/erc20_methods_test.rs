use starknet::{
    accounts::{Account, Call},
    core::types::{BlockId, BlockTag, FunctionCall},
    macros::{felt, selector},
    providers::Provider,
};

use super::katana_runner::KatanaRunner;
use crate::deploy_contract::FEE_TOKEN_ADDRESS;

// Starknet devnet
// cargo run -- --port 1234 --seed 0

#[tokio::test]
async fn test_balance_of() {
    let runner = KatanaRunner::load();
    let account = runner.prefunded_single_owner_account().await;

    let call_result: Vec<starknet::core::types::FieldElement> = runner
        .client()
        .call(
            FunctionCall {
                contract_address: *FEE_TOKEN_ADDRESS,
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
    let account = runner.prefunded_single_owner_account().await;

    let call_result = account
        .execute(vec![Call {
            to: *FEE_TOKEN_ADDRESS,
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
    let new_account = felt!("0x78662e7352d062084b0010068b99288486c2d8b914f6e2a55ce945f8792c8b1");
    let account = runner.prefunded_single_owner_account().await;

    let call_result = account
        .execute(vec![Call {
            to: *FEE_TOKEN_ADDRESS,
            selector: selector!("balanceOf"),
            calldata: vec![new_account],
        }])
        .send()
        .await
        .unwrap();
    dbg!(call_result);

    let call_result = account
        .execute(vec![Call {
            to: *FEE_TOKEN_ADDRESS,
            selector: selector!("transfer"),
            calldata: vec![new_account, felt!("0x10"), felt!("0x0")],
        }])
        .send()
        .await
        .unwrap();
    dbg!(call_result);
}

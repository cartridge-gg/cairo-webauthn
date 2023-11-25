use starknet::{
    accounts::{Account, Call},
    core::types::{BlockId, BlockTag, FunctionCall},
    macros::{felt, selector},
    providers::Provider,
};

use super::katana_runner::KatanaRunner;
use crate::deploy_contract::FEE_TOKEN_ADDRESS;

#[tokio::test]
async fn test_balance_of() {
    let runner = KatanaRunner::load();
    let account = runner.prefunded_single_owner_account().await;

    runner
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
}

#[tokio::test]
async fn test_balance_of_account() {
    let runner = KatanaRunner::load();
    let account = runner.prefunded_single_owner_account().await;

    account
        .execute(vec![Call {
            to: *FEE_TOKEN_ADDRESS,
            selector: selector!("balanceOf"),
            calldata: vec![account.address()],
        }])
        .send()
        .await
        .unwrap();
}

#[tokio::test]
async fn test_transfer() {
    let runner = KatanaRunner::load();
    let new_account = felt!("0x18301129");
    let account = runner.prefunded_single_owner_account().await;

    account
        .execute(vec![Call {
            to: *FEE_TOKEN_ADDRESS,
            selector: selector!("balanceOf"),
            calldata: vec![new_account],
        }])
        .send()
        .await
        .unwrap();

    account
        .execute(vec![Call {
            to: *FEE_TOKEN_ADDRESS,
            selector: selector!("transfer"),
            calldata: vec![new_account, felt!("0x10"), felt!("0x0")],
        }])
        .send()
        .await
        .unwrap();
}

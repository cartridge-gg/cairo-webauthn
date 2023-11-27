use starknet::{
    accounts::{Account, Call},
    macros::{felt, selector},
    signers::SigningKey,
};

use super::katana_runner::KatanaRunner;
use crate::deploy_contract::{single_owner_account, FEE_TOKEN_ADDRESS};

use super::deployment_test::{declare, deploy};

#[tokio::test]
async fn test_authorize_execute() {
    let runner = KatanaRunner::load();
    let prefunded = runner.prefunded_single_owner_account().await;
    let class_hash = declare(runner.client(), &prefunded).await;
    let private_key = SigningKey::from_random();
    let deployed_address = deploy(
        runner.client(),
        &prefunded,
        private_key.verifying_key().scalar(),
        class_hash,
    )
    .await;

    let new_account = single_owner_account(runner.client(), private_key, deployed_address).await;

    prefunded
        .execute(vec![Call {
            to: *FEE_TOKEN_ADDRESS,
            selector: selector!("transfer"),
            calldata: vec![new_account.address(), felt!("0x10000000"), felt!("0x0")],
        }])
        .send()
        .await
        .unwrap();

    new_account
        .execute(vec![Call {
            to: prefunded.address(),
            selector: selector!("getPublicKey"),
            calldata: vec![],
        }])
        .send()
        .await
        .unwrap();
}

use starknet::{
    accounts::{Account, Call},
    core::types::{BlockId, BlockTag, FunctionCall},
    macros::{felt, selector},
    providers::Provider,
    signers::SigningKey,
};

use crate::{
    deploy_contract::{single_owner_account, FEE_TOKEN_ADDRESS},
    tests::runners::{katana_runner::KatanaRunner, TestnetRunner},
    webauthn_signer::{P256r1Signer, cairo_args::VerifyWebauthnSignerArgs}, felt_ser::to_felts,
};

use super::deployment_test::{declare, deploy};

#[tokio::test]
async fn test_public_key_point() {
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
            calldata: vec![
                new_account.address(),
                felt!("0x8944000000000000"),
                felt!("0x0"),
            ],
        }])
        .send()
        .await
        .unwrap();

    let signer = P256r1Signer::random("localhost".into());

    let response = signer.sign("aaaa".into());
    let calldata = VerifyWebauthnSignerArgs::from((signer.public_key_bytes(), response.clone()));
    dbg!(&calldata);

    let result = runner
        .client()
        .call(
            FunctionCall {
                contract_address: new_account.address(),
                entry_point_selector: selector!("verifyWebauthnSigner"),
                calldata: to_felts(&calldata),
            },
            BlockId::Tag(BlockTag::Latest),
        )
        .await
        .expect("failed to call contract");

    // let result = new_account.execute(vec![Call {
    //     to: new_account.address(),
    //     selector: selector!("verifyWebauthnSigner"),
    //     calldata,
    // }]).send().await.unwrap();

    dbg!(result);
}

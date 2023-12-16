use cainome::cairo_serde::ContractAddress;
use starknet::{
    accounts::Account,
    core::types::{BlockId, BlockTag},
    signers::SigningKey,
};

use crate::abigen::account::CartridgeAccountReader;
use crate::abigen::erc20::{Erc20Contract, U256};
use crate::{
    deploy_contract::{single_owner_account, FEE_TOKEN_ADDRESS},
    tests::runners::{katana_runner::KatanaRunner, TestnetRunner},
    webauthn_signer::{cairo_args::VerifyWebauthnSignerArgs, P256r1Signer},
};

use super::deployment_test::{declare, deploy};

#[tokio::test]
async fn test_verify_webauthn_signer() {
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

    let erc20_prefunded = Erc20Contract::new(*FEE_TOKEN_ADDRESS, prefunded);

    erc20_prefunded
        .transfer(
            &ContractAddress(new_account.address()),
            &U256 {
                low: 0x8944000000000000_u128,
                high: 0,
            },
        )
        .send()
        .await
        .unwrap();

    let origin = "localhost".to_string();
    let signer = P256r1Signer::random(origin.clone());
    let challenge = "aaaa".to_string();
    let response = signer.sign(challenge.clone());

    let args = VerifyWebauthnSignerArgs::from_response(
        signer.public_key_bytes(),
        origin,
        challenge.into_bytes(),
        response.clone(),
    );

    let new_account = CartridgeAccountReader::new(new_account.address(), runner.client());

    let result = new_account
        .verifyWebauthnSigner(
            &args.pub_x.into(),
            &args.pub_y.into(),
            &args.r.into(),
            &args.s.into(),
            &args.type_offset,
            &args.challenge_offset,
            &args.origin_offset,
            &args.client_data_json,
            &args.challenge,
            &args.origin,
            &args.authenticator_data,
        )
        .block_id(BlockId::Tag(BlockTag::Latest))
        .call()
        .await
        .unwrap();

    assert!(result);
}

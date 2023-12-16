use cainome::cairo_serde::ContractAddress;
use starknet::{
    accounts::{Account, ConnectedAccount, Execution},
    core::types::{BlockId, BlockTag, FieldElement},
    signers::SigningKey,
};

use crate::{
    abigen::account::{
        CartridgeAccount, CartridgeAccountReader, WebauthnPubKey, WebauthnSignature,
    },
    transaction_waiter::TransactionWaiter,
};
use crate::{
    abigen::erc20::{Erc20Contract, U256},
    webauthn_signer::{account::WebauthnAccount, cairo_args::pub_key_to_felts},
};
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

    let args =
        VerifyWebauthnSignerArgs::from_response(origin, challenge.into_bytes(), response.clone());

    let new_account_reader = CartridgeAccountReader::new(new_account.address(), runner.client());
    let new_account_executor = CartridgeAccount::new(new_account.address(), new_account.clone());

    let (pub_x, pub_y) = pub_key_to_felts(signer.public_key_bytes());
    let set_execution: Execution<'_, _> = new_account_executor.setWebauthnPubKey(&WebauthnPubKey {
        x: pub_x.into(),
        y: pub_y.into(),
    });
    let max_fee = set_execution.estimate_fee().await.unwrap().overall_fee * 2;
    let set_execution = set_execution
        .nonce(new_account.get_nonce().await.unwrap())
        .max_fee(FieldElement::from(max_fee))
        .prepared()
        .unwrap();
    let set_tx = set_execution.transaction_hash(false);

    set_execution.send().await.unwrap();

    TransactionWaiter::new(set_tx, runner.client())
        .await
        .unwrap();

    dbg!(new_account_reader
        .getWebauthnPubKey()
        .block_id(BlockId::Tag(BlockTag::Latest))
        .call()
        .await
        .unwrap());

    let signature = WebauthnSignature {
        r: args.r.into(),
        s: args.s.into(),
        type_offset: args.type_offset,
        challenge_offset: args.challenge_offset,
        origin_offset: args.origin_offset,
        client_data_json: args.client_data_json,
        challenge: args.challenge,
        origin: args.origin,
        authenticator_data: args.authenticator_data,
    };

    let result = new_account_reader
        .verifyWebauthnSigner(&signature, &FieldElement::from(0_usize))
        .block_id(BlockId::Tag(BlockTag::Latest))
        .call()
        .await
        .unwrap();

    dbg!(result);
    assert!(result);

    let webauthn_executor = CartridgeAccount::new(
        new_account.address(),
        WebauthnAccount::new(
            runner.client(),
            signer,
            new_account.address(),
            new_account.chain_id(),
        ),
    );
    let result = webauthn_executor
        .setWebauthnPubKey(&WebauthnPubKey {
            x: pub_x.into(),
            y: pub_y.into(),
        })
        .send()
        .await
        .unwrap();
    dbg!(result);
}

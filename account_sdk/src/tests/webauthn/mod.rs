mod utils;

use starknet::{
    core::types::{BlockId, BlockTag},
    signers::SigningKey,
};

use crate::abigen::account::WebauthnSignature;
use crate::{
    abigen,
    tests::runners::devnet_runner::DevnetRunner,
    webauthn_signer::{cairo_args::VerifyWebauthnSignerArgs, P256r1Signer},
};

#[tokio::test]
async fn test_set_webauthn_public_key() {
    let private_key = SigningKey::from_random();
    let origin = "localhost".to_string();
    let signer = P256r1Signer::random(origin.clone());

    let data = utils::WebauthnTestData::<DevnetRunner>::new(private_key, signer).await;
    let reader = data.account_reader();

    let public_key = reader
        .getWebauthnPubKey()
        .block_id(BlockId::Tag(BlockTag::Latest))
        .call()
        .await
        .unwrap();

    match public_key {
        abigen::account::Option::Some(_) => panic!("Public key already set"),
        abigen::account::Option::None => (),
    }

    data.set_webauthn_public_key().await;

    let public_key = reader
        .getWebauthnPubKey()
        .block_id(BlockId::Tag(BlockTag::Latest))
        .call()
        .await
        .unwrap();

    match public_key {
        abigen::account::Option::Some(_) => (),
        abigen::account::Option::None => panic!("Public key not set"),
    }
}

#[tokio::test]
async fn test_verify_webauthn_explicit() {
    let private_key = SigningKey::from_random();
    let origin = "localhost".to_string();
    let signer = P256r1Signer::random(origin.clone());

    let data = utils::WebauthnTestData::<DevnetRunner>::new(private_key, signer).await;
    data.set_webauthn_public_key().await;
    let reader = data.account_reader();

    let challenge = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa".as_bytes();
    let response = data.signer.sign(challenge);

    let args =
        VerifyWebauthnSignerArgs::from_response(origin, challenge.to_vec(), response.clone());

    let signature = WebauthnSignature {
        r: args.r.into(),
        s: args.s.into(),
        type_offset: args.type_offset,
        challenge_offset: args.challenge_offset,
        origin_offset: args.origin_offset,
        client_data_json: args.client_data_json,
        origin: args.origin,
        authenticator_data: args.authenticator_data,
    };

    let result = reader
        .verifyWebauthnSigner(&signature, &challenge.to_vec())
        .block_id(BlockId::Tag(BlockTag::Latest))
        .call()
        .await
        .unwrap();

    assert!(result);

    // let webauthn_executor = CartridgeAccount::new(
    //     new_account.address(),
    //     WebauthnAccount::new(
    //         runner.client(),
    //         signer,
    //         new_account.address(),
    //         new_account.chain_id(),
    //     ),
    // );
    // let result = webauthn_executor
    //     .setWebauthnPubKey(&WebauthnPubKey {
    //         x: pub_x.into(),
    //         y: pub_y.into(),
    //     })
    //     .send()
    //     .await
    //     .unwrap();
    // dbg!(result);
}

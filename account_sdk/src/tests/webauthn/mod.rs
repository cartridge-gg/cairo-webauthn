mod utils;

use starknet::{
    core::types::{BlockId, BlockTag},
    signers::SigningKey, macros::felt,
};

use crate::abigen::account::WebauthnPubKey;
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

    let challenge = felt!("0x0169af1f6f99d35e0b80e0140235ec4a2041048868071a8654576223934726f5");
    let challenge_bytes = challenge.to_bytes_be().to_vec();
    let response = data.signer.sign(&challenge_bytes);

    let args =
        VerifyWebauthnSignerArgs::from_response(origin, challenge_bytes, response.clone());

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
        .verifyWebauthnSigner(&signature, &challenge)
        .block_id(BlockId::Tag(BlockTag::Latest))
        .call()
        .await
        .unwrap();

    assert!(result);
}

#[tokio::test]
async fn test_verify_webauthn_execute() {
    let private_key = SigningKey::from_random();
    let origin = "localhost".to_string();
    let signer = P256r1Signer::random(origin.clone());

    let data = utils::WebauthnTestData::<DevnetRunner>::new(private_key, signer).await;
    data.set_webauthn_public_key().await;

    let webauthn_executor = data.webauthn_executor().await;
    let (pub_x, pub_y) = data.webauthn_public_key();

    let result = webauthn_executor
        .setWebauthnPubKey(&WebauthnPubKey {
            x: pub_x.into(),
            y: pub_y.into(),
        })
        .send()
        .await;
    result.unwrap();
}

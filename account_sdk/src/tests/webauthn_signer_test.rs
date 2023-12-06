use primitive_types::U256;
use starknet::{
    accounts::{Account, Call},
    core::types::FieldElement,
    macros::selector,
    signers::SigningKey,
};
use u256_literal::u256;

use super::katana_runner::KatanaRunner;
use crate::deploy_contract::single_owner_account;

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
    let pub_x = felt_pair(u256!(
        85361148225729824017625108732123897247053575672172763810522989717862412662042
    ));
    let pub_y = felt_pair(u256!(
        34990362585894687818855246831758567645528911684717374214517047635026995605
    ));

    new_account
        .execute(vec![Call {
            to: new_account.address(),
            selector: selector!("verifyWebauthnSigner"),
            calldata: vec![pub_x.0, pub_x.1, pub_y.0, pub_y.1],
        }])
        .send()
        .await
        .unwrap();
}

fn felt_pair(u: U256) -> (FieldElement, FieldElement) {
    let mut bytes = [0; 32];
    u.to_big_endian(&mut bytes);
    (
        FieldElement::from_bytes_be(&extend_to_32(&bytes[16..32])).unwrap(),
        FieldElement::from_bytes_be(&extend_to_32(&bytes[0..16])).unwrap(),
    )
}

fn extend_to_32(bytes: &[u8]) -> [u8; 32] {
    let mut ret = [0; 32];
    ret[32 - bytes.len()..].copy_from_slice(bytes);
    ret
}

use primitive_types::U256;
use starknet::{
    accounts::{Account, Call},
    core::types::{FieldElement, FunctionCall, BlockId, BlockTag},
    macros::{selector, felt},
    signers::SigningKey, providers::Provider,
};
use u256_literal::u256;

use super::katana_runner::KatanaRunner;
use crate::deploy_contract::{single_owner_account, FEE_TOKEN_ADDRESS};

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
            calldata: vec![new_account.address(), felt!("0x8944000000000000"), felt!("0x0")],
        }])
        .send()
        .await
        .unwrap();

    
    let pub_x = felt_pair(u256!(
        85361148225729824017625108732123897247053575672172763810522989717862412662042
    ));
    let pub_y = felt_pair(u256!(
        34990362585894687818855246831758567645528911684717374214517047635026995605
    ));

    let calldata = vec![pub_x.0, pub_x.1, pub_y.0, pub_y.1];
    dbg!(&calldata);

    let result = runner
        .client()
        .call(
            FunctionCall {
                contract_address: new_account.address(),
                entry_point_selector: selector!("createPoint"),
                calldata,
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

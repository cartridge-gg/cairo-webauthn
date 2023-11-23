use starknet::{
    accounts::{Account, Call},
    macros::{felt, selector},
    signers::SigningKey,
};

use super::deployment_test::declare_and_deploy;
use crate::suppliers::{
    katana::KatanaSupplier, katana_runner::KatanaRunner, AccountData, PredeployedClientSupplier,
    PrefundedClientSupplier,
};

#[tokio::test]
async fn test_authorize_execute() {
    let runner = KatanaRunner::load();
    let supplier = KatanaSupplier::from(&runner);
    let prefunded = supplier.prefunded_single_owner_account().await;
    let private_key = SigningKey::from_random();
    let deployed_address =
        declare_and_deploy(&supplier, &prefunded, private_key.verifying_key().scalar()).await;
    let new_account = supplier
        .single_owner_account(&AccountData::new(
            deployed_address,
            private_key.secret_scalar(),
        ))
        .await;

    prefunded
        .execute(vec![Call {
            to: supplier.predeployed_fee_token().address,
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

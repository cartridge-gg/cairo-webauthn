use starknet::{
    accounts::{Account, AccountError, Call},
    macros::{felt, selector},
    providers::StarknetErrorWithMessage,
    signers::SigningKey,
};

use super::deployment_test::declare_and_deploy;
use crate::suppliers::{
    devnet::DevnetSupplier, katana::KatanaSupplier, katana_runner::KatanaRunner, AccountData,
    PredeployedClientSupplier, PrefundedClientSupplier,
};
use starknet::providers::MaybeUnknownErrorCode::Known;
use starknet::providers::ProviderError::StarknetError;
use starknet::core::types::StarknetError::InsufficientAccountBalance;

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

#[tokio::test]
#[ignore = "This test requires a fresh instance of devnet running and exposed on port 1234"]
async fn test_authorize_execute_devnet() {
    let supplier = DevnetSupplier { port: 1234 };
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
            calldata: vec![
                new_account.address(),
                felt!("10000000000000000"),
                felt!("0x0"),
            ],
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

#[tokio::test]
#[ignore = "This test requires a fresh instance of devnet running and exposed on port 1234"]
async fn test_authorize_execute_devnet_should_fail() {
    let supplier = DevnetSupplier { port: 1234 };
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

    let result = new_account
        .execute(vec![Call {
            to: prefunded.address(),
            selector: selector!("getPublicKey"),
            calldata: vec![],
        }])
        .send()
        .await;

    assert!(matches!(
        result,
        Err(AccountError::Provider(StarknetError(
            StarknetErrorWithMessage {
                code: Known(InsufficientAccountBalance),
                ..
            }
        )))
    ));
}

use starknet::{
    accounts::{Account, Call},
    core::types::{DeclareTransactionResult, FieldElement},
    macros::{felt, selector},
};

use crate::deploy_contract::CustomAccountDeployment;
use crate::{
    deploy_contract::{CustomAccountDeclaration, DeployResult},
    suppliers::{katana::KatanaSupplier, katana_runner::KatanaRunner, PrefoundedClientSupplier},
};

#[tokio::test]
async fn test_declare() {
    let runner = KatanaRunner::load();
    let supplier = KatanaSupplier::from(&runner);
    let account = supplier.prefounded_single_owner().await;
    CustomAccountDeclaration::cartridge_account(&supplier)
        .declare(&account)
        .await
        .unwrap()
        .wait_for_completion()
        .await;
}

#[tokio::test]
async fn test_deploy() {
    let runner = KatanaRunner::load();
    let supplier = KatanaSupplier::from(&runner);
    let account = supplier.prefounded_single_owner().await;
    let DeclareTransactionResult { class_hash, .. } =
        CustomAccountDeclaration::cartridge_account(&supplier)
            .declare(&account)
            .await
            .unwrap()
            .wait_for_completion()
            .await;

    CustomAccountDeployment::new(&supplier)
        .deploy(
            vec![felt!("12345")],
            FieldElement::ZERO,
            &account,
            class_hash,
        )
        .await
        .unwrap()
        .wait_for_completion()
        .await;
}

#[tokio::test]
async fn test_deploy_and_call() {
    let runner = KatanaRunner::load();
    let supplier = KatanaSupplier::from(&runner);
    let account = supplier.prefounded_single_owner().await;
    let DeclareTransactionResult { class_hash, .. } =
        CustomAccountDeclaration::cartridge_account(&supplier)
            .declare(&account)
            .await
            .unwrap()
            .wait_for_completion()
            .await;

    let DeployResult {
        deployed_address, ..
    } = CustomAccountDeployment::new(&supplier)
        .deploy(
            vec![felt!("12345")],
            FieldElement::ZERO,
            &account,
            class_hash,
        )
        .await
        .unwrap()
        .wait_for_completion()
        .await;

    account
        .execute(vec![Call {
            to: deployed_address,
            selector: selector!("getZero"),
            calldata: vec![],
        }])
        .send()
        .await
        .unwrap();
}

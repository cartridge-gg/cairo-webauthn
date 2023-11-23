use starknet::{
    accounts::{Account, Call},
    core::types::{DeclareTransactionResult, FieldElement},
    macros::{felt, selector},
};

use crate::deploy_contract::CustomAccountDeployment;
use crate::{
    deploy_contract::{CustomAccountDeclaration, DeployResult},
    providers::{katana::KatanaProvider, katana_runner::KatanaRunner, PrefoundedClientProvider},
};

#[tokio::test]
async fn test_declare() {
    let runner = KatanaRunner::load();
    let provider = KatanaProvider::from(&runner);
    let account = provider.prefounded_single_owner().await;
    CustomAccountDeclaration::cartridge_account(&provider)
        .declare(&account)
        .await
        .unwrap()
        .wait_for_completion()
        .await;
}

#[tokio::test]
async fn test_deploy() {
    let runner = KatanaRunner::load();
    let provider = KatanaProvider::from(&runner);
    let account = provider.prefounded_single_owner().await;
    let DeclareTransactionResult { class_hash, .. } =
        CustomAccountDeclaration::cartridge_account(&provider)
            .declare(&account)
            .await
            .unwrap()
            .wait_for_completion()
            .await;

    CustomAccountDeployment::new(&provider)
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
    let provider = KatanaProvider::from(&runner);
    let account = provider.prefounded_single_owner().await;
    let DeclareTransactionResult { class_hash, .. } =
        CustomAccountDeclaration::cartridge_account(&provider)
            .declare(&account)
            .await
            .unwrap()
            .wait_for_completion()
            .await;

    let DeployResult {
        deployed_address, ..
    } = CustomAccountDeployment::new(&provider)
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

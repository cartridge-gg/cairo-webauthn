use starknet::{
    accounts::{Account, Call, SingleOwnerAccount},
    core::types::{DeclareTransactionResult, FieldElement},
    macros::{felt, selector},
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
    signers::LocalWallet,
};

use crate::{
    deploy_contract::CustomAccountDeployment,
    suppliers::{PredeployedClientSupplier, RpcClientSupplier},
};
use crate::{
    deploy_contract::{CustomAccountDeclaration, DeployResult},
    suppliers::{katana::KatanaSupplier, katana_runner::KatanaRunner, PrefundedClientSupplier},
};

pub async fn declare_and_deploy(
    supplier: &impl PredeployedClientSupplier,
    account: &SingleOwnerAccount<JsonRpcClient<HttpTransport>, LocalWallet>,
    public_key: FieldElement,
) -> FieldElement {
    let DeclareTransactionResult { class_hash, .. } =
        CustomAccountDeclaration::cartridge_account(supplier.client())
            .declare(&account)
            .await
            .unwrap()
            .wait_for_completion()
            .await;

    let DeployResult {
        deployed_address, ..
    } = CustomAccountDeployment::new(supplier)
        .deploy(vec![public_key], FieldElement::ZERO, &account, class_hash)
        .await
        .unwrap()
        .wait_for_completion()
        .await;
    deployed_address
}

#[tokio::test]
async fn test_declare() {
    let runner = KatanaRunner::load();
    let supplier = KatanaSupplier::from(&runner);
    let account = supplier.prefunded_single_owner_account().await;
    CustomAccountDeclaration::cartridge_account(supplier.client())
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
    let account = supplier.prefunded_single_owner_account().await;
    declare_and_deploy(&supplier, &account, felt!("1337")).await;
}

#[tokio::test]
async fn test_deploy_and_call() {
    let runner = KatanaRunner::load();
    let supplier = KatanaSupplier::from(&runner);
    let account = supplier.prefunded_single_owner_account().await;
    let deployed_address = declare_and_deploy(&supplier, &account, felt!("1939")).await;

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

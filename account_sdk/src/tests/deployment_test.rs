use starknet::{
    accounts::SingleOwnerAccount,
    core::types::{DeclareTransactionResult, FieldElement},
    macros::felt,
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
    signers::LocalWallet,
};

use super::runners::katana_runner::KatanaRunner;
use crate::abigen::account::CartridgeAccount;
use crate::deploy_contract::{AccountDeclaration, DeployResult};
use crate::{deploy_contract::AccountDeployment, tests::runners::TestnetRunner};

pub async fn declare(
    client: &JsonRpcClient<HttpTransport>,
    account: &SingleOwnerAccount<&JsonRpcClient<HttpTransport>, LocalWallet>,
) -> FieldElement {
    let DeclareTransactionResult { class_hash, .. } =
        AccountDeclaration::cartridge_account(&client)
            .declare(&account)
            .await
            .unwrap()
            .wait_for_completion()
            .await;

    class_hash
}

pub async fn deploy(
    client: &JsonRpcClient<HttpTransport>,
    account: &SingleOwnerAccount<&JsonRpcClient<HttpTransport>, LocalWallet>,
    public_key: FieldElement,
    class_hash: FieldElement,
) -> FieldElement {
    let DeployResult {
        deployed_address, ..
    } = AccountDeployment::new(&client)
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
    let account = runner.prefunded_single_owner_account().await;
    declare(runner.client(), &account).await;
}

#[tokio::test]
async fn test_deploy() {
    let runner = KatanaRunner::load();
    let account = runner.prefunded_single_owner_account().await;
    let class_hash = declare(runner.client(), &account).await;
    deploy(runner.client(), &account, felt!("1337"), class_hash).await;
}

#[tokio::test]
async fn test_deploy_and_call() {
    let runner = KatanaRunner::load();
    let account = runner.prefunded_single_owner_account().await;
    let client = runner.client();
    let class_hash = declare(client, &account).await;
    let deployed_address = deploy(client, &account, felt!("1337"), class_hash).await;

    let contract = CartridgeAccount::new(deployed_address, account);
    contract.getPublicKey().call().await.unwrap();
}

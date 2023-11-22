use crate::{
    providers::{PredeployedClientProvider, RpcClientProvider},
    transaction_waiter::TransactionWaiter,
};
use starknet::{
    accounts::SingleOwnerAccount,
    contract::ContractFactory,
    core::types::{FieldElement, InvokeTransactionResult},
    providers::{JsonRpcClient, Provider},
    signers::Signer,
};

pub(crate) mod declaration;
mod pending;
pub use declaration::CustomAccountDeclaration;

#[derive(Debug, Clone)]
pub struct DeployResult {
    pub deployed_address: FieldElement,
    pub transaction_hash: FieldElement,
}

pub async fn deploy_contract<T, P, S>(
    client_provider: &(impl RpcClientProvider<T> + PredeployedClientProvider),
    constructor_calldata: Vec<FieldElement>,
    salt: FieldElement,
    account: SingleOwnerAccount<P, S>,
    class_hash: FieldElement,
) -> Result<DeployResult, String>
where
    P: Provider + Send + Sync,
    S: Signer + Send + Sync,
    JsonRpcClient<T>: Provider,
    T: Send + Sync,
{
    let contract_factory = ContractFactory::new_with_udc(
        class_hash,
        account,
        client_provider.predeployed_udc().address,
    );

    let deployment = contract_factory.deploy(constructor_calldata, salt, false);
    let deployed_address = deployment.deployed_address();
    let InvokeTransactionResult { transaction_hash } =
        deployment.send().await.expect("Unable to deploy contract");

    TransactionWaiter::new(transaction_hash, &client_provider.get_client())
        .await
        .unwrap();

    Ok(DeployResult {
        deployed_address,
        transaction_hash,
    })
}

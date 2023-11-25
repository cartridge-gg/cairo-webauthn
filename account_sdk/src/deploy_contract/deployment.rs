use starknet::{
    accounts::SingleOwnerAccount,
    contract::ContractFactory,
    core::types::{FieldElement, InvokeTransactionResult},
    providers::{JsonRpcClient, Provider},
    signers::Signer,
};

use super::{pending::PendingDeployment, UDC_ADDRESS};

pub struct CustomAccountDeployment<T> {
    client: JsonRpcClient<T>,
}

impl<T> CustomAccountDeployment<T> {
    pub fn new(client: JsonRpcClient<T>) -> Self
    where
        JsonRpcClient<T>: Provider,
        T: Send + Sync,
    {
        CustomAccountDeployment { client }
    }
}

#[derive(Debug, Clone)]
pub struct DeployResult {
    pub deployed_address: FieldElement,
    pub transaction_hash: FieldElement,
}

impl<T> CustomAccountDeployment<T> {
    pub async fn deploy<P, S>(
        self,
        constructor_calldata: Vec<FieldElement>,
        salt: FieldElement,
        account: &SingleOwnerAccount<P, S>,
        class_hash: FieldElement,
    ) -> Result<PendingDeployment<T>, String>
    where
        P: Provider + Send + Sync,
        S: Signer + Send + Sync,
        JsonRpcClient<T>: Provider,
        T: Send + Sync,
    {
        let contract_factory = ContractFactory::new_with_udc(class_hash, account, *UDC_ADDRESS);

        let deployment = contract_factory.deploy(constructor_calldata, salt, false);
        let deployed_address = deployment.deployed_address();
        let InvokeTransactionResult { transaction_hash } =
            deployment.send().await.expect("Unable to deploy contract");

        let result = DeployResult {
            deployed_address,
            transaction_hash,
        };

        Ok(PendingDeployment::from((result, self.client)))
    }
}

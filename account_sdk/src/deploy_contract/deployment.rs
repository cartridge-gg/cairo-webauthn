use starknet::{
    accounts::SingleOwnerAccount,
    contract::ContractFactory,
    core::types::{FieldElement, InvokeTransactionResult},
    providers::{JsonRpcClient, Provider},
    signers::Signer,
};

use super::{pending::PendingDeployment, UDC_ADDRESS};

pub struct CustomAccountDeployment<'a, T> {
    client: &'a JsonRpcClient<T>,
}

impl<'a, T> CustomAccountDeployment<'a, T> {
    pub fn new(client: &'a JsonRpcClient<T>) -> Self
    where
        &'a JsonRpcClient<T>: Provider,
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

impl<'a, T> CustomAccountDeployment<'a, T> {
    pub async fn deploy<P, S>(
        self,
        constructor_calldata: Vec<FieldElement>,
        salt: FieldElement,
        account: & SingleOwnerAccount<P, S>,
        class_hash: FieldElement,
    ) -> Result<PendingDeployment<'a, T>, String>
    where
        P: Provider + Send + Sync,
        S: Signer + Send + Sync,
        &'a JsonRpcClient<T>: Provider,
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

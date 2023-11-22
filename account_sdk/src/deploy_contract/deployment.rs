use starknet::{
    accounts::SingleOwnerAccount,
    contract::ContractFactory,
    core::types::{FieldElement, InvokeTransactionResult},
    providers::{JsonRpcClient, Provider},
    signers::Signer,
};

use crate::providers::{PredeployedClientProvider, RpcClientProvider};

use super::pending::PendingDeployment;

pub struct CustomAccountDeployment<Q> {
    client_provider: Q,
}

impl<Q> CustomAccountDeployment<Q> {
    pub fn new<T>(client_provider: Q) -> Self
    where
        Q: RpcClientProvider<T> + PredeployedClientProvider,
        JsonRpcClient<T>: Provider,
        T: Send + Sync,
    {
        CustomAccountDeployment { client_provider }
    }
}

#[derive(Debug, Clone)]
pub struct DeployResult {
    pub deployed_address: FieldElement,
    pub transaction_hash: FieldElement,
}

impl<Q> CustomAccountDeployment<Q> {
    pub async fn deploy<T, P, S>(
        &self,
        constructor_calldata: Vec<FieldElement>,
        salt: FieldElement,
        account: SingleOwnerAccount<P, S>,
        class_hash: FieldElement,
    ) -> Result<PendingDeployment<T>, String>
    where
        Q: RpcClientProvider<T> + PredeployedClientProvider,
        P: Provider + Send + Sync,
        S: Signer + Send + Sync,
        JsonRpcClient<T>: Provider,
        T: Send + Sync,
    {
        let contract_factory = ContractFactory::new_with_udc(
            class_hash,
            account,
            self.client_provider.predeployed_udc().address,
        );

        let deployment = contract_factory.deploy(constructor_calldata, salt, false);
        let deployed_address = deployment.deployed_address();
        let InvokeTransactionResult { transaction_hash } =
            deployment.send().await.expect("Unable to deploy contract");

        let result = DeployResult {
            deployed_address,
            transaction_hash,
        };

        Ok(PendingDeployment::from((
            result,
            self.client_provider.get_client(),
        )))
    }
}

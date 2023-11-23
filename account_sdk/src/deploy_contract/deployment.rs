use starknet::{
    accounts::SingleOwnerAccount,
    contract::ContractFactory,
    core::types::{FieldElement, InvokeTransactionResult},
    providers::{JsonRpcClient, Provider},
    signers::Signer,
};

use crate::suppliers::{PredeployedClientSupplier, RpcClientSupplier};

use super::pending::PendingDeployment;

pub struct CustomAccountDeployment<'a, Q> {
    supplier: &'a Q,
}

impl<'a, Q> CustomAccountDeployment<'a, Q> {
    pub fn new<T>(client_supplier: &'a Q) -> Self
    where
        Q: RpcClientSupplier<T> + PredeployedClientSupplier,
        JsonRpcClient<T>: Provider,
        T: Send + Sync,
    {
        CustomAccountDeployment {
            supplier: &client_supplier,
        }
    }
}

#[derive(Debug, Clone)]
pub struct DeployResult {
    pub deployed_address: FieldElement,
    pub transaction_hash: FieldElement,
}

impl<'a, Q> CustomAccountDeployment<'a, Q> {
    pub async fn deploy<T, P, S>(
        &self,
        constructor_calldata: Vec<FieldElement>,
        salt: FieldElement,
        account: &SingleOwnerAccount<P, S>,
        class_hash: FieldElement,
    ) -> Result<PendingDeployment<T>, String>
    where
        Q: RpcClientSupplier<T> + PredeployedClientSupplier,
        P: Provider + Send + Sync,
        S: Signer + Send + Sync,
        JsonRpcClient<T>: Provider,
        T: Send + Sync,
    {
        let contract_factory = ContractFactory::new_with_udc(
            class_hash,
            account,
            self.supplier.predeployed_udc().address,
        );

        let deployment = contract_factory.deploy(constructor_calldata, salt, false);
        let deployed_address = deployment.deployed_address();
        let InvokeTransactionResult { transaction_hash } =
            deployment.send().await.expect("Unable to deploy contract");

        let result = DeployResult {
            deployed_address,
            transaction_hash,
        };

        Ok(PendingDeployment::from((result, self.supplier.client())))
    }
}

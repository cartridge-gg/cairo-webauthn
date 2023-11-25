use starknet::{
    core::types::{DeclareTransactionResult, FieldElement},
    providers::{JsonRpcClient, Provider},
};

use crate::transaction_waiter::TransactionWaiter;

use super::deployment::DeployResult;

pub struct PendingTransaction<'a, P, T>
where
    &'a P: Provider + Send,
{
    transaction_result: T,
    transaction_hash: FieldElement,
    client: &'a P,
}

impl<'a, P, T> PendingTransaction<'a, P, T>
where
    &'a P: Provider + Send,
{
    pub fn new(transaction_result: T, transaction_hash: FieldElement, provider: &'a P) -> Self {
        PendingTransaction {
            transaction_result,
            transaction_hash,
            client: provider,
        }
    }
    pub async fn wait_for_completion(self) -> T {
        TransactionWaiter::new(self.transaction_hash, &self.client)
            .await
            .unwrap();
        self.transaction_result
    }
    pub fn skip_waiting(self) -> T {
        self.transaction_result
    }
}

pub type PendingDeclaration<'a, T> = PendingTransaction<'a, JsonRpcClient<T>, DeclareTransactionResult>;

impl<'a, T> From<(DeclareTransactionResult, &'a JsonRpcClient<T>)> for PendingDeclaration<'a, T>
where
    T: Send + Sync,
    &'a JsonRpcClient<T>: Provider,
{
    fn from((result, provider): (DeclareTransactionResult, &'a JsonRpcClient<T>)) -> Self {
        let transaction_hash = result.transaction_hash;
        Self::new(result, transaction_hash, provider)
    }
}

pub type PendingDeployment<'a, T> = PendingTransaction<'a, JsonRpcClient<T>, DeployResult>;

impl<'a, T> From<(DeployResult, &'a JsonRpcClient<T>)> for PendingDeployment<'a, T>
where
    T: Send + Sync,
    &'a JsonRpcClient<T>: Provider,
{
    fn from((result, provider): (DeployResult, &'a JsonRpcClient<T>)) -> Self {
        let transaction_hash = result.transaction_hash;
        Self::new(result, transaction_hash, provider)
    }
}

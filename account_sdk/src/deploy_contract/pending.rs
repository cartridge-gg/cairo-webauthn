use starknet::{
    core::types::{DeclareTransactionResult, FieldElement},
    providers::{JsonRpcClient, Provider},
};

use crate::transaction_waiter::TransactionWaiter;

pub struct PendingTransaction<P, T>
where
    P: Provider,
{
    transaction_result: T,
    transaction_hash: FieldElement,
    provider: P,
}

impl<P, T> PendingTransaction<P, T>
where
    P: Provider + Send,
{
    pub fn new(transaction_result: T, transaction_hash: FieldElement, provider: P) -> Self {
        PendingTransaction {
            transaction_result,
            transaction_hash,
            provider,
        }
    }
    pub async fn wait_for_completion(self) -> T {
        TransactionWaiter::new(self.transaction_hash, &self.provider)
            .await
            .unwrap();
        self.transaction_result
    }
    pub fn skip_waiting(self) -> T {
        self.transaction_result
    }
}

pub type PendingDeclaration<T> = PendingTransaction<JsonRpcClient<T>, DeclareTransactionResult>;

impl<T> From<(DeclareTransactionResult, JsonRpcClient<T>)> for PendingDeclaration<T>
where
    T: Send + Sync,
    JsonRpcClient<T>: Provider,
{
    fn from((result, provider): (DeclareTransactionResult, JsonRpcClient<T>)) -> Self {
        let transaction_hash = result.transaction_hash;
        Self::new(result, transaction_hash, provider)
    }
}

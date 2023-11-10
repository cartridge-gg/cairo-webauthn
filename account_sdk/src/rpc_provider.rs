use starknet::{core::types::FieldElement, providers::JsonRpcClient};

pub trait RpcClientProvider<T> {
    fn get_client(&self) -> JsonRpcClient<T>;
    fn chain_id(&self) -> FieldElement;
}

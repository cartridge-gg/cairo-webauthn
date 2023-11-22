use starknet::providers::JsonRpcClient;

pub trait RpcClientProvider<T> {
    fn get_client(&self) -> JsonRpcClient<T>;
}

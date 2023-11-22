use starknet::{
    core::types::FieldElement,
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
};
use url::Url;

use crate::rpc_provider::RpcClientProvider;

use super::KatanaRunner;

#[derive(Debug, Clone, Copy)]
pub struct KatanaProvider {
    port: u16,
}

impl From<&u16> for KatanaProvider {
    fn from(value: &u16) -> Self {
        KatanaProvider { port: *value }
    }
}

impl From<&KatanaRunner> for KatanaProvider {
    fn from(value: &KatanaRunner) -> Self {
        KatanaProvider { port: value.port() }
    }
}

impl RpcClientProvider<HttpTransport> for KatanaProvider {
    fn get_client(&self) -> JsonRpcClient<HttpTransport> {
        JsonRpcClient::new(HttpTransport::new(
            Url::parse(&format!("http://0.0.0.0:{}/", self.port)).unwrap(),
        ))
    }

    fn chain_id(&self) -> FieldElement {
        FieldElement::from_byte_slice_be(&"KATANA".as_bytes()[..]).unwrap()
    }
}

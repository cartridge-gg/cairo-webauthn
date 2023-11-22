use starknet::{
    core::types::FieldElement,
    providers::{jsonrpc::HttpTransport, JsonRpcClient}, macros::felt,
};
use url::Url;

use crate::rpc_provider::RpcClientProvider;

use super::{KatanaRunner, PredeployedContract, PredeployedAccount, PredeployedProvider};

#[derive(Debug, Clone, Copy)]
pub struct KatanaProvider {
    port: u16,
}

impl PredeployedProvider for KatanaProvider {
    // cargo run -- --port 1234 --seed 0
    fn prefounded_account(&self) -> PredeployedAccount {
        PredeployedAccount {
            account_address: felt!(
                "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973"
            ),
            private_key: felt!("0x1800000000300000180000000000030000000000003006001800006600"),
            public_key: felt!("0x2b191c2f3ecf685a91af7cf72a43e7b90e2e41220175de5c4f7498981b10053"),
        }
    }

    fn predeployed_fee_token(&self) -> PredeployedContract {
        todo!("Look up the fields in the dojo sourcecode")
    }

    fn predeployed_udc(&self) -> PredeployedContract {
        todo!("Look up the fields in the dojo sourcecode")
    }
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

    //TODO: this is probably wrong but can be read from self.get_client().chain_id().await.unwrap()
    fn chain_id(&self) -> FieldElement {
        FieldElement::from_byte_slice_be(&"KATANA".as_bytes()[..]).unwrap()
    }
}

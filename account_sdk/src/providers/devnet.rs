use starknet::{macros::felt, providers::{jsonrpc::HttpTransport, JsonRpcClient}, core::types::FieldElement};
use url::Url;

use crate::rpc_provider::RpcClientProvider;

use super::{PredeployedAccount, PredeployedContract};

#[derive(Debug, Clone)]
pub struct StarknetDevnet {
    pub port: u16,
}


impl StarknetDevnet {
    // cargo run -- --port 1234 --seed 0
    pub fn prefounded_account(&self) -> PredeployedAccount {
        PredeployedAccount {
            account_address: felt!(
                "0x64b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691"
            ),
            private_key: felt!("0x71d7bb07b9a64f6f78ac4c816aff4da9"),
            public_key: felt!("0x39d9e6ce352ad4530a0ef5d5a18fd3303c3606a7fa6ac5b620020ad681cc33b"),
        }
    }

    pub fn fee_token(&self) -> PredeployedContract {
        PredeployedContract {
            address: felt!("0x49D36570D4E46F48E99674BD3FCC84644DDD6B96F7C741B1562B82F9E004DC7"),
            class_hash: felt!("0x6A22BF63C7BC07EFFA39A25DFBD21523D211DB0100A0AFD054D172B81840EAF"),
        }
    }
}


impl RpcClientProvider<HttpTransport> for StarknetDevnet {
    fn get_client(&self) -> JsonRpcClient<HttpTransport> {
        JsonRpcClient::new(HttpTransport::new(
            Url::parse(&format!("http://0.0.0.0:{}/", self.port)).unwrap(),
        ))
    }

    fn chain_id(&self) -> FieldElement {
        FieldElement::from_byte_slice_be(&"TESTNET".as_bytes()[..]).unwrap()
    }
}
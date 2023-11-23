use starknet::{
    macros::felt,
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
};
use url::Url;

use super::{PrefundedClientSupplier, RpcClientSupplier};

use super::{AccountData, PredeployedClientSupplier, PredeployedContract};

// starknet-devnet-rs
// cargo run -- --port <port> --seed 0
#[derive(Debug, Clone)]
pub struct DevnetSupplier {
    pub port: u16,
}

impl PrefundedClientSupplier for DevnetSupplier {
    fn prefunded_account(&self) -> AccountData {
        AccountData {
            account_address: felt!(
                "0x64b48806902a367c8598f4f95c305e8c1a1acba5f082d294a43793113115691"
            ),
            private_key: felt!("0x71d7bb07b9a64f6f78ac4c816aff4da9"),
            public_key: felt!("0x39d9e6ce352ad4530a0ef5d5a18fd3303c3606a7fa6ac5b620020ad681cc33b"),
        }
    }
}

impl PredeployedClientSupplier for DevnetSupplier {
    
    fn predeployed_fee_token(&self) -> PredeployedContract {
        PredeployedContract {
            address: felt!("0x49D36570D4E46F48E99674BD3FCC84644DDD6B96F7C741B1562B82F9E004DC7"),
            class_hash: felt!("0x6A22BF63C7BC07EFFA39A25DFBD21523D211DB0100A0AFD054D172B81840EAF"),
        }
    }

    fn predeployed_udc(&self) -> PredeployedContract {
        PredeployedContract {
            address: felt!("0x41A78E741E5AF2FEC34B695679BC6891742439F7AFB8484ECD7766661AD02BF"),
            class_hash: felt!("0x7B3E05F48F0C69E4A65CE5E076A66271A527AFF2C34CE1083EC6E1526997A69"),
        }
    }
}

impl RpcClientSupplier<HttpTransport> for DevnetSupplier {
    fn client(&self) -> JsonRpcClient<HttpTransport> {
        JsonRpcClient::new(HttpTransport::new(
            Url::parse(&format!("http://0.0.0.0:{}/", self.port)).unwrap(),
        ))
    }
}

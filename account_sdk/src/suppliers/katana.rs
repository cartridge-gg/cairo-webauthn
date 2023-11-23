use starknet::{
    macros::felt,
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
};
use url::Url;

use super::{katana_runner::KatanaRunner, PrefoundedClientSupplier, RpcClientSupplier};

use super::{PredeployedAccount, PredeployedClientSupplier, PredeployedContract};

#[derive(Debug, Clone, Copy)]
pub struct KatanaSupplier {
    port: u16,
}

impl PrefoundedClientSupplier for KatanaSupplier {
    fn prefounded_account(&self) -> PredeployedAccount {
        PredeployedAccount {
            account_address: felt!(
                "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973"
            ),
            private_key: felt!("0x1800000000300000180000000000030000000000003006001800006600"),
            public_key: felt!("0x2b191c2f3ecf685a91af7cf72a43e7b90e2e41220175de5c4f7498981b10053"),
        }
    }
}

impl PredeployedClientSupplier for KatanaSupplier {
    // cargo run -- --port 1234 --seed 0
    fn predeployed_fee_token(&self) -> PredeployedContract {
        PredeployedContract {
            address: felt!("0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7"),
            class_hash: felt!("0x02a8846878b6ad1f54f6ba46f5f40e11cee755c677f130b2c4b60566c9003f1f"),
        }
    }

    fn predeployed_udc(&self) -> PredeployedContract {
        PredeployedContract {
            address: felt!("0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf"),
            class_hash: felt!("0x07b3e05f48f0c69e4a65ce5e076a66271a527aff2c34ce1083ec6e1526997a69"),
        }
    }
}

impl From<&u16> for KatanaSupplier {
    fn from(value: &u16) -> Self {
        KatanaSupplier { port: *value }
    }
}

impl From<&KatanaRunner> for KatanaSupplier {
    fn from(value: &KatanaRunner) -> Self {
        KatanaSupplier { port: value.port() }
    }
}

impl RpcClientSupplier<HttpTransport> for KatanaSupplier {
    fn client(&self) -> JsonRpcClient<HttpTransport> {
        JsonRpcClient::new(HttpTransport::new(
            Url::parse(&format!("http://0.0.0.0:{}/", self.port)).unwrap(),
        ))
    }
}

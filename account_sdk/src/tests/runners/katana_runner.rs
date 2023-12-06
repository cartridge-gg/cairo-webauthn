use async_trait::async_trait;
use starknet::accounts::{ExecutionEncoding, SingleOwnerAccount};
use starknet::providers::jsonrpc::HttpTransport;
use starknet::providers::JsonRpcClient;
use starknet::signers::LocalWallet;
use starknet::{core::types::FieldElement, macros::felt, signers::SigningKey};
use std::process::{Command, Stdio};
use url::Url;

use lazy_static::lazy_static;

use crate::deploy_contract::single_owner_account_with_encoding;

use super::{find_free_port, SubprocessRunner, TestnetConfig, TestnetRunner};

lazy_static! {
    // Signing key and address of the katana prefunded account.
    pub static ref PREFUNDED: (SigningKey, FieldElement) = (
        SigningKey::from_secret_scalar(
            felt!(
                "0x1800000000300000180000000000030000000000003006001800006600"
            ),
        ),
        felt!(
            "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973"
        )
    );

    pub static ref CONFIG: TestnetConfig = TestnetConfig{
        port: 1234,
        executable_path: "katana".to_string(),
        execute_from_folder: ".".to_string(),
        log_file_path: "log/katana.log".to_string(),
    };
}

#[derive(Debug)]
pub struct KatanaRunner {
    testnet: SubprocessRunner,
    client: JsonRpcClient<HttpTransport>,
}

impl KatanaRunner {
    pub fn new(config: TestnetConfig) -> Self {
        let child = Command::new(config.executable_path)
            .args(["-p", &config.port.to_string()])
            .args(["--json-log"])
            .stdout(Stdio::piped())
            .spawn()
            .expect("failed to start subprocess");

        let testnet = SubprocessRunner::new(child, config.log_file_path, |l| {
            l.contains(r#""target":"katana""#)
        });

        let client = JsonRpcClient::new(HttpTransport::new(
            Url::parse(&format!("http://0.0.0.0:{}/", config.port)).unwrap(),
        ));

        KatanaRunner { testnet, client }
    }
}

#[async_trait]
impl TestnetRunner for KatanaRunner {
    fn load() -> Self {
        KatanaRunner::new(CONFIG.clone().port(find_free_port()))
    }
    fn client(&self) -> &JsonRpcClient<HttpTransport> {
        &self.client
    }
    async fn prefunded_single_owner_account(
        &self,
    ) -> SingleOwnerAccount<&JsonRpcClient<HttpTransport>, LocalWallet> {
        single_owner_account_with_encoding(
            &self.client,
            PREFUNDED.0.clone(),
            PREFUNDED.1,
            ExecutionEncoding::Legacy,
        )
        .await
    }
}

impl Drop for KatanaRunner {
    fn drop(&mut self) {
        self.testnet.kill();
    }
}

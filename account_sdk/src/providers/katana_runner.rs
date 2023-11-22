use serde::Deserialize;
use starknet::{
    core::types::FieldElement,
    macros::felt,
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
    signers::SigningKey,
};
use std::{path::{Path, PathBuf}, net::TcpListener};
use std::process::{Child, Command, Stdio};
use std::sync::mpsc;
use std::thread;
use std::time::Duration;
use std::{
    fs,
    io::{BufRead, BufReader, Write},
};
use std::{fs::File, process::ChildStdout, sync::mpsc::Sender};
use url::Url;

use lazy_static::lazy_static;

pub fn find_free_port() -> u16 {
    TcpListener::bind("127.0.0.1:0")
        .unwrap()
        .local_addr()
        .unwrap()
        .port()
}
use super::RpcClientProvider;

lazy_static! {
    pub static ref UDC_ADDRESS: FieldElement =
        felt!("0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf");
    pub static ref FEE_TOKEN_ADDRESS: FieldElement =
        felt!("0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7");
    pub static ref ERC20_CONTRACT_CLASS_HASH: FieldElement =
        felt!("0x02a8846878b6ad1f54f6ba46f5f40e11cee755c677f130b2c4b60566c9003f1f");
    pub static ref CHAIN_ID: FieldElement =
        felt!("0x00000000000000000000000000000000000000000000000000004b4154414e41");
    pub static ref PREFUNDED: (SigningKey, FieldElement) = (
        SigningKey::from_secret_scalar(
            FieldElement::from_hex_be(
                "0x1800000000300000180000000000030000000000003006001800006600"
            )
            .unwrap(),
        ),
        FieldElement::from_hex_be(
            "0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973",
        )
        .unwrap()
    );
}

#[derive(Debug, Clone, Deserialize)]
pub struct KatanaRunnerConfig {
    pub port: u16,
    pub katana_path: String,
    pub log_file_path: String,
}

impl KatanaRunnerConfig {
    pub fn from_file(path: impl Into<String>) -> Self {
        let config_string = fs::read_to_string(path.into()).expect("Failed to read config file");

        toml::from_str(&config_string).expect("Failed to parse config file")
    }

    pub fn port(mut self, port: u16) -> Self {
        self.port = port;
        self.log_file_path = KatanaRunnerConfig::add_port_to_filename(&self.log_file_path, port);
        self
    }

    fn add_port_to_filename(file_path: &str, port: u16) -> String {
        let path = Path::new(file_path);
        let stem = path.file_stem().and_then(|s| s.to_str()).unwrap_or("");
        let extension = path.extension().and_then(|s| s.to_str()).unwrap_or("");

        let new_file_name = if extension.is_empty() {
            format!("{}_{}", stem, port)
        } else {
            format!("{}_{}.{}", stem, port, extension)
        };
        let mut new_path = PathBuf::from(path.parent().unwrap_or_else(|| Path::new("")));
        new_path.push(new_file_name);
        new_path.to_string_lossy().into_owned()
    }
}

#[derive(Debug)]
pub struct KatanaRunner {
    child: Child,
    port: u16,
}

impl KatanaRunner {
    pub fn new(config: KatanaRunnerConfig) -> Self {
        let mut child = Command::new(config.katana_path)
            .args(["-p", &config.port.to_string()])
            .args(["--json-log"])
            .stdout(Stdio::piped())
            .spawn()
            .expect("failed to start subprocess");

        let stdout = child
            .stdout
            .take()
            .expect("failed to take subprocess stdout");

        let (sender, receiver) = mpsc::channel();

        thread::spawn(move || {
            KatanaRunner::wait_for_server_started_and_signal(&config.log_file_path, stdout, sender);
        });

        receiver
            .recv_timeout(Duration::from_secs(5))
            .expect("timeout waiting for server to start");

        KatanaRunner {
            child,
            port: config.port,
        }
    }

    pub fn load() -> Self {
        KatanaRunner::new(KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()))
    }

    fn wait_for_server_started_and_signal(
        log_file_path: &str,
        stdout: ChildStdout,
        sender: Sender<()>,
    ) {
        let reader = BufReader::new(stdout);
        let mut log_writer = File::create(log_file_path).expect("failed to create log file");

        for line in reader.lines() {
            let line = line.expect("failed to read line from subprocess stdout");
            writeln!(log_writer, "{}", line).expect("failed to write to log file");

            if line.contains(r#""target":"katana""#) {
                sender.send(()).expect("failed to send start signal");
            }
        }
    }

    pub fn port(&self) -> u16 {
        self.port
    }
}

#[derive(Debug, Clone, Copy)]
pub struct KatanaClientProvider {
    port: u16,
}

impl KatanaClientProvider {
    pub fn port(&self) -> u16 {
        self.port
    }
}

impl From<u16> for KatanaClientProvider {
    fn from(value: u16) -> Self {
        KatanaClientProvider { port: value }
    }
}

impl From<&KatanaRunner> for KatanaClientProvider {
    fn from(value: &KatanaRunner) -> Self {
        KatanaClientProvider { port: value.port }
    }
}

impl RpcClientProvider<HttpTransport> for KatanaClientProvider {
    fn get_client(&self) -> JsonRpcClient<HttpTransport> {
        JsonRpcClient::new(HttpTransport::new(
            Url::parse(&format!("http://0.0.0.0:{}/", self.port)).unwrap(),
        ))
    }
}

impl Drop for KatanaRunner {
    fn drop(&mut self) {
        if let Err(e) = self.child.kill() {
            eprintln!("Failed to kill katana subprocess: {}", e);
        }
        if let Err(e) = self.child.wait() {
            eprintln!("Failed to wait for katana subprocess: {}", e);
        }
    }
}

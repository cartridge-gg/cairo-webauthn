use serde::Deserialize;
use starknet::{
    core::types::FieldElement,
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
};
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

pub trait RpcClientProvider<T> {
    fn get_provider(&self) -> JsonRpcClient<T>;
    fn chain_id(&self) -> FieldElement;
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
}

#[derive(Debug)]
pub struct KatanaRunner {
    child: Child,
    port: u16,
}

impl KatanaRunner {
    pub fn new(config: KatanaRunnerConfig) -> Self {
        let mut child = Command::new("katana")
            .args(["-p", &config.port.to_string()])
            .args(["--disable-fee", "--no-mining", "--json-log"])
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
}

impl RpcClientProvider<HttpTransport> for KatanaRunner {
    fn get_provider(&self) -> JsonRpcClient<HttpTransport> {
        JsonRpcClient::new(HttpTransport::new(
            Url::parse(&format!("http://0.0.0.0:{}/", self.port)).unwrap(),
        ))
    }

    fn chain_id(&self) -> FieldElement {
        FieldElement::from_byte_slice_be(&"KATANA".as_bytes()[..]).unwrap()
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

#[test]
fn test_katana_runner() {
    KatanaRunner::new(KatanaRunnerConfig::from_file("KatanaConfig.toml"));
}

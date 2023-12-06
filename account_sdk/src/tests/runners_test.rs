use super::runners::{katana_runner::KatanaRunner, TestnetRunner, devnet_runner::DevnetRunner};

#[test]
fn test_katana_runner() {
    KatanaRunner::load();
}

#[test]
fn test_devnet_runner() {
    DevnetRunner::load();
}

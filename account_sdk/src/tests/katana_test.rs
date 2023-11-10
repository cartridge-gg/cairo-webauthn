use crate::katana::{KatanaRunner, KatanaRunnerConfig};

use super::find_free_port;

#[test]
fn test_katana_runner() {
    KatanaRunner::new(KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()));
}

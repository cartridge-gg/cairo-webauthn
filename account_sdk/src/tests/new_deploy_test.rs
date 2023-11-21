use crate::{
    deploy_contract::declare_and_deploy_contract,
    katana::{KatanaClientProvider, KatanaRunner, KatanaRunnerConfig},
    tests::{find_free_port, get_key_and_address},
};

#[tokio::test]
async fn test_new_deploy() {
    let runner = KatanaRunner::new(
        KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    );
    let (signing_key, address) = get_key_and_address();

    let provider = KatanaClientProvider::from(&runner);
    let public_key = signing_key.verifying_key().scalar();
    declare_and_deploy_contract(provider, signing_key, address, vec![public_key])
        .await
        .unwrap();
}

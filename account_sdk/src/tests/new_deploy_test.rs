use starknet::{
    accounts::{Account, Call, ExecutionEncoding, SingleOwnerAccount},
    core::types::{BlockId, BlockTag, FunctionCall},
    macros::{felt, selector},
    providers::Provider,
    signers::LocalWallet,
};

use crate::{
    deploy_contract::declare_and_deploy_contract,
    providers::RpcClientProvider,
    providers::{
        DevnetProvider, KatanaClientProvider, KatanaProvider, KatanaRunner, KatanaRunnerConfig,
        PredeployedProvider, StarknetDevnet,
    },
    providers::{PrefoundedClientProvider, RpcClientProvider},
    tests::find_free_port,
};

#[tokio::test]
async fn test_new_deploy() {
    let runner = KatanaRunner::new(
        KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    );
    let provider = KatanaProvider::from(&runner);
    let prfd_account = provider.prefounded_account();
    declare_and_deploy_contract(
        &provider,
        prfd_account.signing_key(),
        prfd_account.account_address,
        vec![prfd_account.public_key],
    )
    .await
    .unwrap();
}

// Starknet devnet
// cargo run -- --port 1234 --seed 0

#[tokio::test]
async fn test_balance_of() {
    let devnet = DevnetProvider { port: 1234 };
    let predpld_acc = devnet.prefounded_account();
    let call_result = devnet
        .get_client()
        .call(
            FunctionCall {
                contract_address: devnet.predeployed_fee_token().address,
                entry_point_selector: selector!("balanceOf"),
                calldata: vec![predpld_acc.account_address],
            },
            BlockId::Tag(BlockTag::Latest),
        )
        .await
        .expect("failed to call contract");

    dbg!(call_result);
}

#[tokio::test]
async fn test_balance_of_account() {
    let devnet = DevnetProvider { port: 1234 };
    let predpld_acc = devnet.prefounded_account();
    let account = SingleOwnerAccount::new(
        devnet.get_client(),
        LocalWallet::from(predpld_acc.signing_key()),
        predpld_acc.account_address,
        devnet.get_client().chain_id().await.unwrap(),
        ExecutionEncoding::Legacy,
    );
    let call_result = account
        .execute(vec![Call {
            to: devnet.predeployed_fee_token().address,
            selector: selector!("balanceOf"),
            calldata: vec![predpld_acc.account_address],
        }])
        .send()
        .await
        .unwrap();

    dbg!(call_result);
}

#[tokio::test]
async fn test_transfer() {
    let runner = KatanaRunner::new(
        KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    );
    let network = KatanaClientProvider::from(&runner);
    let predeployed = network.prefounded_account();
    let new_account = felt!("0x78662e7352d062084b0010068b99288486c2d8b914f6e2a55ce945f8792c8b1");
    let mut account = SingleOwnerAccount::new(
        network.get_client(),
        LocalWallet::from(predeployed.signing_key()),
        predeployed.account_address,
        network.get_client().chain_id().await.unwrap(),
        ExecutionEncoding::Legacy,
    );
    account.set_block_id(BlockId::Tag(BlockTag::Pending)); // Fetching valid nonce

    let call_result = account
        .execute(vec![Call {
            to: network.predeployed_fee_token().address,
            selector: selector!("balanceOf"),
            calldata: vec![new_account],
        }])
        .send()
        .await
        .unwrap();
    dbg!(call_result);

    let call_result = account
        .execute(vec![Call {
            to: network.predeployed_fee_token().address,
            selector: selector!("transfer"),
            calldata: vec![new_account, felt!("0x10"), felt!("0x0")],
        }])
        .send()
        .await
        .unwrap();
    dbg!(call_result);
}

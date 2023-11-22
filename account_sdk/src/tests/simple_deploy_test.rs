use starknet::{
    accounts::ConnectedAccount,
    contract::ContractFactory,
    core::types::FieldElement,
    signers::{LocalWallet, SigningKey},
};

use crate::{
    deploy_contract::{account_for_address, declare_contract},
    providers::{KatanaProvider, KatanaRunner, KatanaRunnerConfig},
    tests::{find_free_port, prefounded_key_and_address},
    transaction_waiter::TransactionWaiter,
};

/// The default UDC address: 0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf.
const _DEFAULT_UDC_ADDRESS: FieldElement = FieldElement::from_mont([
    15144800532519055890,
    15685625669053253235,
    9333317513348225193,
    121672436446604875,
]);

struct KatanaAccountData {
    pub private: SigningKey,
    pub public: FieldElement,
    pub address: FieldElement,
    pub _signer: LocalWallet,
}

impl KatanaAccountData {
    pub fn new() -> Self {
        let (private, address) = prefounded_key_and_address();
        let signer = LocalWallet::from_signing_key(private.clone());
        let public = private.verifying_key().scalar();
        KatanaAccountData {
            private,
            public,
            address,
            _signer: signer,
        }
    }
}

#[tokio::test]
async fn test_simple() {
    let runner = KatanaRunner::new(
        KatanaRunnerConfig::from_file("KatanaConfig.toml").port(find_free_port()),
    );

    let provider = KatanaProvider::from(&runner);

    let prf_data = KatanaAccountData::new();

    let prf_account =
        account_for_address(&provider, prf_data.private.clone(), prf_data.address).await;

    let (custom_declare, _) = declare_contract(&provider, prf_data.private, prf_data.address)
        .await
        .unwrap();
    dbg!(&custom_declare);
    dbg!(
        TransactionWaiter::new(custom_declare.transaction_hash, prf_account.provider())
            .await
            .unwrap()
    );

    let factory = ContractFactory::new(custom_declare.class_hash, &prf_account);

    // https://github.com/xJonathanLEI/starkli/blob/master/src/subcommands/account/deploy.rs
    // todo!("Implement starknet::providers::Provider for KatanaClientProvider");
    let deployment = factory.deploy(vec![prf_data.public], FieldElement::ZERO, true);
    let _deployed_address = deployment.deployed_address();
    let _result = deployment.simulate(false, false).await.unwrap();
    // dbg!(TransactionWaiter::new(result.transaction_hash, prf_account.provider()).await.unwrap());

    // dbg!(deployed_address);

    // let _call_result = prf_account
    //     .execute(vec![Call {
    //         to: deployed_address,
    //         selector: selector!("getPublicKey"),
    //         calldata: vec![],
    //     }])
    //     .send()
    //     .await
    //     .unwrap();
}

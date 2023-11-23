use async_trait::async_trait;
use starknet::accounts::{ExecutionEncoding, SingleOwnerAccount};
use starknet::core::types::{BlockId, BlockTag};
use starknet::providers::{JsonRpcClient, Provider};
use starknet::signers::LocalWallet;
use starknet::{
    core::types::FieldElement, macros::felt, providers::jsonrpc::HttpTransport, signers::SigningKey,
};

use lazy_static::lazy_static;

pub mod devnet;
pub mod katana;
pub mod katana_runner;

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

pub trait RpcClientSupplier<T> {
    fn client(&self) -> JsonRpcClient<T>;
}

pub trait PredeployedClientSupplier
where
    Self: RpcClientSupplier<HttpTransport>,
{
    fn predeployed_fee_token(&self) -> PredeployedContract;
    fn predeployed_udc(&self) -> PredeployedContract;
}

#[async_trait]
pub trait PrefoundedClientSupplier
where
    Self: PredeployedClientSupplier,
{
    fn prefounded_account(&self) -> AccountData;
    async fn prefounded_single_owner(
        &self,
    ) -> SingleOwnerAccount<JsonRpcClient<HttpTransport>, LocalWallet> {
        self.single_owner_account(&self.prefounded_account()).await
    }
    async fn single_owner_account(
        &self,
        data: &AccountData,
    ) -> SingleOwnerAccount<JsonRpcClient<HttpTransport>, LocalWallet> {
        let network = self.client();
        let chain_id = network.chain_id().await.unwrap();

        let mut account = SingleOwnerAccount::new(
            network,
            LocalWallet::from(data.signing_key()),
            data.account_address,
            chain_id,
            ExecutionEncoding::Legacy,
        );

        account.set_block_id(BlockId::Tag(BlockTag::Pending)); // For fetching valid nonce
        account
    }
}

#[derive(Debug, Clone)]
pub struct AccountData {
    pub account_address: FieldElement,
    pub private_key: FieldElement,
    pub public_key: FieldElement,
}

impl AccountData {
    pub fn new(account_address: FieldElement, private_key: FieldElement) -> AccountData {
        AccountData {
            account_address,
            private_key,
            public_key: SigningKey::from_secret_scalar(private_key)
                .verifying_key()
                .scalar(),
        }
    }
    pub fn signing_key(&self) -> SigningKey {
        SigningKey::from_secret_scalar(self.private_key)
    }
}

pub struct PredeployedContract {
    pub address: FieldElement,
    pub class_hash: FieldElement,
}

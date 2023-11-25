use async_trait::async_trait;
use starknet::accounts::{ExecutionEncoding, SingleOwnerAccount};
use starknet::core::types::{BlockId, BlockTag};
use starknet::providers::{JsonRpcClient, Provider};
use starknet::signers::LocalWallet;
use starknet::{core::types::FieldElement, providers::jsonrpc::HttpTransport, signers::SigningKey};

pub mod devnet;
pub mod katana;
pub mod katana_runner;

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
pub trait PrefundedClientSupplier
where
    Self: PredeployedClientSupplier,
{
    fn prefunded_account(&self) -> AccountData;
    async fn prefunded_single_owner_account(
        &self,
    ) -> SingleOwnerAccount<JsonRpcClient<HttpTransport>, LocalWallet> {
        self._single_owner_account_with_encoding(
            &self.prefunded_account(),
            ExecutionEncoding::Legacy,
        )
        .await
    }
    async fn single_owner_account(
        &self,
        data: &AccountData,
    ) -> SingleOwnerAccount<JsonRpcClient<HttpTransport>, LocalWallet> {
        self._single_owner_account_with_encoding(data, ExecutionEncoding::New)
            .await
    }
    async fn _single_owner_account_with_encoding(
        &self,
        data: &AccountData,
        encoding: ExecutionEncoding,
    ) -> SingleOwnerAccount<JsonRpcClient<HttpTransport>, LocalWallet> {
        let network = self.client();
        let chain_id = network.chain_id().await.unwrap();

        let mut account = SingleOwnerAccount::new(
            network,
            LocalWallet::from(data.signing_key()),
            data.account_address,
            chain_id,
            encoding,
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

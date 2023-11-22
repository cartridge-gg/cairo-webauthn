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

pub trait RpcClientProvider<T> {
    fn get_client(&self) -> JsonRpcClient<T>;
}

pub trait PredeployedClientProvider
where
    Self: RpcClientProvider<HttpTransport>,
{
    fn predeployed_fee_token(&self) -> PredeployedContract;
    fn predeployed_udc(&self) -> PredeployedContract;
}

pub trait PrefoundedClientProvider
where
    Self: RpcClientProvider<HttpTransport>,
{
    fn prefounded_account(&self) -> PredeployedAccount;
}

pub struct PredeployedAccount {
    pub account_address: FieldElement,
    pub private_key: FieldElement,
    pub public_key: FieldElement,
}

impl PredeployedAccount {
    pub fn signing_key(&self) -> SigningKey {
        SigningKey::from_secret_scalar(self.private_key)
    }
}

pub struct PredeployedContract {
    pub address: FieldElement,
    pub class_hash: FieldElement,
}

pub async fn prefunded<T>(
    provider: &T,
) -> SingleOwnerAccount<JsonRpcClient<HttpTransport>, LocalWallet>
where
    T: PrefoundedClientProvider,
    T: RpcClientProvider<HttpTransport>,
{
    let predeployed = provider.prefounded_account();
    let network = provider.get_client();
    let chain_id = network.chain_id().await.unwrap();

    let mut account = SingleOwnerAccount::new(
        network,
        LocalWallet::from(predeployed.signing_key()),
        predeployed.account_address,
        chain_id,
        ExecutionEncoding::Legacy,
    );

    account.set_block_id(BlockId::Tag(BlockTag::Pending)); // For fetching valid nonce
    account
}

use std::sync::Arc;

use crate::{
    deployer::{Declarable, Deployable},
    providers::{RpcClientProvider, PredeployedClientProvider}, transaction_waiter::TransactionWaiter,
};
use starknet::{
    accounts::{Account, Call, ExecutionEncoding, SingleOwnerAccount},
    core::types::{
        contract::{CompiledClass, SierraClass},
        BlockId, BlockTag, DeclareTransactionResult, FieldElement, InvokeTransactionResult,
    },
    macros::selector,
    providers::{JsonRpcClient, Provider},
    signers::{LocalWallet, Signer, SigningKey},
};

pub const SIERRA_STR: &str = include_str!(
    "../../cartridge_account/target/dev/cartridge_account_Account.contract_class.json"
);
pub const CASM_STR: &str = include_str!(
    "../../cartridge_account/target/dev/cartridge_account_Account.compiled_contract_class.json"
);

pub struct CustomContract;

impl Declarable for CustomContract {
    fn artifact_str(&self) -> &str {
        SIERRA_STR
    }
}

impl Deployable for CustomContract {
    fn salt(&self) -> FieldElement {
        FieldElement::default()
    }
}

pub async fn declare_and_deploy_contract<T>(
    rpc_provider: &(impl RpcClientProvider<T> + PredeployedClientProvider),
    signing_key: SigningKey,
    address: FieldElement,
    constructor_calldata: Vec<FieldElement>,
) -> Result<InvokeTransactionResult, String>
where
    JsonRpcClient<T>: Provider,
    T: Send + Sync,
{
    let (result, account) = declare_contract(rpc_provider, signing_key, address)
        .await
        .unwrap();
    deploy_contract(rpc_provider, constructor_calldata, account, result.class_hash).await
}

pub async fn declare_contract<T>(
    rpc_provider: &impl RpcClientProvider<T>,
    signing_key: SigningKey,
    address: FieldElement,
) -> Result<
    (
        DeclareTransactionResult,
        SingleOwnerAccount<JsonRpcClient<T>, LocalWallet>,
    ),
    String,
>
where
    JsonRpcClient<T>: Provider,
    T: Send + Sync,
{
    // Sierra class artifact. Output of the `starknet-compile` command
    let contract_artifact: SierraClass =
        serde_json::from_str(SIERRA_STR).map_err(|e| e.to_string())?;

    // Class hash of the compiled CASM class from the `starknet-sierra-compile` command
    let compiled_class: CompiledClass =
        serde_json::from_str(CASM_STR).map_err(|e| e.to_string())?;
    let casm_class_hash = compiled_class.class_hash().map_err(|e| e.to_string())?;

    let account = account_for_address(rpc_provider, signing_key, address).await;

    // We need to flatten the ABI into a string first
    let flattened_class = contract_artifact.flatten().map_err(|e| e.to_string())?;

    let declaration_result = account.declare(Arc::new(flattened_class), casm_class_hash).send().await.unwrap();

    TransactionWaiter::new(declaration_result.transaction_hash, &rpc_provider.get_client()).await.unwrap();

    Ok((declaration_result, account))
}

pub async fn deploy_contract<T, P, S>(
    client_provider: &(impl RpcClientProvider<T> + PredeployedClientProvider),
    constructor_calldata: Vec<FieldElement>,
    account: SingleOwnerAccount<P, S>,
    class_hash: FieldElement,
) -> Result<InvokeTransactionResult, String>
where
    P: Provider + Send + Sync,
    S: Signer + Send + Sync,
    JsonRpcClient<T>: Provider,
    T: Send + Sync,
{
    let calldata = [
        vec![
            class_hash,
            FieldElement::ZERO, // salt
            FieldElement::ZERO, // unique
            FieldElement::from(constructor_calldata.len()),
        ],
        constructor_calldata,
    ]
    .concat();

    let result = account
        .execute(vec![Call {
            calldata,
            selector: selector!("deployContract"),
            to: client_provider.predeployed_udc().address,
        }])
        .send()
        .await.map_err(|e| e.to_string())?;

    TransactionWaiter::new(result.transaction_hash, &client_provider.get_client()).await.unwrap();

    Ok(result)
}

pub async fn account_for_address<T>(
    rpc_provider: &impl RpcClientProvider<T>,
    signing_key: SigningKey,
    address: FieldElement,
) -> SingleOwnerAccount<JsonRpcClient<T>, LocalWallet>
where
    JsonRpcClient<T>: Provider,
    T: Send + Sync,
{
    let client = rpc_provider.get_client();
    let signer = LocalWallet::from(signing_key);
    let chain_id = rpc_provider
        .get_client()
        .chain_id()
        .await
        .expect("No connection");

    let mut account =
        SingleOwnerAccount::new(client, signer, address, chain_id, ExecutionEncoding::New);

    // `SingleOwnerAccount` defaults to checking nonce and estimating fees against the latest
    // block. Optionally change the target block to pending with the following line:
    account.set_block_id(BlockId::Tag(BlockTag::Latest));
    account
}

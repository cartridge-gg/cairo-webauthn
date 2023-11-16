use std::sync::Arc;

use crate::rpc_provider::RpcClientProvider;
use starknet::{
    accounts::{Account, ExecutionEncoding, SingleOwnerAccount},
    core::types::{
        contract::{CompiledClass, SierraClass},
        DeclareTransactionResult, FieldElement, BlockId, BlockTag,
    },
    providers::{JsonRpcClient, Provider},
    signers::{LocalWallet, SigningKey},
};

const SIERRA_STR: &str =
    include_str!("../../cartridge_account/target/dev/cartridge_account_Account.contract_class.json");
const CASM_STR: &str =
    include_str!("../../cartridge_account/target/dev/cartridge_account_Account.compiled_contract_class.json");

pub async fn deploy_contract<T>(
    rpc_provider: impl RpcClientProvider<T>,
    signing_key: SigningKey,
    address: FieldElement,
) -> Result<DeclareTransactionResult, String>
where
    JsonRpcClient<T>: Provider,
    T: Send + Sync,
{
    let _ = rpc_provider;
    // Sierra class artifact. Output of the `starknet-compile` command
    let contract_artifact: SierraClass =
        serde_json::from_str(SIERRA_STR).map_err(|e| e.to_string())?;

    // Class hash of the compiled CASM class from the `starknet-sierra-compile` command
    let compiled_class: CompiledClass =
        serde_json::from_str(CASM_STR).map_err(|e| e.to_string())?;
    let compiled_class_hash = compiled_class.class_hash().map_err(|e| e.to_string())?;

    let client = rpc_provider.get_client();
    let signer = LocalWallet::from(signing_key);

    let mut account = SingleOwnerAccount::new(
        client,
        signer,
        address,
        rpc_provider.chain_id(),
        ExecutionEncoding::New,
    );

    // `SingleOwnerAccount` defaults to checking nonce and estimating fees against the latest
    // block. Optionally change the target block to pending with the following line:
    account.set_block_id(BlockId::Tag(BlockTag::Pending));

    // We need to flatten the ABI into a string first
    let flattened_class = contract_artifact.flatten().map_err(|e| e.to_string())?;

    let declaration = account.declare(Arc::new(flattened_class), compiled_class_hash);

    declaration.send().await.map_err(|e| e.to_string())
}

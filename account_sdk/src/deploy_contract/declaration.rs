use std::sync::Arc;

use starknet::{
    accounts::{Account, SingleOwnerAccount},
    core::types::contract::{CompiledClass, SierraClass},
    providers::{JsonRpcClient, Provider},
    signers::Signer,
};

use crate::providers::RpcClientProvider;

use super::pending::PendingDeclaration;

pub const SIERRA_STR: &str = include_str!(
    "../../../cartridge_account/target/dev/cartridge_account_Account.contract_class.json"
);
pub const CASM_STR: &str = include_str!(
    "../../../cartridge_account/target/dev/cartridge_account_Account.compiled_contract_class.json"
);

pub struct CustomAccountDeclaration<'a, Q> {
    contract_artifact: SierraClass,
    compiled_class: CompiledClass,
    rpc_provider: &'a Q,
}

impl<'a, Q> CustomAccountDeclaration<'a, Q> {
    pub fn new<T>(
        contract_artifact: SierraClass,
        compiled_class: CompiledClass,
        rpc_provider: &'a Q,
    ) -> Self
    where
        T: Send + Sync,
        JsonRpcClient<T>: Provider,
        Q: RpcClientProvider<T>,
    {
        Self {
            contract_artifact,
            compiled_class,
            rpc_provider,
        }
    }
    pub fn cartridge_account<T>(rpc_provider: &'a Q) -> Self
    where
        T: Send + Sync,
        JsonRpcClient<T>: Provider,
        Q: RpcClientProvider<T>,
    {
        Self {
            contract_artifact: serde_json::from_str(SIERRA_STR).unwrap(),
            compiled_class: serde_json::from_str(CASM_STR).unwrap(),
            rpc_provider,
        }
    }
}

impl<'a, Q> CustomAccountDeclaration<'a, Q> {
    pub async fn declare<T, P, S>(
        &self,
        account: &SingleOwnerAccount<P, S>,
    ) -> Result<PendingDeclaration<T>, String>
    where
        T: Send + Sync,
        JsonRpcClient<T>: Provider,
        Q: RpcClientProvider<T>,
        P: Provider + Send + Sync,
        S: Signer + Send + Sync,
    {
        let casm_class_hash = self
            .compiled_class
            .class_hash()
            .map_err(|e| e.to_string())?;

        // We need to flatten the ABI into a string first
        let flattened_class = self
            .contract_artifact
            .clone()
            .flatten()
            .map_err(|e| e.to_string())?;

        let declaration_result = account
            .declare(Arc::new(flattened_class), casm_class_hash)
            .send()
            .await
            .unwrap();

        Ok(PendingDeclaration::from((
            declaration_result,
            self.rpc_provider.get_client(),
        )))
    }
}

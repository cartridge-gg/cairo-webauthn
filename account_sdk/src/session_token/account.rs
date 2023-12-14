use async_trait::async_trait;
use starknet::{
    accounts::{
        Account, Call, ConnectedAccount, Declaration, Execution, ExecutionEncoder,
        LegacyDeclaration, RawDeclaration, RawExecution, RawLegacyDeclaration, SingleOwnerAccount,
    },
    core::{
        crypto::EcdsaSignError,
        types::{
            contract::legacy::LegacyContractClass, BlockId, FieldElement, FlattenedSierraClass, BlockTag,
        },
    },
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
    signers::{LocalWallet, SigningKey},
};
use std::sync::Arc;

use super::{Session, SessionSignature};

impl<'a> ExecutionEncoder for SessionAccount<'a> {
    fn encode_calls(&self, calls: &[Call]) -> Vec<FieldElement> {
        // analogous to SingleOwnerAccount::encode_calls for ExecutionEncoding::Legacy
        let mut execute_calldata: Vec<FieldElement> = vec![calls.len().into()];

        let mut concated_calldata: Vec<FieldElement> = vec![];
        for call in calls.iter() {
            execute_calldata.push(call.to); // to
            execute_calldata.push(call.selector); // selector
            execute_calldata.push(concated_calldata.len().into()); // data_offset
            execute_calldata.push(call.calldata.len().into()); // data_len

            for item in call.calldata.iter() {
                concated_calldata.push(*item);
            }
        }

        execute_calldata.push(concated_calldata.len().into()); // calldata_len
        execute_calldata.extend_from_slice(&concated_calldata);
        execute_calldata
    }
}

#[derive(Debug, thiserror::Error)]
pub enum SignError {
    #[error("Signer error: {0}")]
    Signer(EcdsaSignError),
}

pub struct SessionAccount<'a> {
    session: Session,
    owned: SingleOwnerAccount<&'a JsonRpcClient<HttpTransport>, LocalWallet>,
    chain_id: FieldElement,
    address: FieldElement,
    signer: SigningKey,
}

impl<'a> SessionAccount<'a> {
    pub fn new(
        session: Session,
        owned: SingleOwnerAccount<&'a JsonRpcClient<HttpTransport>, LocalWallet>,
        chain_id: FieldElement,
        address: FieldElement,
        signer: SigningKey,
    ) -> Self {
        Self {
            session,
            owned,
            chain_id,
            address,
            signer,
        }
    }
}

#[cfg_attr(not(target_arch = "wasm32"), async_trait)]
#[cfg_attr(target_arch = "wasm32", async_trait(?Send))]
impl<'a> Account for SessionAccount<'a> {
    type SignError = SignError;

    fn address(&self) -> FieldElement {
        self.owned.address()
    }

    fn chain_id(&self) -> FieldElement {
        self.owned.chain_id()
    }

    async fn sign_execution(
        &self,
        execution: &RawExecution,
        query_only: bool,
    ) -> Result<Vec<FieldElement>, Self::SignError> {
        let tx_hash = execution.transaction_hash(self.chain_id, self.address, query_only, self);
        let signature = self
            .signer
            .sign(&tx_hash)
            .map_err(|e| SignError::Signer(e))?;

        let signature = SessionSignature {
            r: signature.r,
            s: signature.s,
            session_key: self.session.session_key(),
            session_expires: self.session.session_expires(),
            root: self.session.root(),
            proof_len: self.session.proof_len(),
            proofs: self.session.proofs(),
            session_token: self.session.session_token(),
        };

        Ok(signature.into())
    }

    async fn sign_declaration(
        &self,
        _declaration: &RawDeclaration,
        _query_only: bool,
    ) -> Result<Vec<FieldElement>, Self::SignError> {
        unimplemented!("sign_declaration")
    }

    async fn sign_legacy_declaration(
        &self,
        _legacy_declaration: &RawLegacyDeclaration,
        _query_only: bool,
    ) -> Result<Vec<FieldElement>, Self::SignError> {
        unimplemented!("sign_legacy_declaration")
    }

    fn execute(&self, calls: Vec<Call>) -> Execution<Self> {
        Execution::new(calls, self)
    }

    fn declare(
        &self,
        contract_class: Arc<FlattenedSierraClass>,
        compiled_class_hash: FieldElement,
    ) -> Declaration<Self> {
        Declaration::new(contract_class, compiled_class_hash, self)
    }

    fn declare_legacy(&self, contract_class: Arc<LegacyContractClass>) -> LegacyDeclaration<Self> {
        LegacyDeclaration::new(contract_class, self)
    }
}

impl<'a> ConnectedAccount for SessionAccount<'a> {
    type Provider = JsonRpcClient<HttpTransport>;

    fn provider(&self) -> &Self::Provider {
        self.owned.provider()
    }

    fn block_id(&self) -> BlockId {
        BlockId::Tag(BlockTag::Latest)
    }
}

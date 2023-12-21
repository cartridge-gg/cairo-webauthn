use async_trait::async_trait;
use cainome::cairo_serde::CairoSerde;
use starknet::{
    accounts::{
        Account, Call as StarknetCall, ConnectedAccount, Declaration, Execution, ExecutionEncoder,
        LegacyDeclaration, RawDeclaration, RawExecution, RawLegacyDeclaration,
    },
    core::types::{
        contract::legacy::LegacyContractClass, BlockId, BlockTag, FieldElement,
        FlattenedSierraClass,
    },
    providers::Provider,
    signers::Signer,
};
use std::{sync::Arc, vec};

use crate::abigen::account::SessionSignature;
use crate::session_token::Session;

impl<P, S> ExecutionEncoder for SessionAccount<P, S>
where
    P: Provider + Send,
    S: Signer + Send,
{
    fn encode_calls(&self, calls: &[StarknetCall]) -> Vec<FieldElement> {
        // analogous to SingleOwnerAccount::encode_calls for ExecutionEncoding::New
        let mut serialized = vec![calls.len().into()];

        for call in calls.iter() {
            serialized.push(call.to); // to
            serialized.push(call.selector); // selector

            serialized.push(call.calldata.len().into()); // calldata.len()
            serialized.extend_from_slice(&call.calldata);
        }

        serialized
    }
}

#[derive(Debug, thiserror::Error)]
pub enum SignError<S, P> {
    #[error(transparent)]
    Signer(S),
    #[error(transparent)]
    SignersPubkey(P),
}

pub struct SessionAccount<P, S>
where
    P: Provider + Send,
    S: Signer + Send,
{
    provider: P,
    signer: S,
    session: Session,
    chain_id: FieldElement,
    address: FieldElement,
}

impl<P, S> SessionAccount<P, S>
where
    P: Provider + Send,
    S: Signer + Send,
{
    pub fn new(
        provider: P,
        signer: S,
        session: Session,
        address: FieldElement,
        chain_id: FieldElement,
    ) -> Self {
        Self {
            provider,
            signer,
            session,
            chain_id,
            address,
        }
    }

    pub fn session(&mut self) -> &mut Session {
        &mut self.session
    }
}

#[cfg_attr(not(target_arch = "wasm32"), async_trait)]
#[cfg_attr(target_arch = "wasm32", async_trait(?Send))]
impl<P, S> Account for SessionAccount<P, S>
where
    P: Provider + Send + Sync,
    S: Signer + Send + Sync,
{
    type SignError = SignError<S::SignError, S::GetPublicKeyError>;

    fn address(&self) -> FieldElement {
        self.address
    }

    fn chain_id(&self) -> FieldElement {
        self.chain_id
    }

    async fn sign_execution(
        &self,
        execution: &RawExecution,
        query_only: bool,
    ) -> Result<Vec<FieldElement>, Self::SignError> {
        let tx_hash = execution.transaction_hash(self.chain_id, self.address, query_only, self);
        let signature = self
            .signer
            .sign_hash(&tx_hash)
            .await
            .map_err(SignError::Signer)?;

        let signature = self.session.signature(signature, 0);

        Ok(SessionSignature::cairo_serialize(&signature))
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

    fn execute(&self, calls: Vec<StarknetCall>) -> Execution<Self> {
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

impl<P, S> ConnectedAccount for SessionAccount<P, S>
where
    P: Provider + Send + Sync,
    S: Signer + Send + Sync,
{
    type Provider = P;

    fn provider(&self) -> &Self::Provider {
        &self.provider
    }

    fn block_id(&self) -> BlockId {
        BlockId::Tag(BlockTag::Latest)
    }
}

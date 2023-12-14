use async_trait::async_trait;
use starknet::{
    accounts::{
        Account, Call, ConnectedAccount, Declaration, Execution, ExecutionEncoder,
        LegacyDeclaration, RawDeclaration, RawExecution, RawLegacyDeclaration, SingleOwnerAccount,
    },
    core::{
        crypto::EcdsaSignError,
        types::{
            contract::legacy::LegacyContractClass, BlockId, BlockTag, FieldElement,
            FlattenedSierraClass,
        },
    },
    providers::{jsonrpc::HttpTransport, JsonRpcClient},
    signers::{LocalWallet, SigningKey},
};
use std::sync::Arc;

use super::{Session, SessionSignature};

impl<'a> ExecutionEncoder for SessionAccount<'a> {
    fn encode_calls(&self, calls: &[Call]) -> Vec<FieldElement> {
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
        // let tx_hash = FieldElement::from(2137u32);
        let signature = self
            .signer
            .sign(&tx_hash)
            .map_err(|e| SignError::Signer(e))?;

        let signature = SessionSignature {
            r: signature.r,
            s: signature.s,
            session_key: self.signer.verifying_key().scalar(),
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

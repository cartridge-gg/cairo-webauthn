use std::vec;

use starknet::{
    accounts::{Account, ConnectedAccount},
    core::{crypto::Signature, types::FieldElement},
    macros::felt,
    signers::VerifyingKey,
};

use crate::abigen::account::{Call, CartridgeAccount, SessionSignature, SignatureProofs};

use super::SESSION_SIGNATURE_TYPE;

#[derive(Clone)]
pub struct CallWithProof(pub Call, pub Vec<FieldElement>);

#[derive(Clone)]
pub struct Session {
    session_key: VerifyingKey,
    expires: u64,
    calls: Vec<CallWithProof>,
    session_token: Vec<FieldElement>,
    root: FieldElement,
}

#[derive(Debug, thiserror::Error)]
pub enum SessionError {
    #[error("At least one call has to be permitted")]
    NoCallsPermited,
    #[error("Call to compute method failed")]
    ChainCallFailed,
}

impl Session {
    pub fn new(key: VerifyingKey, expires: u64) -> Self {
        Self {
            session_key: key,
            expires,
            calls: vec![],
            session_token: vec![],
            root: FieldElement::ZERO,
        }
    }

    pub fn session_expires(&self) -> u64 {
        self.expires
    }

    pub fn session_token(&self) -> Vec<FieldElement> {
        self.session_token.clone()
    }

    pub fn call_with_proof(&self, position: usize) -> &CallWithProof {
        &self.calls[position]
    }

    pub async fn set_permitted_calls<A>(
        &mut self,
        calls: Vec<Call>,
        account: CartridgeAccount<A>,
    ) -> Result<FieldElement, SessionError>
    where
        A: Account + ConnectedAccount + Sync,
    {
        if calls.is_empty() {
            Err(SessionError::NoCallsPermited)?;
        }

        self.calls = Vec::with_capacity(calls.len());

        for i in 0..(calls.len() as u64) {
            let proof = account
                .compute_proof(&calls, &i)
                .call()
                .await
                .map_err(|_| SessionError::ChainCallFailed)?;
            let call_with_proof = CallWithProof(calls[i as usize].clone(), proof);
            self.calls.push(call_with_proof);
        }

        self.root = account
            .compute_root(&calls[0], &self.calls[0].1)
            .call()
            .await
            .map_err(|_| SessionError::ChainCallFailed)?;

        // Only three fields are hashed: session_key, session_expires and root
        let signature = SessionSignature {
            signature_type: FieldElement::ZERO,
            r: FieldElement::ZERO,
            s: FieldElement::ZERO,
            session_key: self.session_key.scalar(),
            session_expires: self.expires,
            root: self.root,
            proofs: SignatureProofs {
                single_proof_len: 0,
                proofs_flat: vec![],
            },
            session_token: vec![],
        };

        let session_hash = account
            .compute_session_hash(&signature)
            .call()
            .await
            .map_err(|_| SessionError::ChainCallFailed)?;

        Ok(session_hash)
    }

    pub fn set_token(&mut self, token: Signature) {
        self.session_token = vec![token.r, token.s];
    }

    pub fn signature(
        &self,
        transaction_signature: Signature,
        call_position: usize,
    ) -> SessionSignature {
        let CallWithProof(_, proof) = &self.calls[call_position];

        SessionSignature {
            signature_type: SESSION_SIGNATURE_TYPE,
            r: transaction_signature.r,
            s: transaction_signature.s,
            session_key: self.session_key.scalar(),
            session_expires: self.expires,
            root: self.root,
            proofs: SignatureProofs {
                single_proof_len: proof.len() as u32,
                proofs_flat: proof.clone(),
            },
            session_token: self.session_token.clone(),
        }
    }
}

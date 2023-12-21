use starknet::{
    accounts::{Account, ConnectedAccount},
    core::types::FieldElement,
    macros::felt,
};

use crate::abigen::account::{Call, CartridgeAccount};

#[derive(Clone)]
pub struct CallWithProof(pub Call, pub Vec<FieldElement>);

#[derive(Clone)]
pub struct Session {
    session_expires: u64,
    calls: Vec<CallWithProof>,
    session_token: Vec<FieldElement>,
    root: FieldElement,
}

enum SessionError {
    NoCallsPermited,
    ChainCallFailed,
}

impl Session {
    pub fn session_expires(&self) -> u64 {
        self.session_expires
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
    ) -> Result<(), SessionError>
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

        Ok(())
    }
}

impl Default for Session {
    fn default() -> Self {
        Self {
            session_expires: u64::MAX,
            session_token: vec![felt!("0x2137")],
            calls: vec![],
            root: felt!("0x2137"),
        }
    }
}

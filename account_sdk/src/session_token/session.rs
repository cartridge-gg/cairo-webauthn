use starknet::{core::types::FieldElement, macros::felt, signers::SigningKey};

use super::signature::SessionSignature;

#[derive(Clone)]
pub struct Session {
    session_key: FieldElement,
    session_expires: u64,
    root: FieldElement,
    proof_len: u32,
    proofs: Vec<FieldElement>,
    session_token: Vec<FieldElement>,
}

impl Session {
    pub fn session_expires(&self) -> u64 {
        self.session_expires
    }

    pub fn root(&self) -> FieldElement {
        self.root
    }

    pub fn proof_len(&self) -> u32 {
        self.proof_len
    }

    pub fn proofs(&self) -> Vec<FieldElement> {
        self.proofs.clone()
    }

    pub fn session_token(&self) -> Vec<FieldElement> {
        self.session_token.clone()
    }
}

impl Default for Session {
    fn default() -> Self {
        Self {
            session_key: felt!("0x69"),
            session_expires: u64::MAX,
            root: felt!("0x0"),
            proof_len: 1,
            proofs: vec![felt!("44")],
            session_token: vec![felt!("2137")],
        }
    }
}

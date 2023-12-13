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
    pub fn sign(&mut self, signing: &SigningKey) -> SessionSignature {
        let hash = FieldElement::from(2137u32);
        let signature = signing.sign(&hash).unwrap();
        self.session_key = signing.verifying_key().scalar();

        SessionSignature {
            r: signature.r,
            s: signature.s,
            session_key: self.session_key,
            session_expires: self.session_expires,
            root: self.root,
            proof_len: self.proof_len,
            proofs: self.proofs.clone(),
            session_token: self.session_token.clone(),
        }
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

use starknet::core::types::FieldElement;

#[derive(Clone)]
pub struct SessionSignature {
    pub r: FieldElement,
    pub s: FieldElement,
    pub session_key: FieldElement,
    pub session_expires: u64,
    pub root: FieldElement,
    pub proof_len: u32,
    pub proofs: Vec<FieldElement>,
    pub session_token: Vec<FieldElement>,
}

impl Into<Vec<FieldElement>> for SessionSignature {
    fn into(self) -> Vec<FieldElement> {
        let mut result = vec![super::SIGNATURE_TYPE];
        result.push(self.r);
        result.push(self.s);
        result.push(self.session_key);
        result.push(self.session_expires.into());
        result.push(self.root);
        result.push(self.proof_len.into());
        result.push(self.proofs.len().into());
        result.extend(self.proofs);
        result.push(self.session_token.len().into());
        result.extend(self.session_token);
        result
    }
}

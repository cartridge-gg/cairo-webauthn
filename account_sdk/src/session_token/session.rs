use starknet::{core::types::FieldElement, macros::felt};

#[derive(Clone)]
pub struct Session {
    session_expires: u64,
    session_token: Vec<FieldElement>,
}

impl Session {
    pub fn session_expires(&self) -> u64 {
        self.session_expires
    }

    pub fn session_token(&self) -> Vec<FieldElement> {
        self.session_token.clone()
    }
}

impl Default for Session {
    fn default() -> Self {
        Self {
            session_expires: u64::MAX,
            session_token: vec![felt!("0x2137")],
        }
    }
}

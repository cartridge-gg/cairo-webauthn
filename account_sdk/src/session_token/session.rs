use starknet::{core::types::FieldElement, macros::felt};

use crate::abigen::account::Call;

#[derive(Clone)]
pub struct Session {
    session_expires: u64,
    session_token: Vec<FieldElement>,
    permitted_calls: Vec<Call>,
}

impl Session {
    pub fn session_expires(&self) -> u64 {
        self.session_expires
    }

    pub fn session_token(&self) -> Vec<FieldElement> {
        self.session_token.clone()
    }

    pub fn permitted_calls(&self) -> &Vec<Call> {
        &self.permitted_calls
    }

    pub fn set_permitted_calls(&mut self, calls: Vec<Call>) {
        self.permitted_calls = calls;
    }
}

impl Default for Session {
    fn default() -> Self {
        Self {
            session_expires: u64::MAX,
            session_token: vec![felt!("0x2137")],
            permitted_calls: vec![],
        }
    }
}

use serde::Serialize;
use starknet::core::types::FieldElement;

use super::{credential::AuthenticatorAssertionResponse, U256};

#[derive(Debug, Clone, Serialize)]
pub struct VerifyWebauthnSignerArgs {
    pub_x: U256,
    pub_y: U256,
    r: U256,
    s: U256,
}

impl From<(([u8; 32], [u8; 32]), AuthenticatorAssertionResponse)> for VerifyWebauthnSignerArgs {
    fn from((pub_key, response): (([u8; 32], [u8; 32]), AuthenticatorAssertionResponse)) -> Self {
        let (pub_x, pub_y) = (felt_pair(&pub_key.0), felt_pair(&pub_key.1));
        let (r, s) = (
            felt_pair(&response.signature[0..32].try_into().unwrap()),
            felt_pair(&response.signature[32..64].try_into().unwrap()),
        );
        Self { pub_x, pub_y, r, s }
    }
}

fn felt_pair(bytes: &[u8; 32]) -> (FieldElement, FieldElement) {
    (
        FieldElement::from_bytes_be(&extend_to_32(&bytes[16..32])).unwrap(),
        FieldElement::from_bytes_be(&extend_to_32(&bytes[0..16])).unwrap(),
    )
}

fn extend_to_32(bytes: &[u8]) -> [u8; 32] {
    let mut ret = [0; 32];
    ret[32 - bytes.len()..].copy_from_slice(bytes);
    ret
}

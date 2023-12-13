use serde::Serialize;
use starknet::core::types::FieldElement;

use super::{credential::AuthenticatorAssertionResponse, U256};

#[derive(Debug, Clone, Serialize)]
pub struct VerifyWebauthnSignerArgs {
    pub_x: U256,
    pub_y: U256,
    r: U256,
    s: U256,
    type_offset: usize,
    challenge_offset: usize,
    origin_offset: usize,
    client_data_json: Vec<u8>,
    challenge: Vec<u8>,
    origin: Vec<u8>,
    authenticator_data: Vec<u8>,
}

impl VerifyWebauthnSignerArgs {
    pub fn from_response(
        pub_key: ([u8; 32], [u8; 32]),
        origin: String,
        challenge: Vec<u8>,
        response: AuthenticatorAssertionResponse,
    ) -> Self {
        let (pub_x, pub_y) = (felt_pair(&pub_key.0), felt_pair(&pub_key.1));
        let (r, s) = (
            felt_pair(&response.signature[0..32].try_into().unwrap()),
            felt_pair(&response.signature[32..64].try_into().unwrap()),
        );
        let type_offset = find_value_index(&response.client_data_json, "type").unwrap();
        let challenge_offset = find_value_index(&response.client_data_json, "challenge").unwrap();
        let origin_offset = find_value_index(&response.client_data_json, "origin").unwrap();
        Self {
            pub_x,
            pub_y,
            r,
            s,
            type_offset,
            challenge_offset,
            origin_offset,
            client_data_json: response.client_data_json.into_bytes(),
            challenge,
            origin: origin.into_bytes(),
            authenticator_data: response.authenticator_data.into(),
        }
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

fn find_value_index(json_str: &str, key: &str) -> Option<usize> {
    let key_index = json_str.find(&format!("\"{}\"", key))?;

    let colon_index = json_str[key_index..].find(':')? + key_index;

    let value_start_index = json_str[colon_index + 1..].find('"')?;

    Some(colon_index + 1 + value_start_index + 1)
}

#[cfg(test)]
mod tests {
    use super::find_value_index;
    #[test]
    fn test_find_value_index() {
        let json_str =
            r#"{"type":"webauthn.get","challenge":"aGVsbG8=","origin":"https://example.com"}"#;
        assert_eq!(find_value_index(json_str, "type"), Some(9));
        assert_eq!(find_value_index(json_str, "challenge"), Some(36));
        assert_eq!(find_value_index(json_str, "origin"), Some(56));
    }

    #[test]
    fn test_find_value_index_whitespace() {
        let json_str = r#"{   "type":      "webauthn.get",  "challenge":   "aGVsbG8=","origin":    "https://example.com"}"#;
        assert_eq!(find_value_index(json_str, "type"), Some(18));
        assert_eq!(find_value_index(json_str, "challenge"), Some(50));
        assert_eq!(find_value_index(json_str, "origin"), Some(74));
    }
}

use serde::Serialize;

#[derive(Debug, Clone, Serialize)]
pub struct CliendData {
    #[serde(rename = "type")]
    type_: String,
    challenge: String,
    origin: String,
    #[serde(rename = "crossOrigin")]
    cross_origin: bool,
}

impl CliendData {
    pub fn new(challenge: impl AsRef<[u8]>, origin: String) -> Self {
        use base64::{engine::general_purpose::URL_SAFE, Engine as _};
        let challenge = URL_SAFE.encode(challenge);

        Self {
            type_: "webauthn.get".into(),
            challenge,
            origin,
            cross_origin: false,
        }
    }
    pub fn to_json(&self) -> String {
        serde_json::to_string(self).unwrap()
    }
}

#[derive(Debug, Clone, Serialize)]
pub struct AuthenticatorAssertionResponse {
    pub authenticator_data: AuthenticatorData,
    pub client_data_json: String,
    pub signature: Vec<u8>,
    pub user_handle: Option<Vec<u8>>,
}

#[derive(Debug, Clone, Serialize)]
pub struct AuthenticatorData {
    pub rp_id_hash: [u8; 32],
    pub flags: u8,
    pub sign_count: u32,
    // ...
}

impl Into<Vec<u8>> for AuthenticatorData {
    fn into(self) -> Vec<u8> {
        let mut data = Vec::new();
        data.extend_from_slice(&self.rp_id_hash);
        data.push(self.flags);
        data.extend_from_slice(&self.sign_count.to_be_bytes());
        data
    }
}

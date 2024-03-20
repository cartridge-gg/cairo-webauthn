use async_trait::async_trait;
use futures::channel::oneshot;
use wasm_bindgen_futures::spawn_local;
use wasm_webauthn::*;

use crate::webauthn_signer::credential::{AuthenticatorAssertionResponse, AuthenticatorData};

use super::Signer;

#[derive(Debug, Clone)]
pub struct DeviceSigner {
    pub rp_id: String,
    pub credential_id: Vec<u8>
}

impl DeviceSigner {
    pub fn new(rp_id: String, credential_id: Vec<u8>) -> Self {
        Self {
            rp_id,
            credential_id
        }
    }

    pub async fn register(rp_id: String, user_name: String, challenge: &[u8]) -> Self {
        let MakeCredentialResponse {
            credential
        } = Self::create_credential(rp_id.clone(), user_name, challenge).await;

        Self {
            rp_id,
            credential_id: credential.id.0
        }
    }

    async fn create_credential(rp_id: String, user_name: String, challenge: &[u8]) -> MakeCredentialResponse {
        let (tx, rx) = oneshot::channel();
        let rp_id = rp_id.to_owned();
        let challenge = challenge.to_vec();

        spawn_local(async move {
            let results: MakeCredentialResponse = MakeCredentialArgsBuilder::default()
                .rp_id(Some(rp_id))
                .challenge(challenge)
                .user_name(Some(user_name))
                .uv(UserVerificationRequirement::Required)
                .build().expect("invalid args")
                .make_credential().await
                .expect("make credential");

            tx.send(results).expect("receiver dropped")
        });

        rx.await.expect("receiver dropped")
    }

    async fn get_assertion(&self, challenge: &[u8]) -> GetAssertionResponse {
        let (tx, rx) = oneshot::channel();
        let credential_id = self.credential_id.clone();
        let rp_id = self.rp_id.to_owned();
        let challenge = challenge.to_vec();
        
        spawn_local(async move {
            let credential = Credential::from(CredentialID(credential_id));

            let results: GetAssertionResponse = GetAssertionArgsBuilder::default()
                .rp_id(Some(rp_id))
                .credentials(Some(vec![credential]))
                .challenge(challenge)
                .uv(UserVerificationRequirement::Required)
                .build()
                .expect("invalid args")
                .get_assertion()
                .await
                .expect("get assertion");

            tx.send(results).expect("receiver dropped");
        });

        rx.await.expect("receiver dropped")
    }
}

#[cfg_attr(not(target_arch = "wasm32"), async_trait)]
#[cfg_attr(target_arch = "wasm32", async_trait(?Send))]
impl Signer for DeviceSigner {
    async fn sign(&self, challenge: &[u8]) -> AuthenticatorAssertionResponse {
        let GetAssertionResponse {
            signature,
            client_data_json,
            flags,
            counter,
        } = self.get_assertion(challenge).await;

        AuthenticatorAssertionResponse {
            authenticator_data: AuthenticatorData {
                rp_id_hash: [0; 32],
                flags,
                sign_count: counter,
            },
            client_data_json,
            signature,
            user_handle: None,
        }
    }

    fn public_key_bytes(&self) -> ([u8; 32], [u8; 32]) {
        unimplemented!("unimplemented public_key_bytes")
    }
}

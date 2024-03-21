use super::credential::AuthenticatorAssertionResponse;
use super::account::SignError;
use async_trait::async_trait;

pub mod device;
pub mod p256r1;

#[cfg_attr(not(target_arch = "wasm32"), async_trait)]
#[cfg_attr(target_arch = "wasm32", async_trait(?Send))]
pub trait Signer {
    async fn sign(&self, challenge: &[u8]) -> Result<AuthenticatorAssertionResponse, SignError>;
    fn public_key_bytes(&self) -> ([u8; 32], [u8; 32]);
}

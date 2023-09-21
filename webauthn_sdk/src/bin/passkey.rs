use async_trait::async_trait;
use passkey::{
    authenticator::{Authenticator, UserValidationMethod},
    client::{Client, WebauthnError},
    types::{ctap2::*, rand::random_vec, webauthn::*, Bytes, Passkey},
};
use url::Url;

struct MyUserValidationMethod {}

#[async_trait]
impl UserValidationMethod for MyUserValidationMethod {
    /// Check for user verification user a user gesture and confirmation if this operation passes
    /// both the user presence and user verification flags will be enabled
    async fn check_user_verification(&self) -> bool {
        true
    }

    /// Used when only the user's presence is required, not their verification. For that see
    /// `check_user_verification`. This will capture the user's consent to the operation.
    async fn check_user_presence(&self) -> bool {
        true
    }

    /// Indicates whether this type is capable of testing user presence.
    fn is_presence_enabled(&self) -> bool {
        true
    }

    fn is_verification_enabled(&self) -> Option<bool> {
        Some(true)
    }
}

#[tokio::main]
async fn main() -> Result<(), WebauthnError> {
    let user_validation_method = MyUserValidationMethod {};
    let store: Option<Passkey> = None;
    let my_aaguid = Aaguid::new_empty();
    let my_authenticator = Authenticator::new(my_aaguid, store, user_validation_method);
    let origin: Url = Url::parse("https://example.net").unwrap();

    let my_client = Client::new(my_authenticator);

    let challenge_bytes_from_rp: Bytes = random_vec(32).into();
    // Now try and authenticate
    let credential_request = CredentialRequestOptions {
        public_key: PublicKeyCredentialRequestOptions {
            challenge: challenge_bytes_from_rp,
            timeout: None,
            rp_id: Some(String::from(origin.domain().unwrap())),
            allow_credentials: None,
            user_verification: UserVerificationRequirement::default(),
            extensions: None,
        },
    };

    // let credential = my_client.register(origin, request);

    let _authenticated_cred: AuthenticatedPublicKeyCredential = my_client
        .authenticate(&origin, credential_request, None)
        .await?;
    Ok(())
}

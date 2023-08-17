use serde::Serde;
use traits::Destruct;
use traits::Into;
use traits::Drop;
use traits::PartialEq;
use array::ArrayTrait;
use integer::upcast;
use debug::PrintTrait;
use option::OptionTrait;
use option::OptionCopy;
use core::clone::Clone;
use result::ResultTrait;
use starknet::secp256r1::Secp256r1Point;
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1PointImpl;
use starknet::secp256_trait::Secp256PointTrait;

use alexandria_math::sha256::sha256;
use alexandria_encoding::base64::Base64UrlEncoder;
use alexandria_math::karatsuba;
use alexandria_math::BitShift;

use webauthn::ecdsa::verify_ecdsa;
use webauthn::helpers::allow_credentials_contain_credential;
use webauthn::helpers::PartialEqArray;
use webauthn::helpers::UTF8Decoder;
use webauthn::helpers::JSONClientDataParser;
use webauthn::helpers::OriginChecker;
use webauthn::types::PublicKeyCredentialRequestOptions;
use webauthn::types::PublicKeyCredential;
use webauthn::types::PublicKey;
use webauthn::types::PublicKeyCredentialDescriptor;
use webauthn::types::AuthenticatorResponse;
use webauthn::types::OptionTCloneImpl;

enum StoreError {
    KeyRetirevalFailed
}

impl RTSEIntoRTAE<T>
    of Into<Result<T, StoreError>, Result<T, AuthnError>> {
    fn into(self: Result<T, StoreError>) -> Result<T, AuthnError>{
        match self {
            Result::Ok(t) => Result::Ok(t),
            Result::Err(e) => match e {
                StoreError::KeyRetirevalFailed => AuthnError::KeyRetirevalFailed.into()
            }
        }
    }
}

trait WebauthnStoreTrait<T>{
    fn verify_allow_credentials(
        self: @T, 
        allow_credentials: @Array<PublicKeyCredentialDescriptor>
    ) -> Result<(), ()>;
    fn retrieve_public_key(
        self: @T, 
        credential_raw_id: @Array<u8>
    ) -> Result<PublicKey, StoreError>;
}

// Probably should be split, we'll see later
trait WebauthnAuthenticatorTrait<T>{
    fn navigator_credentials_get(
        self: @T,
        options: @PublicKeyCredentialRequestOptions
    ) -> Result<PublicKeyCredential, ()>;
}

enum AuthnError{
    TransportNotAllowed,
    GetCredentialRejected,
    ResponseIsNotAttestation,
    CredentialNotAllowed,
    KeyRetirevalFailed,
    IdentifiedUsersMismatch,
    ChallengeMismatch,
    OriginMismatch
}

impl AuthnErrorIntoResultT<T>
    of Into<AuthnError, Result<T, AuthnError>> {
    fn into(self: AuthnError) -> Result<T, AuthnError>{
        Result::Err(self)
    }
}

// According to https://www.w3.org/TR/webauthn/#sctn-verifying-assertion
// Couldn't find a way to create a struct with all the necessary generic implementations
// There was either some name resolution problem or a recursive (cyclic) compiler bug
// Or I'm stupid
fn verify_authentication_assertion
<
// Store:
    StoreT, 
    impl WebauthnStoreTImpl: WebauthnStoreTrait<StoreT>, 
    impl SDrop: Drop<StoreT>,
// Authenticator:
    AuthenticatorT, 
    impl WebauthnAuthenticatorTImpl: WebauthnAuthenticatorTrait<AuthenticatorT>, 
    impl ADrop: Drop<AuthenticatorT>,
// Utils
    impl UTF8DecoderImpl: UTF8Decoder,
    impl JSONClientDataParserImpl: JSONClientDataParser,
    impl OriginCheckerImpl: OriginChecker
>
(
    // Can answer queries about prior registrations eg. a database driver
    store: StoreT, 
    // An authenticator abstraction 
    authenticator: AuthenticatorT,
    // Options configured by the relying party needs for the ceremony
    options: PublicKeyCredentialRequestOptions,
    // Some(...) if the user was identified before the ceremony, 
    // eg. via a username or cookie, None otherwise
    preidentified_user_handle: Option<Array<u8>> 
) -> Result<(), AuthnError> {
    // 1. 
    match @options.allow_credentials {
        Option::Some(c) => {
            match store.verify_allow_credentials(c) {
                Result::Ok => (),
                Result::Err => {
                    return AuthnError::TransportNotAllowed.into();
                }
            }
        },
        Option::None => (),
    };
    // 2.
    let credential = match @authenticator.navigator_credentials_get(@options) {
        Result::Ok(c) => c,
        Result::Err => {
            return AuthnError::GetCredentialRejected.into();
        }
    };
    // 3. 
    let response = match @credential.response {
        AuthenticatorResponse::Attestation(_) => {
            return AuthnError::ResponseIsNotAttestation.into();
        },
        AuthenticatorResponse::Assertion(r) => r
    };
    // 4. pass
    // 5. 
    match @options.allow_credentials {
        Option::Some(c) => {
            if !allow_credentials_contain_credential(c, credential){
                return AuthnError::CredentialNotAllowed.into();
            };
        },
        Option::None => (),
    };
    // 6. AND 7. TODO: Kick out to a separate method
    let credential_public_key = match @preidentified_user_handle {
        Option::Some(user) => {
            let pk_1 = RTSEIntoRTAE::<PublicKey>::into(store.retrieve_public_key(credential.raw_id))?;
            let pk_2 = RTSEIntoRTAE::<PublicKey>::into(store.retrieve_public_key(user))?;
            if pk_1 != pk_2 {
                return AuthnError::IdentifiedUsersMismatch.into();
            };
            match response.user_handle {
                Option::Some(handle) => {
                    let pk_3 = RTSEIntoRTAE::<PublicKey>::into(store.retrieve_public_key(*handle))?;
                    if pk_1 != pk_3 {
                        return AuthnError::IdentifiedUsersMismatch.into();
                    };
                },
                Option::None => (),
            }
            pk_1
        },
        Option::None => {
            let pk_1 = RTSEIntoRTAE::<PublicKey>::into(store.retrieve_public_key(credential.raw_id))?;
            let pk_2 = match response.user_handle {
                Option::Some(handle) 
                    => RTSEIntoRTAE::<PublicKey>::into(store.retrieve_public_key(credential.raw_id))?,
                Option::None => {
                    return AuthnError::IdentifiedUsersMismatch.into();
                },
            };
            if pk_1 != pk_2 {
                return AuthnError::IdentifiedUsersMismatch.into();
            };
            pk_1
        }
    };
    // 8.
    let c_data = response.client_data_json.clone();
    let auth_data = response.authenticator_data.clone();
    let sig = response.signature.clone();
    // 9. 
    let json_text = UTF8DecoderImpl::decode(c_data.clone());
    // 10.
    let c = JSONClientDataParserImpl::parse(json_text); 
    // 11. pass
    // 12. 
    if c.challenge != Base64UrlEncoder::encode(options.challenge) {
        return AuthnError::ChallengeMismatch.into();
    };
    // 13. 
    if !OriginCheckerImpl::check(c.origin) {
        return AuthnError::OriginMismatch.into();
    };
    // 14. pass
    // 15. 
    // ...


    Result::Ok(())
}

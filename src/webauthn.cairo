use core::traits::TryInto;
use traits::PartialEq;
use array::ArrayTrait;
use integer::upcast;
use debug::PrintTrait;
use option::OptionTrait;
use option::OptionCopy;
use result::ResultTrait;
use core::serde::Serde;
use core::traits::Destruct;
use core::traits::Into;
use core::traits::Drop;
use core::clone::Clone;
use starknet::secp256r1;
use starknet::secp256_trait::{
    recover_public_key,
    Signature
};
use alexandria_math::{sha256::sha256, BitShift};

use alexandria_encoding::base64::Base64UrlEncoder;

use webauthn::ecdsa::verify_ecdsa;
use webauthn::errors::{
    AuthnError,
    StoreError,
    RTSEIntoRTAE
};
use webauthn::helpers::{
    allow_credentials_contain_credential,
    PartialEqArray,
    UTF8Decoder,
    JSONClientDataParser,
    OriginChecker
};

use webauthn::types::{
    PublicKeyCredentialRequestOptions,
    PublicKeyCredential,
    PublicKey,
    PublicKeyCredentialDescriptor,
    AuthenticatorResponse,
    AuthenticatorAssertionResponse,
    OptionTCloneImpl,
    AuthenticatorData,
    AssertionOptions
};


trait WebauthnStoreTrait<T>{
    // This method should probably only return the saved credentials for them to be verified here 
    // reather than doing the chcecking itself
    // Leaving for now. TODO: revise this.
    fn verify_allow_credentials(
        self: @T, 
        allow_credentials: @Array<PublicKeyCredentialDescriptor>
    ) -> Result<(), ()>;
    fn retrieve_public_key(
        self: @T, 
        credential_raw_id: @Array<u8>
    ) -> Result<PublicKey, StoreError>;
}


trait WebauthnAuthenticatorTrait<T>{
    fn navigator_credentials_get(
        self: @T,
        options: @PublicKeyCredentialRequestOptions
    ) -> Result<PublicKeyCredential, ()>;
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
    preidentified_user_handle: Option<Array<u8>>,
    // Config options specific to the needs of this assertions
    assertion_options: AssertionOptions    
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
        AuthenticatorResponse::Assertion(r) => r.clone()
    };
    // 4. pass (extensions) 
    // 5. 
    match @options.allow_credentials {
        Option::Some(c) => {
            if !allow_credentials_contain_credential(c, credential){
                return AuthnError::CredentialNotAllowed.into();
            };
        },
        Option::None => (),
    };
    // 6. AND 7. 
    let credential_public_key = find_and_verify_credential_source
        ::<StoreT, WebauthnStoreTImpl, SDrop>(
            @store, @preidentified_user_handle, credential, response
        )?;
    // 8.
    let c_data = response.client_data_json.clone();
    let auth_data = response.authenticator_data.clone();
    let sig = response.signature.clone();
    // 9. 
    let json_text = UTF8DecoderImpl::decode(c_data.clone());
    // 10.
    let c = JSONClientDataParserImpl::parse(json_text); 
    // 11. pass (string verification) TODO:
    // 12. 
    if c.challenge != Base64UrlEncoder::encode(options.challenge) {
        return AuthnError::ChallengeMismatch.into();
    };
    // 13. 
    if !OriginCheckerImpl::check(c.origin) {
        return AuthnError::OriginMismatch.into();
    };
    // 14. pass TODO:
    // 15. 
    let auth_data_struct = 
        expand_auth_data_and_verify_rp_id_hash(
            auth_data.clone(), 
            assertion_options.expected_rp_id
    )?;
    // 16. AND 17.
    verify_user_flags(@auth_data_struct, assertion_options.force_user_verified)?;
    // 18. pass (extensions) 
    // 19.
    let hash = sha256(c_data);
    // 20.
    verify_signature(hash, auth_data, credential_public_key, sig)?;

    Result::Ok(())
}

// Steps 6. and 7. of the verify_authentication_assertion(..) method
// This should be exactly according to the specification
// There are basically two conditions for this method to succed:
// 1. There are at least two user identifiers
// 2. All available user identifiers should yeld the same public key 
fn find_and_verify_credential_source
<
// Store:
    StoreT, 
    impl WebauthnStoreTImpl: WebauthnStoreTrait<StoreT>, 
    impl SDrop: Drop<StoreT>
>
(
    store: @StoreT,
    preidentified_user_handle: @Option<Array<u8>>,
    credential: @PublicKeyCredential,
    response: @AuthenticatorAssertionResponse
) -> Result<PublicKey, AuthnError> {
    let pk = match @preidentified_user_handle {
        Option::Some(user) => {
            let pk_1 = RTSEIntoRTAE::<PublicKey>::into(
                store.retrieve_public_key(credential.raw_id)
            )?;
            let pk_2 = RTSEIntoRTAE::<PublicKey>::into(store.retrieve_public_key(*user))?;
            if pk_1 != pk_2 {
                return AuthnError::IdentifiedUsersMismatch.into();
            };
            match response.user_handle {
                Option::Some(handle) => {
                    let pk_3 = RTSEIntoRTAE::<PublicKey>::into(
                        store.retrieve_public_key(handle)
                    )?;
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
    Result::Ok(pk)
}

// Steps 16 and 17 of https://www.w3.org/TR/webauthn/#sctn-verifying-assertion
fn verify_user_flags(
    auth_data: @AuthenticatorData, force_user_verified: bool
) -> Result<(), AuthnError> {
    let flags: u128 = upcast(*auth_data.flags);
    let mask: u128 = if force_user_verified {
        upcast(1_u8 + 4_u8)
    } else {
        upcast(1_u8)
    };
    if (flags & mask) == mask {
        Result::Ok(())
    } else {
        AuthnError::UserFlagsMismatch.into()
    }
}

fn expand_auth_data_and_verify_rp_id_hash(
    auth_data: Array<u8>, expected_rp_id: Array<u8>
) -> Result<AuthenticatorData, AuthnError> {
    let auth_data_struct = match auth_data.try_into() {
        Option::Some(ad) => ad,
        Option::None => {
            return AuthnError::InvalidAuthData.into();
        }
    };
    if sha256(expected_rp_id) == auth_data_struct.rp_id_hash {
        Result::Ok(auth_data_struct)
    } else {
        AuthnError::RelyingPartyIdHashMismatch.into()
    }
}

// https://www.w3.org/TR/webauthn/#sctn-authenticator-data
impl ImplArrayu8TryIntoAuthData of TryInto<Array<u8>, AuthenticatorData> {
    // Construct the AuthenticatorData object from a ByteArray
    // Authenticator Data layout looks like: 
    // [ RP ID hash - 32 bytes ] [ Flags - 1 byte ] [ Counter - 4 byte ] [ ... ]
    fn try_into(self: Array<u8>) -> Option<AuthenticatorData>{
        if self.len() < 37 {
            return Option::None;
        };
        // There is some problem regarding the moving of self
        // For now this problem exceeds my mental capacity
        // TODO: Make it proper
        let cloned = self.clone();
        let mut rp_id_hash: Array<u8> = ArrayTrait::new();
        let counter = 0_usize;
        loop {
            if counter == 32 {
                break;
            };
            rp_id_hash.append(*cloned[counter]);
        };
        
        let flags = *self[32];
        let mut sc_u256: u256 = BitShift::shl((*self[33]).into(), 3 * 8);
        sc_u256 = sc_u256 |  BitShift::shl((*self[34]).into(), 2 * 8);
        sc_u256 = sc_u256 |  BitShift::shl((*self[35]).into(), 0 * 8);
        sc_u256 = sc_u256 |  BitShift::shl((*self[36]).into(), 1 * 8);
        let sign_count: u32 = sc_u256.try_into().unwrap();
        Option::Some(AuthenticatorData {rp_id_hash, flags, sign_count})
    }
}

// step 20. of https://www.w3.org/TR/webauthn/#sctn-verifying-assertion
fn verify_signature(
    hash: Array<u8>, auth_data: Array<u8>, credential_public_key: PublicKey, sig: Array<u8>
) -> Result<(), AuthnError> {
    // TODO:
    // 1. Concatenate hash and auth_data
    // 2. Extract r and s from sig
    // 3. Validate using verify_ecdsa
    Result::Ok(())
}

use array::ArrayTrait;
use integer::upcast;
use option::OptionTrait;
use result::ResultTrait;
use clone::Clone;
use traits::{Into, TryInto, Drop, PartialEq};
use starknet::secp256r1::Secp256r1Point;
use alexandria_math::{sha256::sha256, BitShift};

use alexandria_encoding::base64::Base64UrlEncoder;

use webauthn_auth::ecdsa::verify_ecdsa;
use webauthn_auth::errors::{AuthnError, StoreError, RTSEIntoRTAE};
use webauthn_auth::helpers::{
    allow_credentials_contain_credential, UTF8Decoder, JSONClientDataParser, OriginChecker,
    concatenate, extract_r_and_s_from_array
};

use webauthn_auth::types::{
    PublicKeyCredentialRequestOptions, PublicKeyCredential, PublicKey,
    PublicKeyCredentialDescriptor, AuthenticatorResponse, AuthenticatorAssertionResponse,
    AuthenticatorData, AssertionOptions
};


trait WebauthnStoreTrait<T> {
    // This method should probably only return the saved credentials for them to be verified here 
    // reather than doing the chcecking itself
    // Leaving for now. TODO: revise this.
    fn verify_allow_credentials(
        self: @T, allow_credentials: @Array<PublicKeyCredentialDescriptor>
    ) -> Result<(), ()>;
    fn retrieve_public_key(
        self: @T, credential_raw_id: @Array<u8>
    ) -> Result<PublicKey, StoreError>;
}

trait WebauthnAuthenticatorTrait<T> {
    fn navigator_credentials_get(
        self: @T, options: @PublicKeyCredentialRequestOptions
    ) -> Result<PublicKeyCredential, ()>;
}


fn verify(
    pub: Secp256r1Point, // public key as point on elliptic curve
    r: u256, // 'r' part from ecdsa
    s: u256, // 's' part from ecdsa
    type_offset: usize, // offset to 'type' field in json
    challenge_offset: usize, // offset to 'challenge' field in json
    origin_offset: usize, // offset to 'origin' field in json
    client_data_json: Array<u8>, // json with client_data as 1-byte array 
    challenge: Array<u8>, // challenge as 1-byte
    origin: Array<u8>, //  array origin as 1-byte array
    authenticator_data: Array<u8> // authenticator data as 1-byte array
) -> Result<(), AuthnError> {
    // 11. Verify that the value of C.type is the string webauthn.get
    // Skipping for now

    // 12. Verify that the value of C.challenge equals the base64url encoding of options.challenge.
    verify_challenge(@client_data_json, challenge_offset, challenge);

    // 13. Verify that the value of C.origin matches the Relying Party's origin.
    // Skipping for now.

    // 15. Verify that the rpIdHash in authData is the SHA-256 hash of the RP ID expected by the Relying Party.
    // Skipping for now. This protects against authenticator cloning which is generally not
    // a concern of blockchain wallets today.
    // Authenticator Data layout looks like: [ RP ID hash - 32 bytes ] [ Flags - 1 byte ] [ Counter - 4 byte ] [ ... ]
    // See: https://w3c.github.io/webauthn/#sctn-authenticator-data

    // 16. Verify that the User Present (0) and User Verified (2) bits of the flags in authData is set.
    let ad: AuthenticatorData = match authenticator_data.clone().try_into() {
        Option::Some(x) => x,
        Option::None => {
            return AuthnError::UserFlagsMismatch.into();
        }
    };
    verify_user_flags(@ad, true)?;

    // 17. Skipping extensions

    // 18. Compute hash of client_data
    let client_data_hash = sha256(client_data_json);

    // Compute message ready for verification.
    let result = concatenate(@authenticator_data, @client_data_hash);

    match verify_ecdsa(pub, result, r, s) {
        Result::Ok => Result::Ok(()),
        Result::Err(e) => AuthnError::InvalidSignature.into()
    }
}

fn verify_challenge(
    client_data_json: @Array<u8>, challenge_offset: usize, challenge: Array<u8>
) -> Result<(), AuthnError> {
    let challenge: Array<u8> = Base64UrlEncoder::encode(challenge);
    let mut i: usize = 0;
    let challenge_len: usize = challenge.len();
    loop {
        // Base64UrlEncoder at the moment pads with '=' => remove -1 later {assumes len == 43} or 
        // additionally break on '=' sign
        if i == challenge_len - 1 {
            break Result::Ok(());
        }
        if *client_data_json.at(challenge_offset + i) != *challenge.at(i) {
            break AuthnError::ChallengeMismatch.into();
        }
        i += 1_usize;
    }
}

// According to https://www.w3.org/TR/webauthn/#sctn-verifying-assertion
// Couldn't find a way to create a struct with all the necessary generic implementations
// There was either some name resolution problem or a recursive (cyclic) compiler bug
// Or I'm stupid
// There is a 'parallel' implementation solution that would split this method into separate chunks,
// and in the particular points (now dealt with by the generic traits) outsource the control flow 
// to the user, trough for example some state-transition abstraction.
// This is would ?probably? be better suited for Cairo use cases.
// Another considerations: 
//  Current approach - visually closer to the specification
//  Parallel approach - easier testing
// Either way the inner workings of the method stay the same.
// fn verify_authentication_assertion<
//     // Store:
//     StoreT,
//     impl WebauthnStoreTImpl: WebauthnStoreTrait<StoreT>,
//     impl SDrop: Drop<StoreT>,
//     // Authenticator:
//     AuthenticatorT,
//     impl WebauthnAuthenticatorTImpl: WebauthnAuthenticatorTrait<AuthenticatorT>,
//     impl ADrop: Drop<AuthenticatorT>,
//     // Utils
//     impl UTF8DecoderImpl: UTF8Decoder,
//     impl JSONClientDataParserImpl: JSONClientDataParser,
//     impl OriginCheckerImpl: OriginChecker
// >(
//     // Can answer queries about prior registrations eg. a database driver
//     store: StoreT,
//     // An authenticator abstraction 
//     authenticator: AuthenticatorT,
//     // Options configured by the relying party needs for the ceremony
//     options: PublicKeyCredentialRequestOptions,
//     // Some(...) if the user was identified before the ceremony, 
//     // eg. via a username or cookie, None otherwise
//     preidentified_user_handle: Option<Array<u8>>,
//     // Config options specific to the needs of this assertion
//     assertion_options: AssertionOptions
// ) -> Result<(), AuthnError> {
//     // 1. 
//     match @options.allow_credentials {
//         Option::Some(c) => {
//             match store.verify_allow_credentials(c) {
//                 Result::Ok => (),
//                 Result::Err => {
//                     return AuthnError::TransportNotAllowed.into();
//                 }
//             }
//         },
//         Option::None => (),
//     };
//     // 2.
//     let credential = match @authenticator.navigator_credentials_get(@options) {
//         Result::Ok(c) => c,
//         Result::Err => {
//             return AuthnError::GetCredentialRejected.into();
//         }
//     };
//     // 3. 
//     let response = match @credential.response {
//         AuthenticatorResponse::Attestation(_) => {
//             return AuthnError::ResponseIsNotAttestation.into();
//         },
//         AuthenticatorResponse::Assertion(r) => r.clone()
//     };
//     // 4. pass (extensions) 
//     // 5. 
//     match @options.allow_credentials {
//         Option::Some(c) => {
//             if !allow_credentials_contain_credential(c, credential) {
//                 return AuthnError::CredentialNotAllowed.into();
//             };
//         },
//         Option::None => (),
//     };
//     // 6. AND 7. 
//     let credential_public_key = find_and_verify_credential_source::<StoreT,
//     WebauthnStoreTImpl,
//     SDrop>(@store, @preidentified_user_handle, credential, response)?;
//     // 8.
//     let c_data = response.client_data_json.clone();
//     let auth_data = response.authenticator_data.clone();
//     let sig = response.signature.clone();
//     // 9. 
//     let json_text = UTF8DecoderImpl::decode(c_data.clone());
//     // 10.
//     let c = JSONClientDataParserImpl::parse(json_text);
//     // 11. pass (string verification) TODO:
//     // 12. 
//     if c.challenge != Base64UrlEncoder::encode(options.challenge) {
//         return AuthnError::ChallengeMismatch.into();
//     };
//     // 13. 
//     if !OriginCheckerImpl::check(c.origin) {
//         return AuthnError::OriginMismatch.into();
//     };
//     // 14. pass TODO:
//     // 15. 
//     let auth_data_struct = expand_auth_data_and_verify_rp_id_hash(
//         auth_data.clone(), assertion_options.expected_rp_id
//     )?;
//     // 16. AND 17.
//     verify_user_flags(@auth_data_struct, assertion_options.force_user_verified)?;
//     // 18. pass (extensions) 
//     // 19.
//     let hash = sha256(c_data);
//     // 20. 
//     verify_signature(hash, auth_data, credential_public_key, sig)
// }

// Steps 6. and 7. of the verify_authentication_assertion(..) method
// This should be exactly according to the specification
// There are basically two conditions for this method to succed:
// 1. There are at least two user identifiers
// 2. All available user identifiers should yeld the same public key 
fn find_and_verify_credential_source<
    // Store:
    StoreT, impl WebauthnStoreTImpl: WebauthnStoreTrait<StoreT>, impl SDrop: Drop<StoreT>
>(
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
                    let pk_3 = RTSEIntoRTAE::<PublicKey>::into(store.retrieve_public_key(handle))?;
                    if pk_1 != pk_3 {
                        return AuthnError::IdentifiedUsersMismatch.into();
                    };
                },
                Option::None => (),
            }
            pk_1
        },
        Option::None => {
            let pk_1 = RTSEIntoRTAE::<PublicKey>::into(
                store.retrieve_public_key(credential.raw_id)
            )?;
            let pk_2 = match response.user_handle {
                Option::Some(handle) => RTSEIntoRTAE::<PublicKey>::into(
                    store.retrieve_public_key(credential.raw_id)
                )?,
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

// Step 15
// Expands auth_data crunched into an array to an AuthenticatorData object
fn expand_auth_data_and_verify_rp_id_hash(
    auth_data: Array<u8>, expected_rp_id: Array<u8>
) -> Result<AuthenticatorData, AuthnError> {
    let auth_data_struct: AuthenticatorData = match auth_data.try_into() {
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

// Steps 16 and 17 of https://www.w3.org/TR/webauthn/#sctn-verifying-assertion
fn verify_user_flags(
    auth_data: @AuthenticatorData, force_user_verified: bool
) -> Result<(), AuthnError> {
    let flags: u128 = upcast(*auth_data.flags);
    let mask: u128 = upcast(
        if force_user_verified {
            1_u8 + 4_u8 // 10100000
        } else {
            1_u8 // 10000000
        }
    );
    if (flags & mask) == mask {
        Result::Ok(())
    } else {
        AuthnError::UserFlagsMismatch.into()
    }
}

// https://www.w3.org/TR/webauthn/#sctn-authenticator-data
impl ImplArrayu8TryIntoAuthData of TryInto<Array<u8>, AuthenticatorData> {
    // Construct the AuthenticatorData object from a ByteArray
    // Authenticator Data layout looks like: 
    // [ RP ID hash - 32 bytes ] [ Flags - 1 byte ] [ Counter - 4 byte ] [ ... ]
    fn try_into(self: Array<u8>) -> Option<AuthenticatorData> {
        if self.len() < 37 {
            return Option::None;
        };
        // There is some problem regarding the moving of self
        // For now this problem exceeds my mental capacity
        // TODO: Remove clone()
        let cloned = self.clone();
        let mut rp_id_hash: Array<u8> = ArrayTrait::new();
        let mut counter = 0_usize;
        loop {
            if counter == 32 {
                break;
            };
            rp_id_hash.append(*cloned[counter]);
            counter += 1;
        };

        let flags = *self[32];
        let mut sign_count = 0_u32;
        sign_count = sign_count | BitShift::shl((*self[33]).into(), 3 * 8);
        sign_count = sign_count | BitShift::shl((*self[34]).into(), 2 * 8);
        sign_count = sign_count | BitShift::shl((*self[35]).into(), 1 * 8);
        sign_count = sign_count | BitShift::shl((*self[36]).into(), 0 * 8);
        Option::Some(AuthenticatorData { rp_id_hash, flags, sign_count })
    }
}

// step 20. of https://www.w3.org/TR/webauthn/#sctn-verifying-assertion
fn verify_signature(
    hash: Array<u8>, auth_data: Array<u8>, credential_public_key: PublicKey, sig: Array<u8>
) -> Result<(), AuthnError> {
    let concatenation = concatenate(@auth_data, @hash);
    let (r, s) = match extract_r_and_s_from_array(@sig) {
        Option::Some(p) => p,
        Option::None => {
            return AuthnError::InvalidSignature.into();
        }
    };
    let pub_key_point: Secp256r1Point = match credential_public_key.try_into() {
        Option::Some(p) => p,
        Option::None => {
            return AuthnError::InvalidPublicKey.into();
        }
    };
    match verify_ecdsa(pub_key_point, concatenation, r, s) {
        Result::Ok => Result::Ok(()),
        Result::Err(e) => AuthnError::InvalidSignature.into()
    }
}

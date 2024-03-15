use webauthn_auth::types::PublicKey;
use webauthn_auth::ecdsa::VerifyEcdsaError;
use starknet::secp256r1::Secp256r1Point;
use webauthn_auth::errors::{AuthnError, RTSEIntoRTAE, AuthnErrorIntoFelt252};
use webauthn_auth::ecdsa::verify_hashed_ecdsa;
use core::traits::Into;
use webauthn_auth::webauthn::ImplArrayu8TryIntoAuthData;
use webauthn_auth::types::AuthenticatorData;
use webauthn_auth::helpers::extract_u256_from_u8_array;

fn verify_hashed_ecdsa_endpoint(
    public_key_pt: PublicKey, msg_hash: u256, r: u256, s: u256
) -> Result<(), VerifyEcdsaError> {
    let pub_key_point: Secp256r1Point = match public_key_pt.try_into() {
        Option::Some(p) => p,
        Option::None => { return Result::Err(VerifyEcdsaError::WrongArgument); }
    };
    verify_hashed_ecdsa(pub_key_point, msg_hash, r, s)
}

fn expand_auth_data_endpoint(
    auth_data: Array<u8>
) -> AuthenticatorData {
    let data: Option<AuthenticatorData> = ImplArrayu8TryIntoAuthData::try_into(auth_data);
    return data.unwrap();
}

fn extract_u256_from_u8_array_endpoint(bytes: Array<u8>, offset: u32) -> Option<u256> {
    extract_u256_from_u8_array(@bytes, offset)
}
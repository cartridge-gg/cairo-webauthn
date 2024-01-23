use webauthn_auth::types::PublicKey;
use webauthn_auth::ecdsa::VerifyEcdsaError;
use starknet::secp256r1::Secp256r1Point;
use webauthn_auth::errors::{AuthnError, RTSEIntoRTAE, AuthnErrorIntoFelt252};
use webauthn_auth::ecdsa::verify_hashed_ecdsa;
use core::traits::Into;

fn verify_hashed_ecdsa_endpoint(
    public_key_pt: PublicKey, msg_hash: u256, r: u256, s: u256
) -> Result<(), VerifyEcdsaError> {
    let pub_key_point: Secp256r1Point = match public_key_pt.try_into() {
        Option::Some(p) => p,
        Option::None => { return Result::Err(VerifyEcdsaError::WrongArgument); }
    };
    verify_hashed_ecdsa(pub_key_point, msg_hash, r, s)
}
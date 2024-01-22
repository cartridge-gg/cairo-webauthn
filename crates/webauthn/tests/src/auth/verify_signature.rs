use account_sdk::webauthn_signer::P256r1Signer;
use cairo_args_runner::Felt252;
use p256::{
    ecdsa::{signature::Signer, SigningKey},
    elliptic_curve::{consts::P256, rand_core::OsRng},
};

use crate::{Function, FunctionUnspecified};

const VERIFY_SIGNATURE: FunctionUnspecified = Function::new_unspecified("verify_signature");

pub struct CairoU256 {
    low: Felt252,
    high: Felt252,
}

impl CairoU256 {
    pub fn new(low: Felt252, high: Felt252) -> Self {
        Self { low, high }
    }
    pub fn from_bytes_be(low: &[u8; 16], high: &[u8; 16]) -> Self {
        Self::new(Felt252::from_bytes_be(low), Felt252::from_bytes_be(high))
    }
    pub fn from_byte_slice_be(bytes: &[u8]) -> Self {
        let (low, high): (&[u8; 16], &[u8; 16]) =
            (bytes[16..].try_into().unwrap(), bytes[..16].try_into().unwrap());
        Self::from_bytes_be(low, high)
    }
}

#[test]
fn test_verify_signature() {
    let message = b"hello world";
    let signing_key = SigningKey::random(&mut OsRng);
    let (signature, _): (_, _) = signing_key.sign(message);
    let (r, s) = (signature.r(), signature.s());
    let (r, s) = (r.to_bytes(), s.to_bytes());
    let (r, s) = (r.as_slice(), s.as_slice());
    let p = signing_key.verifying_key().to_sec1_bytes();
}

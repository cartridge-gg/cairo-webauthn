use account_sdk::webauthn_signer::P256VerifyingKeyConverter;
use cairo_args_runner::Felt252;
use p256::{
    ecdsa::{signature::Signer, Signature, SigningKey},
    elliptic_curve::rand_core::OsRng,
};

use crate::{Function, FunctionTrait as _, FunctionUnspecified};

use super::{ArgsBuilder, FeltSerialize};

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
    pub fn from_byte_slice_be(bytes: &[u8; 32]) -> Self {
        let (low, high): (&[u8; 16], &[u8; 16]) = (
            bytes[16..].try_into().unwrap(),
            bytes[..16].try_into().unwrap(),
        );
        Self::from_bytes_be(low, high)
    }
}

impl FeltSerialize for CairoU256 {
    fn to_felts(self) -> Vec<Felt252> {
        vec![self.low, self.high]
    }
}

struct P256r1PublicKey {
    x: CairoU256,
    y: CairoU256,
}

impl P256r1PublicKey {
    pub fn new(x: CairoU256, y: CairoU256) -> Self {
        Self { x, y }
    }
    pub fn from_bytes_be(x: &[u8; 32], y: &[u8; 32]) -> Self {
        Self::new(
            CairoU256::from_byte_slice_be(x),
            CairoU256::from_byte_slice_be(y),
        )
    }
}

impl FeltSerialize for P256r1PublicKey {
    fn to_felts(self) -> Vec<Felt252> {
        self.x
            .to_felts()
            .into_iter()
            .chain(self.y.to_felts())
            .collect()
    }
}

fn verify_signature(
    hash: &[u8],
    auth_data: &[u8],
    signing_key: SigningKey,
    signature: Signature,
) -> bool {
    let (r, s) = (signature.r(), signature.s());
    let (r, s) = (r.to_bytes(), s.to_bytes());
    let (r, s) = (r.as_slice(), s.as_slice());
    let (x, y) = P256VerifyingKeyConverter::new(*signing_key.verifying_key()).to_bytes();
    let pub_key = P256r1PublicKey::from_bytes_be(&x, &y);
    let args = ArgsBuilder::new()
        .add_array(hash.iter().cloned())
        .add_array(auth_data.iter().cloned())
        .add_struct(pub_key.to_felts())
        .add_array(r.into_iter().copied().chain(s.iter().copied()));
    let result = VERIFY_SIGNATURE.run(args.build());
    result == vec![0.into(), 0.into()]
}

#[test]
fn test_verify_signature_1() {
    let hash: &[u8] = b"hello world";
    let auth_data = b"dummy auth data";
    let signing_key = SigningKey::random(&mut OsRng);
    let (signature, _) = signing_key.sign(&vec![auth_data, hash].concat());
    assert!(verify_signature(hash, auth_data, signing_key, signature))
}

#[test]
fn test_verify_signature_2() {
    let hash: &[u8] = b"1234567890987654321";
    let auth_data = b"auuuuuuuuuuth daaaaataaaaaaaaaa";
    let signing_key = SigningKey::random(&mut OsRng);
    let (signature, _) = signing_key.sign(&vec![auth_data, hash].concat());
    assert!(verify_signature(hash, auth_data, signing_key, signature))
}

#[test]
fn test_verify_signature_should_fail_1() {
    let hash = b"hello world";
    let auth_data = b"dummy auth data";
    let wrong_hash: &[u8] = b"definetly not hello world";
    let signing_key = SigningKey::random(&mut OsRng);
    let (signature, _) = signing_key.sign(&vec![auth_data, wrong_hash].concat());
    assert_eq!(
        verify_signature(hash, auth_data, signing_key, signature),
        false
    )
}

#[test]
fn test_verify_signature_should_fail_2() {
    let hash: &[u8] = b"1234567890987654321";
    let auth_data = b"dummy auth data";
    let signing_key = SigningKey::random(&mut OsRng);
    let other_signing_key = SigningKey::random(&mut OsRng);
    let (signature, _) = signing_key.sign(&vec![auth_data, hash].concat());
    assert_eq!(
        verify_signature(hash, auth_data, other_signing_key, signature),
        false
    )
}

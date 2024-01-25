use account_sdk::webauthn_signer::P256VerifyingKeyConverter;
use cairo_args_runner::Felt252;
use p256::{
    ecdsa::{signature::Signer, Signature, SigningKey},
    elliptic_curve::rand_core::OsRng,
};

use sha2::{digest::Update, Digest, Sha256};

use super::*;
use crate::*;
const VERIFY_HASHED_ECDSA: Function<SimpleVecParser, ConstLenExtractor<2>> = Function::new(
    "verify_hashed_ecdsa_endpoint",
    SimpleVecParser::new(),
    ConstLenExtractor::new(),
);

fn verify_ecdsa(message: &[u8], signing_key: SigningKey, signature: Signature) -> bool {
    let (r, s) = (signature.r(), signature.s());
    let (r, s) = (r.to_bytes(), s.to_bytes());
    let (r, s) = (r.as_slice(), s.as_slice());
    let (r, s) = (
        CairoU256::from_byte_slice_be(r.try_into().unwrap()),
        CairoU256::from_byte_slice_be(s.try_into().unwrap()),
    );
    let (x, y) = P256VerifyingKeyConverter::new(*signing_key.verifying_key()).to_bytes();
    let pub_key = P256r1PublicKey::from_bytes_be(&x, &y);

    let hash = Sha256::new().chain(message).finalize();
    let hash: &[u8] = hash.as_slice();
    let hash = CairoU256::from_byte_slice_be(hash.try_into().unwrap());

    let args = ArgsBuilder::new()
        .add_struct(pub_key.to_felts())
        .add_struct(hash.to_felts())
        .add_struct(r.to_felts())
        .add_struct(s.to_felts());
    let result: [Felt252; 2] = VERIFY_HASHED_ECDSA.run(args.build());
    result == [0.into(), 0.into()]
}

#[test]
fn test_verify_ecdsa_1() {
    let message: &[u8] = b"hello world";
    let signing_key = SigningKey::random(&mut OsRng);
    let (signature, _) = signing_key.sign(message);
    assert!(verify_ecdsa(message, signing_key, signature));
}

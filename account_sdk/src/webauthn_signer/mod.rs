use p256::{
    ecdsa::{SigningKey, VerifyingKey},
    elliptic_curve::sec1::Coordinates,
};
use rand_core::OsRng;
use serde::Serialize;
use starknet::core::types::FieldElement;

use crate::felt_ser::to_felts;

pub type U256 = (FieldElement, FieldElement);
pub type Secp256r1Point = (U256, U256);
#[derive(Debug, Clone, Serialize)]
pub struct VerifyWebauthnSignerArgs {
    pub_x: U256,
    pub_y: U256,
}

pub struct P256r1Signer {
    pub signing_key: SigningKey,
}

impl P256r1Signer {
    pub fn random() -> Self {
        let signing_key = SigningKey::random(&mut OsRng);
        Self::new(signing_key)
    }
    pub fn new(signing_key: SigningKey) -> Self {
        Self { signing_key }
    }
    fn public_key_bytes(&self) -> ([u8; 32], [u8; 32]) {
        let verifying_key: VerifyingKey = VerifyingKey::from(&self.signing_key);
        let encoded = &verifying_key.to_encoded_point(false);
        let (x, y) = match encoded.coordinates() {
            Coordinates::Uncompressed { x, y } => (x, y),
            _ => panic!("unexpected compression"),
        };
        (
            x.as_slice().try_into().unwrap(),
            y.as_slice().try_into().unwrap(),
        )
    }
    pub fn sign(&self) -> Vec<FieldElement> {
        let (pub_x, pub_y) = self.public_key();
        let args = VerifyWebauthnSignerArgs { pub_x, pub_y };
        to_felts(&args)
    }
    fn public_key(&self) -> Secp256r1Point {
        let (x, y) = self.public_key_bytes();
        dbg!(x.len(), y.len());
        (felt_pair(&x), felt_pair(&y))
    }
}

fn felt_pair(bytes: &[u8; 32]) -> (FieldElement, FieldElement) {
    (
        FieldElement::from_bytes_be(&extend_to_32(&bytes[16..32])).unwrap(),
        FieldElement::from_bytes_be(&extend_to_32(&bytes[0..16])).unwrap(),
    )
}

fn extend_to_32(bytes: &[u8]) -> [u8; 32] {
    let mut ret = [0; 32];
    ret[32 - bytes.len()..].copy_from_slice(bytes);
    ret
}

#[test]
fn test_signer() {
    let signer = P256r1Signer::random();
    let calldata = signer.sign();
    dbg!(&calldata);
}
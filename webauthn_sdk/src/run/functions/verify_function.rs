use crate::{
    arg_val,
    run::{functions::utils::ToFelts, IntoArguments},
};
use cairo_felt::Felt252;
use cairo_lang_runner::Arg;
use ecdsa::{signature::Signer, SigningKey};
use p256::{ecdsa::Signature, NistP256};
use rand::rngs::OsRng;
use serde::Serialize;

use super::{
    utils::{decode_hex, extract_u128_pair},
    FunctionExecution, IntoFunctionExecution,
};

#[derive(Serialize, Debug)]
struct ClientData {
    #[serde(rename = "type")]
    type_: String,
    challenge: String,
    origin: String,
}

#[derive(Debug)]
struct CliendDataJson {
    json: Vec<u8>,
    type_offset: usize,
    challenge_offset: usize,
    origin_offset: usize,
}

impl ClientData {
    pub fn new(type_: &str, challenge: &str, origin: &str) -> Self {
        ClientData {
            type_: type_.into(),
            challenge: challenge.into(),
            origin: origin.into(),
        }
    }
    pub fn to_client_data_json(self) -> CliendDataJson {
        let json = serde_json::to_string(&self).unwrap();

        CliendDataJson {
            type_offset: ClientData::find_offset(&json, "\"type\":\""),
            challenge_offset: ClientData::find_offset(&json, "\"challenge\":\""),
            origin_offset: ClientData::find_offset(&json, "\"origin\":\""),
            json: json.into_bytes(),
        }
    }
    fn find_offset(json: &String, pattern: &str) -> usize {
        json.find(pattern).unwrap() + pattern.len()
    }
}

impl AuthenticatorData {
    pub fn new(rp_id: &str, flags: u8) -> Self {
        AuthenticatorData::with_sign_count(rp_id, flags, 0)
    }
    pub fn with_sign_count(rp_id: &str, flags: u8, sign_count: u32) -> Self {
        let bytes = decode_hex(&sha256::digest(rp_id)).unwrap();
        AuthenticatorData {
            rp_id_hash: bytes.try_into().unwrap(),
            flags,
            sign_count,
        }
    }
    pub fn to_bytes(self) -> Vec<u8> {
        let mut result = self.rp_id_hash.to_vec();
        result.push(self.flags);
        result.append(&mut self.sign_count.to_be_bytes().to_vec());
        result
    }
}

struct AuthenticatorData {
    rp_id_hash: [u8; 32],
    flags: u8,
    sign_count: u32,
}

pub struct VerifyArguments {
    pub_x_u128: (u128, u128),
    pub_y_u128: (u128, u128),
    r_u128: (u128, u128),
    s_u128: (u128, u128),
    client_data_json: CliendDataJson,
    challenge: String,
    origin: String,
    authenticator_data: Vec<u8>,
}

impl VerifyArguments {
    pub fn new(origin: &str, challenge: &str) -> Self {
        let mut rng = OsRng;
        let signing_key = ecdsa::SigningKey::<NistP256>::random(&mut rng);
        VerifyArguments::with_signing_key(signing_key, origin, challenge)
    }
    pub fn with_signing_key(
        signing_key: SigningKey<NistP256>,
        origin: &str,
        challenge: &str,
    ) -> Self {
        let client_data = ClientData::new("webauthn.get", challenge, origin);
        let client_data_json = client_data.to_client_data_json();
        let client_data_hash = decode_hex(&sha256::digest(&client_data_json.json)).unwrap();
        let authenticator_data = AuthenticatorData::new(origin, 0b00000101).to_bytes();

        let to_hash = [authenticator_data.clone(), client_data_hash.clone()].join(&[][..]);

        let signature: Signature = signing_key.sign(&to_hash);

        let pub_point = signing_key.verifying_key().to_encoded_point(false);
        let (pub_x, pub_y) = (pub_point.x().unwrap(), pub_point.y().unwrap());
        let pub_x_u128 = extract_u128_pair(pub_x[..].try_into().unwrap());
        let pub_y_u128 = extract_u128_pair(pub_y[..].try_into().unwrap());

        let (r, s): ([u8; 32], [u8; 32]) = (
            signature.r().to_bytes()[..].try_into().unwrap(),
            signature.s().to_bytes()[..].try_into().unwrap(),
        );

        let r_u128 = extract_u128_pair(r[..].try_into().unwrap());
        let s_u128 = extract_u128_pair(s[..].try_into().unwrap());

        VerifyArguments {
            pub_x_u128,
            pub_y_u128,
            r_u128,
            s_u128,
            client_data_json,
            challenge: challenge.into(),
            origin: origin.into(),
            authenticator_data,
        }
    }
}

impl IntoArguments for VerifyArguments {
    fn into_arguments(self) -> Vec<Arg> {
        let data = [
            self.client_data_json.json.clone(),
            self.challenge.as_bytes().to_vec(),
            self.origin.as_bytes().to_vec(),
            self.authenticator_data,
        ]
        .join(&[][..]);
        vec![
            arg_val!(self.pub_x_u128.0),
            arg_val!(self.pub_x_u128.1),
            arg_val!(self.pub_y_u128.0),
            arg_val!(self.pub_y_u128.1),
            arg_val!(self.r_u128.0),
            arg_val!(self.r_u128.1),
            arg_val!(self.s_u128.0),
            arg_val!(self.s_u128.1),
            arg_val!(self.client_data_json.type_offset),
            arg_val!(self.client_data_json.challenge_offset),
            arg_val!(self.client_data_json.origin_offset),
            arg_val!(self.client_data_json.json.len()),
            arg_val!(self.challenge.as_bytes().len()),
            arg_val!(self.origin.as_bytes().len()),
            Arg::Array(data.into_felts()),
        ]
    }
}

pub struct VerifyFunction;

impl IntoFunctionExecution<VerifyArguments> for VerifyFunction {
    fn into_execution(self, args: VerifyArguments) -> FunctionExecution<VerifyArguments> {
        FunctionExecution::new("::verify_interface", args)
    }
}

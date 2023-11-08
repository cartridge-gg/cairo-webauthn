use std::env;

use cairo_client::{
    arg_val,
    compile::DevCompiler,
    generate::{DevGenerator, DummyGenerator},
    logger::{LoggerCompiler, LoggerGenerator, LoggerParser},
    parse::DevParser,
    run::DevRunner,
};
use cairo_felt::Felt252;
use cairo_lang_runner::Arg;
use ecdsa::signature::Signer;
use p256::{ecdsa::Signature, NistP256};
use rand::rngs::OsRng;
use serde::Serialize;

use anyhow::Result;

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

struct AuthenticatorData {
    rp_id_hash: [u8; 32],
    flags: u8,
    sign_count: u32,
}

fn decode_hex(str: &str) -> Option<Vec<u8>> {
    if str.len() % 2 == 1 {
        return None;
    }
    (0..str.len())
        .step_by(2)
        .map(|i| u8::from_str_radix(&str[i..i + 2], 16).ok())
        .collect()
}

fn extract_u128_pair(arr: [u8; 32]) -> (u128, u128) {
    (
        u128::from_be_bytes(arr[0..16].try_into().unwrap()),
        u128::from_be_bytes(arr[16..32].try_into().unwrap()),
    )
}

trait ToFelts {
    fn into_felts(&self) -> Vec<Felt252>;
}

impl<'a, T: 'a> ToFelts for Vec<T>
where
    Felt252: From<T>,
    T: Copy,
{
    fn into_felts(&self) -> Vec<Felt252> {
        self.into_iter().map(|i| Felt252::from(*i)).collect()
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

fn main() -> Result<()> {
    let mut rng = OsRng;
    let signing_key = ecdsa::SigningKey::<NistP256>::random(&mut rng);

    // Get the public key associated with the private key
    let verifying_key = signing_key.verifying_key();

    let args: Vec<String> = env::args().collect();

    let (origin, challenge) = match &args[..] {
        [_, o, c] => (o, c),
        _ => {
            return Result::Err(anyhow::Error::msg("Usage: cargo run [origin] [challenge]"));
        }
    };

    let client_data = ClientData::new("webauthn.get", challenge, origin);
    let client_data_json = client_data.to_client_data_json();
    let client_data_hash = decode_hex(&sha256::digest(&client_data_json.json)).unwrap();
    let authenticator_data = AuthenticatorData::new(origin, 0b00000101).to_bytes();

    let to_hash = [authenticator_data.clone(), client_data_hash.clone()].join(&[][..]);

    let signature: Signature = signing_key.sign(&to_hash);

    let pub_point = verifying_key.to_encoded_point(false);
    let (pub_x, pub_y) = (pub_point.x().unwrap(), pub_point.y().unwrap());
    let pub_x_u128 = extract_u128_pair(pub_x[..].try_into().unwrap());
    let pub_y_u128 = extract_u128_pair(pub_y[..].try_into().unwrap());

    let (r, s): ([u8; 32], [u8; 32]) = (
        signature.r().to_bytes()[..].try_into().unwrap(),
        signature.s().to_bytes()[..].try_into().unwrap(),
    );

    let r_u128 = extract_u128_pair(r[..].try_into().unwrap());
    let s_u128 = extract_u128_pair(s[..].try_into().unwrap());

    let data = [
        client_data_json.json.clone(),
        challenge.as_bytes().to_vec(),
        origin.as_bytes().to_vec(),
        authenticator_data,
    ]
    .join(&[][..]);

    println!(
        "Generated assertion challenge for: \n\t origin: {origin} \n\t challenge: {challenge}"
    );

    let generator = LoggerGenerator::new(DummyGenerator::new("cairo", "dev_sdk"));
    let compiler = LoggerCompiler::new(generator.generate()?);
    let parser = LoggerParser::new(compiler.compile()?);
    let runner = parser.parse()?;

    let result = runner.run(
        "::verify_interface",
        &vec![
            arg_val!(pub_x_u128.0),
            arg_val!(pub_x_u128.1),
            arg_val!(pub_y_u128.0),
            arg_val!(pub_y_u128.1),
            arg_val!(r_u128.0),
            arg_val!(r_u128.1),
            arg_val!(s_u128.0),
            arg_val!(s_u128.1),
            arg_val!(client_data_json.type_offset),
            arg_val!(client_data_json.challenge_offset),
            arg_val!(client_data_json.origin_offset),
            arg_val!(client_data_json.json.len()),
            arg_val!(challenge.as_bytes().len()),
            arg_val!(origin.as_bytes().len()),
            Arg::Array(data.into_felts()),
        ],
    );
    if let Result::Ok(v) = result {
        if v[0] == Felt252::from(0) {
            println!("Success!")
        } else {
            println!("Fail!")
        }
    } else {
        println!("Fail!")
    }

    Ok(())
}

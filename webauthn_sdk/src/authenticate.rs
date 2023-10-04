use ecdsa::signature::Signer;
use p256::{ecdsa::Signature, NistP256};
use rand::rngs::OsRng;
use serde::Serialize;

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

struct AuthenticatorData{
    rp_id_hash: [u8; 32],
    flags: u8,
    sign_count: u32
}

impl AuthenticatorData{
    pub fn new(rp_id: &str, flags: u8) -> Self {
        AuthenticatorData::with_sign_count(rp_id, flags, 0)
    }
    pub fn with_sign_count(rp_id: &str, flags: u8, sign_count: u32) -> Self {
        AuthenticatorData { rp_id_hash: sha256::digest(rp_id).into_bytes().try_into().unwrap(), flags, sign_count }
    }
    pub fn to_bytes(self) -> Vec<u8> {
        let mut result = self.rp_id_hash.to_vec();
        result.push(self.flags);
        result.append(&mut self.sign_count.to_be_bytes().to_vec());
        result
    }
} 

fn main() {
    let mut rng = OsRng;
    let signing_key = ecdsa::SigningKey::<NistP256>::random(&mut rng);

    // Get the public key associated with the private key
    let verifying_key = signing_key.verifying_key();

    

    // Print the private and public keys (in hexadecimal format)
    println!("Private key: {:?}", signing_key.to_bytes());
    println!(
        "Public key: {:?}",
        verifying_key.to_encoded_point(true).as_bytes()
    );
    println!("Signature: {}", signature);

    let origin = "example_origin.org";
    let challenge = "RadnomChallenge";
    let client_data = ClientData::new("webauthn.get", challenge, origin);
    let client_data_json = client_data.to_client_data_json();
    let client_data_hash = sha256::digest(client_data_json).into_bytes();
    let authenticator_data = AuthenticatorData::new(origin, 0b00000101);

    let signature: Signature = signing_key.sign("trampampaka".as_bytes());

}

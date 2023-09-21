use core::clone::Clone;
use core::option::OptionTrait;
use debug::PrintTrait;
use webauthn_session::is_valid_signature;
use webauthn_auth::webauthn::{WebauthnStoreTrait, WebauthnAuthenticatorTrait, verify};
use starknet::Felt252TryIntoContractAddress;
use array::ArrayTrait;
use starknet::secp256r1::Secp256r1Point;
use starknet::secp256r1::Secp256r1Impl;
use starknet::SyscallResultTrait;

use webauthn_auth::types::{
    PublicKeyCredentialDescriptor, PublicKey, PublicKeyCredential,
    PublicKeyCredentialRequestOptions, AssertionOptions, CollectedClientData, DomString
};
use webauthn_auth::errors::{AuthnError, StoreError, RTSEIntoRTAE};
use webauthn_auth::helpers::{UTF8Decoder, MyString, JSONClientDataParser, OriginChecker};

#[derive(Drop)]
struct MyStruct {
    size: u8,
// members: Array<felt252>,
}

fn testing(a: MyStruct, b: Array<felt252>, c: Array<felt252>, d: Array<felt252>, e: u8) -> u256 {
    a.size.print();
    // a.members.print();
    '---'.print();
    b.len().print();
    b.print();
    c.print();
    d.print();
    e.print();
    0_u256
}

// fn main(number: felt252) {
//     'Hello, World!'.print();
//     number.print();
// }

fn verify_interface(
    pub: Array<u128>,
    r_s: Array<u128>,
    type_offset: usize, // offset to 'type' field in json
    challenge_offset: usize, // offset to 'challenge' field in json
    origin_offset: usize, // offset to 'origin' field in json
    client_data_json: Array<u8>, // json with client_data as 1-byte array 
    challenge: Array<u8>, // challenge as 1-byte
    origin: Array<u8>, //  array origin as 1-byte array
    authenticator_data: Array<u8>
) -> Result<(), AuthnError> {
    let pub = Secp256r1Impl::secp256_ec_new_syscall(
        u256 { low: *pub[1], high: *pub[0] }, u256 { low: *pub[3], high: *pub[2] },
    )
        .unwrap_syscall()
        .unwrap();
    let r = u256 { low: *r_s[1], high: *r_s[0] };
    let s = u256 { low: *r_s[3], high: *r_s[2] };
    verify(
        pub,
        r,
        s,
        type_offset,
        challenge_offset,
        origin_offset,
        client_data_json,
        challenge,
        origin,
        authenticator_data
    )
}

#[derive(Drop, Clone)]
struct WebauthnStore {
    public_key: PublicKey
}

impl WebauthnStoreimpl of WebauthnStoreTrait<WebauthnStore> {
    fn verify_allow_credentials(
        self: @WebauthnStore, allow_credentials: @Array<PublicKeyCredentialDescriptor>
    ) -> Result<(), ()> {
        Result::Ok(())
    }
    fn retrieve_public_key(
        self: @WebauthnStore, credential_raw_id: @Array<u8>
    ) -> Result<PublicKey, StoreError> {
        Result::Ok(self.public_key.clone())
    }
}

#[derive(Drop)]
struct WebauthnAuthenticator {
    credential: Option<PublicKeyCredential>
}

impl WebauthnAuthenticatorImpl of WebauthnAuthenticatorTrait<WebauthnAuthenticator> {
    fn navigator_credentials_get(
        self: @WebauthnAuthenticator, options: @PublicKeyCredentialRequestOptions
    ) -> Result<PublicKeyCredential, ()> {
        match self.credential {
            Option::Some(c) => Result::Ok(c.clone()),
            Option::None => Result::Err(())
        }
    }
}

impl UTF8DecoderImpl of UTF8Decoder {
    fn decode(data: Array<u8>) -> MyString {
        MyString { data: data }
    }
}

impl JSONClientDataParserImpl of JSONClientDataParser {
    fn parse(string: MyString) -> CollectedClientData {
        CollectedClientData {
            type_: ArrayTrait::new(),
            challenge: ArrayTrait::new(),
            origin: ArrayTrait::new(),
            cross_origin: false,
            token_binding: Option::None(())
        }
    }
}

impl OriginCheckerImpl of OriginChecker {
    fn check(string: DomString) -> bool {
        true
    }
}

fn main() {
    let store = WebauthnStore { public_key: PublicKey { x: 0_u256, y: 0_u256 } };
    let authenticator = WebauthnAuthenticator { credential: Option::None(()) };
    let options = PublicKeyCredentialRequestOptions {
        challenge: ArrayTrait::new(), allow_credentials: Option::None
    };
    let assertion_options = AssertionOptions {
        expected_rp_id: ArrayTrait::new(), force_user_verified: false
    };
// verify_authentication_assertion(store, authenticator, options, Option::None(()), assertion_options);
}

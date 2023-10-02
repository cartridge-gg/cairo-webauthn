use core::traits::Into;
use core::array::SpanTrait;
use core::result::ResultTrait;
use core::starknet::secp256_trait::Secp256PointTrait;
use core::traits::TryInto;
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
use alexandria_encoding::base64::Base64UrlEncoder;
// use webauthn_auth::errors::{AuthnError, StoreError, RTSEIntoRTAE};

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

fn main() {
    let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    104967586276524112165136420848571543889145022871617809227185613247970118558132,
	    28809706358176254426074279673041700809583625420180899505741393676573453514447
	);
    match pub_key {
        Result::Ok(_) => (),
        Result::Err(e) => e.print()
    };
}

fn verify_interface_2( 
) {
    let pub_p = Secp256r1Impl::secp256_ec_new_syscall(0_u256, 0_u256);
    match pub_p {
        Result::Ok(_) => (),
        Result::Err(e) => e.print()
    };
}

fn test_order(
    a: Array<felt252>,
    b: Array<felt252>,
    c: Array<felt252>,
) {
    (*a[0]).print();
    a.len().print();
    (*b[0]).print();
    b.len().print();
    (*c[0]).print();
    c.len().print();
}

trait ArraySlice{
    fn arr_slice(self: @Array<u8>, start: usize, len: usize) -> Array<u8>;
}

impl ArraySliceImpl of ArraySlice {
    fn arr_slice(self: @Array<u8>, start: usize, len: usize) -> Array<u8>{
        self.span().slice(start, len).snapshot.clone()
    }
}

fn verify_interface(
    pub_0: u128,
    pub_1: u128,
    pub_2: u128,
    pub_3: u128,
    r_0: u128,
    r_1: u128,
    s_0: u128,
    s_1: u128,
    type_offset: usize, // offset to 'type' field in json
    challenge_offset: usize, // offset to 'challenge' field in json
    origin_offset: usize, // offset to 'origin' field in json
    client_data_json_len: usize,
    challenge_len: usize, 
    origin_len: usize, 
    data: Array<u8>, // json + chalenge + origin + auth_data
) -> usize {
    let pub_x = u256 {
        low: pub_1, high: pub_0
    };
    
    let pub_y = u256 {
        low: pub_3, high: pub_2
    };
    let pub_p = Secp256r1Impl::secp256_ec_new_syscall(pub_x, pub_y).unwrap_syscall().unwrap();
    
    let r = u256 { low: r_1, high: r_0 };
    let s = u256 { low: s_1, high: s_0 };

    let client_data_json = data.arr_slice(0, client_data_json_len);
    let challenge = data.arr_slice(client_data_json_len, challenge_len);
    let origin = data.arr_slice(client_data_json_len + challenge_len, origin_len);
    let auth_index = client_data_json_len + challenge_len + origin_len;
    let authenticator_data = data.arr_slice(auth_index, data.len() - auth_index);
    match verify(
        pub_p,
        r,
        s,
        type_offset,
        challenge_offset,
        origin_offset,
        client_data_json,
        challenge,
        origin,
        authenticator_data
    ) {
        Result::Ok => 0,
        Result::Err(_) => 1
    }
}
// #[derive(Drop, Clone)]
// struct WebauthnStore {
//     public_key: PublicKey
// }

// impl WebauthnStoreimpl of WebauthnStoreTrait<WebauthnStore> {
//     fn verify_allow_credentials(
//         self: @WebauthnStore, allow_credentials: @Array<PublicKeyCredentialDescriptor>
//     ) -> Result<(), ()> {
//         Result::Ok(())
//     }
//     fn retrieve_public_key(
//         self: @WebauthnStore, credential_raw_id: @Array<u8>
//     ) -> Result<PublicKey, StoreError> {
//         Result::Ok(self.public_key.clone())
//     }
// }

// #[derive(Drop)]
// struct WebauthnAuthenticator {
//     credential: Option<PublicKeyCredential>
// }

// impl WebauthnAuthenticatorImpl of WebauthnAuthenticatorTrait<WebauthnAuthenticator> {
//     fn navigator_credentials_get(
//         self: @WebauthnAuthenticator, options: @PublicKeyCredentialRequestOptions
//     ) -> Result<PublicKeyCredential, ()> {
//         match self.credential {
//             Option::Some(c) => Result::Ok(c.clone()),
//             Option::None => Result::Err(())
//         }
//     }
// }

// impl UTF8DecoderImpl of UTF8Decoder {
//     fn decode(data: Array<u8>) -> MyString {
//         MyString { data: data }
//     }
// }

// impl JSONClientDataParserImpl of JSONClientDataParser {
//     fn parse(string: MyString) -> CollectedClientData {
//         CollectedClientData {
//             type_: ArrayTrait::new(),
//             challenge: ArrayTrait::new(),
//             origin: ArrayTrait::new(),
//             cross_origin: false,
//             token_binding: Option::None(())
//         }
//     }
// }

// impl OriginCheckerImpl of OriginChecker {
//     fn check(string: DomString) -> bool {
//         true
//     }
// }
// fn main() {
//     let store = WebauthnStore { public_key: PublicKey { x: 0_u256, y: 0_u256 } };
//     let authenticator = WebauthnAuthenticator { credential: Option::None(()) };
//     let options = PublicKeyCredentialRequestOptions {
//         challenge: ArrayTrait::new(), allow_credentials: Option::None
//     };
//     let assertion_options = AssertionOptions {
//         expected_rp_id: ArrayTrait::new(), force_user_verified: false
//     };
// // verify_authentication_assertion(store, authenticator, options, Option::None(()), assertion_options);
// }



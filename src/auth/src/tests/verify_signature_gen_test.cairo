// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/verify_signature_test.py for details
use core::traits::Into;
use result::ResultTrait;
use core::option::OptionTrait;
use webauthn_auth::ecdsa::{verify_ecdsa, verify_hashed_ecdsa, VerifyEcdsaError};
use webauthn_auth::types::PublicKey;
use webauthn_auth::webauthn::verify_signature;
use webauthn_auth::errors::AuthnErrorIntoFelt252;
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1Point;
use starknet::SyscallResultTrait;
use array::ArrayTrait;

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_0() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x7);
	hash.append(0xd7);
	hash.append(0x76);
	hash.append(0xcc);
	hash.append(0x7e);
	hash.append(0x5d);
	hash.append(0xb1);
	hash.append(0xee);
	hash.append(0x2);
	hash.append(0x13);
	hash.append(0x36);
	hash.append(0x3);
	hash.append(0x6a);
	hash.append(0xb6);
	hash.append(0x46);
	hash.append(0xca);
	hash.append(0x34);
	hash.append(0x2b);
	hash.append(0xa6);
	hash.append(0x9a);
	hash.append(0x14);
	hash.append(0xf3);
	hash.append(0xad);
	hash.append(0xd3);
	hash.append(0x72);
	hash.append(0x50);
	hash.append(0x25);
	hash.append(0x34);
	hash.append(0x21);
	hash.append(0x82);
	hash.append(0xea);
	hash.append(0x80);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xbb);
	auth_data.append(0x5e);
	auth_data.append(0xeb);
	auth_data.append(0xea);
	auth_data.append(0x98);
	auth_data.append(0xba);
	auth_data.append(0x6d);
	auth_data.append(0xf2);
	auth_data.append(0xeb);
	auth_data.append(0xd4);
	auth_data.append(0xf4);
	auth_data.append(0x72);
	auth_data.append(0x3c);
	auth_data.append(0x20);
	auth_data.append(0x97);
	auth_data.append(0x0);
	auth_data.append(0x7f);
	auth_data.append(0x7c);
	auth_data.append(0x24);
	auth_data.append(0x57);
	auth_data.append(0xbf);
	auth_data.append(0x1b);
	auth_data.append(0x1);
	auth_data.append(0x14);
	auth_data.append(0x8a);
	auth_data.append(0x49);
	auth_data.append(0x3b);
	auth_data.append(0x55);
	auth_data.append(0xff);
	auth_data.append(0x9d);
	auth_data.append(0xcb);
	auth_data.append(0x38);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x78);
	sig.append(0xf3);
	sig.append(0x31);
	sig.append(0x58);
	sig.append(0xab);
	sig.append(0x1b);
	sig.append(0x14);
	sig.append(0xfc);
	sig.append(0x1f);
	sig.append(0x97);
	sig.append(0x10);
	sig.append(0xc7);
	sig.append(0xad);
	sig.append(0xbf);
	sig.append(0x94);
	sig.append(0xa0);
	sig.append(0x3);
	sig.append(0x52);
	sig.append(0x9e);
	sig.append(0x57);
	sig.append(0xe2);
	sig.append(0x7e);
	sig.append(0x26);
	sig.append(0x74);
	sig.append(0xe8);
	sig.append(0x54);
	sig.append(0xb7);
	sig.append(0xad);
	sig.append(0x6f);
	sig.append(0x1e);
	sig.append(0x25);
	sig.append(0x5f);
	sig.append(0x42);
	sig.append(0xbc);
	sig.append(0xda);
	sig.append(0xd0);
	sig.append(0x37);
	sig.append(0x47);
	sig.append(0x10);
	sig.append(0x5a);
	sig.append(0x73);
	sig.append(0xbf);
	sig.append(0xe6);
	sig.append(0xa8);
	sig.append(0x81);
	sig.append(0xd);
	sig.append(0xcc);
	sig.append(0x78);
	sig.append(0xf9);
	sig.append(0x68);
	sig.append(0x56);
	sig.append(0xc6);
	sig.append(0x3e);
	sig.append(0x81);
	sig.append(0x6a);
	sig.append(0xd7);
	sig.append(0x78);
	sig.append(0x9e);
	sig.append(0xde);
	sig.append(0x69);
	sig.append(0xc7);
	sig.append(0x65);
	sig.append(0x44);
	sig.append(0x6b);
	let pk = PublicKey {
		 x: 79206113756107905566309966496261130503887550328593376168341764508796112751750, 
		 y: 75160675599390139063618837652855966954030502862501850704972376770327354192277
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_1() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x8f);
	hash.append(0xc8);
	hash.append(0x56);
	hash.append(0x79);
	hash.append(0xc);
	hash.append(0x8);
	hash.append(0xba);
	hash.append(0xf8);
	hash.append(0x12);
	hash.append(0xb5);
	hash.append(0x12);
	hash.append(0x7a);
	hash.append(0x21);
	hash.append(0x90);
	hash.append(0x1f);
	hash.append(0xcd);
	hash.append(0xe9);
	hash.append(0x63);
	hash.append(0x84);
	hash.append(0xd9);
	hash.append(0xde);
	hash.append(0x71);
	hash.append(0xb5);
	hash.append(0x7f);
	hash.append(0x1d);
	hash.append(0xf1);
	hash.append(0x2d);
	hash.append(0xf6);
	hash.append(0x24);
	hash.append(0x47);
	hash.append(0x7d);
	hash.append(0x12);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x19);
	auth_data.append(0xc0);
	auth_data.append(0xa2);
	auth_data.append(0x7a);
	auth_data.append(0xff);
	auth_data.append(0xdd);
	auth_data.append(0xd1);
	auth_data.append(0xe1);
	auth_data.append(0x63);
	auth_data.append(0x21);
	auth_data.append(0xab);
	auth_data.append(0x23);
	auth_data.append(0x53);
	auth_data.append(0xbe);
	auth_data.append(0xf2);
	auth_data.append(0x27);
	auth_data.append(0x8c);
	auth_data.append(0xda);
	auth_data.append(0xfa);
	auth_data.append(0x1d);
	auth_data.append(0x44);
	auth_data.append(0xe4);
	auth_data.append(0x9a);
	auth_data.append(0x88);
	auth_data.append(0x45);
	auth_data.append(0x89);
	auth_data.append(0x7b);
	auth_data.append(0xe8);
	auth_data.append(0x28);
	auth_data.append(0x4b);
	auth_data.append(0x19);
	auth_data.append(0xc0);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xdf);
	sig.append(0x21);
	sig.append(0x86);
	sig.append(0x34);
	sig.append(0x84);
	sig.append(0x7d);
	sig.append(0xa2);
	sig.append(0x90);
	sig.append(0x54);
	sig.append(0x59);
	sig.append(0x92);
	sig.append(0xd);
	sig.append(0xd4);
	sig.append(0x6f);
	sig.append(0xe7);
	sig.append(0x6a);
	sig.append(0x20);
	sig.append(0xa3);
	sig.append(0x3b);
	sig.append(0xc0);
	sig.append(0xae);
	sig.append(0xd0);
	sig.append(0x44);
	sig.append(0x86);
	sig.append(0x7e);
	sig.append(0xba);
	sig.append(0x86);
	sig.append(0xc6);
	sig.append(0x50);
	sig.append(0xc4);
	sig.append(0xe9);
	sig.append(0xfb);
	sig.append(0x44);
	sig.append(0x58);
	sig.append(0xa7);
	sig.append(0x8c);
	sig.append(0xfc);
	sig.append(0x1a);
	sig.append(0x9c);
	sig.append(0xfb);
	sig.append(0x85);
	sig.append(0x33);
	sig.append(0x11);
	sig.append(0x2e);
	sig.append(0xce);
	sig.append(0xbc);
	sig.append(0x61);
	sig.append(0x36);
	sig.append(0x79);
	sig.append(0x0);
	sig.append(0x5);
	sig.append(0xa4);
	sig.append(0xc0);
	sig.append(0x31);
	sig.append(0xb5);
	sig.append(0xf3);
	sig.append(0x49);
	sig.append(0x8c);
	sig.append(0x7);
	sig.append(0xaa);
	sig.append(0xd8);
	sig.append(0x69);
	sig.append(0xdf);
	sig.append(0xb7);
	let pk = PublicKey {
		 x: 107887586133109709057000171128912927788557134451467688169539040764505535598480, 
		 y: 69901025457738893013986366184453403051549151451870151274316805050521293336638
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_2() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0xc6);
	hash.append(0x6d);
	hash.append(0x2d);
	hash.append(0x84);
	hash.append(0x57);
	hash.append(0x35);
	hash.append(0xb8);
	hash.append(0xb8);
	hash.append(0x8c);
	hash.append(0xc5);
	hash.append(0x4a);
	hash.append(0xba);
	hash.append(0xce);
	hash.append(0xcc);
	hash.append(0x4d);
	hash.append(0x67);
	hash.append(0xcd);
	hash.append(0x9a);
	hash.append(0xbe);
	hash.append(0xa5);
	hash.append(0xbb);
	hash.append(0x19);
	hash.append(0xa3);
	hash.append(0x45);
	hash.append(0x30);
	hash.append(0x23);
	hash.append(0x24);
	hash.append(0x9e);
	hash.append(0xc7);
	hash.append(0xcb);
	hash.append(0x37);
	hash.append(0x9d);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x77);
	auth_data.append(0xf9);
	auth_data.append(0x38);
	auth_data.append(0xdb);
	auth_data.append(0x6);
	auth_data.append(0x61);
	auth_data.append(0xc5);
	auth_data.append(0x74);
	auth_data.append(0x3c);
	auth_data.append(0xd3);
	auth_data.append(0xf6);
	auth_data.append(0x88);
	auth_data.append(0x8c);
	auth_data.append(0xd8);
	auth_data.append(0x74);
	auth_data.append(0x42);
	auth_data.append(0xca);
	auth_data.append(0x43);
	auth_data.append(0xbf);
	auth_data.append(0x8b);
	auth_data.append(0x10);
	auth_data.append(0x24);
	auth_data.append(0x2);
	auth_data.append(0x6d);
	auth_data.append(0x8);
	auth_data.append(0x8a);
	auth_data.append(0x88);
	auth_data.append(0xca);
	auth_data.append(0x30);
	auth_data.append(0xbd);
	auth_data.append(0x5);
	auth_data.append(0x35);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xc0);
	sig.append(0x41);
	sig.append(0x3a);
	sig.append(0x34);
	sig.append(0x32);
	sig.append(0x69);
	sig.append(0x69);
	sig.append(0xb1);
	sig.append(0xbd);
	sig.append(0x8e);
	sig.append(0x2c);
	sig.append(0xb6);
	sig.append(0x6c);
	sig.append(0xb0);
	sig.append(0x3d);
	sig.append(0xbf);
	sig.append(0x9);
	sig.append(0x68);
	sig.append(0xa);
	sig.append(0x56);
	sig.append(0xdd);
	sig.append(0x12);
	sig.append(0x57);
	sig.append(0xd4);
	sig.append(0xc9);
	sig.append(0x89);
	sig.append(0x6b);
	sig.append(0x75);
	sig.append(0x2f);
	sig.append(0x7f);
	sig.append(0x9a);
	sig.append(0x8a);
	sig.append(0xe);
	sig.append(0xf4);
	sig.append(0xc0);
	sig.append(0x62);
	sig.append(0xe);
	sig.append(0x9d);
	sig.append(0x83);
	sig.append(0xdd);
	sig.append(0xf7);
	sig.append(0xc8);
	sig.append(0xbe);
	sig.append(0xfd);
	sig.append(0x7a);
	sig.append(0xcc);
	sig.append(0xe3);
	sig.append(0x42);
	sig.append(0x50);
	sig.append(0xa1);
	sig.append(0x40);
	sig.append(0xf8);
	sig.append(0x25);
	sig.append(0x9d);
	sig.append(0x88);
	sig.append(0x73);
	sig.append(0xb6);
	sig.append(0x52);
	sig.append(0xb6);
	sig.append(0xb8);
	sig.append(0xdc);
	sig.append(0x2);
	sig.append(0x16);
	sig.append(0x42);
	let pk = PublicKey {
		 x: 30084165178166600638407235077954870139695123690075017262096123891803164920818, 
		 y: 112731528670689870899781362441961947403289660021273632606835409861846354379797
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_3() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x33);
	hash.append(0x76);
	hash.append(0x70);
	hash.append(0x1d);
	hash.append(0x97);
	hash.append(0x29);
	hash.append(0x77);
	hash.append(0x6a);
	hash.append(0x82);
	hash.append(0xf3);
	hash.append(0x99);
	hash.append(0x2f);
	hash.append(0x50);
	hash.append(0xf4);
	hash.append(0xa0);
	hash.append(0xce);
	hash.append(0x60);
	hash.append(0x76);
	hash.append(0x6a);
	hash.append(0x81);
	hash.append(0x36);
	hash.append(0x25);
	hash.append(0x9a);
	hash.append(0xf9);
	hash.append(0xb7);
	hash.append(0x34);
	hash.append(0x6);
	hash.append(0x37);
	hash.append(0xc3);
	hash.append(0xc7);
	hash.append(0x49);
	hash.append(0xb7);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x2a);
	auth_data.append(0x5c);
	auth_data.append(0x6d);
	auth_data.append(0x53);
	auth_data.append(0xcf);
	auth_data.append(0x62);
	auth_data.append(0x49);
	auth_data.append(0xd3);
	auth_data.append(0xb6);
	auth_data.append(0xf4);
	auth_data.append(0xb1);
	auth_data.append(0x3c);
	auth_data.append(0x75);
	auth_data.append(0x38);
	auth_data.append(0xfe);
	auth_data.append(0x67);
	auth_data.append(0xd8);
	auth_data.append(0x2d);
	auth_data.append(0x94);
	auth_data.append(0x39);
	auth_data.append(0x78);
	auth_data.append(0x41);
	auth_data.append(0x49);
	auth_data.append(0xdb);
	auth_data.append(0x4c);
	auth_data.append(0xa2);
	auth_data.append(0xe6);
	auth_data.append(0x9b);
	auth_data.append(0xb2);
	auth_data.append(0xb3);
	auth_data.append(0xcc);
	auth_data.append(0xc8);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xb3);
	sig.append(0xd9);
	sig.append(0x0);
	sig.append(0xee);
	sig.append(0x29);
	sig.append(0x1d);
	sig.append(0x82);
	sig.append(0x3a);
	sig.append(0xa7);
	sig.append(0xdd);
	sig.append(0x84);
	sig.append(0x32);
	sig.append(0x56);
	sig.append(0x8a);
	sig.append(0x9a);
	sig.append(0xb2);
	sig.append(0x79);
	sig.append(0x89);
	sig.append(0x71);
	sig.append(0x13);
	sig.append(0x3);
	sig.append(0xbe);
	sig.append(0x10);
	sig.append(0x29);
	sig.append(0x17);
	sig.append(0xa9);
	sig.append(0x41);
	sig.append(0x38);
	sig.append(0xf2);
	sig.append(0x74);
	sig.append(0x80);
	sig.append(0xfe);
	sig.append(0x22);
	sig.append(0xab);
	sig.append(0xbb);
	sig.append(0x25);
	sig.append(0xc7);
	sig.append(0xba);
	sig.append(0x3d);
	sig.append(0x9b);
	sig.append(0x9d);
	sig.append(0x45);
	sig.append(0x6a);
	sig.append(0x56);
	sig.append(0x59);
	sig.append(0xc7);
	sig.append(0x12);
	sig.append(0x30);
	sig.append(0x7e);
	sig.append(0xa7);
	sig.append(0xdf);
	sig.append(0xf2);
	sig.append(0xc5);
	sig.append(0x21);
	sig.append(0x3d);
	sig.append(0xcb);
	sig.append(0x88);
	sig.append(0xf6);
	sig.append(0x4c);
	sig.append(0xef);
	sig.append(0x90);
	sig.append(0x6c);
	sig.append(0x8b);
	sig.append(0xf3);
	let pk = PublicKey {
		 x: 104849962515125151455450505898227648166655062526106209134822010844544586089979, 
		 y: 50079633641201757508129791846549146084243480717973717054300313821396232380430
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_4() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0xa1);
	hash.append(0xb7);
	hash.append(0xb4);
	hash.append(0xfd);
	hash.append(0x95);
	hash.append(0xed);
	hash.append(0xa);
	hash.append(0x11);
	hash.append(0xc2);
	hash.append(0x4c);
	hash.append(0x75);
	hash.append(0xca);
	hash.append(0x96);
	hash.append(0x1c);
	hash.append(0x92);
	hash.append(0x1d);
	hash.append(0xe0);
	hash.append(0xfe);
	hash.append(0xa5);
	hash.append(0xba);
	hash.append(0x71);
	hash.append(0xd9);
	hash.append(0x9a);
	hash.append(0xf8);
	hash.append(0xc8);
	hash.append(0x25);
	hash.append(0xf7);
	hash.append(0x4b);
	hash.append(0x36);
	hash.append(0x85);
	hash.append(0x6e);
	hash.append(0xc0);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x16);
	auth_data.append(0xda);
	auth_data.append(0x6a);
	auth_data.append(0xb0);
	auth_data.append(0xc8);
	auth_data.append(0xb7);
	auth_data.append(0x3b);
	auth_data.append(0xb1);
	auth_data.append(0xe7);
	auth_data.append(0x4c);
	auth_data.append(0x26);
	auth_data.append(0x87);
	auth_data.append(0xfa);
	auth_data.append(0xec);
	auth_data.append(0xf8);
	auth_data.append(0x58);
	auth_data.append(0xd6);
	auth_data.append(0xda);
	auth_data.append(0xf7);
	auth_data.append(0x51);
	auth_data.append(0x60);
	auth_data.append(0xe0);
	auth_data.append(0x65);
	auth_data.append(0x1e);
	auth_data.append(0xa4);
	auth_data.append(0x98);
	auth_data.append(0xf9);
	auth_data.append(0x2);
	auth_data.append(0xe6);
	auth_data.append(0xc8);
	auth_data.append(0x74);
	auth_data.append(0xe0);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x55);
	sig.append(0x65);
	sig.append(0x5a);
	sig.append(0xff);
	sig.append(0x64);
	sig.append(0xac);
	sig.append(0x16);
	sig.append(0x7d);
	sig.append(0x40);
	sig.append(0x9a);
	sig.append(0xdf);
	sig.append(0x9f);
	sig.append(0x3e);
	sig.append(0xfe);
	sig.append(0xa8);
	sig.append(0x7a);
	sig.append(0xe7);
	sig.append(0x52);
	sig.append(0xf2);
	sig.append(0xcd);
	sig.append(0x3c);
	sig.append(0x65);
	sig.append(0x9d);
	sig.append(0xae);
	sig.append(0xd4);
	sig.append(0x5e);
	sig.append(0x37);
	sig.append(0x75);
	sig.append(0x6f);
	sig.append(0xa7);
	sig.append(0x77);
	sig.append(0xbe);
	sig.append(0x55);
	sig.append(0x4f);
	sig.append(0xc5);
	sig.append(0xd0);
	sig.append(0x57);
	sig.append(0x3b);
	sig.append(0x6);
	sig.append(0x9a);
	sig.append(0x80);
	sig.append(0x20);
	sig.append(0x80);
	sig.append(0xf3);
	sig.append(0x38);
	sig.append(0x13);
	sig.append(0xbd);
	sig.append(0x1f);
	sig.append(0xca);
	sig.append(0x8c);
	sig.append(0x88);
	sig.append(0x1d);
	sig.append(0x42);
	sig.append(0xf);
	sig.append(0xe2);
	sig.append(0x76);
	sig.append(0x50);
	sig.append(0x3e);
	sig.append(0xf1);
	sig.append(0xc6);
	sig.append(0xdd);
	sig.append(0x8e);
	sig.append(0xe0);
	sig.append(0x91);
	let pk = PublicKey {
		 x: 61144968270043864632069846311445672191184283944314387293857801098251137766426, 
		 y: 14899365901841242235543790110451740880436277676485293038065696492322707640874
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_5() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x4c);
	hash.append(0xf);
	hash.append(0xe7);
	hash.append(0x0);
	hash.append(0x75);
	hash.append(0x5a);
	hash.append(0x19);
	hash.append(0x9c);
	hash.append(0x3c);
	hash.append(0xc8);
	hash.append(0x4d);
	hash.append(0x15);
	hash.append(0xd8);
	hash.append(0x7a);
	hash.append(0xf4);
	hash.append(0x2c);
	hash.append(0xe);
	hash.append(0x71);
	hash.append(0xc6);
	hash.append(0xd8);
	hash.append(0xa1);
	hash.append(0x74);
	hash.append(0xec);
	hash.append(0x4d);
	hash.append(0xff);
	hash.append(0xf1);
	hash.append(0x50);
	hash.append(0xf8);
	hash.append(0x93);
	hash.append(0x6d);
	hash.append(0x45);
	hash.append(0xba);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x29);
	auth_data.append(0x3e);
	auth_data.append(0xf8);
	auth_data.append(0xa1);
	auth_data.append(0x50);
	auth_data.append(0x40);
	auth_data.append(0x6c);
	auth_data.append(0xfb);
	auth_data.append(0x51);
	auth_data.append(0xe4);
	auth_data.append(0xaf);
	auth_data.append(0x51);
	auth_data.append(0x89);
	auth_data.append(0x8);
	auth_data.append(0x50);
	auth_data.append(0xfc);
	auth_data.append(0x5);
	auth_data.append(0x8e);
	auth_data.append(0xa2);
	auth_data.append(0x88);
	auth_data.append(0x52);
	auth_data.append(0x1);
	auth_data.append(0xab);
	auth_data.append(0xaf);
	auth_data.append(0x28);
	auth_data.append(0xe0);
	auth_data.append(0x19);
	auth_data.append(0xbb);
	auth_data.append(0xa3);
	auth_data.append(0x8b);
	auth_data.append(0xa5);
	auth_data.append(0xdc);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x9f);
	sig.append(0x7c);
	sig.append(0xa);
	sig.append(0x47);
	sig.append(0x61);
	sig.append(0xcf);
	sig.append(0x2a);
	sig.append(0xfc);
	sig.append(0x57);
	sig.append(0x53);
	sig.append(0xbf);
	sig.append(0xe0);
	sig.append(0x81);
	sig.append(0xa6);
	sig.append(0x47);
	sig.append(0x16);
	sig.append(0x38);
	sig.append(0xf3);
	sig.append(0x23);
	sig.append(0xda);
	sig.append(0x59);
	sig.append(0x43);
	sig.append(0x39);
	sig.append(0x6d);
	sig.append(0x67);
	sig.append(0xd);
	sig.append(0xbd);
	sig.append(0xc0);
	sig.append(0xd0);
	sig.append(0xb6);
	sig.append(0x43);
	sig.append(0xec);
	sig.append(0x36);
	sig.append(0x8);
	sig.append(0x68);
	sig.append(0x3d);
	sig.append(0x61);
	sig.append(0x4f);
	sig.append(0x68);
	sig.append(0x10);
	sig.append(0xf5);
	sig.append(0xb1);
	sig.append(0x35);
	sig.append(0x43);
	sig.append(0x4e);
	sig.append(0xf4);
	sig.append(0xdc);
	sig.append(0x40);
	sig.append(0x65);
	sig.append(0xc2);
	sig.append(0x3a);
	sig.append(0x5d);
	sig.append(0xfc);
	sig.append(0x1a);
	sig.append(0xa0);
	sig.append(0xa1);
	sig.append(0x7f);
	sig.append(0x16);
	sig.append(0x19);
	sig.append(0x57);
	sig.append(0x1b);
	sig.append(0x8b);
	sig.append(0xd2);
	sig.append(0x80);
	let pk = PublicKey {
		 x: 103544818925609994668537704715636182892899947788060775383671055357568639564995, 
		 y: 86057677475206946650397559346607367653280469061199940331837753038224458354965
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_6() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x9);
	hash.append(0xb7);
	hash.append(0x61);
	hash.append(0x7e);
	hash.append(0x67);
	hash.append(0xfa);
	hash.append(0xe0);
	hash.append(0x9e);
	hash.append(0x9a);
	hash.append(0x22);
	hash.append(0x6b);
	hash.append(0xb0);
	hash.append(0xb0);
	hash.append(0x80);
	hash.append(0x54);
	hash.append(0x78);
	hash.append(0x6b);
	hash.append(0x70);
	hash.append(0x8a);
	hash.append(0xf2);
	hash.append(0x18);
	hash.append(0x29);
	hash.append(0x58);
	hash.append(0xa4);
	hash.append(0xbd);
	hash.append(0xc9);
	hash.append(0x52);
	hash.append(0xcb);
	hash.append(0x35);
	hash.append(0x60);
	hash.append(0xb);
	hash.append(0x3e);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xea);
	auth_data.append(0x4d);
	auth_data.append(0x3b);
	auth_data.append(0xf9);
	auth_data.append(0xe);
	auth_data.append(0xe5);
	auth_data.append(0x92);
	auth_data.append(0xc);
	auth_data.append(0x9e);
	auth_data.append(0x74);
	auth_data.append(0x7d);
	auth_data.append(0x3d);
	auth_data.append(0x8c);
	auth_data.append(0x13);
	auth_data.append(0xeb);
	auth_data.append(0x36);
	auth_data.append(0xd0);
	auth_data.append(0x52);
	auth_data.append(0xba);
	auth_data.append(0xa6);
	auth_data.append(0xf2);
	auth_data.append(0xe);
	auth_data.append(0x9e);
	auth_data.append(0x4c);
	auth_data.append(0xf);
	auth_data.append(0x40);
	auth_data.append(0x2a);
	auth_data.append(0x38);
	auth_data.append(0x59);
	auth_data.append(0xb1);
	auth_data.append(0x3f);
	auth_data.append(0xed);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x88);
	sig.append(0x45);
	sig.append(0x8);
	sig.append(0x49);
	sig.append(0xc6);
	sig.append(0xee);
	sig.append(0x76);
	sig.append(0x6f);
	sig.append(0xe0);
	sig.append(0xa3);
	sig.append(0x9a);
	sig.append(0x4e);
	sig.append(0xc);
	sig.append(0x8a);
	sig.append(0x17);
	sig.append(0x70);
	sig.append(0x52);
	sig.append(0x61);
	sig.append(0xf6);
	sig.append(0xf2);
	sig.append(0xd7);
	sig.append(0x5a);
	sig.append(0xc);
	sig.append(0xb5);
	sig.append(0x8d);
	sig.append(0x1f);
	sig.append(0xed);
	sig.append(0x6e);
	sig.append(0x1a);
	sig.append(0x76);
	sig.append(0xea);
	sig.append(0xde);
	sig.append(0xa7);
	sig.append(0xcd);
	sig.append(0x23);
	sig.append(0x4d);
	sig.append(0x93);
	sig.append(0x43);
	sig.append(0x9e);
	sig.append(0x81);
	sig.append(0x73);
	sig.append(0x28);
	sig.append(0xd5);
	sig.append(0x81);
	sig.append(0x13);
	sig.append(0x74);
	sig.append(0x0);
	sig.append(0xf2);
	sig.append(0xb4);
	sig.append(0xcd);
	sig.append(0x9f);
	sig.append(0x22);
	sig.append(0xf0);
	sig.append(0x4a);
	sig.append(0x4f);
	sig.append(0xdd);
	sig.append(0xb9);
	sig.append(0x1a);
	sig.append(0x64);
	sig.append(0xcb);
	sig.append(0x29);
	sig.append(0x2);
	sig.append(0x3);
	sig.append(0x83);
	let pk = PublicKey {
		 x: 22470775162063530094884409562128263752500536794520647761546146081582905263141, 
		 y: 52507221784527933963204589404273126730350628281726378886537094897997326724859
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_7() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x88);
	hash.append(0xb3);
	hash.append(0x2d);
	hash.append(0x38);
	hash.append(0x4);
	hash.append(0xf6);
	hash.append(0xfd);
	hash.append(0xc6);
	hash.append(0x22);
	hash.append(0x85);
	hash.append(0x2);
	hash.append(0x38);
	hash.append(0xcb);
	hash.append(0xa3);
	hash.append(0x25);
	hash.append(0xc);
	hash.append(0x81);
	hash.append(0x8f);
	hash.append(0x89);
	hash.append(0x81);
	hash.append(0x10);
	hash.append(0x1c);
	hash.append(0xb7);
	hash.append(0x4e);
	hash.append(0x25);
	hash.append(0x85);
	hash.append(0xcc);
	hash.append(0xf);
	hash.append(0xe0);
	hash.append(0x91);
	hash.append(0x2d);
	hash.append(0x9f);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x6d);
	auth_data.append(0xee);
	auth_data.append(0xc7);
	auth_data.append(0xf6);
	auth_data.append(0x7d);
	auth_data.append(0xb4);
	auth_data.append(0xbf);
	auth_data.append(0xf1);
	auth_data.append(0x8c);
	auth_data.append(0x6b);
	auth_data.append(0xb4);
	auth_data.append(0xa1);
	auth_data.append(0x43);
	auth_data.append(0x52);
	auth_data.append(0x31);
	auth_data.append(0x20);
	auth_data.append(0x73);
	auth_data.append(0x7e);
	auth_data.append(0xd6);
	auth_data.append(0x16);
	auth_data.append(0x22);
	auth_data.append(0xef);
	auth_data.append(0xfd);
	auth_data.append(0x3);
	auth_data.append(0xfb);
	auth_data.append(0xf3);
	auth_data.append(0x86);
	auth_data.append(0x32);
	auth_data.append(0x64);
	auth_data.append(0x83);
	auth_data.append(0x20);
	auth_data.append(0xf3);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x54);
	sig.append(0x64);
	sig.append(0xf4);
	sig.append(0x6d);
	sig.append(0x83);
	sig.append(0xbb);
	sig.append(0xa5);
	sig.append(0xcd);
	sig.append(0x5a);
	sig.append(0x9b);
	sig.append(0x7c);
	sig.append(0xb8);
	sig.append(0xb4);
	sig.append(0xa);
	sig.append(0xf2);
	sig.append(0x51);
	sig.append(0xb8);
	sig.append(0x3b);
	sig.append(0xeb);
	sig.append(0x85);
	sig.append(0x63);
	sig.append(0x82);
	sig.append(0xa5);
	sig.append(0xbd);
	sig.append(0xf1);
	sig.append(0xd);
	sig.append(0xd1);
	sig.append(0xdd);
	sig.append(0x3d);
	sig.append(0xf);
	sig.append(0x19);
	sig.append(0x47);
	sig.append(0xdd);
	sig.append(0xdf);
	sig.append(0x2d);
	sig.append(0xc7);
	sig.append(0x68);
	sig.append(0x1c);
	sig.append(0x8a);
	sig.append(0x66);
	sig.append(0xb7);
	sig.append(0xf3);
	sig.append(0xdc);
	sig.append(0x2d);
	sig.append(0xae);
	sig.append(0x3b);
	sig.append(0xe1);
	sig.append(0xc7);
	sig.append(0xf6);
	sig.append(0x69);
	sig.append(0x8f);
	sig.append(0x91);
	sig.append(0x13);
	sig.append(0x2f);
	sig.append(0xaf);
	sig.append(0xfc);
	sig.append(0xbe);
	sig.append(0x9);
	sig.append(0x1f);
	sig.append(0xc3);
	sig.append(0x54);
	sig.append(0x9c);
	sig.append(0x75);
	sig.append(0x68);
	let pk = PublicKey {
		 x: 38926700580258585304182966226922877879301602170530771158905577775845100990084, 
		 y: 50934717460432867800162397677325773313586886757756518050889652302181382142368
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_8() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x1);
	hash.append(0x87);
	hash.append(0xca);
	hash.append(0x23);
	hash.append(0x4e);
	hash.append(0xbb);
	hash.append(0x1f);
	hash.append(0x62);
	hash.append(0xad);
	hash.append(0x1c);
	hash.append(0x55);
	hash.append(0x94);
	hash.append(0x44);
	hash.append(0x65);
	hash.append(0xa9);
	hash.append(0xe7);
	hash.append(0xa1);
	hash.append(0x3);
	hash.append(0xca);
	hash.append(0x9);
	hash.append(0x29);
	hash.append(0xae);
	hash.append(0xed);
	hash.append(0x1c);
	hash.append(0xe);
	hash.append(0x40);
	hash.append(0x58);
	hash.append(0xa3);
	hash.append(0x14);
	hash.append(0x45);
	hash.append(0x7);
	hash.append(0x85);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x32);
	auth_data.append(0xb3);
	auth_data.append(0x25);
	auth_data.append(0x1c);
	auth_data.append(0x12);
	auth_data.append(0x8d);
	auth_data.append(0x32);
	auth_data.append(0xe6);
	auth_data.append(0x4d);
	auth_data.append(0x60);
	auth_data.append(0xdb);
	auth_data.append(0x4a);
	auth_data.append(0x86);
	auth_data.append(0xd7);
	auth_data.append(0xd6);
	auth_data.append(0x6b);
	auth_data.append(0x6c);
	auth_data.append(0xad);
	auth_data.append(0x96);
	auth_data.append(0x22);
	auth_data.append(0x21);
	auth_data.append(0x28);
	auth_data.append(0x7d);
	auth_data.append(0x47);
	auth_data.append(0x65);
	auth_data.append(0xbe);
	auth_data.append(0xf3);
	auth_data.append(0x6);
	auth_data.append(0x10);
	auth_data.append(0xcd);
	auth_data.append(0x28);
	auth_data.append(0xda);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xb3);
	sig.append(0x80);
	sig.append(0x22);
	sig.append(0xfa);
	sig.append(0x59);
	sig.append(0xd2);
	sig.append(0xe);
	sig.append(0xb6);
	sig.append(0x6e);
	sig.append(0xfe);
	sig.append(0x86);
	sig.append(0x39);
	sig.append(0xfc);
	sig.append(0xaa);
	sig.append(0x6e);
	sig.append(0x93);
	sig.append(0x83);
	sig.append(0x5d);
	sig.append(0xe9);
	sig.append(0xdd);
	sig.append(0xc2);
	sig.append(0xe7);
	sig.append(0xac);
	sig.append(0x8e);
	sig.append(0xe6);
	sig.append(0xa8);
	sig.append(0x9c);
	sig.append(0x79);
	sig.append(0x72);
	sig.append(0xe9);
	sig.append(0x7d);
	sig.append(0x8c);
	sig.append(0xfc);
	sig.append(0x56);
	sig.append(0x93);
	sig.append(0x3b);
	sig.append(0xab);
	sig.append(0xf5);
	sig.append(0xb2);
	sig.append(0x3e);
	sig.append(0xf7);
	sig.append(0xeb);
	sig.append(0xa0);
	sig.append(0xdf);
	sig.append(0x6b);
	sig.append(0xa3);
	sig.append(0x77);
	sig.append(0x34);
	sig.append(0xba);
	sig.append(0x38);
	sig.append(0x61);
	sig.append(0x97);
	sig.append(0xfb);
	sig.append(0xd6);
	sig.append(0x3b);
	sig.append(0x37);
	sig.append(0x54);
	sig.append(0xa8);
	sig.append(0x47);
	sig.append(0x98);
	sig.append(0x10);
	sig.append(0x68);
	sig.append(0xb6);
	sig.append(0xf0);
	let pk = PublicKey {
		 x: 33769391094347673733185647273023031134179618301456440794379279567989365093301, 
		 y: 66405536297362112955289356278209407017362166368021748027544989147857116846556
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_9() {
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x2);
	hash.append(0x29);
	hash.append(0xa0);
	hash.append(0x40);
	hash.append(0xa5);
	hash.append(0xbe);
	hash.append(0x5c);
	hash.append(0xdc);
	hash.append(0xbc);
	hash.append(0xdd);
	hash.append(0xa6);
	hash.append(0x4);
	hash.append(0x3c);
	hash.append(0x37);
	hash.append(0xc3);
	hash.append(0xc2);
	hash.append(0xaa);
	hash.append(0xf8);
	hash.append(0xc3);
	hash.append(0xbb);
	hash.append(0x57);
	hash.append(0x35);
	hash.append(0xf6);
	hash.append(0xea);
	hash.append(0x81);
	hash.append(0x37);
	hash.append(0x1b);
	hash.append(0x9c);
	hash.append(0xa1);
	hash.append(0x50);
	hash.append(0xb8);
	hash.append(0x29);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xee);
	auth_data.append(0x91);
	auth_data.append(0xe1);
	auth_data.append(0x48);
	auth_data.append(0x67);
	auth_data.append(0x6d);
	auth_data.append(0x7a);
	auth_data.append(0x9d);
	auth_data.append(0x71);
	auth_data.append(0xf0);
	auth_data.append(0x9a);
	auth_data.append(0xe9);
	auth_data.append(0x9e);
	auth_data.append(0x39);
	auth_data.append(0x5c);
	auth_data.append(0x97);
	auth_data.append(0x86);
	auth_data.append(0xba);
	auth_data.append(0xed);
	auth_data.append(0x59);
	auth_data.append(0x39);
	auth_data.append(0x3b);
	auth_data.append(0x43);
	auth_data.append(0xb0);
	auth_data.append(0x91);
	auth_data.append(0xe1);
	auth_data.append(0x2);
	auth_data.append(0xa1);
	auth_data.append(0xda);
	auth_data.append(0x97);
	auth_data.append(0x36);
	auth_data.append(0x1f);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xd8);
	sig.append(0xfb);
	sig.append(0x20);
	sig.append(0x8);
	sig.append(0x5d);
	sig.append(0xe4);
	sig.append(0x1d);
	sig.append(0x82);
	sig.append(0x81);
	sig.append(0xbd);
	sig.append(0xd);
	sig.append(0x2b);
	sig.append(0x31);
	sig.append(0x25);
	sig.append(0x5f);
	sig.append(0xb9);
	sig.append(0xfa);
	sig.append(0xa4);
	sig.append(0x1f);
	sig.append(0xfc);
	sig.append(0x7b);
	sig.append(0x8a);
	sig.append(0xcb);
	sig.append(0x7b);
	sig.append(0xaa);
	sig.append(0x74);
	sig.append(0x67);
	sig.append(0xcf);
	sig.append(0x2e);
	sig.append(0x14);
	sig.append(0x26);
	sig.append(0x1d);
	sig.append(0x2b);
	sig.append(0x12);
	sig.append(0xc1);
	sig.append(0xd5);
	sig.append(0x1a);
	sig.append(0xc5);
	sig.append(0xdc);
	sig.append(0x58);
	sig.append(0xe4);
	sig.append(0xe8);
	sig.append(0xab);
	sig.append(0x48);
	sig.append(0x7d);
	sig.append(0xa7);
	sig.append(0x78);
	sig.append(0xd9);
	sig.append(0xf4);
	sig.append(0xde);
	sig.append(0x67);
	sig.append(0xb6);
	sig.append(0x44);
	sig.append(0x35);
	sig.append(0x65);
	sig.append(0xd1);
	sig.append(0x42);
	sig.append(0xa8);
	sig.append(0xbe);
	sig.append(0x53);
	sig.append(0x87);
	sig.append(0x8f);
	sig.append(0x99);
	sig.append(0xab);
	let pk = PublicKey {
		 x: 105136942027406525699436681276204026825846763507830383427057126706186752345254, 
		 y: 73460761307173820279920137640698774022816048736729014840840222224186232344403
	};
	match verify_signature(
	    hash, auth_data, pk, sig            
	) {
	    Result::Ok => (),
	    Result::Err(e) => {
	        assert(false, AuthnErrorIntoFelt252::into(e))
	    }
	}
}


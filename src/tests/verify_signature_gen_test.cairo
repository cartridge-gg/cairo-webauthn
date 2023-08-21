// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/verify_signature_test.py for details
use core::traits::Into;
use result::ResultTrait;
use core::option::OptionTrait;
use webauthn::ecdsa::{verify_ecdsa, verify_hashed_ecdsa, VerifyEcdsaError};
use webauthn::types::PublicKey;
use webauthn::webauthn::verify_signature;
use webauthn::errors::AuthnErrorIntoFelt252;
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1Point;
use starknet::SyscallResultTrait;
use array::ArrayTrait;

#[test]
#[available_gas(200000000000)]
fn test_verify_signature_0(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0xe3);
	hash.append(0x71);
	hash.append(0x5d);
	hash.append(0x6);
	hash.append(0x8d);
	hash.append(0x7b);
	hash.append(0xa0);
	hash.append(0xb4);
	hash.append(0x7b);
	hash.append(0xc8);
	hash.append(0x0);
	hash.append(0xdf);
	hash.append(0x6);
	hash.append(0x91);
	hash.append(0x4e);
	hash.append(0x9d);
	hash.append(0xed);
	hash.append(0xa0);
	hash.append(0x21);
	hash.append(0xd1);
	hash.append(0x94);
	hash.append(0xc1);
	hash.append(0x6d);
	hash.append(0x2);
	hash.append(0x21);
	hash.append(0x24);
	hash.append(0x82);
	hash.append(0x19);
	hash.append(0xa5);
	hash.append(0xde);
	hash.append(0x8e);
	hash.append(0x23);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x23);
	auth_data.append(0x52);
	auth_data.append(0x8f);
	auth_data.append(0x14);
	auth_data.append(0x1e);
	auth_data.append(0x98);
	auth_data.append(0x2d);
	auth_data.append(0x92);
	auth_data.append(0xec);
	auth_data.append(0x43);
	auth_data.append(0x72);
	auth_data.append(0x94);
	auth_data.append(0xb4);
	auth_data.append(0x2f);
	auth_data.append(0xd0);
	auth_data.append(0xbf);
	auth_data.append(0xc6);
	auth_data.append(0xd);
	auth_data.append(0x10);
	auth_data.append(0x96);
	auth_data.append(0x8d);
	auth_data.append(0x82);
	auth_data.append(0x1c);
	auth_data.append(0x6b);
	auth_data.append(0xb8);
	auth_data.append(0xbb);
	auth_data.append(0x81);
	auth_data.append(0x71);
	auth_data.append(0x41);
	auth_data.append(0xf);
	auth_data.append(0x6e);
	auth_data.append(0x84);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa);
	sig.append(0x94);
	sig.append(0x45);
	sig.append(0xf4);
	sig.append(0x24);
	sig.append(0xa5);
	sig.append(0xe3);
	sig.append(0xea);
	sig.append(0x3b);
	sig.append(0x82);
	sig.append(0xf9);
	sig.append(0x41);
	sig.append(0x36);
	sig.append(0x2a);
	sig.append(0xa8);
	sig.append(0xb0);
	sig.append(0x1a);
	sig.append(0xe3);
	sig.append(0x7b);
	sig.append(0x8);
	sig.append(0x38);
	sig.append(0xd7);
	sig.append(0xb7);
	sig.append(0x30);
	sig.append(0xcd);
	sig.append(0xde);
	sig.append(0x50);
	sig.append(0x1a);
	sig.append(0xc4);
	sig.append(0x4e);
	sig.append(0x38);
	sig.append(0xb9);
	sig.append(0x23);
	sig.append(0xb4);
	sig.append(0x5b);
	sig.append(0xaf);
	sig.append(0x24);
	sig.append(0x5b);
	sig.append(0x29);
	sig.append(0x85);
	sig.append(0x21);
	sig.append(0x62);
	sig.append(0x1);
	sig.append(0xe1);
	sig.append(0x14);
	sig.append(0x51);
	sig.append(0x88);
	sig.append(0xab);
	sig.append(0xfb);
	sig.append(0x9f);
	sig.append(0x3b);
	sig.append(0xba);
	sig.append(0xd6);
	sig.append(0xea);
	sig.append(0x74);
	sig.append(0xc6);
	sig.append(0x26);
	sig.append(0x6f);
	sig.append(0xb1);
	sig.append(0x15);
	sig.append(0xc1);
	sig.append(0x19);
	sig.append(0x50);
	sig.append(0x2f);
	let pk = PublicKey {
		 x: 82058831676903512469813610166966140111895109178398782359627341234543984805438, 
		 y: 38589816572119371165065292048833516878686715428107352969933935105237175910843
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
fn test_verify_signature_1(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x6c);
	hash.append(0xf8);
	hash.append(0x2e);
	hash.append(0xfe);
	hash.append(0xdb);
	hash.append(0x5e);
	hash.append(0xbe);
	hash.append(0x2f);
	hash.append(0xe3);
	hash.append(0x3);
	hash.append(0xe7);
	hash.append(0x14);
	hash.append(0x9f);
	hash.append(0x4b);
	hash.append(0x56);
	hash.append(0x8f);
	hash.append(0x6a);
	hash.append(0x72);
	hash.append(0x97);
	hash.append(0x6b);
	hash.append(0x96);
	hash.append(0x49);
	hash.append(0xa6);
	hash.append(0x74);
	hash.append(0xfa);
	hash.append(0x36);
	hash.append(0xba);
	hash.append(0x2f);
	hash.append(0x79);
	hash.append(0x7b);
	hash.append(0xf7);
	hash.append(0x4a);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xb2);
	auth_data.append(0x8c);
	auth_data.append(0x1f);
	auth_data.append(0xa0);
	auth_data.append(0xa0);
	auth_data.append(0x7c);
	auth_data.append(0xcd);
	auth_data.append(0x88);
	auth_data.append(0xac);
	auth_data.append(0xb6);
	auth_data.append(0x0);
	auth_data.append(0xe);
	auth_data.append(0x85);
	auth_data.append(0xd8);
	auth_data.append(0xa5);
	auth_data.append(0xa4);
	auth_data.append(0xfb);
	auth_data.append(0xf);
	auth_data.append(0xf3);
	auth_data.append(0x6b);
	auth_data.append(0x8c);
	auth_data.append(0x64);
	auth_data.append(0x18);
	auth_data.append(0xfb);
	auth_data.append(0x3d);
	auth_data.append(0x0);
	auth_data.append(0x70);
	auth_data.append(0x31);
	auth_data.append(0x3b);
	auth_data.append(0x95);
	auth_data.append(0xb0);
	auth_data.append(0xbd);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x9b);
	sig.append(0x6);
	sig.append(0x61);
	sig.append(0xf4);
	sig.append(0xc5);
	sig.append(0x47);
	sig.append(0x7b);
	sig.append(0x7);
	sig.append(0x8a);
	sig.append(0x41);
	sig.append(0x8a);
	sig.append(0x89);
	sig.append(0x62);
	sig.append(0x50);
	sig.append(0x35);
	sig.append(0x2c);
	sig.append(0x85);
	sig.append(0xca);
	sig.append(0x80);
	sig.append(0x50);
	sig.append(0x88);
	sig.append(0xda);
	sig.append(0x9);
	sig.append(0x89);
	sig.append(0x1);
	sig.append(0x9e);
	sig.append(0xac);
	sig.append(0xdc);
	sig.append(0x39);
	sig.append(0x7b);
	sig.append(0x37);
	sig.append(0x7d);
	sig.append(0xea);
	sig.append(0x8e);
	sig.append(0xa5);
	sig.append(0x8e);
	sig.append(0x2b);
	sig.append(0xb3);
	sig.append(0xe4);
	sig.append(0xf1);
	sig.append(0x17);
	sig.append(0x23);
	sig.append(0x8b);
	sig.append(0xdd);
	sig.append(0xed);
	sig.append(0x7);
	sig.append(0x2d);
	sig.append(0xb7);
	sig.append(0x19);
	sig.append(0xa8);
	sig.append(0x11);
	sig.append(0xff);
	sig.append(0x1d);
	sig.append(0x97);
	sig.append(0xe0);
	sig.append(0x1a);
	sig.append(0xfd);
	sig.append(0x3f);
	sig.append(0x21);
	sig.append(0xd9);
	sig.append(0x1c);
	sig.append(0xea);
	sig.append(0xbf);
	sig.append(0x7f);
	let pk = PublicKey {
		 x: 813795443684103144017100369348309960016061950854523700775802077067289173229, 
		 y: 89648593900126847006030943156654430806875106308289637334836688613829777419918
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
fn test_verify_signature_2(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x70);
	hash.append(0x66);
	hash.append(0x8a);
	hash.append(0x5e);
	hash.append(0x47);
	hash.append(0xd7);
	hash.append(0x64);
	hash.append(0xe0);
	hash.append(0xb4);
	hash.append(0xe2);
	hash.append(0xb8);
	hash.append(0x28);
	hash.append(0x49);
	hash.append(0xba);
	hash.append(0x13);
	hash.append(0x63);
	hash.append(0xc3);
	hash.append(0xe3);
	hash.append(0x65);
	hash.append(0xde);
	hash.append(0xfd);
	hash.append(0x3);
	hash.append(0x1e);
	hash.append(0xe4);
	hash.append(0x65);
	hash.append(0x38);
	hash.append(0xb4);
	hash.append(0x22);
	hash.append(0xd3);
	hash.append(0x89);
	hash.append(0x2f);
	hash.append(0x70);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x81);
	auth_data.append(0xf9);
	auth_data.append(0x22);
	auth_data.append(0x8f);
	auth_data.append(0xe9);
	auth_data.append(0xcb);
	auth_data.append(0x29);
	auth_data.append(0x1a);
	auth_data.append(0x39);
	auth_data.append(0x14);
	auth_data.append(0xaa);
	auth_data.append(0xdd);
	auth_data.append(0xb);
	auth_data.append(0xa0);
	auth_data.append(0x2b);
	auth_data.append(0x38);
	auth_data.append(0x49);
	auth_data.append(0xec);
	auth_data.append(0xfc);
	auth_data.append(0x81);
	auth_data.append(0x3f);
	auth_data.append(0x35);
	auth_data.append(0xfb);
	auth_data.append(0xe3);
	auth_data.append(0x58);
	auth_data.append(0x2f);
	auth_data.append(0xc7);
	auth_data.append(0xb0);
	auth_data.append(0x56);
	auth_data.append(0x11);
	auth_data.append(0xe1);
	auth_data.append(0x89);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x4f);
	sig.append(0x71);
	sig.append(0xfe);
	sig.append(0xb4);
	sig.append(0xe4);
	sig.append(0xf);
	sig.append(0xad);
	sig.append(0xef);
	sig.append(0x9a);
	sig.append(0x55);
	sig.append(0x1c);
	sig.append(0x17);
	sig.append(0x21);
	sig.append(0xb5);
	sig.append(0x43);
	sig.append(0xa1);
	sig.append(0x1e);
	sig.append(0x3b);
	sig.append(0x37);
	sig.append(0x6b);
	sig.append(0xe9);
	sig.append(0x2f);
	sig.append(0x46);
	sig.append(0x4d);
	sig.append(0x68);
	sig.append(0x5e);
	sig.append(0xf9);
	sig.append(0xcf);
	sig.append(0x82);
	sig.append(0x17);
	sig.append(0x8f);
	sig.append(0x47);
	sig.append(0x7e);
	sig.append(0x7b);
	sig.append(0xb6);
	sig.append(0xbc);
	sig.append(0xfb);
	sig.append(0x5e);
	sig.append(0xba);
	sig.append(0x99);
	sig.append(0x13);
	sig.append(0x21);
	sig.append(0xb1);
	sig.append(0x7a);
	sig.append(0xd8);
	sig.append(0x60);
	sig.append(0xef);
	sig.append(0xaa);
	sig.append(0x1);
	sig.append(0x31);
	sig.append(0x16);
	sig.append(0x64);
	sig.append(0x5b);
	sig.append(0xf8);
	sig.append(0x49);
	sig.append(0x81);
	sig.append(0x1c);
	sig.append(0x55);
	sig.append(0x19);
	sig.append(0x95);
	sig.append(0x5e);
	sig.append(0x25);
	sig.append(0x89);
	sig.append(0xc5);
	let pk = PublicKey {
		 x: 47099765554619191429884752832336702651899500270489976872442372077705921935950, 
		 y: 5386245605591742005358530290337360954918467566334671523987686307843705059452
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
fn test_verify_signature_3(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0xee);
	hash.append(0xac);
	hash.append(0x46);
	hash.append(0x51);
	hash.append(0x95);
	hash.append(0xbb);
	hash.append(0x1e);
	hash.append(0x37);
	hash.append(0x9a);
	hash.append(0x5d);
	hash.append(0x47);
	hash.append(0x22);
	hash.append(0x1);
	hash.append(0x43);
	hash.append(0xd5);
	hash.append(0x7d);
	hash.append(0x83);
	hash.append(0x4);
	hash.append(0xdc);
	hash.append(0x14);
	hash.append(0x3);
	hash.append(0x72);
	hash.append(0x20);
	hash.append(0xd4);
	hash.append(0x40);
	hash.append(0x8f);
	hash.append(0xd0);
	hash.append(0xf6);
	hash.append(0xb1);
	hash.append(0x0);
	hash.append(0x12);
	hash.append(0x6b);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x85);
	auth_data.append(0x4f);
	auth_data.append(0x30);
	auth_data.append(0x95);
	auth_data.append(0xdc);
	auth_data.append(0x5f);
	auth_data.append(0x67);
	auth_data.append(0x5d);
	auth_data.append(0x7b);
	auth_data.append(0x42);
	auth_data.append(0x6b);
	auth_data.append(0xc5);
	auth_data.append(0xf9);
	auth_data.append(0x63);
	auth_data.append(0xc4);
	auth_data.append(0x61);
	auth_data.append(0x8a);
	auth_data.append(0x54);
	auth_data.append(0xa4);
	auth_data.append(0x6d);
	auth_data.append(0xf1);
	auth_data.append(0x24);
	auth_data.append(0xa5);
	auth_data.append(0x3b);
	auth_data.append(0x79);
	auth_data.append(0xbc);
	auth_data.append(0x6f);
	auth_data.append(0x3a);
	auth_data.append(0x42);
	auth_data.append(0xac);
	auth_data.append(0x40);
	auth_data.append(0x60);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa6);
	sig.append(0xe5);
	sig.append(0x1e);
	sig.append(0xc6);
	sig.append(0xe);
	sig.append(0xd6);
	sig.append(0xfd);
	sig.append(0x67);
	sig.append(0xed);
	sig.append(0x97);
	sig.append(0x64);
	sig.append(0x3d);
	sig.append(0x76);
	sig.append(0xaf);
	sig.append(0x4a);
	sig.append(0x87);
	sig.append(0x28);
	sig.append(0xb);
	sig.append(0x12);
	sig.append(0xd8);
	sig.append(0xcb);
	sig.append(0x9a);
	sig.append(0x93);
	sig.append(0x11);
	sig.append(0xa0);
	sig.append(0x98);
	sig.append(0x7);
	sig.append(0xe4);
	sig.append(0x5b);
	sig.append(0x5f);
	sig.append(0x66);
	sig.append(0x29);
	sig.append(0x7c);
	sig.append(0xdc);
	sig.append(0x5a);
	sig.append(0x45);
	sig.append(0x89);
	sig.append(0xd3);
	sig.append(0x78);
	sig.append(0xae);
	sig.append(0x60);
	sig.append(0x29);
	sig.append(0x93);
	sig.append(0x22);
	sig.append(0x95);
	sig.append(0x51);
	sig.append(0x67);
	sig.append(0x75);
	sig.append(0xdf);
	sig.append(0xa9);
	sig.append(0xf1);
	sig.append(0x70);
	sig.append(0xe1);
	sig.append(0xdb);
	sig.append(0xc0);
	sig.append(0xbb);
	sig.append(0x4f);
	sig.append(0xf);
	sig.append(0x9a);
	sig.append(0xbe);
	sig.append(0x92);
	sig.append(0x31);
	sig.append(0x21);
	sig.append(0x81);
	let pk = PublicKey {
		 x: 57957129512894960782056840471897271509624035137226312492532998158815240916854, 
		 y: 911642742032534337938744612825719806719034286760132156661684929176609377940
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
fn test_verify_signature_4(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0xe3);
	hash.append(0xb5);
	hash.append(0xbe);
	hash.append(0xc6);
	hash.append(0x6c);
	hash.append(0xe6);
	hash.append(0x20);
	hash.append(0x1c);
	hash.append(0x94);
	hash.append(0x71);
	hash.append(0x23);
	hash.append(0xc6);
	hash.append(0x64);
	hash.append(0x32);
	hash.append(0x4b);
	hash.append(0xad);
	hash.append(0x1a);
	hash.append(0x5a);
	hash.append(0xde);
	hash.append(0x44);
	hash.append(0xee);
	hash.append(0xe5);
	hash.append(0x78);
	hash.append(0x74);
	hash.append(0x38);
	hash.append(0xc8);
	hash.append(0x86);
	hash.append(0x3d);
	hash.append(0x6d);
	hash.append(0xd3);
	hash.append(0x3a);
	hash.append(0x1c);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x3e);
	auth_data.append(0x22);
	auth_data.append(0x94);
	auth_data.append(0xce);
	auth_data.append(0xdb);
	auth_data.append(0x0);
	auth_data.append(0x34);
	auth_data.append(0x41);
	auth_data.append(0xb3);
	auth_data.append(0x37);
	auth_data.append(0x83);
	auth_data.append(0x62);
	auth_data.append(0x1c);
	auth_data.append(0x5);
	auth_data.append(0x55);
	auth_data.append(0xc0);
	auth_data.append(0x41);
	auth_data.append(0x8e);
	auth_data.append(0xa6);
	auth_data.append(0x64);
	auth_data.append(0x55);
	auth_data.append(0xb3);
	auth_data.append(0xf9);
	auth_data.append(0x14);
	auth_data.append(0xb7);
	auth_data.append(0xb7);
	auth_data.append(0x18);
	auth_data.append(0x55);
	auth_data.append(0xa8);
	auth_data.append(0x83);
	auth_data.append(0xec);
	auth_data.append(0x23);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x94);
	sig.append(0x16);
	sig.append(0xf0);
	sig.append(0xaa);
	sig.append(0xc5);
	sig.append(0xa4);
	sig.append(0x37);
	sig.append(0xa0);
	sig.append(0xde);
	sig.append(0x10);
	sig.append(0xc7);
	sig.append(0xa0);
	sig.append(0x9e);
	sig.append(0xb1);
	sig.append(0xc2);
	sig.append(0xde);
	sig.append(0x7);
	sig.append(0x1e);
	sig.append(0x13);
	sig.append(0x38);
	sig.append(0x48);
	sig.append(0x72);
	sig.append(0x50);
	sig.append(0x90);
	sig.append(0x14);
	sig.append(0xee);
	sig.append(0x7a);
	sig.append(0xda);
	sig.append(0x7d);
	sig.append(0xcb);
	sig.append(0xf0);
	sig.append(0x2e);
	sig.append(0xfb);
	sig.append(0x72);
	sig.append(0x0);
	sig.append(0x45);
	sig.append(0xa5);
	sig.append(0xac);
	sig.append(0x50);
	sig.append(0x66);
	sig.append(0x47);
	sig.append(0x8e);
	sig.append(0x3c);
	sig.append(0x36);
	sig.append(0xca);
	sig.append(0xa2);
	sig.append(0xc2);
	sig.append(0xc6);
	sig.append(0xd7);
	sig.append(0x6d);
	sig.append(0x34);
	sig.append(0xc);
	sig.append(0x9e);
	sig.append(0x2);
	sig.append(0x41);
	sig.append(0x39);
	sig.append(0x11);
	sig.append(0x9b);
	sig.append(0x56);
	sig.append(0x7d);
	sig.append(0x3f);
	sig.append(0x3a);
	sig.append(0x28);
	sig.append(0xec);
	let pk = PublicKey {
		 x: 91369915951167635710798788316307577472019844807514621959579042428619106399693, 
		 y: 105746438611222095575153403377759528388730546518428221408089800166362933784114
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
fn test_verify_signature_5(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x38);
	hash.append(0x84);
	hash.append(0x7d);
	hash.append(0xe2);
	hash.append(0x41);
	hash.append(0x95);
	hash.append(0x49);
	hash.append(0xdb);
	hash.append(0x31);
	hash.append(0xa2);
	hash.append(0x1a);
	hash.append(0xb1);
	hash.append(0xa6);
	hash.append(0x7e);
	hash.append(0x51);
	hash.append(0x30);
	hash.append(0xf1);
	hash.append(0x1b);
	hash.append(0x3e);
	hash.append(0x9);
	hash.append(0x4);
	hash.append(0xd3);
	hash.append(0x60);
	hash.append(0xb2);
	hash.append(0x44);
	hash.append(0x98);
	hash.append(0x35);
	hash.append(0xf8);
	hash.append(0xdc);
	hash.append(0x9d);
	hash.append(0xc);
	hash.append(0x2a);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x36);
	auth_data.append(0x39);
	auth_data.append(0x29);
	auth_data.append(0x21);
	auth_data.append(0xe9);
	auth_data.append(0x36);
	auth_data.append(0x26);
	auth_data.append(0x58);
	auth_data.append(0xa9);
	auth_data.append(0xb1);
	auth_data.append(0xc6);
	auth_data.append(0x98);
	auth_data.append(0xe4);
	auth_data.append(0x87);
	auth_data.append(0x15);
	auth_data.append(0xed);
	auth_data.append(0x55);
	auth_data.append(0x8d);
	auth_data.append(0xdc);
	auth_data.append(0xa1);
	auth_data.append(0x91);
	auth_data.append(0xbb);
	auth_data.append(0xbb);
	auth_data.append(0x1f);
	auth_data.append(0x9a);
	auth_data.append(0xf2);
	auth_data.append(0xb5);
	auth_data.append(0xc3);
	auth_data.append(0x98);
	auth_data.append(0x9a);
	auth_data.append(0xb1);
	auth_data.append(0x86);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xe1);
	sig.append(0x79);
	sig.append(0x2f);
	sig.append(0x26);
	sig.append(0xb7);
	sig.append(0x97);
	sig.append(0xad);
	sig.append(0x14);
	sig.append(0x54);
	sig.append(0x39);
	sig.append(0xd0);
	sig.append(0x5e);
	sig.append(0xa1);
	sig.append(0x81);
	sig.append(0x0);
	sig.append(0x77);
	sig.append(0x6e);
	sig.append(0x13);
	sig.append(0x74);
	sig.append(0x4f);
	sig.append(0x49);
	sig.append(0xda);
	sig.append(0xac);
	sig.append(0xc7);
	sig.append(0xed);
	sig.append(0x4f);
	sig.append(0xc1);
	sig.append(0x2d);
	sig.append(0x8);
	sig.append(0x5f);
	sig.append(0x53);
	sig.append(0x15);
	sig.append(0xa0);
	sig.append(0x2f);
	sig.append(0x57);
	sig.append(0x3f);
	sig.append(0x84);
	sig.append(0x9c);
	sig.append(0xf5);
	sig.append(0x4f);
	sig.append(0x5d);
	sig.append(0xc6);
	sig.append(0x62);
	sig.append(0x2b);
	sig.append(0xaa);
	sig.append(0xf2);
	sig.append(0x24);
	sig.append(0x47);
	sig.append(0x73);
	sig.append(0xab);
	sig.append(0x73);
	sig.append(0xa5);
	sig.append(0x78);
	sig.append(0x41);
	sig.append(0x5a);
	sig.append(0x92);
	sig.append(0x29);
	sig.append(0x84);
	sig.append(0xe);
	sig.append(0xe4);
	sig.append(0x18);
	sig.append(0xce);
	sig.append(0x2b);
	sig.append(0xc9);
	let pk = PublicKey {
		 x: 85613799190260658706910303252152225425882372163420339564113020909142670415810, 
		 y: 101735355672580552088256724034814701870625703907211681096747008925053272654651
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
fn test_verify_signature_6(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x9d);
	hash.append(0x64);
	hash.append(0x59);
	hash.append(0x9b);
	hash.append(0x28);
	hash.append(0x23);
	hash.append(0x4f);
	hash.append(0x2c);
	hash.append(0x8f);
	hash.append(0xf2);
	hash.append(0xfc);
	hash.append(0xcf);
	hash.append(0x4d);
	hash.append(0x92);
	hash.append(0x4);
	hash.append(0x4);
	hash.append(0x9);
	hash.append(0xbc);
	hash.append(0x93);
	hash.append(0xc6);
	hash.append(0xcf);
	hash.append(0x96);
	hash.append(0x1e);
	hash.append(0x95);
	hash.append(0xc1);
	hash.append(0x44);
	hash.append(0xab);
	hash.append(0xd9);
	hash.append(0x6f);
	hash.append(0xb2);
	hash.append(0x93);
	hash.append(0x39);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xe8);
	auth_data.append(0x19);
	auth_data.append(0x2b);
	auth_data.append(0x8d);
	auth_data.append(0xe4);
	auth_data.append(0xba);
	auth_data.append(0x2c);
	auth_data.append(0x6d);
	auth_data.append(0xea);
	auth_data.append(0x12);
	auth_data.append(0x98);
	auth_data.append(0xc3);
	auth_data.append(0x2a);
	auth_data.append(0x40);
	auth_data.append(0x4e);
	auth_data.append(0xa9);
	auth_data.append(0x98);
	auth_data.append(0xbd);
	auth_data.append(0xb5);
	auth_data.append(0x98);
	auth_data.append(0xbc);
	auth_data.append(0xdc);
	auth_data.append(0x98);
	auth_data.append(0x18);
	auth_data.append(0xce);
	auth_data.append(0xa2);
	auth_data.append(0xf8);
	auth_data.append(0xa7);
	auth_data.append(0xa7);
	auth_data.append(0x19);
	auth_data.append(0x4e);
	auth_data.append(0xf);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x97);
	sig.append(0xd0);
	sig.append(0x25);
	sig.append(0x3d);
	sig.append(0xcb);
	sig.append(0x8d);
	sig.append(0xae);
	sig.append(0x7a);
	sig.append(0xb7);
	sig.append(0x6f);
	sig.append(0xa1);
	sig.append(0xe9);
	sig.append(0x54);
	sig.append(0xda);
	sig.append(0xdc);
	sig.append(0xdd);
	sig.append(0x76);
	sig.append(0xe7);
	sig.append(0xd7);
	sig.append(0xa3);
	sig.append(0xf1);
	sig.append(0x93);
	sig.append(0xd3);
	sig.append(0x9c);
	sig.append(0x39);
	sig.append(0x6f);
	sig.append(0x46);
	sig.append(0x9c);
	sig.append(0xb2);
	sig.append(0x5a);
	sig.append(0xa6);
	sig.append(0xec);
	sig.append(0xc9);
	sig.append(0xa3);
	sig.append(0xa);
	sig.append(0x4a);
	sig.append(0xd7);
	sig.append(0x48);
	sig.append(0x77);
	sig.append(0xf8);
	sig.append(0x9);
	sig.append(0x55);
	sig.append(0x81);
	sig.append(0x49);
	sig.append(0xf2);
	sig.append(0xed);
	sig.append(0x5c);
	sig.append(0x7a);
	sig.append(0x3b);
	sig.append(0x33);
	sig.append(0x0);
	sig.append(0xb5);
	sig.append(0x93);
	sig.append(0xbe);
	sig.append(0x38);
	sig.append(0x3a);
	sig.append(0xc2);
	sig.append(0xd);
	sig.append(0x66);
	sig.append(0x6d);
	sig.append(0xf6);
	sig.append(0x18);
	sig.append(0xf4);
	sig.append(0x89);
	let pk = PublicKey {
		 x: 5755258511248638689420965828034010948494645619045539066970102195962134239476, 
		 y: 28923365995199094647801021390300644491388688075903851599336158832327142137821
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
fn test_verify_signature_7(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x2a);
	hash.append(0xa0);
	hash.append(0xcb);
	hash.append(0x31);
	hash.append(0xe1);
	hash.append(0x53);
	hash.append(0xf2);
	hash.append(0x20);
	hash.append(0x35);
	hash.append(0x27);
	hash.append(0x2f);
	hash.append(0xa9);
	hash.append(0x97);
	hash.append(0x62);
	hash.append(0xc3);
	hash.append(0x78);
	hash.append(0x4b);
	hash.append(0x91);
	hash.append(0x65);
	hash.append(0x23);
	hash.append(0xde);
	hash.append(0xd6);
	hash.append(0x21);
	hash.append(0x2b);
	hash.append(0x79);
	hash.append(0xe9);
	hash.append(0xaa);
	hash.append(0x22);
	hash.append(0xb3);
	hash.append(0x73);
	hash.append(0xd);
	hash.append(0xc6);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x51);
	auth_data.append(0x9);
	auth_data.append(0xef);
	auth_data.append(0x31);
	auth_data.append(0x3);
	auth_data.append(0x18);
	auth_data.append(0x9);
	auth_data.append(0x31);
	auth_data.append(0xd9);
	auth_data.append(0x76);
	auth_data.append(0x27);
	auth_data.append(0x19);
	auth_data.append(0x69);
	auth_data.append(0x4e);
	auth_data.append(0xef);
	auth_data.append(0x91);
	auth_data.append(0x58);
	auth_data.append(0x63);
	auth_data.append(0x3);
	auth_data.append(0x24);
	auth_data.append(0x3d);
	auth_data.append(0xbc);
	auth_data.append(0xad);
	auth_data.append(0xf5);
	auth_data.append(0x44);
	auth_data.append(0xc7);
	auth_data.append(0xce);
	auth_data.append(0xe4);
	auth_data.append(0x77);
	auth_data.append(0xd8);
	auth_data.append(0x8a);
	auth_data.append(0x37);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x37);
	sig.append(0x2);
	sig.append(0x78);
	sig.append(0x53);
	sig.append(0xdc);
	sig.append(0x40);
	sig.append(0xd5);
	sig.append(0x2);
	sig.append(0x7);
	sig.append(0x26);
	sig.append(0xee);
	sig.append(0x3);
	sig.append(0x4e);
	sig.append(0x5f);
	sig.append(0x71);
	sig.append(0xe);
	sig.append(0xb5);
	sig.append(0xcf);
	sig.append(0xa0);
	sig.append(0xef);
	sig.append(0x96);
	sig.append(0x9);
	sig.append(0x26);
	sig.append(0x16);
	sig.append(0x66);
	sig.append(0xa5);
	sig.append(0x27);
	sig.append(0x6a);
	sig.append(0xf5);
	sig.append(0x41);
	sig.append(0x64);
	sig.append(0x87);
	sig.append(0x7a);
	sig.append(0x28);
	sig.append(0xe1);
	sig.append(0x40);
	sig.append(0x1a);
	sig.append(0xaa);
	sig.append(0x2a);
	sig.append(0xce);
	sig.append(0x37);
	sig.append(0xf9);
	sig.append(0xe4);
	sig.append(0x81);
	sig.append(0x78);
	sig.append(0xe3);
	sig.append(0xa1);
	sig.append(0xfc);
	sig.append(0xf8);
	sig.append(0x1b);
	sig.append(0xe);
	sig.append(0x60);
	sig.append(0x96);
	sig.append(0xcf);
	sig.append(0x55);
	sig.append(0x90);
	sig.append(0x27);
	sig.append(0x58);
	sig.append(0xf3);
	sig.append(0xf3);
	sig.append(0xcb);
	sig.append(0xeb);
	sig.append(0x8b);
	sig.append(0x3d);
	let pk = PublicKey {
		 x: 84921403539172404232560320094077163049336774648977961283286371283981789976063, 
		 y: 92256833845322922666559987582181529319034004455225924813526589384899529340777
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
fn test_verify_signature_8(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0x7f);
	hash.append(0x38);
	hash.append(0xb4);
	hash.append(0x34);
	hash.append(0x90);
	hash.append(0x41);
	hash.append(0x66);
	hash.append(0xb5);
	hash.append(0x6a);
	hash.append(0x1d);
	hash.append(0x88);
	hash.append(0x38);
	hash.append(0x42);
	hash.append(0x73);
	hash.append(0x8a);
	hash.append(0x2c);
	hash.append(0xc3);
	hash.append(0xa0);
	hash.append(0x83);
	hash.append(0xe7);
	hash.append(0xe9);
	hash.append(0x79);
	hash.append(0xda);
	hash.append(0xf8);
	hash.append(0x78);
	hash.append(0xb1);
	hash.append(0x3b);
	hash.append(0xed);
	hash.append(0x24);
	hash.append(0xc3);
	hash.append(0x7f);
	hash.append(0xf5);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x1e);
	auth_data.append(0x98);
	auth_data.append(0xd2);
	auth_data.append(0x33);
	auth_data.append(0xa1);
	auth_data.append(0x63);
	auth_data.append(0x1a);
	auth_data.append(0x89);
	auth_data.append(0x1a);
	auth_data.append(0xc9);
	auth_data.append(0x79);
	auth_data.append(0xb8);
	auth_data.append(0xfd);
	auth_data.append(0x4e);
	auth_data.append(0x42);
	auth_data.append(0x3);
	auth_data.append(0xa);
	auth_data.append(0x18);
	auth_data.append(0xb7);
	auth_data.append(0xbf);
	auth_data.append(0x1a);
	auth_data.append(0x7a);
	auth_data.append(0x8e);
	auth_data.append(0xfe);
	auth_data.append(0x5f);
	auth_data.append(0x66);
	auth_data.append(0xea);
	auth_data.append(0x1d);
	auth_data.append(0xc1);
	auth_data.append(0x9d);
	auth_data.append(0xdf);
	auth_data.append(0x7d);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xc2);
	sig.append(0xb);
	sig.append(0xcd);
	sig.append(0x78);
	sig.append(0x41);
	sig.append(0x8b);
	sig.append(0x83);
	sig.append(0xca);
	sig.append(0xe1);
	sig.append(0x86);
	sig.append(0xec);
	sig.append(0x15);
	sig.append(0xef);
	sig.append(0xe3);
	sig.append(0x2a);
	sig.append(0x7c);
	sig.append(0x59);
	sig.append(0xc5);
	sig.append(0xf);
	sig.append(0x6b);
	sig.append(0x2);
	sig.append(0xc1);
	sig.append(0x70);
	sig.append(0x87);
	sig.append(0xa6);
	sig.append(0x6);
	sig.append(0xd6);
	sig.append(0x8f);
	sig.append(0x7b);
	sig.append(0xad);
	sig.append(0xb8);
	sig.append(0x75);
	sig.append(0x6a);
	sig.append(0x86);
	sig.append(0x1d);
	sig.append(0x80);
	sig.append(0xe1);
	sig.append(0x59);
	sig.append(0xf9);
	sig.append(0x98);
	sig.append(0x76);
	sig.append(0xa8);
	sig.append(0x88);
	sig.append(0x20);
	sig.append(0x8e);
	sig.append(0x4c);
	sig.append(0xc1);
	sig.append(0x5a);
	sig.append(0xef);
	sig.append(0x9e);
	sig.append(0x57);
	sig.append(0x79);
	sig.append(0xe6);
	sig.append(0xc7);
	sig.append(0x74);
	sig.append(0x48);
	sig.append(0xe8);
	sig.append(0xe8);
	sig.append(0x77);
	sig.append(0x9c);
	sig.append(0x10);
	sig.append(0x57);
	sig.append(0x15);
	sig.append(0x21);
	let pk = PublicKey {
		 x: 74683992930966683998387216636412701700996759281844582379786260639013945170740, 
		 y: 96543099427722615111260233779493754400662563420005014209545535677794676813600
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
fn test_verify_signature_9(){
	let mut hash: Array<u8> = ArrayTrait::new();
	hash.append(0xa5);
	hash.append(0x0);
	hash.append(0xb);
	hash.append(0x5d);
	hash.append(0x46);
	hash.append(0xc0);
	hash.append(0x9e);
	hash.append(0x1c);
	hash.append(0x10);
	hash.append(0x71);
	hash.append(0x43);
	hash.append(0x45);
	hash.append(0x9f);
	hash.append(0x7);
	hash.append(0xd2);
	hash.append(0xd0);
	hash.append(0xf1);
	hash.append(0xfe);
	hash.append(0xc3);
	hash.append(0x7a);
	hash.append(0x14);
	hash.append(0xb3);
	hash.append(0x3c);
	hash.append(0x34);
	hash.append(0xed);
	hash.append(0x45);
	hash.append(0xc6);
	hash.append(0xc2);
	hash.append(0xae);
	hash.append(0x34);
	hash.append(0x88);
	hash.append(0x7c);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xb7);
	auth_data.append(0xea);
	auth_data.append(0x57);
	auth_data.append(0xd0);
	auth_data.append(0x21);
	auth_data.append(0xf7);
	auth_data.append(0x1e);
	auth_data.append(0xb1);
	auth_data.append(0xa1);
	auth_data.append(0x63);
	auth_data.append(0xeb);
	auth_data.append(0x83);
	auth_data.append(0x62);
	auth_data.append(0x81);
	auth_data.append(0x40);
	auth_data.append(0xbb);
	auth_data.append(0x62);
	auth_data.append(0xe);
	auth_data.append(0xca);
	auth_data.append(0xfe);
	auth_data.append(0xd1);
	auth_data.append(0x95);
	auth_data.append(0x3e);
	auth_data.append(0x63);
	auth_data.append(0xd1);
	auth_data.append(0x21);
	auth_data.append(0x45);
	auth_data.append(0x8a);
	auth_data.append(0xfa);
	auth_data.append(0x9d);
	auth_data.append(0xdf);
	auth_data.append(0xf6);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xfc);
	sig.append(0x8d);
	sig.append(0x72);
	sig.append(0xdf);
	sig.append(0x91);
	sig.append(0x25);
	sig.append(0x76);
	sig.append(0x84);
	sig.append(0x71);
	sig.append(0x5c);
	sig.append(0x38);
	sig.append(0x8);
	sig.append(0x20);
	sig.append(0x82);
	sig.append(0x5b);
	sig.append(0x10);
	sig.append(0x54);
	sig.append(0xc8);
	sig.append(0xb2);
	sig.append(0xa1);
	sig.append(0x56);
	sig.append(0x96);
	sig.append(0x4c);
	sig.append(0x1a);
	sig.append(0xa9);
	sig.append(0xf0);
	sig.append(0x77);
	sig.append(0x56);
	sig.append(0xe4);
	sig.append(0x56);
	sig.append(0x6a);
	sig.append(0x90);
	sig.append(0xd4);
	sig.append(0x2c);
	sig.append(0x49);
	sig.append(0x96);
	sig.append(0xcb);
	sig.append(0xba);
	sig.append(0x39);
	sig.append(0xc1);
	sig.append(0x4d);
	sig.append(0xdd);
	sig.append(0xf2);
	sig.append(0x6d);
	sig.append(0xd2);
	sig.append(0x3d);
	sig.append(0xb1);
	sig.append(0x2d);
	sig.append(0x19);
	sig.append(0x6);
	sig.append(0x20);
	sig.append(0xd6);
	sig.append(0x70);
	sig.append(0xb5);
	sig.append(0x3f);
	sig.append(0xc8);
	sig.append(0x39);
	sig.append(0x69);
	sig.append(0xa6);
	sig.append(0x6e);
	sig.append(0xda);
	sig.append(0x9);
	sig.append(0xc9);
	sig.append(0x5b);
	let pk = PublicKey {
		 x: 41656983325288801647553067648466043740822485314398469028591075951756655256956, 
		 y: 44505064739510410951869968442597945824639178385789686713062044478505434029496
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


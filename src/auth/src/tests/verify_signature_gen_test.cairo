// This file is script-generated.
// Don't modify it manually!
// See /test_gen_scripts/auth/verify_signature_test.py for details
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
	hash.append(0x26);
	hash.append(0x0);
	hash.append(0x61);
	hash.append(0xbb);
	hash.append(0x79);
	hash.append(0x81);
	hash.append(0x77);
	hash.append(0x93);
	hash.append(0x2a);
	hash.append(0x1d);
	hash.append(0xef);
	hash.append(0x7c);
	hash.append(0x8c);
	hash.append(0xa5);
	hash.append(0xb);
	hash.append(0x5a);
	hash.append(0x91);
	hash.append(0x3b);
	hash.append(0x5d);
	hash.append(0x26);
	hash.append(0xc8);
	hash.append(0x1a);
	hash.append(0x97);
	hash.append(0xca);
	hash.append(0x6b);
	hash.append(0xba);
	hash.append(0x62);
	hash.append(0x68);
	hash.append(0x68);
	hash.append(0x64);
	hash.append(0x7f);
	hash.append(0x52);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xc7);
	auth_data.append(0xf5);
	auth_data.append(0x20);
	auth_data.append(0x24);
	auth_data.append(0xf5);
	auth_data.append(0xeb);
	auth_data.append(0x97);
	auth_data.append(0x7d);
	auth_data.append(0x71);
	auth_data.append(0x42);
	auth_data.append(0x8f);
	auth_data.append(0x6b);
	auth_data.append(0x81);
	auth_data.append(0x2b);
	auth_data.append(0x5c);
	auth_data.append(0x68);
	auth_data.append(0xfb);
	auth_data.append(0xb0);
	auth_data.append(0x48);
	auth_data.append(0xd);
	auth_data.append(0x69);
	auth_data.append(0xf2);
	auth_data.append(0x5);
	auth_data.append(0x28);
	auth_data.append(0xdc);
	auth_data.append(0x5c);
	auth_data.append(0xb3);
	auth_data.append(0xf7);
	auth_data.append(0x2d);
	auth_data.append(0xe6);
	auth_data.append(0x85);
	auth_data.append(0x2f);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa6);
	sig.append(0xcc);
	sig.append(0x52);
	sig.append(0x8b);
	sig.append(0x34);
	sig.append(0x33);
	sig.append(0xe3);
	sig.append(0x86);
	sig.append(0xa9);
	sig.append(0x40);
	sig.append(0x7c);
	sig.append(0x2a);
	sig.append(0x16);
	sig.append(0x9a);
	sig.append(0x5);
	sig.append(0x62);
	sig.append(0x66);
	sig.append(0x64);
	sig.append(0x3d);
	sig.append(0x4a);
	sig.append(0xc9);
	sig.append(0x1f);
	sig.append(0xba);
	sig.append(0xc4);
	sig.append(0xf5);
	sig.append(0xb7);
	sig.append(0x17);
	sig.append(0xfa);
	sig.append(0x26);
	sig.append(0x90);
	sig.append(0x8c);
	sig.append(0x94);
	sig.append(0xd8);
	sig.append(0xc3);
	sig.append(0x63);
	sig.append(0x1d);
	sig.append(0x5);
	sig.append(0xda);
	sig.append(0x3a);
	sig.append(0x21);
	sig.append(0x99);
	sig.append(0xad);
	sig.append(0x16);
	sig.append(0x6b);
	sig.append(0xa2);
	sig.append(0x30);
	sig.append(0x96);
	sig.append(0xe6);
	sig.append(0x44);
	sig.append(0xb2);
	sig.append(0xc4);
	sig.append(0x45);
	sig.append(0xd2);
	sig.append(0xb6);
	sig.append(0xb8);
	sig.append(0x39);
	sig.append(0x83);
	sig.append(0x69);
	sig.append(0xaf);
	sig.append(0x66);
	sig.append(0x69);
	sig.append(0xec);
	sig.append(0xf2);
	sig.append(0x64);
	let pk = PublicKey {
		 x: 63634380348196905368447035061790806935519102586515754102937176176028709350984, 
		 y: 81848896276987134416563049725524733317746560079440655273927041923893954444086
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
	hash.append(0xf7);
	hash.append(0x50);
	hash.append(0x3c);
	hash.append(0x77);
	hash.append(0x23);
	hash.append(0x46);
	hash.append(0x18);
	hash.append(0x4b);
	hash.append(0x42);
	hash.append(0xdc);
	hash.append(0x8);
	hash.append(0x67);
	hash.append(0xf0);
	hash.append(0xd6);
	hash.append(0xd5);
	hash.append(0x9a);
	hash.append(0xf0);
	hash.append(0xcf);
	hash.append(0x18);
	hash.append(0x96);
	hash.append(0x54);
	hash.append(0xba);
	hash.append(0xe7);
	hash.append(0xbb);
	hash.append(0x51);
	hash.append(0xc);
	hash.append(0xbe);
	hash.append(0x39);
	hash.append(0x3e);
	hash.append(0xf7);
	hash.append(0x6e);
	hash.append(0xaf);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xcf);
	auth_data.append(0xa3);
	auth_data.append(0xf0);
	auth_data.append(0xee);
	auth_data.append(0xa5);
	auth_data.append(0xc0);
	auth_data.append(0xa0);
	auth_data.append(0x4);
	auth_data.append(0xd);
	auth_data.append(0xc4);
	auth_data.append(0xbc);
	auth_data.append(0x3b);
	auth_data.append(0x6a);
	auth_data.append(0xf6);
	auth_data.append(0xa4);
	auth_data.append(0xb0);
	auth_data.append(0x7e);
	auth_data.append(0x24);
	auth_data.append(0x65);
	auth_data.append(0x90);
	auth_data.append(0x28);
	auth_data.append(0x2e);
	auth_data.append(0xc1);
	auth_data.append(0x88);
	auth_data.append(0xd7);
	auth_data.append(0xea);
	auth_data.append(0x7f);
	auth_data.append(0x5a);
	auth_data.append(0x10);
	auth_data.append(0xc8);
	auth_data.append(0x7a);
	auth_data.append(0x4c);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x5a);
	sig.append(0xf1);
	sig.append(0x86);
	sig.append(0x8e);
	sig.append(0x5);
	sig.append(0xda);
	sig.append(0x98);
	sig.append(0x0);
	sig.append(0x80);
	sig.append(0x8c);
	sig.append(0xb6);
	sig.append(0x56);
	sig.append(0x21);
	sig.append(0xf3);
	sig.append(0x0);
	sig.append(0xcb);
	sig.append(0x7b);
	sig.append(0xdf);
	sig.append(0xdc);
	sig.append(0x6e);
	sig.append(0xd);
	sig.append(0xe9);
	sig.append(0xe9);
	sig.append(0xa8);
	sig.append(0x47);
	sig.append(0x3f);
	sig.append(0x7b);
	sig.append(0xb);
	sig.append(0x5e);
	sig.append(0x9f);
	sig.append(0x5f);
	sig.append(0xac);
	sig.append(0x51);
	sig.append(0x23);
	sig.append(0x7c);
	sig.append(0x7f);
	sig.append(0x28);
	sig.append(0x73);
	sig.append(0xa7);
	sig.append(0x23);
	sig.append(0xec);
	sig.append(0xd9);
	sig.append(0xfc);
	sig.append(0xc7);
	sig.append(0xb);
	sig.append(0x78);
	sig.append(0x67);
	sig.append(0x88);
	sig.append(0x26);
	sig.append(0xa2);
	sig.append(0xc);
	sig.append(0x88);
	sig.append(0x73);
	sig.append(0xf4);
	sig.append(0xfc);
	sig.append(0x5);
	sig.append(0x95);
	sig.append(0x64);
	sig.append(0x5e);
	sig.append(0x1a);
	sig.append(0xd6);
	sig.append(0xe6);
	sig.append(0x5a);
	sig.append(0x34);
	let pk = PublicKey {
		 x: 64796833686827846317269676932831936019638405695310542330020646971095835273533, 
		 y: 73465353155845902903393283514601278868126642162294938414937683932768356907119
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
	hash.append(0x41);
	hash.append(0xdd);
	hash.append(0x61);
	hash.append(0x18);
	hash.append(0x31);
	hash.append(0xe);
	hash.append(0xfc);
	hash.append(0x36);
	hash.append(0x3f);
	hash.append(0x66);
	hash.append(0xe2);
	hash.append(0x53);
	hash.append(0x8f);
	hash.append(0x11);
	hash.append(0x39);
	hash.append(0x4c);
	hash.append(0x7f);
	hash.append(0x77);
	hash.append(0x96);
	hash.append(0xc3);
	hash.append(0xf4);
	hash.append(0xd6);
	hash.append(0xf7);
	hash.append(0x8d);
	hash.append(0x54);
	hash.append(0x11);
	hash.append(0x23);
	hash.append(0x3d);
	hash.append(0xe9);
	hash.append(0x41);
	hash.append(0x76);
	hash.append(0xaf);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x38);
	auth_data.append(0xef);
	auth_data.append(0x46);
	auth_data.append(0xd7);
	auth_data.append(0x62);
	auth_data.append(0x87);
	auth_data.append(0x96);
	auth_data.append(0xfc);
	auth_data.append(0x0);
	auth_data.append(0xa8);
	auth_data.append(0x3b);
	auth_data.append(0xf4);
	auth_data.append(0x92);
	auth_data.append(0x96);
	auth_data.append(0x76);
	auth_data.append(0x1c);
	auth_data.append(0x26);
	auth_data.append(0x4b);
	auth_data.append(0xae);
	auth_data.append(0x21);
	auth_data.append(0x1b);
	auth_data.append(0x6f);
	auth_data.append(0xa3);
	auth_data.append(0xec);
	auth_data.append(0xce);
	auth_data.append(0x98);
	auth_data.append(0xdb);
	auth_data.append(0xb8);
	auth_data.append(0xc4);
	auth_data.append(0x6a);
	auth_data.append(0x76);
	auth_data.append(0x37);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x8);
	sig.append(0x11);
	sig.append(0x3d);
	sig.append(0x13);
	sig.append(0xa2);
	sig.append(0x6e);
	sig.append(0x31);
	sig.append(0xb3);
	sig.append(0xae);
	sig.append(0xaa);
	sig.append(0xd);
	sig.append(0xb2);
	sig.append(0x29);
	sig.append(0x90);
	sig.append(0x0);
	sig.append(0x4f);
	sig.append(0x27);
	sig.append(0x23);
	sig.append(0x82);
	sig.append(0x34);
	sig.append(0xe5);
	sig.append(0x8b);
	sig.append(0xfd);
	sig.append(0x18);
	sig.append(0xab);
	sig.append(0x7b);
	sig.append(0x92);
	sig.append(0xfd);
	sig.append(0x4e);
	sig.append(0xa3);
	sig.append(0xbf);
	sig.append(0x5c);
	sig.append(0xba);
	sig.append(0x93);
	sig.append(0x5d);
	sig.append(0x17);
	sig.append(0xcc);
	sig.append(0x10);
	sig.append(0xc8);
	sig.append(0x3d);
	sig.append(0x42);
	sig.append(0x65);
	sig.append(0xa8);
	sig.append(0x45);
	sig.append(0xae);
	sig.append(0xc5);
	sig.append(0x88);
	sig.append(0x91);
	sig.append(0xf8);
	sig.append(0x57);
	sig.append(0x38);
	sig.append(0xa7);
	sig.append(0x3b);
	sig.append(0xf2);
	sig.append(0x8b);
	sig.append(0x19);
	sig.append(0xcc);
	sig.append(0x85);
	sig.append(0xfa);
	sig.append(0x9c);
	sig.append(0x9c);
	sig.append(0x3f);
	sig.append(0x2b);
	sig.append(0xb4);
	let pk = PublicKey {
		 x: 35890058869247617881269912636222177362118998189137205690204260035077316755745, 
		 y: 47652217851261425558870259747308480514516122439102638923342319735449553673959
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
	hash.append(0x32);
	hash.append(0x84);
	hash.append(0x3e);
	hash.append(0xd5);
	hash.append(0xa8);
	hash.append(0xff);
	hash.append(0x19);
	hash.append(0xfd);
	hash.append(0xa9);
	hash.append(0x34);
	hash.append(0xd0);
	hash.append(0x62);
	hash.append(0x21);
	hash.append(0x3c);
	hash.append(0xeb);
	hash.append(0x95);
	hash.append(0xd5);
	hash.append(0x1d);
	hash.append(0x53);
	hash.append(0x22);
	hash.append(0xe4);
	hash.append(0x69);
	hash.append(0xf);
	hash.append(0x8c);
	hash.append(0x2);
	hash.append(0xdf);
	hash.append(0x99);
	hash.append(0x5d);
	hash.append(0xe9);
	hash.append(0xff);
	hash.append(0x83);
	hash.append(0x4d);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xd4);
	auth_data.append(0xa4);
	auth_data.append(0xb8);
	auth_data.append(0x23);
	auth_data.append(0x8f);
	auth_data.append(0xb7);
	auth_data.append(0x7d);
	auth_data.append(0xf2);
	auth_data.append(0x1e);
	auth_data.append(0x22);
	auth_data.append(0x52);
	auth_data.append(0x81);
	auth_data.append(0x6d);
	auth_data.append(0xa2);
	auth_data.append(0x28);
	auth_data.append(0xf);
	auth_data.append(0x1b);
	auth_data.append(0x29);
	auth_data.append(0x1c);
	auth_data.append(0x9a);
	auth_data.append(0x2e);
	auth_data.append(0xc7);
	auth_data.append(0x40);
	auth_data.append(0xa7);
	auth_data.append(0xf7);
	auth_data.append(0xb7);
	auth_data.append(0x29);
	auth_data.append(0xcd);
	auth_data.append(0xe3);
	auth_data.append(0x1);
	auth_data.append(0xac);
	auth_data.append(0x76);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x35);
	sig.append(0x26);
	sig.append(0x5e);
	sig.append(0x61);
	sig.append(0xac);
	sig.append(0xc7);
	sig.append(0x98);
	sig.append(0xaa);
	sig.append(0x8f);
	sig.append(0x25);
	sig.append(0xca);
	sig.append(0xf4);
	sig.append(0x20);
	sig.append(0xa1);
	sig.append(0xe7);
	sig.append(0xe7);
	sig.append(0xaf);
	sig.append(0x8b);
	sig.append(0x43);
	sig.append(0x9c);
	sig.append(0xb9);
	sig.append(0x4b);
	sig.append(0x7c);
	sig.append(0x5a);
	sig.append(0xdc);
	sig.append(0xbf);
	sig.append(0x65);
	sig.append(0x3d);
	sig.append(0x8a);
	sig.append(0xb7);
	sig.append(0xd0);
	sig.append(0x4a);
	sig.append(0xa6);
	sig.append(0x84);
	sig.append(0xb0);
	sig.append(0xee);
	sig.append(0xb9);
	sig.append(0xec);
	sig.append(0x1b);
	sig.append(0xcd);
	sig.append(0xdd);
	sig.append(0x20);
	sig.append(0xb);
	sig.append(0xdc);
	sig.append(0xf0);
	sig.append(0x1a);
	sig.append(0xff);
	sig.append(0xee);
	sig.append(0xe4);
	sig.append(0xf4);
	sig.append(0x90);
	sig.append(0xcd);
	sig.append(0x19);
	sig.append(0x3c);
	sig.append(0x42);
	sig.append(0x6a);
	sig.append(0x6b);
	sig.append(0x7a);
	sig.append(0x92);
	sig.append(0x82);
	sig.append(0x20);
	sig.append(0x41);
	sig.append(0xef);
	sig.append(0x2b);
	let pk = PublicKey {
		 x: 74537231597568328847293614707589805658246399849982024553032126767663683581276, 
		 y: 86896028191228466904234299190813447531504709866927481571338666511137827023261
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
	hash.append(0xc7);
	hash.append(0xb6);
	hash.append(0x92);
	hash.append(0xd8);
	hash.append(0xc8);
	hash.append(0xba);
	hash.append(0x60);
	hash.append(0xd6);
	hash.append(0x96);
	hash.append(0xf1);
	hash.append(0xe5);
	hash.append(0xaf);
	hash.append(0xa0);
	hash.append(0xe1);
	hash.append(0xb7);
	hash.append(0xbd);
	hash.append(0xc1);
	hash.append(0x36);
	hash.append(0xc5);
	hash.append(0xb7);
	hash.append(0xad);
	hash.append(0xb7);
	hash.append(0x47);
	hash.append(0x1);
	hash.append(0x66);
	hash.append(0x5e);
	hash.append(0xce);
	hash.append(0xaf);
	hash.append(0x89);
	hash.append(0x89);
	hash.append(0x55);
	hash.append(0x5e);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x18);
	auth_data.append(0x62);
	auth_data.append(0x52);
	auth_data.append(0xfa);
	auth_data.append(0x29);
	auth_data.append(0x5b);
	auth_data.append(0xab);
	auth_data.append(0x4f);
	auth_data.append(0x2d);
	auth_data.append(0x54);
	auth_data.append(0xd5);
	auth_data.append(0x72);
	auth_data.append(0x95);
	auth_data.append(0xef);
	auth_data.append(0x55);
	auth_data.append(0x1a);
	auth_data.append(0x33);
	auth_data.append(0xc0);
	auth_data.append(0xa1);
	auth_data.append(0x68);
	auth_data.append(0xd3);
	auth_data.append(0x69);
	auth_data.append(0x65);
	auth_data.append(0xad);
	auth_data.append(0x6a);
	auth_data.append(0xe8);
	auth_data.append(0x3e);
	auth_data.append(0xf1);
	auth_data.append(0x58);
	auth_data.append(0xf);
	auth_data.append(0x9e);
	auth_data.append(0xca);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xe0);
	sig.append(0x65);
	sig.append(0x0);
	sig.append(0xb4);
	sig.append(0xb1);
	sig.append(0xfa);
	sig.append(0xe9);
	sig.append(0x6f);
	sig.append(0x5f);
	sig.append(0x67);
	sig.append(0xe5);
	sig.append(0x8d);
	sig.append(0x6a);
	sig.append(0xd1);
	sig.append(0x62);
	sig.append(0xff);
	sig.append(0xed);
	sig.append(0xf8);
	sig.append(0xe7);
	sig.append(0x8f);
	sig.append(0x6b);
	sig.append(0xb9);
	sig.append(0x8);
	sig.append(0x1b);
	sig.append(0xb);
	sig.append(0xff);
	sig.append(0x88);
	sig.append(0x2a);
	sig.append(0xa0);
	sig.append(0x84);
	sig.append(0x1c);
	sig.append(0xf7);
	sig.append(0x5c);
	sig.append(0x4e);
	sig.append(0xa);
	sig.append(0xb2);
	sig.append(0x42);
	sig.append(0x4b);
	sig.append(0x49);
	sig.append(0x54);
	sig.append(0xc9);
	sig.append(0x2a);
	sig.append(0x86);
	sig.append(0x8c);
	sig.append(0x27);
	sig.append(0xb8);
	sig.append(0xd5);
	sig.append(0xba);
	sig.append(0x41);
	sig.append(0x27);
	sig.append(0x61);
	sig.append(0x44);
	sig.append(0x1d);
	sig.append(0x32);
	sig.append(0x64);
	sig.append(0xf1);
	sig.append(0x8b);
	sig.append(0x42);
	sig.append(0xa3);
	sig.append(0xe6);
	sig.append(0xfe);
	sig.append(0xef);
	sig.append(0x84);
	sig.append(0xad);
	let pk = PublicKey {
		 x: 89072753940336879488859633594712241141384939420942838694991946028990382676059, 
		 y: 84204568989981390178058116933924346829435771692865569659820140571984665848211
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
	hash.append(0x0);
	hash.append(0xf);
	hash.append(0xc2);
	hash.append(0xc7);
	hash.append(0x78);
	hash.append(0xae);
	hash.append(0xf7);
	hash.append(0x89);
	hash.append(0x73);
	hash.append(0x40);
	hash.append(0xbe);
	hash.append(0x16);
	hash.append(0xb5);
	hash.append(0x47);
	hash.append(0xf9);
	hash.append(0x72);
	hash.append(0x83);
	hash.append(0xdc);
	hash.append(0xa6);
	hash.append(0x4c);
	hash.append(0xfd);
	hash.append(0x99);
	hash.append(0x7);
	hash.append(0x3);
	hash.append(0x49);
	hash.append(0xdc);
	hash.append(0x14);
	hash.append(0x1a);
	hash.append(0x2e);
	hash.append(0x6a);
	hash.append(0xb5);
	hash.append(0xa5);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x65);
	auth_data.append(0xba);
	auth_data.append(0x2a);
	auth_data.append(0x6f);
	auth_data.append(0x39);
	auth_data.append(0x84);
	auth_data.append(0x30);
	auth_data.append(0xbd);
	auth_data.append(0x5a);
	auth_data.append(0xec);
	auth_data.append(0x29);
	auth_data.append(0x6);
	auth_data.append(0x95);
	auth_data.append(0xbb);
	auth_data.append(0x41);
	auth_data.append(0xb);
	auth_data.append(0x46);
	auth_data.append(0x2d);
	auth_data.append(0xf1);
	auth_data.append(0x54);
	auth_data.append(0xa);
	auth_data.append(0x60);
	auth_data.append(0xd9);
	auth_data.append(0xb);
	auth_data.append(0x7);
	auth_data.append(0xdf);
	auth_data.append(0x49);
	auth_data.append(0x6c);
	auth_data.append(0x5f);
	auth_data.append(0xe6);
	auth_data.append(0x79);
	auth_data.append(0x32);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x1e);
	sig.append(0x4e);
	sig.append(0xd2);
	sig.append(0x88);
	sig.append(0x7d);
	sig.append(0x7e);
	sig.append(0x26);
	sig.append(0x9f);
	sig.append(0x8c);
	sig.append(0xc3);
	sig.append(0xe4);
	sig.append(0x3b);
	sig.append(0x1b);
	sig.append(0xb3);
	sig.append(0xdf);
	sig.append(0x7c);
	sig.append(0xe8);
	sig.append(0x8);
	sig.append(0xdb);
	sig.append(0x56);
	sig.append(0x8);
	sig.append(0x22);
	sig.append(0x20);
	sig.append(0x8);
	sig.append(0x51);
	sig.append(0xf2);
	sig.append(0x88);
	sig.append(0x48);
	sig.append(0x92);
	sig.append(0x7c);
	sig.append(0x1c);
	sig.append(0xb3);
	sig.append(0xad);
	sig.append(0xcc);
	sig.append(0xe7);
	sig.append(0x3);
	sig.append(0x46);
	sig.append(0xb3);
	sig.append(0xe5);
	sig.append(0x9f);
	sig.append(0x76);
	sig.append(0xc6);
	sig.append(0xcc);
	sig.append(0x44);
	sig.append(0xf8);
	sig.append(0xf);
	sig.append(0x47);
	sig.append(0x5b);
	sig.append(0x87);
	sig.append(0x26);
	sig.append(0x3b);
	sig.append(0xfd);
	sig.append(0x53);
	sig.append(0xda);
	sig.append(0x8a);
	sig.append(0x77);
	sig.append(0xa1);
	sig.append(0x1);
	sig.append(0xac);
	sig.append(0xf1);
	sig.append(0xc8);
	sig.append(0x6e);
	sig.append(0xe7);
	sig.append(0xa2);
	let pk = PublicKey {
		 x: 86761229604724846081930545183612934884567847818880245374649082522615688430486, 
		 y: 115393888773339569304434853841038659829503774905079769773602880725329015828477
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
	hash.append(0x21);
	hash.append(0x5a);
	hash.append(0x71);
	hash.append(0xb);
	hash.append(0xf1);
	hash.append(0x6a);
	hash.append(0x80);
	hash.append(0x6a);
	hash.append(0x4f);
	hash.append(0xa7);
	hash.append(0xa6);
	hash.append(0xa1);
	hash.append(0xd);
	hash.append(0xfc);
	hash.append(0x83);
	hash.append(0xa5);
	hash.append(0xad);
	hash.append(0xb9);
	hash.append(0x83);
	hash.append(0xe2);
	hash.append(0x74);
	hash.append(0x40);
	hash.append(0xa);
	hash.append(0xc4);
	hash.append(0xf3);
	hash.append(0xd3);
	hash.append(0x7c);
	hash.append(0xa0);
	hash.append(0xe);
	hash.append(0x2f);
	hash.append(0x1b);
	hash.append(0xc9);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xab);
	auth_data.append(0xa5);
	auth_data.append(0xb0);
	auth_data.append(0x45);
	auth_data.append(0x6a);
	auth_data.append(0xd8);
	auth_data.append(0xdf);
	auth_data.append(0xe4);
	auth_data.append(0x50);
	auth_data.append(0x1a);
	auth_data.append(0xa6);
	auth_data.append(0xf5);
	auth_data.append(0xcf);
	auth_data.append(0xbf);
	auth_data.append(0xb3);
	auth_data.append(0xda);
	auth_data.append(0xbb);
	auth_data.append(0x83);
	auth_data.append(0xab);
	auth_data.append(0x5d);
	auth_data.append(0x9d);
	auth_data.append(0xea);
	auth_data.append(0x5c);
	auth_data.append(0xf9);
	auth_data.append(0xe3);
	auth_data.append(0x5b);
	auth_data.append(0x39);
	auth_data.append(0x10);
	auth_data.append(0x1b);
	auth_data.append(0x54);
	auth_data.append(0x90);
	auth_data.append(0xf9);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x4f);
	sig.append(0x42);
	sig.append(0xed);
	sig.append(0x3e);
	sig.append(0xd7);
	sig.append(0xf);
	sig.append(0x46);
	sig.append(0xc0);
	sig.append(0x66);
	sig.append(0x6a);
	sig.append(0xfb);
	sig.append(0x90);
	sig.append(0xb4);
	sig.append(0x27);
	sig.append(0x4);
	sig.append(0xbe);
	sig.append(0xf3);
	sig.append(0x75);
	sig.append(0xd9);
	sig.append(0x87);
	sig.append(0xf5);
	sig.append(0xac);
	sig.append(0xcf);
	sig.append(0x1b);
	sig.append(0x9e);
	sig.append(0x52);
	sig.append(0x29);
	sig.append(0xe4);
	sig.append(0x1c);
	sig.append(0x66);
	sig.append(0x1b);
	sig.append(0xed);
	sig.append(0x70);
	sig.append(0x2d);
	sig.append(0x77);
	sig.append(0xfa);
	sig.append(0x3e);
	sig.append(0x4c);
	sig.append(0x93);
	sig.append(0x4e);
	sig.append(0x63);
	sig.append(0xee);
	sig.append(0xfa);
	sig.append(0x65);
	sig.append(0x68);
	sig.append(0x2a);
	sig.append(0x21);
	sig.append(0x87);
	sig.append(0xed);
	sig.append(0x72);
	sig.append(0x51);
	sig.append(0xcf);
	sig.append(0x52);
	sig.append(0xb5);
	sig.append(0xd9);
	sig.append(0x9e);
	sig.append(0x9d);
	sig.append(0xd6);
	sig.append(0x7c);
	sig.append(0x72);
	sig.append(0xae);
	sig.append(0xf2);
	sig.append(0x60);
	sig.append(0xe1);
	let pk = PublicKey {
		 x: 1188885629372927224966817312963040849897431943845383513118997658748293025180, 
		 y: 72771478859448294838921638513635503268330803703525209618988238196991194920510
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
	hash.append(0xd5);
	hash.append(0x43);
	hash.append(0xf9);
	hash.append(0x56);
	hash.append(0x26);
	hash.append(0x53);
	hash.append(0xc);
	hash.append(0xea);
	hash.append(0xc9);
	hash.append(0xdf);
	hash.append(0x5a);
	hash.append(0x43);
	hash.append(0x48);
	hash.append(0x18);
	hash.append(0xe9);
	hash.append(0xc8);
	hash.append(0xdb);
	hash.append(0xc4);
	hash.append(0x7b);
	hash.append(0xf7);
	hash.append(0x85);
	hash.append(0xb4);
	hash.append(0x45);
	hash.append(0x2d);
	hash.append(0xf);
	hash.append(0xe1);
	hash.append(0xb2);
	hash.append(0x52);
	hash.append(0x33);
	hash.append(0x70);
	hash.append(0x86);
	hash.append(0xda);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x21);
	auth_data.append(0x8a);
	auth_data.append(0x7f);
	auth_data.append(0x6b);
	auth_data.append(0xdd);
	auth_data.append(0x3a);
	auth_data.append(0xe8);
	auth_data.append(0x7);
	auth_data.append(0xd7);
	auth_data.append(0x5d);
	auth_data.append(0xa6);
	auth_data.append(0x50);
	auth_data.append(0x55);
	auth_data.append(0x8f);
	auth_data.append(0x96);
	auth_data.append(0x4d);
	auth_data.append(0x53);
	auth_data.append(0x54);
	auth_data.append(0x36);
	auth_data.append(0x9c);
	auth_data.append(0xd4);
	auth_data.append(0x92);
	auth_data.append(0xcc);
	auth_data.append(0x77);
	auth_data.append(0x82);
	auth_data.append(0x3);
	auth_data.append(0x61);
	auth_data.append(0xbb);
	auth_data.append(0x10);
	auth_data.append(0x64);
	auth_data.append(0xf1);
	auth_data.append(0xe1);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x21);
	sig.append(0xaf);
	sig.append(0x2f);
	sig.append(0x84);
	sig.append(0xd9);
	sig.append(0xae);
	sig.append(0xe6);
	sig.append(0xdc);
	sig.append(0xfc);
	sig.append(0xbf);
	sig.append(0x11);
	sig.append(0x66);
	sig.append(0x2);
	sig.append(0x8a);
	sig.append(0xc0);
	sig.append(0xb6);
	sig.append(0x7a);
	sig.append(0x5c);
	sig.append(0x75);
	sig.append(0x3a);
	sig.append(0x42);
	sig.append(0xf8);
	sig.append(0xbd);
	sig.append(0x1b);
	sig.append(0x53);
	sig.append(0x52);
	sig.append(0x93);
	sig.append(0x8);
	sig.append(0x73);
	sig.append(0xa5);
	sig.append(0x26);
	sig.append(0x1c);
	sig.append(0xd5);
	sig.append(0x19);
	sig.append(0xe3);
	sig.append(0x2);
	sig.append(0xdf);
	sig.append(0x78);
	sig.append(0xb8);
	sig.append(0xbd);
	sig.append(0xd9);
	sig.append(0x9);
	sig.append(0x36);
	sig.append(0xf3);
	sig.append(0xb0);
	sig.append(0x6d);
	sig.append(0xdf);
	sig.append(0x97);
	sig.append(0x95);
	sig.append(0xba);
	sig.append(0x4);
	sig.append(0xb1);
	sig.append(0xcd);
	sig.append(0xd5);
	sig.append(0x13);
	sig.append(0x43);
	sig.append(0xe4);
	sig.append(0x7d);
	sig.append(0xc8);
	sig.append(0xa7);
	sig.append(0x5f);
	sig.append(0x3d);
	sig.append(0x6d);
	sig.append(0x20);
	let pk = PublicKey {
		 x: 19131647795919582736007061720365606377248091196856535593835491258803900526358, 
		 y: 103913640551785844237202782570275920499315435962405747623915879858984958253613
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
	hash.append(0x80);
	hash.append(0xa2);
	hash.append(0x6d);
	hash.append(0xd1);
	hash.append(0x40);
	hash.append(0x7f);
	hash.append(0xf3);
	hash.append(0x91);
	hash.append(0x7);
	hash.append(0x4e);
	hash.append(0xb4);
	hash.append(0x3f);
	hash.append(0xf5);
	hash.append(0x21);
	hash.append(0xb6);
	hash.append(0x9d);
	hash.append(0xe5);
	hash.append(0x74);
	hash.append(0x3);
	hash.append(0xe);
	hash.append(0xba);
	hash.append(0xf8);
	hash.append(0x5e);
	hash.append(0x20);
	hash.append(0xda);
	hash.append(0x9c);
	hash.append(0x89);
	hash.append(0x62);
	hash.append(0xc);
	hash.append(0xce);
	hash.append(0xa9);
	hash.append(0xb2);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xab);
	auth_data.append(0x39);
	auth_data.append(0xc0);
	auth_data.append(0x64);
	auth_data.append(0x15);
	auth_data.append(0x27);
	auth_data.append(0x60);
	auth_data.append(0xe3);
	auth_data.append(0xcc);
	auth_data.append(0x53);
	auth_data.append(0xa0);
	auth_data.append(0x53);
	auth_data.append(0x7a);
	auth_data.append(0x3a);
	auth_data.append(0xde);
	auth_data.append(0x61);
	auth_data.append(0x8c);
	auth_data.append(0xd4);
	auth_data.append(0xc7);
	auth_data.append(0xf7);
	auth_data.append(0x9e);
	auth_data.append(0xf5);
	auth_data.append(0x4);
	auth_data.append(0xef);
	auth_data.append(0xaa);
	auth_data.append(0x62);
	auth_data.append(0x6d);
	auth_data.append(0xb9);
	auth_data.append(0x64);
	auth_data.append(0xa6);
	auth_data.append(0xe);
	auth_data.append(0x59);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa5);
	sig.append(0x95);
	sig.append(0x15);
	sig.append(0xdb);
	sig.append(0x5e);
	sig.append(0xdc);
	sig.append(0xc7);
	sig.append(0xe1);
	sig.append(0xa4);
	sig.append(0x57);
	sig.append(0x6d);
	sig.append(0x44);
	sig.append(0xc8);
	sig.append(0xcb);
	sig.append(0xd5);
	sig.append(0x95);
	sig.append(0x78);
	sig.append(0x4d);
	sig.append(0x53);
	sig.append(0x3);
	sig.append(0x5b);
	sig.append(0x60);
	sig.append(0xb3);
	sig.append(0x7a);
	sig.append(0xc7);
	sig.append(0x2f);
	sig.append(0x41);
	sig.append(0x77);
	sig.append(0x17);
	sig.append(0x7e);
	sig.append(0xc4);
	sig.append(0xe);
	sig.append(0xb7);
	sig.append(0xb);
	sig.append(0xff);
	sig.append(0x38);
	sig.append(0x6e);
	sig.append(0x97);
	sig.append(0xa);
	sig.append(0x38);
	sig.append(0x1b);
	sig.append(0xc3);
	sig.append(0x3d);
	sig.append(0x6);
	sig.append(0x6c);
	sig.append(0x87);
	sig.append(0xa0);
	sig.append(0x53);
	sig.append(0xc7);
	sig.append(0x8a);
	sig.append(0xf0);
	sig.append(0x63);
	sig.append(0x51);
	sig.append(0xf6);
	sig.append(0x75);
	sig.append(0x62);
	sig.append(0x7b);
	sig.append(0x88);
	sig.append(0xf6);
	sig.append(0xae);
	sig.append(0xb3);
	sig.append(0x6);
	sig.append(0xc7);
	sig.append(0x1c);
	let pk = PublicKey {
		 x: 50153201504276843273969449205708081161469463120921928077036660555692778846346, 
		 y: 28791933083319536407370403987440241026334502656803293090748003630448521266294
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
	hash.append(0x0);
	hash.append(0x6);
	hash.append(0x7d);
	hash.append(0x6d);
	hash.append(0x5d);
	hash.append(0x8f);
	hash.append(0x37);
	hash.append(0x7f);
	hash.append(0x43);
	hash.append(0x57);
	hash.append(0xfa);
	hash.append(0x49);
	hash.append(0x1d);
	hash.append(0xbc);
	hash.append(0xd4);
	hash.append(0x14);
	hash.append(0x98);
	hash.append(0xec);
	hash.append(0xd9);
	hash.append(0x81);
	hash.append(0x56);
	hash.append(0xf9);
	hash.append(0xcb);
	hash.append(0x6f);
	hash.append(0xec);
	hash.append(0x2e);
	hash.append(0x5c);
	hash.append(0x17);
	hash.append(0xda);
	hash.append(0xa2);
	hash.append(0xd5);
	hash.append(0x63);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x66);
	auth_data.append(0x8b);
	auth_data.append(0xf8);
	auth_data.append(0x78);
	auth_data.append(0x38);
	auth_data.append(0xed);
	auth_data.append(0x81);
	auth_data.append(0x76);
	auth_data.append(0x90);
	auth_data.append(0xc9);
	auth_data.append(0xcc);
	auth_data.append(0xce);
	auth_data.append(0x98);
	auth_data.append(0xaa);
	auth_data.append(0x5d);
	auth_data.append(0xf7);
	auth_data.append(0x85);
	auth_data.append(0x47);
	auth_data.append(0xfa);
	auth_data.append(0x97);
	auth_data.append(0x78);
	auth_data.append(0x20);
	auth_data.append(0xac);
	auth_data.append(0xae);
	auth_data.append(0x35);
	auth_data.append(0xe);
	auth_data.append(0xcb);
	auth_data.append(0xf0);
	auth_data.append(0xa6);
	auth_data.append(0xf5);
	auth_data.append(0x68);
	auth_data.append(0xcb);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xe2);
	sig.append(0xb0);
	sig.append(0x66);
	sig.append(0xc2);
	sig.append(0xd4);
	sig.append(0x20);
	sig.append(0xeb);
	sig.append(0xb2);
	sig.append(0x6);
	sig.append(0x7d);
	sig.append(0xc3);
	sig.append(0x19);
	sig.append(0x12);
	sig.append(0x11);
	sig.append(0xda);
	sig.append(0xb5);
	sig.append(0x40);
	sig.append(0x6e);
	sig.append(0xf3);
	sig.append(0xb9);
	sig.append(0x91);
	sig.append(0x30);
	sig.append(0x70);
	sig.append(0x3c);
	sig.append(0x40);
	sig.append(0x10);
	sig.append(0xc1);
	sig.append(0xe0);
	sig.append(0xa4);
	sig.append(0x26);
	sig.append(0x35);
	sig.append(0xc2);
	sig.append(0x91);
	sig.append(0x55);
	sig.append(0x8b);
	sig.append(0xe9);
	sig.append(0x29);
	sig.append(0xfc);
	sig.append(0x2);
	sig.append(0x37);
	sig.append(0xdd);
	sig.append(0xc5);
	sig.append(0x13);
	sig.append(0xd3);
	sig.append(0x50);
	sig.append(0xb2);
	sig.append(0x4c);
	sig.append(0xdb);
	sig.append(0xc4);
	sig.append(0x97);
	sig.append(0x14);
	sig.append(0xad);
	sig.append(0x9);
	sig.append(0xe3);
	sig.append(0xdd);
	sig.append(0xcb);
	sig.append(0x5d);
	sig.append(0x7e);
	sig.append(0xfb);
	sig.append(0x7a);
	sig.append(0x37);
	sig.append(0x4a);
	sig.append(0xf5);
	sig.append(0x26);
	let pk = PublicKey {
		 x: 112905630890098747422881105495251624628557992423591308090516617939886016414996, 
		 y: 20274307799853999573330631970421012076055437725596060251414379881131076707774
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


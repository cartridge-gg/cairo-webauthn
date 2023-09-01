// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/auth/verify_signature_auth.py for details
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
	hash.append(0xe8);
	hash.append(0x40);
	hash.append(0x20);
	hash.append(0x99);
	hash.append(0x11);
	hash.append(0x16);
	hash.append(0xaa);
	hash.append(0x6e);
	hash.append(0x8d);
	hash.append(0x4a);
	hash.append(0xc5);
	hash.append(0xef);
	hash.append(0x9b);
	hash.append(0x13);
	hash.append(0x78);
	hash.append(0xc8);
	hash.append(0xcc);
	hash.append(0x12);
	hash.append(0x5b);
	hash.append(0x93);
	hash.append(0xf2);
	hash.append(0x95);
	hash.append(0xff);
	hash.append(0xa7);
	hash.append(0x3e);
	hash.append(0xbf);
	hash.append(0x89);
	hash.append(0xa6);
	hash.append(0x38);
	hash.append(0x8a);
	hash.append(0x6f);
	hash.append(0x26);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xf0);
	auth_data.append(0xbe);
	auth_data.append(0xd8);
	auth_data.append(0x71);
	auth_data.append(0x50);
	auth_data.append(0x8);
	auth_data.append(0x43);
	auth_data.append(0x69);
	auth_data.append(0xc3);
	auth_data.append(0xcb);
	auth_data.append(0x3a);
	auth_data.append(0x41);
	auth_data.append(0xc9);
	auth_data.append(0xc8);
	auth_data.append(0x66);
	auth_data.append(0xf7);
	auth_data.append(0xc9);
	auth_data.append(0xf0);
	auth_data.append(0x17);
	auth_data.append(0xd8);
	auth_data.append(0xb6);
	auth_data.append(0xda);
	auth_data.append(0xbf);
	auth_data.append(0x5d);
	auth_data.append(0x21);
	auth_data.append(0xb9);
	auth_data.append(0x6c);
	auth_data.append(0xd8);
	auth_data.append(0xc0);
	auth_data.append(0x86);
	auth_data.append(0xc3);
	auth_data.append(0x94);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x62);
	sig.append(0xdd);
	sig.append(0x51);
	sig.append(0x87);
	sig.append(0x9b);
	sig.append(0x64);
	sig.append(0x20);
	sig.append(0xc4);
	sig.append(0x62);
	sig.append(0xd4);
	sig.append(0xb0);
	sig.append(0x9b);
	sig.append(0x0);
	sig.append(0x88);
	sig.append(0x4);
	sig.append(0xa9);
	sig.append(0x9b);
	sig.append(0x87);
	sig.append(0x5);
	sig.append(0x78);
	sig.append(0x6a);
	sig.append(0xe4);
	sig.append(0x80);
	sig.append(0x43);
	sig.append(0x89);
	sig.append(0x16);
	sig.append(0x4c);
	sig.append(0x23);
	sig.append(0x42);
	sig.append(0xc1);
	sig.append(0xfb);
	sig.append(0x71);
	sig.append(0xf);
	sig.append(0xb3);
	sig.append(0x5b);
	sig.append(0xf);
	sig.append(0x9b);
	sig.append(0xcc);
	sig.append(0xa1);
	sig.append(0x94);
	sig.append(0x62);
	sig.append(0xa);
	sig.append(0xd3);
	sig.append(0xa8);
	sig.append(0xed);
	sig.append(0x1f);
	sig.append(0xd2);
	sig.append(0x9f);
	sig.append(0x81);
	sig.append(0xdf);
	sig.append(0x32);
	sig.append(0x9c);
	sig.append(0xae);
	sig.append(0xe7);
	sig.append(0x87);
	sig.append(0xd1);
	sig.append(0x84);
	sig.append(0x5e);
	sig.append(0x32);
	sig.append(0xa6);
	sig.append(0x92);
	sig.append(0x11);
	sig.append(0xe);
	sig.append(0x9f);
	let pk = PublicKey {
		 x: 71051496781075409733497338991584300878385212993213405904995320788416215329543, 
		 y: 114886788185782634821986553705745089087774079608692999866008372250344536686290
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
	hash.append(0xaf);
	hash.append(0xfd);
	hash.append(0x5c);
	hash.append(0x88);
	hash.append(0x48);
	hash.append(0x3c);
	hash.append(0xa8);
	hash.append(0xbe);
	hash.append(0x4e);
	hash.append(0x4d);
	hash.append(0x7);
	hash.append(0xdd);
	hash.append(0x5c);
	hash.append(0xa5);
	hash.append(0x3);
	hash.append(0x76);
	hash.append(0x74);
	hash.append(0xa5);
	hash.append(0x7d);
	hash.append(0x77);
	hash.append(0x6e);
	hash.append(0xa9);
	hash.append(0x8a);
	hash.append(0xd6);
	hash.append(0xf4);
	hash.append(0x91);
	hash.append(0x2);
	hash.append(0xe7);
	hash.append(0x47);
	hash.append(0xe);
	hash.append(0xc);
	hash.append(0xac);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xe8);
	auth_data.append(0xed);
	auth_data.append(0x61);
	auth_data.append(0xd8);
	auth_data.append(0x26);
	auth_data.append(0xbd);
	auth_data.append(0xf0);
	auth_data.append(0xd8);
	auth_data.append(0x7a);
	auth_data.append(0x23);
	auth_data.append(0xc1);
	auth_data.append(0xb5);
	auth_data.append(0x30);
	auth_data.append(0x58);
	auth_data.append(0x50);
	auth_data.append(0xbb);
	auth_data.append(0xb2);
	auth_data.append(0xec);
	auth_data.append(0xe8);
	auth_data.append(0xfa);
	auth_data.append(0x42);
	auth_data.append(0x41);
	auth_data.append(0xd9);
	auth_data.append(0xd3);
	auth_data.append(0xe2);
	auth_data.append(0xc5);
	auth_data.append(0x4d);
	auth_data.append(0x36);
	auth_data.append(0xbf);
	auth_data.append(0x82);
	auth_data.append(0x73);
	auth_data.append(0x48);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x61);
	sig.append(0x8a);
	sig.append(0x89);
	sig.append(0xc9);
	sig.append(0xf0);
	sig.append(0x5a);
	sig.append(0xfe);
	sig.append(0x96);
	sig.append(0x1e);
	sig.append(0xce);
	sig.append(0x22);
	sig.append(0xf2);
	sig.append(0x66);
	sig.append(0xe2);
	sig.append(0x75);
	sig.append(0xee);
	sig.append(0x21);
	sig.append(0x67);
	sig.append(0x33);
	sig.append(0xca);
	sig.append(0xb3);
	sig.append(0xbe);
	sig.append(0xae);
	sig.append(0xc3);
	sig.append(0x1);
	sig.append(0xc7);
	sig.append(0x73);
	sig.append(0x9a);
	sig.append(0xd8);
	sig.append(0x92);
	sig.append(0x60);
	sig.append(0xcd);
	sig.append(0xe6);
	sig.append(0x2f);
	sig.append(0x28);
	sig.append(0x1d);
	sig.append(0x4c);
	sig.append(0x79);
	sig.append(0xb5);
	sig.append(0x52);
	sig.append(0x38);
	sig.append(0x2c);
	sig.append(0x59);
	sig.append(0x6d);
	sig.append(0xe0);
	sig.append(0x20);
	sig.append(0x4b);
	sig.append(0xad);
	sig.append(0xe8);
	sig.append(0xa2);
	sig.append(0x69);
	sig.append(0x5e);
	sig.append(0x51);
	sig.append(0x6f);
	sig.append(0xfe);
	sig.append(0xa);
	sig.append(0xa2);
	sig.append(0x5a);
	sig.append(0x2e);
	sig.append(0xf);
	sig.append(0x30);
	sig.append(0x44);
	sig.append(0xd7);
	sig.append(0x1f);
	let pk = PublicKey {
		 x: 55267985324365459584517676148653888120473075291470034151118861165629143321095, 
		 y: 90421629282396779811286816125741967790391811708213507481128526289937171480703
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
	hash.append(0xb5);
	hash.append(0x4f);
	hash.append(0xdf);
	hash.append(0xe0);
	hash.append(0x47);
	hash.append(0x2c);
	hash.append(0xc);
	hash.append(0x9d);
	hash.append(0x52);
	hash.append(0x9e);
	hash.append(0x7d);
	hash.append(0xd3);
	hash.append(0xf2);
	hash.append(0xe);
	hash.append(0x28);
	hash.append(0x36);
	hash.append(0x73);
	hash.append(0xc);
	hash.append(0xa);
	hash.append(0xf6);
	hash.append(0x40);
	hash.append(0x7c);
	hash.append(0x70);
	hash.append(0xb4);
	hash.append(0x82);
	hash.append(0x67);
	hash.append(0x27);
	hash.append(0x68);
	hash.append(0x11);
	hash.append(0x5c);
	hash.append(0xae);
	hash.append(0xbe);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x51);
	auth_data.append(0x97);
	auth_data.append(0xd1);
	auth_data.append(0x56);
	auth_data.append(0x3d);
	auth_data.append(0xd3);
	auth_data.append(0xf);
	auth_data.append(0x10);
	auth_data.append(0x8c);
	auth_data.append(0xf3);
	auth_data.append(0xfa);
	auth_data.append(0x8d);
	auth_data.append(0xea);
	auth_data.append(0xa4);
	auth_data.append(0x7);
	auth_data.append(0xc6);
	auth_data.append(0xce);
	auth_data.append(0x1d);
	auth_data.append(0x9f);
	auth_data.append(0xf0);
	auth_data.append(0xff);
	auth_data.append(0x5e);
	auth_data.append(0xb1);
	auth_data.append(0xbd);
	auth_data.append(0x1);
	auth_data.append(0x20);
	auth_data.append(0x7f);
	auth_data.append(0xa6);
	auth_data.append(0x5a);
	auth_data.append(0x31);
	auth_data.append(0x49);
	auth_data.append(0x4d);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x40);
	sig.append(0x7b);
	sig.append(0x61);
	sig.append(0x9);
	sig.append(0xbc);
	sig.append(0xa3);
	sig.append(0x36);
	sig.append(0xbe);
	sig.append(0xda);
	sig.append(0x89);
	sig.append(0xca);
	sig.append(0x6e);
	sig.append(0x3a);
	sig.append(0x48);
	sig.append(0xa5);
	sig.append(0x25);
	sig.append(0x60);
	sig.append(0xe6);
	sig.append(0x40);
	sig.append(0x43);
	sig.append(0xaa);
	sig.append(0x61);
	sig.append(0xcf);
	sig.append(0x89);
	sig.append(0x8e);
	sig.append(0x43);
	sig.append(0xa2);
	sig.append(0x16);
	sig.append(0x44);
	sig.append(0xaa);
	sig.append(0x2a);
	sig.append(0xf7);
	sig.append(0x5f);
	sig.append(0x67);
	sig.append(0x40);
	sig.append(0x3f);
	sig.append(0x7b);
	sig.append(0x59);
	sig.append(0xf8);
	sig.append(0x2c);
	sig.append(0xe2);
	sig.append(0xbf);
	sig.append(0x4f);
	sig.append(0xb6);
	sig.append(0x4);
	sig.append(0xea);
	sig.append(0x5e);
	sig.append(0xd0);
	sig.append(0xe);
	sig.append(0xa);
	sig.append(0x59);
	sig.append(0xd2);
	sig.append(0x29);
	sig.append(0x5d);
	sig.append(0x60);
	sig.append(0x88);
	sig.append(0xed);
	sig.append(0x5);
	sig.append(0x60);
	sig.append(0x39);
	sig.append(0x74);
	sig.append(0x86);
	sig.append(0xb9);
	sig.append(0x4b);
	let pk = PublicKey {
		 x: 18487718115218590083794016520047933381177596056930324149665681580339730786671, 
		 y: 109983460294905316857584516730426984834173814545452033512969298607775706992904
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
	hash.append(0xf8);
	hash.append(0x4a);
	hash.append(0xfa);
	hash.append(0x7c);
	hash.append(0x93);
	hash.append(0x74);
	hash.append(0x6e);
	hash.append(0x5f);
	hash.append(0x43);
	hash.append(0xce);
	hash.append(0xd3);
	hash.append(0xb9);
	hash.append(0xf);
	hash.append(0x22);
	hash.append(0xed);
	hash.append(0xff);
	hash.append(0xe0);
	hash.append(0xbf);
	hash.append(0xc5);
	hash.append(0xbe);
	hash.append(0xac);
	hash.append(0x35);
	hash.append(0x1);
	hash.append(0x13);
	hash.append(0x58);
	hash.append(0x39);
	hash.append(0x20);
	hash.append(0xbf);
	hash.append(0xf7);
	hash.append(0xd8);
	hash.append(0x38);
	hash.append(0x34);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x10);
	auth_data.append(0x1a);
	auth_data.append(0xd0);
	auth_data.append(0x49);
	auth_data.append(0x3b);
	auth_data.append(0x0);
	auth_data.append(0x97);
	auth_data.append(0x63);
	auth_data.append(0x4c);
	auth_data.append(0x99);
	auth_data.append(0xe7);
	auth_data.append(0xcc);
	auth_data.append(0x20);
	auth_data.append(0xe2);
	auth_data.append(0xbf);
	auth_data.append(0x99);
	auth_data.append(0x82);
	auth_data.append(0x53);
	auth_data.append(0x50);
	auth_data.append(0x30);
	auth_data.append(0x92);
	auth_data.append(0x1d);
	auth_data.append(0x96);
	auth_data.append(0x4d);
	auth_data.append(0x3d);
	auth_data.append(0x95);
	auth_data.append(0xa3);
	auth_data.append(0xf2);
	auth_data.append(0x83);
	auth_data.append(0xbc);
	auth_data.append(0x6e);
	auth_data.append(0x12);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa2);
	sig.append(0xb);
	sig.append(0xbc);
	sig.append(0x89);
	sig.append(0xf7);
	sig.append(0x24);
	sig.append(0x43);
	sig.append(0x8a);
	sig.append(0x34);
	sig.append(0x35);
	sig.append(0x0);
	sig.append(0xad);
	sig.append(0x85);
	sig.append(0x81);
	sig.append(0xee);
	sig.append(0x18);
	sig.append(0xfe);
	sig.append(0x2b);
	sig.append(0xae);
	sig.append(0xa6);
	sig.append(0x3);
	sig.append(0x19);
	sig.append(0x3b);
	sig.append(0x57);
	sig.append(0x86);
	sig.append(0xb2);
	sig.append(0x70);
	sig.append(0x4e);
	sig.append(0xf7);
	sig.append(0x24);
	sig.append(0xe1);
	sig.append(0x88);
	sig.append(0xdf);
	sig.append(0xc4);
	sig.append(0x24);
	sig.append(0xef);
	sig.append(0x36);
	sig.append(0xb1);
	sig.append(0x56);
	sig.append(0x3c);
	sig.append(0x7f);
	sig.append(0x78);
	sig.append(0x3f);
	sig.append(0x9a);
	sig.append(0xca);
	sig.append(0x1d);
	sig.append(0x5d);
	sig.append(0x13);
	sig.append(0xe);
	sig.append(0xd7);
	sig.append(0x41);
	sig.append(0x5b);
	sig.append(0x89);
	sig.append(0xc2);
	sig.append(0x44);
	sig.append(0xea);
	sig.append(0x2a);
	sig.append(0xa8);
	sig.append(0xdc);
	sig.append(0x5b);
	sig.append(0xa4);
	sig.append(0xba);
	sig.append(0xe4);
	sig.append(0xcb);
	let pk = PublicKey {
		 x: 73033530330538092612982599439253713158024304356218697576542386521293434731737, 
		 y: 25454398412209766293302027022548868304606419616731841257640423167286435616203
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
	hash.append(0xb2);
	hash.append(0x46);
	hash.append(0xfb);
	hash.append(0x14);
	hash.append(0x35);
	hash.append(0xe7);
	hash.append(0xc);
	hash.append(0x29);
	hash.append(0x3c);
	hash.append(0xb4);
	hash.append(0x39);
	hash.append(0x2c);
	hash.append(0xc2);
	hash.append(0xc3);
	hash.append(0x6f);
	hash.append(0x59);
	hash.append(0x50);
	hash.append(0x7d);
	hash.append(0x7e);
	hash.append(0xe6);
	hash.append(0x25);
	hash.append(0x98);
	hash.append(0xd1);
	hash.append(0xb3);
	hash.append(0x73);
	hash.append(0xb);
	hash.append(0x45);
	hash.append(0xb5);
	hash.append(0xc);
	hash.append(0x5d);
	hash.append(0x2f);
	hash.append(0x12);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x2f);
	auth_data.append(0xbb);
	auth_data.append(0x79);
	auth_data.append(0x62);
	auth_data.append(0x28);
	auth_data.append(0xe9);
	auth_data.append(0xf4);
	auth_data.append(0x51);
	auth_data.append(0x4a);
	auth_data.append(0x3);
	auth_data.append(0x2f);
	auth_data.append(0x3);
	auth_data.append(0x1e);
	auth_data.append(0x0);
	auth_data.append(0xcf);
	auth_data.append(0x4e);
	auth_data.append(0x16);
	auth_data.append(0x18);
	auth_data.append(0x56);
	auth_data.append(0x1d);
	auth_data.append(0x3e);
	auth_data.append(0x22);
	auth_data.append(0x27);
	auth_data.append(0x59);
	auth_data.append(0x33);
	auth_data.append(0xfc);
	auth_data.append(0x33);
	auth_data.append(0x25);
	auth_data.append(0x51);
	auth_data.append(0x9b);
	auth_data.append(0xc);
	auth_data.append(0xe4);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x98);
	sig.append(0x59);
	sig.append(0x64);
	sig.append(0x31);
	sig.append(0x19);
	sig.append(0xcc);
	sig.append(0x9d);
	sig.append(0xc3);
	sig.append(0xf8);
	sig.append(0xe5);
	sig.append(0xf9);
	sig.append(0x7b);
	sig.append(0xe8);
	sig.append(0x2e);
	sig.append(0x8d);
	sig.append(0xf2);
	sig.append(0x11);
	sig.append(0x5a);
	sig.append(0x3c);
	sig.append(0x74);
	sig.append(0x6e);
	sig.append(0x7a);
	sig.append(0xcf);
	sig.append(0xfc);
	sig.append(0xc5);
	sig.append(0xf3);
	sig.append(0xb7);
	sig.append(0xaf);
	sig.append(0x74);
	sig.append(0x23);
	sig.append(0xf2);
	sig.append(0x88);
	sig.append(0xd7);
	sig.append(0x82);
	sig.append(0xd8);
	sig.append(0xa3);
	sig.append(0xda);
	sig.append(0x33);
	sig.append(0x94);
	sig.append(0x37);
	sig.append(0xee);
	sig.append(0x63);
	sig.append(0x8d);
	sig.append(0x8d);
	sig.append(0x9);
	sig.append(0xc1);
	sig.append(0x6e);
	sig.append(0x2);
	sig.append(0x6d);
	sig.append(0xf0);
	sig.append(0x77);
	sig.append(0xd1);
	sig.append(0x28);
	sig.append(0xeb);
	sig.append(0x97);
	sig.append(0xf0);
	sig.append(0x40);
	sig.append(0xf0);
	sig.append(0x6);
	sig.append(0x65);
	sig.append(0xdc);
	sig.append(0x81);
	sig.append(0xce);
	sig.append(0x6e);
	let pk = PublicKey {
		 x: 34360103890280382383777120332267723599563355491960601901864150828215360843818, 
		 y: 40642064797525015596385244784828184555919947444726622399745209927685773477713
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
	hash.append(0x28);
	hash.append(0xc6);
	hash.append(0x43);
	hash.append(0xe8);
	hash.append(0xa7);
	hash.append(0xbe);
	hash.append(0x4d);
	hash.append(0xfe);
	hash.append(0x15);
	hash.append(0x27);
	hash.append(0x2a);
	hash.append(0x54);
	hash.append(0x65);
	hash.append(0xdb);
	hash.append(0x53);
	hash.append(0xdc);
	hash.append(0x53);
	hash.append(0x44);
	hash.append(0xda);
	hash.append(0x26);
	hash.append(0x69);
	hash.append(0xda);
	hash.append(0xbe);
	hash.append(0xe9);
	hash.append(0x31);
	hash.append(0x86);
	hash.append(0x15);
	hash.append(0x5a);
	hash.append(0xc);
	hash.append(0x28);
	hash.append(0xd2);
	hash.append(0xba);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x1);
	auth_data.append(0x51);
	auth_data.append(0x7a);
	auth_data.append(0xc7);
	auth_data.append(0xc6);
	auth_data.append(0xa);
	auth_data.append(0xc3);
	auth_data.append(0x1b);
	auth_data.append(0x41);
	auth_data.append(0x26);
	auth_data.append(0x61);
	auth_data.append(0x39);
	auth_data.append(0x6a);
	auth_data.append(0xe0);
	auth_data.append(0xb8);
	auth_data.append(0x24);
	auth_data.append(0xf2);
	auth_data.append(0x67);
	auth_data.append(0xc5);
	auth_data.append(0x94);
	auth_data.append(0xfd);
	auth_data.append(0x18);
	auth_data.append(0x74);
	auth_data.append(0xff);
	auth_data.append(0xa3);
	auth_data.append(0xe2);
	auth_data.append(0x10);
	auth_data.append(0xe0);
	auth_data.append(0x6f);
	auth_data.append(0xba);
	auth_data.append(0x4);
	auth_data.append(0xb3);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa5);
	sig.append(0x9f);
	sig.append(0x8a);
	sig.append(0xc7);
	sig.append(0x36);
	sig.append(0xd4);
	sig.append(0x6a);
	sig.append(0xfe);
	sig.append(0x10);
	sig.append(0xa7);
	sig.append(0xe9);
	sig.append(0xc3);
	sig.append(0x7d);
	sig.append(0x9c);
	sig.append(0x32);
	sig.append(0xf7);
	sig.append(0x10);
	sig.append(0x7d);
	sig.append(0xd3);
	sig.append(0x23);
	sig.append(0xa5);
	sig.append(0xa5);
	sig.append(0x9d);
	sig.append(0x44);
	sig.append(0x88);
	sig.append(0x37);
	sig.append(0xd1);
	sig.append(0x9e);
	sig.append(0x68);
	sig.append(0xb6);
	sig.append(0x23);
	sig.append(0xaf);
	sig.append(0xd0);
	sig.append(0xce);
	sig.append(0x1);
	sig.append(0xef);
	sig.append(0x6a);
	sig.append(0x33);
	sig.append(0xc4);
	sig.append(0xe6);
	sig.append(0x5f);
	sig.append(0xe9);
	sig.append(0x3d);
	sig.append(0xe3);
	sig.append(0x78);
	sig.append(0x99);
	sig.append(0x11);
	sig.append(0xe1);
	sig.append(0x4);
	sig.append(0x92);
	sig.append(0x6c);
	sig.append(0xc0);
	sig.append(0x6b);
	sig.append(0x38);
	sig.append(0x8b);
	sig.append(0xea);
	sig.append(0xa2);
	sig.append(0x5c);
	sig.append(0x1);
	sig.append(0x70);
	sig.append(0xaa);
	sig.append(0xd7);
	sig.append(0x86);
	sig.append(0x77);
	let pk = PublicKey {
		 x: 22184628500399937687277862365666182791266211978178102599599023361592047113034, 
		 y: 59567809868805437911761988121114210574320286321432853236673340373237992342927
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
	hash.append(0x1a);
	hash.append(0xb3);
	hash.append(0xc6);
	hash.append(0xb9);
	hash.append(0xc8);
	hash.append(0x9e);
	hash.append(0x79);
	hash.append(0x86);
	hash.append(0x66);
	hash.append(0x46);
	hash.append(0x8e);
	hash.append(0xee);
	hash.append(0x40);
	hash.append(0xb5);
	hash.append(0xf);
	hash.append(0x51);
	hash.append(0xa9);
	hash.append(0x4e);
	hash.append(0xaf);
	hash.append(0x2);
	hash.append(0xb4);
	hash.append(0x29);
	hash.append(0xf5);
	hash.append(0x31);
	hash.append(0x51);
	hash.append(0x92);
	hash.append(0x72);
	hash.append(0x42);
	hash.append(0xcb);
	hash.append(0xb);
	hash.append(0xa9);
	hash.append(0xae);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xb3);
	auth_data.append(0xdd);
	auth_data.append(0x1f);
	auth_data.append(0xf7);
	auth_data.append(0xc9);
	auth_data.append(0xda);
	auth_data.append(0xed);
	auth_data.append(0xa8);
	auth_data.append(0x95);
	auth_data.append(0xad);
	auth_data.append(0x21);
	auth_data.append(0x32);
	auth_data.append(0x3b);
	auth_data.append(0x50);
	auth_data.append(0x1a);
	auth_data.append(0x5);
	auth_data.append(0x1e);
	auth_data.append(0x84);
	auth_data.append(0x19);
	auth_data.append(0xc0);
	auth_data.append(0x53);
	auth_data.append(0x97);
	auth_data.append(0xec);
	auth_data.append(0x7c);
	auth_data.append(0x75);
	auth_data.append(0x4);
	auth_data.append(0x1f);
	auth_data.append(0xa3);
	auth_data.append(0x4e);
	auth_data.append(0x8);
	auth_data.append(0x38);
	auth_data.append(0x4e);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x94);
	sig.append(0x89);
	sig.append(0x3a);
	sig.append(0x5c);
	sig.append(0x2e);
	sig.append(0xae);
	sig.append(0x9b);
	sig.append(0xdb);
	sig.append(0x41);
	sig.append(0x1d);
	sig.append(0xc7);
	sig.append(0x71);
	sig.append(0x7d);
	sig.append(0xcd);
	sig.append(0xda);
	sig.append(0x1c);
	sig.append(0xad);
	sig.append(0x5c);
	sig.append(0x30);
	sig.append(0xa3);
	sig.append(0xe0);
	sig.append(0xda);
	sig.append(0x10);
	sig.append(0x9b);
	sig.append(0xc1);
	sig.append(0x1a);
	sig.append(0xa1);
	sig.append(0xab);
	sig.append(0x21);
	sig.append(0x29);
	sig.append(0x2b);
	sig.append(0x61);
	sig.append(0x12);
	sig.append(0x26);
	sig.append(0x8f);
	sig.append(0xc4);
	sig.append(0xd4);
	sig.append(0xb7);
	sig.append(0x60);
	sig.append(0x92);
	sig.append(0x69);
	sig.append(0xbd);
	sig.append(0xe6);
	sig.append(0xe1);
	sig.append(0xe6);
	sig.append(0xef);
	sig.append(0x32);
	sig.append(0xad);
	sig.append(0xea);
	sig.append(0x1a);
	sig.append(0xd5);
	sig.append(0x62);
	sig.append(0x40);
	sig.append(0x37);
	sig.append(0xd0);
	sig.append(0x51);
	sig.append(0x66);
	sig.append(0x64);
	sig.append(0xc8);
	sig.append(0x6a);
	sig.append(0x31);
	sig.append(0x53);
	sig.append(0x6a);
	sig.append(0x4c);
	let pk = PublicKey {
		 x: 52465706761431469963407694354043368958568371791362361834789862396388145022696, 
		 y: 90916416980721404769775424352330587352827831196454501922710915233534195426206
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
	hash.append(0x59);
	hash.append(0x59);
	hash.append(0x10);
	hash.append(0x14);
	hash.append(0x3d);
	hash.append(0x3b);
	hash.append(0x62);
	hash.append(0x23);
	hash.append(0x91);
	hash.append(0xbd);
	hash.append(0xb9);
	hash.append(0x79);
	hash.append(0xc7);
	hash.append(0x40);
	hash.append(0x58);
	hash.append(0xc8);
	hash.append(0xb1);
	hash.append(0x71);
	hash.append(0xc9);
	hash.append(0x9d);
	hash.append(0xc3);
	hash.append(0xa4);
	hash.append(0x74);
	hash.append(0x7e);
	hash.append(0xf6);
	hash.append(0xd4);
	hash.append(0x9d);
	hash.append(0x76);
	hash.append(0xae);
	hash.append(0x39);
	hash.append(0xc);
	hash.append(0x8b);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xbe);
	auth_data.append(0xb7);
	auth_data.append(0x9);
	auth_data.append(0x6f);
	auth_data.append(0x41);
	auth_data.append(0x16);
	auth_data.append(0x6d);
	auth_data.append(0x22);
	auth_data.append(0x21);
	auth_data.append(0x72);
	auth_data.append(0xdc);
	auth_data.append(0x43);
	auth_data.append(0x37);
	auth_data.append(0xd);
	auth_data.append(0xf9);
	auth_data.append(0x9a);
	auth_data.append(0x32);
	auth_data.append(0xb9);
	auth_data.append(0x3c);
	auth_data.append(0xf0);
	auth_data.append(0x60);
	auth_data.append(0x26);
	auth_data.append(0x58);
	auth_data.append(0x78);
	auth_data.append(0x16);
	auth_data.append(0x5b);
	auth_data.append(0x53);
	auth_data.append(0xd8);
	auth_data.append(0xf7);
	auth_data.append(0x9b);
	auth_data.append(0x32);
	auth_data.append(0x20);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xc0);
	sig.append(0x37);
	sig.append(0xec);
	sig.append(0x84);
	sig.append(0x99);
	sig.append(0x78);
	sig.append(0xbb);
	sig.append(0x9b);
	sig.append(0x9);
	sig.append(0xb2);
	sig.append(0xdf);
	sig.append(0xa7);
	sig.append(0xc2);
	sig.append(0x10);
	sig.append(0x58);
	sig.append(0x16);
	sig.append(0xe9);
	sig.append(0xdb);
	sig.append(0x5a);
	sig.append(0xc0);
	sig.append(0x64);
	sig.append(0xe9);
	sig.append(0x6a);
	sig.append(0xa5);
	sig.append(0x91);
	sig.append(0x4e);
	sig.append(0xc4);
	sig.append(0x6a);
	sig.append(0xce);
	sig.append(0x2c);
	sig.append(0xaf);
	sig.append(0xd3);
	sig.append(0x9f);
	sig.append(0xfd);
	sig.append(0x65);
	sig.append(0x4f);
	sig.append(0xe7);
	sig.append(0x46);
	sig.append(0xed);
	sig.append(0x5a);
	sig.append(0x9a);
	sig.append(0x8e);
	sig.append(0x6d);
	sig.append(0x91);
	sig.append(0xf9);
	sig.append(0x91);
	sig.append(0x2f);
	sig.append(0x6);
	sig.append(0x47);
	sig.append(0x36);
	sig.append(0xc);
	sig.append(0x13);
	sig.append(0x2);
	sig.append(0x82);
	sig.append(0x27);
	sig.append(0x72);
	sig.append(0x22);
	sig.append(0x46);
	sig.append(0xee);
	sig.append(0x52);
	sig.append(0x18);
	sig.append(0x87);
	sig.append(0x88);
	sig.append(0x4d);
	let pk = PublicKey {
		 x: 37165730896911271302375455845643654251950807798411384803853483445818726693664, 
		 y: 72759287107285140386377849700856147644643640211193835014303199109756393995031
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
	hash.append(0x1a);
	hash.append(0x46);
	hash.append(0x33);
	hash.append(0x33);
	hash.append(0x3d);
	hash.append(0xb4);
	hash.append(0x46);
	hash.append(0x25);
	hash.append(0xf6);
	hash.append(0x65);
	hash.append(0xbd);
	hash.append(0xdf);
	hash.append(0x44);
	hash.append(0x16);
	hash.append(0xf);
	hash.append(0xda);
	hash.append(0x1a);
	hash.append(0x17);
	hash.append(0x90);
	hash.append(0xc5);
	hash.append(0xd7);
	hash.append(0x77);
	hash.append(0x8e);
	hash.append(0xd1);
	hash.append(0x3);
	hash.append(0x92);
	hash.append(0x24);
	hash.append(0x6f);
	hash.append(0x5c);
	hash.append(0xa0);
	hash.append(0xea);
	hash.append(0xa8);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x65);
	auth_data.append(0xe3);
	auth_data.append(0x75);
	auth_data.append(0x3f);
	auth_data.append(0x0);
	auth_data.append(0x5c);
	auth_data.append(0x67);
	auth_data.append(0x86);
	auth_data.append(0xaf);
	auth_data.append(0xb5);
	auth_data.append(0x70);
	auth_data.append(0x20);
	auth_data.append(0x2e);
	auth_data.append(0x9f);
	auth_data.append(0xfb);
	auth_data.append(0x31);
	auth_data.append(0xb7);
	auth_data.append(0xb1);
	auth_data.append(0xb1);
	auth_data.append(0x50);
	auth_data.append(0x84);
	auth_data.append(0xf9);
	auth_data.append(0x4d);
	auth_data.append(0x6);
	auth_data.append(0x12);
	auth_data.append(0x5d);
	auth_data.append(0xe4);
	auth_data.append(0x5a);
	auth_data.append(0x3d);
	auth_data.append(0x50);
	auth_data.append(0x80);
	auth_data.append(0x42);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xf5);
	sig.append(0x2e);
	sig.append(0x74);
	sig.append(0xdc);
	sig.append(0x66);
	sig.append(0x35);
	sig.append(0xa9);
	sig.append(0x22);
	sig.append(0x18);
	sig.append(0xa7);
	sig.append(0x6c);
	sig.append(0xf3);
	sig.append(0x92);
	sig.append(0x51);
	sig.append(0x49);
	sig.append(0xbb);
	sig.append(0x31);
	sig.append(0xc9);
	sig.append(0xae);
	sig.append(0xe7);
	sig.append(0x95);
	sig.append(0x9c);
	sig.append(0x52);
	sig.append(0x62);
	sig.append(0xec);
	sig.append(0x9d);
	sig.append(0xc6);
	sig.append(0x7f);
	sig.append(0xea);
	sig.append(0x42);
	sig.append(0x63);
	sig.append(0x82);
	sig.append(0x5a);
	sig.append(0xbb);
	sig.append(0x26);
	sig.append(0x5d);
	sig.append(0x9b);
	sig.append(0xe6);
	sig.append(0x82);
	sig.append(0x4);
	sig.append(0x7e);
	sig.append(0xba);
	sig.append(0x92);
	sig.append(0x51);
	sig.append(0x20);
	sig.append(0x0);
	sig.append(0xb);
	sig.append(0x7d);
	sig.append(0x89);
	sig.append(0xfd);
	sig.append(0x2b);
	sig.append(0x7e);
	sig.append(0x2f);
	sig.append(0x2e);
	sig.append(0x15);
	sig.append(0x24);
	sig.append(0x73);
	sig.append(0x93);
	sig.append(0xdc);
	sig.append(0xaa);
	sig.append(0xe7);
	sig.append(0x3b);
	sig.append(0x25);
	sig.append(0x4e);
	let pk = PublicKey {
		 x: 92269001688694369715659120142507849996787567488707680719134865532649506070857, 
		 y: 101738400870519013840170139867764766206213217449949321401099347260314240284318
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
	hash.append(0xe7);
	hash.append(0x16);
	hash.append(0x42);
	hash.append(0xb4);
	hash.append(0x8);
	hash.append(0x5f);
	hash.append(0x2f);
	hash.append(0xdc);
	hash.append(0x56);
	hash.append(0xe4);
	hash.append(0x68);
	hash.append(0xdf);
	hash.append(0xc8);
	hash.append(0x9d);
	hash.append(0xad);
	hash.append(0xc1);
	hash.append(0x83);
	hash.append(0x72);
	hash.append(0x32);
	hash.append(0x3b);
	hash.append(0x55);
	hash.append(0xf8);
	hash.append(0xf9);
	hash.append(0xf6);
	hash.append(0x40);
	hash.append(0x2a);
	hash.append(0x7);
	hash.append(0x29);
	hash.append(0xdd);
	hash.append(0x68);
	hash.append(0x68);
	hash.append(0xd1);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xf6);
	auth_data.append(0x4e);
	auth_data.append(0x15);
	auth_data.append(0x2);
	auth_data.append(0x81);
	auth_data.append(0xb4);
	auth_data.append(0xed);
	auth_data.append(0x47);
	auth_data.append(0x1a);
	auth_data.append(0xe2);
	auth_data.append(0xc);
	auth_data.append(0x91);
	auth_data.append(0x74);
	auth_data.append(0xde);
	auth_data.append(0x9b);
	auth_data.append(0xfd);
	auth_data.append(0x85);
	auth_data.append(0xa0);
	auth_data.append(0xa6);
	auth_data.append(0xd7);
	auth_data.append(0x82);
	auth_data.append(0x47);
	auth_data.append(0x92);
	auth_data.append(0xa);
	auth_data.append(0xb1);
	auth_data.append(0x59);
	auth_data.append(0x7b);
	auth_data.append(0x12);
	auth_data.append(0xd3);
	auth_data.append(0x26);
	auth_data.append(0x32);
	auth_data.append(0x59);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xbb);
	sig.append(0xa8);
	sig.append(0x7a);
	sig.append(0xdf);
	sig.append(0x4f);
	sig.append(0xef);
	sig.append(0xd4);
	sig.append(0x70);
	sig.append(0xa2);
	sig.append(0x71);
	sig.append(0x71);
	sig.append(0x71);
	sig.append(0x3d);
	sig.append(0x97);
	sig.append(0x43);
	sig.append(0xf4);
	sig.append(0x7a);
	sig.append(0x95);
	sig.append(0xd6);
	sig.append(0x96);
	sig.append(0x2b);
	sig.append(0xe);
	sig.append(0x18);
	sig.append(0x2d);
	sig.append(0x4c);
	sig.append(0x7a);
	sig.append(0x15);
	sig.append(0xf4);
	sig.append(0x28);
	sig.append(0x23);
	sig.append(0xc3);
	sig.append(0xeb);
	sig.append(0x98);
	sig.append(0x30);
	sig.append(0x7b);
	sig.append(0x5d);
	sig.append(0x69);
	sig.append(0xb3);
	sig.append(0xa8);
	sig.append(0xea);
	sig.append(0x4a);
	sig.append(0x76);
	sig.append(0x40);
	sig.append(0x32);
	sig.append(0x13);
	sig.append(0x4e);
	sig.append(0x5);
	sig.append(0xfa);
	sig.append(0x80);
	sig.append(0x63);
	sig.append(0xe9);
	sig.append(0xc);
	sig.append(0xf4);
	sig.append(0x64);
	sig.append(0x94);
	sig.append(0xdb);
	sig.append(0x7f);
	sig.append(0x1a);
	sig.append(0xa7);
	sig.append(0x2a);
	sig.append(0x75);
	sig.append(0xbd);
	sig.append(0x4b);
	sig.append(0x2);
	let pk = PublicKey {
		 x: 4239440699230047052626709108172958677025898213996303895223549268790843871551, 
		 y: 76867821940783628517423422065485585667871051731593828144020548197825631540074
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


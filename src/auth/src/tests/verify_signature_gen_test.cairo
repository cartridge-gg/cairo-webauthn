// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/auth/verify_signature_test.py for details
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
	hash.append(0xb5);
	hash.append(0x3a);
	hash.append(0xc8);
	hash.append(0xa8);
	hash.append(0x62);
	hash.append(0x41);
	hash.append(0xfd);
	hash.append(0x5e);
	hash.append(0xad);
	hash.append(0xc9);
	hash.append(0xfd);
	hash.append(0xef);
	hash.append(0xe6);
	hash.append(0x53);
	hash.append(0x28);
	hash.append(0x2d);
	hash.append(0x5b);
	hash.append(0xd7);
	hash.append(0x99);
	hash.append(0x9);
	hash.append(0x29);
	hash.append(0xc4);
	hash.append(0x2a);
	hash.append(0x88);
	hash.append(0x8c);
	hash.append(0x2a);
	hash.append(0x38);
	hash.append(0xb1);
	hash.append(0xd0);
	hash.append(0xac);
	hash.append(0x5f);
	hash.append(0xfd);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xe9);
	auth_data.append(0x18);
	auth_data.append(0x55);
	auth_data.append(0x8d);
	auth_data.append(0x5e);
	auth_data.append(0x89);
	auth_data.append(0xf);
	auth_data.append(0xe5);
	auth_data.append(0xb1);
	auth_data.append(0xc);
	auth_data.append(0xbf);
	auth_data.append(0x0);
	auth_data.append(0xd5);
	auth_data.append(0x7f);
	auth_data.append(0x67);
	auth_data.append(0x8d);
	auth_data.append(0x47);
	auth_data.append(0x92);
	auth_data.append(0x8e);
	auth_data.append(0xef);
	auth_data.append(0x58);
	auth_data.append(0x6f);
	auth_data.append(0xf0);
	auth_data.append(0xfb);
	auth_data.append(0x24);
	auth_data.append(0x5f);
	auth_data.append(0x38);
	auth_data.append(0xa2);
	auth_data.append(0xe9);
	auth_data.append(0x68);
	auth_data.append(0x9);
	auth_data.append(0x57);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x36);
	sig.append(0xb);
	sig.append(0x3);
	sig.append(0x83);
	sig.append(0x20);
	sig.append(0x2b);
	sig.append(0xa7);
	sig.append(0xe8);
	sig.append(0xeb);
	sig.append(0x97);
	sig.append(0x29);
	sig.append(0xf9);
	sig.append(0xe1);
	sig.append(0x53);
	sig.append(0x2);
	sig.append(0xc1);
	sig.append(0x58);
	sig.append(0xb4);
	sig.append(0x65);
	sig.append(0xf2);
	sig.append(0x70);
	sig.append(0xad);
	sig.append(0x86);
	sig.append(0xa8);
	sig.append(0xa8);
	sig.append(0xd9);
	sig.append(0x72);
	sig.append(0xfb);
	sig.append(0x25);
	sig.append(0x5c);
	sig.append(0xf6);
	sig.append(0x28);
	sig.append(0xb5);
	sig.append(0xf2);
	sig.append(0xc7);
	sig.append(0x20);
	sig.append(0x3e);
	sig.append(0xdf);
	sig.append(0x41);
	sig.append(0x5f);
	sig.append(0xc);
	sig.append(0xff);
	sig.append(0x42);
	sig.append(0x27);
	sig.append(0xc);
	sig.append(0xc);
	sig.append(0xf8);
	sig.append(0xde);
	sig.append(0xe2);
	sig.append(0x14);
	sig.append(0x99);
	sig.append(0x2d);
	sig.append(0xb0);
	sig.append(0x5b);
	sig.append(0xc);
	sig.append(0x80);
	sig.append(0x3c);
	sig.append(0x2);
	sig.append(0xcc);
	sig.append(0xf0);
	sig.append(0xc5);
	sig.append(0xde);
	sig.append(0x52);
	sig.append(0x5b);
	let pk = PublicKey {
		 x: 18402001900564500889004704668336102227098588485669975709359617526132369465595, 
		 y: 56315231545714385312866284337279074439496847607020809877028943275342675128637
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
	hash.append(0x56);
	hash.append(0xe);
	hash.append(0x19);
	hash.append(0x88);
	hash.append(0x98);
	hash.append(0xc8);
	hash.append(0xd6);
	hash.append(0xbc);
	hash.append(0xf3);
	hash.append(0x66);
	hash.append(0x4);
	hash.append(0x80);
	hash.append(0xa2);
	hash.append(0x9e);
	hash.append(0x0);
	hash.append(0xde);
	hash.append(0x68);
	hash.append(0x3d);
	hash.append(0x3e);
	hash.append(0xad);
	hash.append(0x59);
	hash.append(0x70);
	hash.append(0x91);
	hash.append(0x99);
	hash.append(0x27);
	hash.append(0x81);
	hash.append(0x84);
	hash.append(0x14);
	hash.append(0x5f);
	hash.append(0xc5);
	hash.append(0xaf);
	hash.append(0xae);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xb6);
	auth_data.append(0x12);
	auth_data.append(0x2b);
	auth_data.append(0xf3);
	auth_data.append(0xf4);
	auth_data.append(0xb0);
	auth_data.append(0xc9);
	auth_data.append(0x4c);
	auth_data.append(0xf);
	auth_data.append(0x1e);
	auth_data.append(0x3c);
	auth_data.append(0x5f);
	auth_data.append(0xb);
	auth_data.append(0x4);
	auth_data.append(0xb);
	auth_data.append(0xac);
	auth_data.append(0x7c);
	auth_data.append(0xb0);
	auth_data.append(0x9e);
	auth_data.append(0x5f);
	auth_data.append(0xa1);
	auth_data.append(0xc0);
	auth_data.append(0x39);
	auth_data.append(0x25);
	auth_data.append(0x94);
	auth_data.append(0xcb);
	auth_data.append(0x74);
	auth_data.append(0x99);
	auth_data.append(0x88);
	auth_data.append(0xfb);
	auth_data.append(0xd8);
	auth_data.append(0xdd);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x99);
	sig.append(0xd0);
	sig.append(0x45);
	sig.append(0x84);
	sig.append(0x1b);
	sig.append(0x79);
	sig.append(0x61);
	sig.append(0xe3);
	sig.append(0x31);
	sig.append(0xea);
	sig.append(0x2e);
	sig.append(0xd9);
	sig.append(0xc6);
	sig.append(0xea);
	sig.append(0x31);
	sig.append(0x10);
	sig.append(0x27);
	sig.append(0xad);
	sig.append(0xc1);
	sig.append(0x65);
	sig.append(0xc7);
	sig.append(0x71);
	sig.append(0xc3);
	sig.append(0xc0);
	sig.append(0x52);
	sig.append(0x24);
	sig.append(0x55);
	sig.append(0x15);
	sig.append(0xd6);
	sig.append(0xa6);
	sig.append(0x61);
	sig.append(0xc);
	sig.append(0xd);
	sig.append(0x1c);
	sig.append(0x83);
	sig.append(0x8e);
	sig.append(0x8d);
	sig.append(0x58);
	sig.append(0xd3);
	sig.append(0x14);
	sig.append(0x46);
	sig.append(0x90);
	sig.append(0xce);
	sig.append(0x5d);
	sig.append(0x25);
	sig.append(0x88);
	sig.append(0x72);
	sig.append(0xbe);
	sig.append(0x9a);
	sig.append(0x49);
	sig.append(0xf);
	sig.append(0xee);
	sig.append(0xd1);
	sig.append(0x83);
	sig.append(0xec);
	sig.append(0x46);
	sig.append(0x1d);
	sig.append(0xa8);
	sig.append(0xb3);
	sig.append(0xb9);
	sig.append(0x3b);
	sig.append(0x3b);
	sig.append(0xb2);
	sig.append(0x37);
	let pk = PublicKey {
		 x: 112797896264292481534431361613645043582257874001226283739794718177061038274421, 
		 y: 71254303448759786391236781267253775396313759687154837559045155662916049626819
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
	hash.append(0x55);
	hash.append(0x9c);
	hash.append(0x15);
	hash.append(0x75);
	hash.append(0x8a);
	hash.append(0x3e);
	hash.append(0x9c);
	hash.append(0x48);
	hash.append(0x6c);
	hash.append(0x42);
	hash.append(0x13);
	hash.append(0xfe);
	hash.append(0x45);
	hash.append(0x69);
	hash.append(0x40);
	hash.append(0xec);
	hash.append(0x3b);
	hash.append(0x7e);
	hash.append(0x56);
	hash.append(0xa6);
	hash.append(0x61);
	hash.append(0x72);
	hash.append(0xf1);
	hash.append(0xe1);
	hash.append(0x15);
	hash.append(0xa3);
	hash.append(0xeb);
	hash.append(0x59);
	hash.append(0x3a);
	hash.append(0xf5);
	hash.append(0xcd);
	hash.append(0x79);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xb8);
	auth_data.append(0xa8);
	auth_data.append(0x7f);
	auth_data.append(0x46);
	auth_data.append(0x21);
	auth_data.append(0x80);
	auth_data.append(0xfd);
	auth_data.append(0xd3);
	auth_data.append(0x72);
	auth_data.append(0x89);
	auth_data.append(0x2e);
	auth_data.append(0x87);
	auth_data.append(0xfe);
	auth_data.append(0xe8);
	auth_data.append(0xea);
	auth_data.append(0xd2);
	auth_data.append(0xd6);
	auth_data.append(0x1b);
	auth_data.append(0x6c);
	auth_data.append(0xdf);
	auth_data.append(0xa8);
	auth_data.append(0xa1);
	auth_data.append(0x3a);
	auth_data.append(0x2d);
	auth_data.append(0x76);
	auth_data.append(0xd);
	auth_data.append(0xd1);
	auth_data.append(0xba);
	auth_data.append(0x14);
	auth_data.append(0x55);
	auth_data.append(0x23);
	auth_data.append(0x8b);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x95);
	sig.append(0xe2);
	sig.append(0xba);
	sig.append(0xef);
	sig.append(0x20);
	sig.append(0xaf);
	sig.append(0x97);
	sig.append(0x49);
	sig.append(0x44);
	sig.append(0x73);
	sig.append(0x3);
	sig.append(0xee);
	sig.append(0xf4);
	sig.append(0xdf);
	sig.append(0x8);
	sig.append(0x54);
	sig.append(0xdf);
	sig.append(0xd1);
	sig.append(0x1e);
	sig.append(0x8a);
	sig.append(0x5b);
	sig.append(0x24);
	sig.append(0xd7);
	sig.append(0x61);
	sig.append(0x6c);
	sig.append(0xa6);
	sig.append(0x51);
	sig.append(0x77);
	sig.append(0xde);
	sig.append(0xb1);
	sig.append(0xf6);
	sig.append(0x9a);
	sig.append(0x61);
	sig.append(0x48);
	sig.append(0x15);
	sig.append(0x19);
	sig.append(0x91);
	sig.append(0xc2);
	sig.append(0x5e);
	sig.append(0x6c);
	sig.append(0xed);
	sig.append(0x29);
	sig.append(0x4f);
	sig.append(0x6e);
	sig.append(0xb2);
	sig.append(0x37);
	sig.append(0x7c);
	sig.append(0xd4);
	sig.append(0x9c);
	sig.append(0x6);
	sig.append(0xa7);
	sig.append(0xe5);
	sig.append(0x98);
	sig.append(0xe5);
	sig.append(0x41);
	sig.append(0x11);
	sig.append(0xbb);
	sig.append(0x66);
	sig.append(0xe4);
	sig.append(0xc0);
	sig.append(0x84);
	sig.append(0x9e);
	sig.append(0xca);
	sig.append(0x24);
	let pk = PublicKey {
		 x: 51433912458511107164458704190198697145314552054458208226930830323647644118402, 
		 y: 112403046405652821248888504113111252163791181090021947887817912033775374958572
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
	hash.append(0xa0);
	hash.append(0x24);
	hash.append(0x33);
	hash.append(0x8d);
	hash.append(0x74);
	hash.append(0xb0);
	hash.append(0xc8);
	hash.append(0x48);
	hash.append(0x41);
	hash.append(0xf0);
	hash.append(0x3d);
	hash.append(0xcb);
	hash.append(0xe7);
	hash.append(0x8a);
	hash.append(0x61);
	hash.append(0xce);
	hash.append(0xcb);
	hash.append(0x9);
	hash.append(0x91);
	hash.append(0xf3);
	hash.append(0xee);
	hash.append(0x51);
	hash.append(0x57);
	hash.append(0x14);
	hash.append(0x5c);
	hash.append(0x19);
	hash.append(0xb3);
	hash.append(0xc2);
	hash.append(0x56);
	hash.append(0x43);
	hash.append(0xe4);
	hash.append(0x7c);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x79);
	auth_data.append(0x4);
	auth_data.append(0xe4);
	auth_data.append(0x75);
	auth_data.append(0xc3);
	auth_data.append(0x1f);
	auth_data.append(0x6e);
	auth_data.append(0xe0);
	auth_data.append(0x89);
	auth_data.append(0x9b);
	auth_data.append(0xb8);
	auth_data.append(0xa1);
	auth_data.append(0x2);
	auth_data.append(0x2d);
	auth_data.append(0x6e);
	auth_data.append(0xe);
	auth_data.append(0xff);
	auth_data.append(0x37);
	auth_data.append(0x63);
	auth_data.append(0xcb);
	auth_data.append(0xc7);
	auth_data.append(0x91);
	auth_data.append(0xb8);
	auth_data.append(0x3a);
	auth_data.append(0x2d);
	auth_data.append(0xe7);
	auth_data.append(0x99);
	auth_data.append(0x56);
	auth_data.append(0x7c);
	auth_data.append(0xa4);
	auth_data.append(0xa6);
	auth_data.append(0x15);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x93);
	sig.append(0x40);
	sig.append(0x35);
	sig.append(0x70);
	sig.append(0x73);
	sig.append(0xfc);
	sig.append(0xf8);
	sig.append(0x8e);
	sig.append(0x57);
	sig.append(0x51);
	sig.append(0xc9);
	sig.append(0xc7);
	sig.append(0xd0);
	sig.append(0x97);
	sig.append(0x29);
	sig.append(0xfb);
	sig.append(0x2a);
	sig.append(0xe);
	sig.append(0x2b);
	sig.append(0xd9);
	sig.append(0x42);
	sig.append(0xd9);
	sig.append(0xad);
	sig.append(0xfc);
	sig.append(0xe4);
	sig.append(0xad);
	sig.append(0xba);
	sig.append(0x5c);
	sig.append(0xa9);
	sig.append(0xbe);
	sig.append(0x85);
	sig.append(0xda);
	sig.append(0x59);
	sig.append(0xeb);
	sig.append(0xe1);
	sig.append(0xed);
	sig.append(0xab);
	sig.append(0xf7);
	sig.append(0xad);
	sig.append(0xf);
	sig.append(0x8e);
	sig.append(0x24);
	sig.append(0x2b);
	sig.append(0x2f);
	sig.append(0x73);
	sig.append(0xc5);
	sig.append(0x61);
	sig.append(0xdc);
	sig.append(0xe9);
	sig.append(0x2);
	sig.append(0xd8);
	sig.append(0xf8);
	sig.append(0x8a);
	sig.append(0xdd);
	sig.append(0x10);
	sig.append(0x27);
	sig.append(0xb4);
	sig.append(0xc1);
	sig.append(0x95);
	sig.append(0x81);
	sig.append(0xd);
	sig.append(0xd6);
	sig.append(0xdc);
	sig.append(0xcf);
	let pk = PublicKey {
		 x: 26655792660337593206437930429691368551299146009750983293670143519242799702553, 
		 y: 87647649830268020426432082113220492680354126267818401024181802724337495711729
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
	hash.append(0xf4);
	hash.append(0x5a);
	hash.append(0xb6);
	hash.append(0x8e);
	hash.append(0x6a);
	hash.append(0x97);
	hash.append(0xbc);
	hash.append(0x1d);
	hash.append(0x38);
	hash.append(0x31);
	hash.append(0xad);
	hash.append(0x36);
	hash.append(0xd9);
	hash.append(0x4f);
	hash.append(0xd6);
	hash.append(0xe0);
	hash.append(0x6a);
	hash.append(0xf8);
	hash.append(0x72);
	hash.append(0x97);
	hash.append(0x95);
	hash.append(0x20);
	hash.append(0xb3);
	hash.append(0xb5);
	hash.append(0x4a);
	hash.append(0x59);
	hash.append(0x8);
	hash.append(0x1);
	hash.append(0x7b);
	hash.append(0x77);
	hash.append(0x18);
	hash.append(0xd1);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x46);
	auth_data.append(0x12);
	auth_data.append(0x6e);
	auth_data.append(0x1b);
	auth_data.append(0xf2);
	auth_data.append(0x2f);
	auth_data.append(0x25);
	auth_data.append(0x4c);
	auth_data.append(0xff);
	auth_data.append(0xb4);
	auth_data.append(0x2a);
	auth_data.append(0xef);
	auth_data.append(0x1a);
	auth_data.append(0x1e);
	auth_data.append(0xbf);
	auth_data.append(0xa8);
	auth_data.append(0xa6);
	auth_data.append(0x5a);
	auth_data.append(0x8f);
	auth_data.append(0x60);
	auth_data.append(0x19);
	auth_data.append(0x96);
	auth_data.append(0xdf);
	auth_data.append(0xb1);
	auth_data.append(0x7b);
	auth_data.append(0xe);
	auth_data.append(0x44);
	auth_data.append(0x5f);
	auth_data.append(0xd3);
	auth_data.append(0xca);
	auth_data.append(0xbf);
	auth_data.append(0x8c);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xdd);
	sig.append(0xe3);
	sig.append(0xe1);
	sig.append(0x89);
	sig.append(0xbf);
	sig.append(0xd3);
	sig.append(0x1);
	sig.append(0xf);
	sig.append(0x76);
	sig.append(0x98);
	sig.append(0xb1);
	sig.append(0x50);
	sig.append(0x7f);
	sig.append(0x6d);
	sig.append(0x8a);
	sig.append(0xaa);
	sig.append(0xf0);
	sig.append(0xfe);
	sig.append(0xba);
	sig.append(0x70);
	sig.append(0x7e);
	sig.append(0xf1);
	sig.append(0x70);
	sig.append(0xd8);
	sig.append(0x7b);
	sig.append(0xa);
	sig.append(0xbb);
	sig.append(0x42);
	sig.append(0x33);
	sig.append(0x15);
	sig.append(0x40);
	sig.append(0x70);
	sig.append(0x4);
	sig.append(0xfd);
	sig.append(0xd);
	sig.append(0xc);
	sig.append(0x39);
	sig.append(0x63);
	sig.append(0xc1);
	sig.append(0xae);
	sig.append(0xc);
	sig.append(0xd3);
	sig.append(0xda);
	sig.append(0x8d);
	sig.append(0xee);
	sig.append(0x8f);
	sig.append(0xa5);
	sig.append(0x7b);
	sig.append(0x17);
	sig.append(0x35);
	sig.append(0xd6);
	sig.append(0xff);
	sig.append(0xcc);
	sig.append(0xd);
	sig.append(0x68);
	sig.append(0x16);
	sig.append(0x7b);
	sig.append(0x24);
	sig.append(0x51);
	sig.append(0x48);
	sig.append(0xed);
	sig.append(0xcd);
	sig.append(0x6);
	sig.append(0x74);
	let pk = PublicKey {
		 x: 47572600532379441151045920284709874249474522633466997383982335761970678959876, 
		 y: 85305581203708391567186488089708763898401471937002945701110635066199442145291
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
	hash.append(0x9a);
	hash.append(0x2b);
	hash.append(0xa6);
	hash.append(0x82);
	hash.append(0x10);
	hash.append(0xe0);
	hash.append(0x41);
	hash.append(0xa7);
	hash.append(0x65);
	hash.append(0x96);
	hash.append(0x9b);
	hash.append(0x3b);
	hash.append(0x4e);
	hash.append(0x4d);
	hash.append(0xe7);
	hash.append(0x20);
	hash.append(0xff);
	hash.append(0xbf);
	hash.append(0x94);
	hash.append(0x3f);
	hash.append(0xbb);
	hash.append(0x25);
	hash.append(0xe0);
	hash.append(0x1);
	hash.append(0xca);
	hash.append(0x4c);
	hash.append(0xce);
	hash.append(0xf3);
	hash.append(0x4d);
	hash.append(0x2a);
	hash.append(0xdd);
	hash.append(0xd3);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x88);
	auth_data.append(0x29);
	auth_data.append(0xd5);
	auth_data.append(0xe9);
	auth_data.append(0x15);
	auth_data.append(0x73);
	auth_data.append(0xb2);
	auth_data.append(0xc9);
	auth_data.append(0x24);
	auth_data.append(0x97);
	auth_data.append(0x17);
	auth_data.append(0x30);
	auth_data.append(0xcd);
	auth_data.append(0x25);
	auth_data.append(0x76);
	auth_data.append(0xc0);
	auth_data.append(0x49);
	auth_data.append(0xd);
	auth_data.append(0x88);
	auth_data.append(0xeb);
	auth_data.append(0xb7);
	auth_data.append(0xfa);
	auth_data.append(0xb0);
	auth_data.append(0xda);
	auth_data.append(0xb2);
	auth_data.append(0xd9);
	auth_data.append(0xc8);
	auth_data.append(0x3e);
	auth_data.append(0x62);
	auth_data.append(0xc4);
	auth_data.append(0x55);
	auth_data.append(0xd0);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xd4);
	sig.append(0xf5);
	sig.append(0x67);
	sig.append(0x25);
	sig.append(0x63);
	sig.append(0xd6);
	sig.append(0x3e);
	sig.append(0xbe);
	sig.append(0x62);
	sig.append(0x3c);
	sig.append(0x72);
	sig.append(0xa7);
	sig.append(0x9e);
	sig.append(0xb1);
	sig.append(0x6e);
	sig.append(0x79);
	sig.append(0xdb);
	sig.append(0x6);
	sig.append(0x53);
	sig.append(0x38);
	sig.append(0x3b);
	sig.append(0xdb);
	sig.append(0x90);
	sig.append(0xa9);
	sig.append(0x4b);
	sig.append(0xef);
	sig.append(0xff);
	sig.append(0x6b);
	sig.append(0x14);
	sig.append(0x2);
	sig.append(0xd3);
	sig.append(0x2);
	sig.append(0x2a);
	sig.append(0x29);
	sig.append(0xd3);
	sig.append(0x8e);
	sig.append(0xc6);
	sig.append(0x6c);
	sig.append(0x8f);
	sig.append(0x1f);
	sig.append(0x4e);
	sig.append(0x51);
	sig.append(0x48);
	sig.append(0x32);
	sig.append(0xd4);
	sig.append(0x99);
	sig.append(0xa2);
	sig.append(0xea);
	sig.append(0x4d);
	sig.append(0x80);
	sig.append(0x85);
	sig.append(0x0);
	sig.append(0xe);
	sig.append(0x5f);
	sig.append(0x5b);
	sig.append(0x57);
	sig.append(0xb0);
	sig.append(0xef);
	sig.append(0x76);
	sig.append(0x92);
	sig.append(0xf5);
	sig.append(0xf0);
	sig.append(0x5);
	sig.append(0xb7);
	let pk = PublicKey {
		 x: 39578401308924283432437067501887348529389950866763012362525829892470443745454, 
		 y: 78253439005499503492755414344006496144808387110494692382363936679841383828479
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
	hash.append(0x5f);
	hash.append(0xbd);
	hash.append(0xd3);
	hash.append(0x32);
	hash.append(0x5a);
	hash.append(0xf0);
	hash.append(0x71);
	hash.append(0x6b);
	hash.append(0xf7);
	hash.append(0x2d);
	hash.append(0x74);
	hash.append(0x48);
	hash.append(0xe2);
	hash.append(0x16);
	hash.append(0xa3);
	hash.append(0xbd);
	hash.append(0xd5);
	hash.append(0x2f);
	hash.append(0x4b);
	hash.append(0xad);
	hash.append(0xa);
	hash.append(0x1b);
	hash.append(0x69);
	hash.append(0x9f);
	hash.append(0xfc);
	hash.append(0x70);
	hash.append(0xa1);
	hash.append(0x1);
	hash.append(0x88);
	hash.append(0x7e);
	hash.append(0x21);
	hash.append(0xd3);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x91);
	auth_data.append(0xf7);
	auth_data.append(0xf5);
	auth_data.append(0x3);
	auth_data.append(0xdd);
	auth_data.append(0xa6);
	auth_data.append(0xa7);
	auth_data.append(0xa6);
	auth_data.append(0x4e);
	auth_data.append(0xbc);
	auth_data.append(0x55);
	auth_data.append(0xe4);
	auth_data.append(0x78);
	auth_data.append(0x41);
	auth_data.append(0xc4);
	auth_data.append(0xc1);
	auth_data.append(0x28);
	auth_data.append(0xd3);
	auth_data.append(0xc7);
	auth_data.append(0x73);
	auth_data.append(0x29);
	auth_data.append(0x48);
	auth_data.append(0xcc);
	auth_data.append(0x67);
	auth_data.append(0x94);
	auth_data.append(0xce);
	auth_data.append(0x92);
	auth_data.append(0xd0);
	auth_data.append(0x2c);
	auth_data.append(0x40);
	auth_data.append(0x10);
	auth_data.append(0xfa);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xf6);
	sig.append(0xda);
	sig.append(0x13);
	sig.append(0x13);
	sig.append(0x1d);
	sig.append(0xb0);
	sig.append(0xd8);
	sig.append(0x16);
	sig.append(0xa9);
	sig.append(0x4);
	sig.append(0x7c);
	sig.append(0xa7);
	sig.append(0x5);
	sig.append(0x7a);
	sig.append(0x32);
	sig.append(0x77);
	sig.append(0x47);
	sig.append(0xa4);
	sig.append(0x19);
	sig.append(0xf1);
	sig.append(0x4d);
	sig.append(0x30);
	sig.append(0xee);
	sig.append(0xc4);
	sig.append(0x63);
	sig.append(0x17);
	sig.append(0xb);
	sig.append(0x1c);
	sig.append(0x16);
	sig.append(0x70);
	sig.append(0xfc);
	sig.append(0x3e);
	sig.append(0x6f);
	sig.append(0x5d);
	sig.append(0x64);
	sig.append(0x50);
	sig.append(0x8);
	sig.append(0x4b);
	sig.append(0xbf);
	sig.append(0xdc);
	sig.append(0x5a);
	sig.append(0xb2);
	sig.append(0x58);
	sig.append(0xe3);
	sig.append(0x9b);
	sig.append(0x70);
	sig.append(0xc8);
	sig.append(0x3e);
	sig.append(0x52);
	sig.append(0x68);
	sig.append(0xb8);
	sig.append(0x46);
	sig.append(0xae);
	sig.append(0x38);
	sig.append(0xf);
	sig.append(0x81);
	sig.append(0x2c);
	sig.append(0x6b);
	sig.append(0xb0);
	sig.append(0xb7);
	sig.append(0xf);
	sig.append(0x3e);
	sig.append(0x21);
	sig.append(0x1f);
	let pk = PublicKey {
		 x: 67365681697757700628404517949260347494570105912034116860017275083225091294720, 
		 y: 93925313539503161466451469350916731670456653279334430131251267841915015029278
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
	hash.append(0x77);
	hash.append(0x75);
	hash.append(0x6d);
	hash.append(0xe4);
	hash.append(0xb7);
	hash.append(0xea);
	hash.append(0xac);
	hash.append(0x54);
	hash.append(0xec);
	hash.append(0x23);
	hash.append(0x8a);
	hash.append(0xb2);
	hash.append(0x53);
	hash.append(0x7a);
	hash.append(0xe9);
	hash.append(0xce);
	hash.append(0xc);
	hash.append(0xdc);
	hash.append(0xe5);
	hash.append(0x72);
	hash.append(0xba);
	hash.append(0x8);
	hash.append(0x44);
	hash.append(0x70);
	hash.append(0x3c);
	hash.append(0x29);
	hash.append(0xb);
	hash.append(0x13);
	hash.append(0xb9);
	hash.append(0x66);
	hash.append(0x77);
	hash.append(0x72);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x90);
	auth_data.append(0x69);
	auth_data.append(0xb);
	auth_data.append(0x2);
	auth_data.append(0x88);
	auth_data.append(0xe5);
	auth_data.append(0x9);
	auth_data.append(0x3f);
	auth_data.append(0xc3);
	auth_data.append(0x9);
	auth_data.append(0xc1);
	auth_data.append(0x7b);
	auth_data.append(0x33);
	auth_data.append(0x5c);
	auth_data.append(0xff);
	auth_data.append(0x7);
	auth_data.append(0xb6);
	auth_data.append(0x38);
	auth_data.append(0x4c);
	auth_data.append(0xe6);
	auth_data.append(0xd3);
	auth_data.append(0xb9);
	auth_data.append(0x8f);
	auth_data.append(0xe6);
	auth_data.append(0x5f);
	auth_data.append(0x4);
	auth_data.append(0xf);
	auth_data.append(0xdb);
	auth_data.append(0x72);
	auth_data.append(0x7b);
	auth_data.append(0x28);
	auth_data.append(0x23);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x11);
	sig.append(0x8a);
	sig.append(0x9d);
	sig.append(0xff);
	sig.append(0x20);
	sig.append(0x9a);
	sig.append(0x57);
	sig.append(0x7b);
	sig.append(0x70);
	sig.append(0x8a);
	sig.append(0x52);
	sig.append(0xab);
	sig.append(0xea);
	sig.append(0xa6);
	sig.append(0x4b);
	sig.append(0x9f);
	sig.append(0x19);
	sig.append(0x1);
	sig.append(0x16);
	sig.append(0x59);
	sig.append(0xf5);
	sig.append(0x6d);
	sig.append(0x4d);
	sig.append(0xd6);
	sig.append(0xfb);
	sig.append(0x15);
	sig.append(0xaf);
	sig.append(0x13);
	sig.append(0x0);
	sig.append(0x2d);
	sig.append(0xc8);
	sig.append(0x46);
	sig.append(0xd5);
	sig.append(0xaf);
	sig.append(0x5e);
	sig.append(0xc2);
	sig.append(0xf1);
	sig.append(0x15);
	sig.append(0xdb);
	sig.append(0xe2);
	sig.append(0xdc);
	sig.append(0x72);
	sig.append(0x9a);
	sig.append(0xb4);
	sig.append(0xc8);
	sig.append(0xa2);
	sig.append(0x3a);
	sig.append(0x5c);
	sig.append(0x5e);
	sig.append(0x43);
	sig.append(0x89);
	sig.append(0xcd);
	sig.append(0x27);
	sig.append(0x71);
	sig.append(0x89);
	sig.append(0x99);
	sig.append(0x7f);
	sig.append(0x1e);
	sig.append(0x4c);
	sig.append(0x57);
	sig.append(0xeb);
	sig.append(0x91);
	sig.append(0xa8);
	sig.append(0xff);
	let pk = PublicKey {
		 x: 8224356367265768767057607377397261915465988419375715666541799790686347956240, 
		 y: 75033738894578806783998461043031027362697173626033998447728546152702025758148
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
	hash.append(0x4c);
	hash.append(0x7e);
	hash.append(0x94);
	hash.append(0x82);
	hash.append(0xa3);
	hash.append(0x35);
	hash.append(0xf1);
	hash.append(0xc8);
	hash.append(0xce);
	hash.append(0x35);
	hash.append(0xe5);
	hash.append(0xbd);
	hash.append(0x85);
	hash.append(0xd9);
	hash.append(0x81);
	hash.append(0x61);
	hash.append(0x1c);
	hash.append(0x19);
	hash.append(0xeb);
	hash.append(0x7d);
	hash.append(0x22);
	hash.append(0x58);
	hash.append(0xd8);
	hash.append(0xf8);
	hash.append(0x8f);
	hash.append(0x4c);
	hash.append(0x89);
	hash.append(0x14);
	hash.append(0x52);
	hash.append(0xa9);
	hash.append(0xfe);
	hash.append(0x60);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x9c);
	auth_data.append(0x7c);
	auth_data.append(0x71);
	auth_data.append(0xdc);
	auth_data.append(0x1a);
	auth_data.append(0x69);
	auth_data.append(0x19);
	auth_data.append(0xb2);
	auth_data.append(0x9b);
	auth_data.append(0xbc);
	auth_data.append(0x6);
	auth_data.append(0xca);
	auth_data.append(0xad);
	auth_data.append(0x8f);
	auth_data.append(0x89);
	auth_data.append(0xe6);
	auth_data.append(0xef);
	auth_data.append(0x1c);
	auth_data.append(0x79);
	auth_data.append(0xda);
	auth_data.append(0xbc);
	auth_data.append(0x54);
	auth_data.append(0x93);
	auth_data.append(0x9);
	auth_data.append(0x34);
	auth_data.append(0x27);
	auth_data.append(0x44);
	auth_data.append(0x5d);
	auth_data.append(0xb6);
	auth_data.append(0xc6);
	auth_data.append(0x1d);
	auth_data.append(0x8e);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x39);
	sig.append(0x83);
	sig.append(0xb8);
	sig.append(0x33);
	sig.append(0x1f);
	sig.append(0x8f);
	sig.append(0x2e);
	sig.append(0x0);
	sig.append(0x10);
	sig.append(0x61);
	sig.append(0x64);
	sig.append(0x5a);
	sig.append(0x5d);
	sig.append(0x61);
	sig.append(0xeb);
	sig.append(0xd2);
	sig.append(0x97);
	sig.append(0x49);
	sig.append(0xb4);
	sig.append(0x64);
	sig.append(0xf5);
	sig.append(0xdc);
	sig.append(0xce);
	sig.append(0x0);
	sig.append(0x1c);
	sig.append(0x4a);
	sig.append(0x69);
	sig.append(0x67);
	sig.append(0xca);
	sig.append(0x50);
	sig.append(0x54);
	sig.append(0x1);
	sig.append(0xc4);
	sig.append(0xf0);
	sig.append(0xcf);
	sig.append(0xa5);
	sig.append(0xb6);
	sig.append(0x8f);
	sig.append(0x6d);
	sig.append(0x76);
	sig.append(0x1c);
	sig.append(0xe0);
	sig.append(0xbb);
	sig.append(0xca);
	sig.append(0x9d);
	sig.append(0x7a);
	sig.append(0xae);
	sig.append(0xdb);
	sig.append(0x8f);
	sig.append(0x39);
	sig.append(0x1);
	sig.append(0x47);
	sig.append(0xf8);
	sig.append(0x96);
	sig.append(0x65);
	sig.append(0xbb);
	sig.append(0x3a);
	sig.append(0x35);
	sig.append(0x76);
	sig.append(0xd1);
	sig.append(0x2a);
	sig.append(0xd2);
	sig.append(0xda);
	sig.append(0x5);
	let pk = PublicKey {
		 x: 9982668974529383302778758602941864963283087685644977679397133457725659362678, 
		 y: 114869384173757787338829461233949046798368628089022310000877937680719146988237
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
	hash.append(0x4f);
	hash.append(0x9);
	hash.append(0xcd);
	hash.append(0xbb);
	hash.append(0x5d);
	hash.append(0x5c);
	hash.append(0x8a);
	hash.append(0x62);
	hash.append(0x6a);
	hash.append(0x90);
	hash.append(0x2b);
	hash.append(0xc);
	hash.append(0x6);
	hash.append(0x5b);
	hash.append(0xad);
	hash.append(0x96);
	hash.append(0x75);
	hash.append(0xc6);
	hash.append(0xda);
	hash.append(0x8d);
	hash.append(0x98);
	hash.append(0x22);
	hash.append(0xd7);
	hash.append(0x1);
	hash.append(0xeb);
	hash.append(0x9f);
	hash.append(0xec);
	hash.append(0x4d);
	hash.append(0x74);
	hash.append(0x12);
	hash.append(0x68);
	hash.append(0xb4);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xc);
	auth_data.append(0x8b);
	auth_data.append(0x0);
	auth_data.append(0x95);
	auth_data.append(0xcc);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x53);
	auth_data.append(0x2f);
	auth_data.append(0xb2);
	auth_data.append(0x2a);
	auth_data.append(0x7);
	auth_data.append(0x17);
	auth_data.append(0xe9);
	auth_data.append(0x69);
	auth_data.append(0x8);
	auth_data.append(0xf1);
	auth_data.append(0x1f);
	auth_data.append(0x6c);
	auth_data.append(0x53);
	auth_data.append(0xf5);
	auth_data.append(0xeb);
	auth_data.append(0xee);
	auth_data.append(0xd3);
	auth_data.append(0x0);
	auth_data.append(0x8a);
	auth_data.append(0xb);
	auth_data.append(0xfd);
	auth_data.append(0xb3);
	auth_data.append(0xac);
	auth_data.append(0x57);
	auth_data.append(0xd9);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x8c);
	sig.append(0x6);
	sig.append(0x54);
	sig.append(0x27);
	sig.append(0xbb);
	sig.append(0x9e);
	sig.append(0x21);
	sig.append(0x51);
	sig.append(0xd4);
	sig.append(0xf7);
	sig.append(0x9a);
	sig.append(0x31);
	sig.append(0xf8);
	sig.append(0x95);
	sig.append(0x67);
	sig.append(0xe);
	sig.append(0xb1);
	sig.append(0x64);
	sig.append(0x3a);
	sig.append(0xb7);
	sig.append(0xd8);
	sig.append(0xba);
	sig.append(0xc0);
	sig.append(0x6b);
	sig.append(0x3a);
	sig.append(0x79);
	sig.append(0x89);
	sig.append(0x3f);
	sig.append(0x26);
	sig.append(0x92);
	sig.append(0xe1);
	sig.append(0xe0);
	sig.append(0xd3);
	sig.append(0x7e);
	sig.append(0xe4);
	sig.append(0x2);
	sig.append(0xb9);
	sig.append(0x86);
	sig.append(0x14);
	sig.append(0x15);
	sig.append(0x6d);
	sig.append(0x5b);
	sig.append(0x6f);
	sig.append(0x7c);
	sig.append(0x83);
	sig.append(0x82);
	sig.append(0x3f);
	sig.append(0xd8);
	sig.append(0xfb);
	sig.append(0xb6);
	sig.append(0x7d);
	sig.append(0xba);
	sig.append(0xed);
	sig.append(0xae);
	sig.append(0xc1);
	sig.append(0x34);
	sig.append(0x42);
	sig.append(0x9e);
	sig.append(0xe7);
	sig.append(0x69);
	sig.append(0x2c);
	sig.append(0xb4);
	sig.append(0xce);
	sig.append(0x10);
	let pk = PublicKey {
		 x: 39174334694137262116319847864691620993131612292957985065736629505783469788732, 
		 y: 86528844267632478584308498647954992010741347159791994455419023713380217581025
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


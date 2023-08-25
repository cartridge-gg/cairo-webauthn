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
	hash.append(0x33);
	hash.append(0x1a);
	hash.append(0x13);
	hash.append(0x6f);
	hash.append(0x2f);
	hash.append(0x2b);
	hash.append(0xbe);
	hash.append(0xcd);
	hash.append(0x59);
	hash.append(0xb5);
	hash.append(0xe);
	hash.append(0xb9);
	hash.append(0x9d);
	hash.append(0xf1);
	hash.append(0x53);
	hash.append(0xb7);
	hash.append(0xe1);
	hash.append(0x53);
	hash.append(0x6a);
	hash.append(0x50);
	hash.append(0x78);
	hash.append(0xc5);
	hash.append(0x5c);
	hash.append(0x74);
	hash.append(0x98);
	hash.append(0x8e);
	hash.append(0xd0);
	hash.append(0x69);
	hash.append(0x7c);
	hash.append(0x42);
	hash.append(0x73);
	hash.append(0xfa);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x16);
	auth_data.append(0x49);
	auth_data.append(0xf3);
	auth_data.append(0x10);
	auth_data.append(0x4d);
	auth_data.append(0xc4);
	auth_data.append(0x74);
	auth_data.append(0xbe);
	auth_data.append(0x69);
	auth_data.append(0x23);
	auth_data.append(0xff);
	auth_data.append(0xfc);
	auth_data.append(0xc9);
	auth_data.append(0xc9);
	auth_data.append(0x77);
	auth_data.append(0x69);
	auth_data.append(0x1c);
	auth_data.append(0xd7);
	auth_data.append(0xa9);
	auth_data.append(0x2d);
	auth_data.append(0x4d);
	auth_data.append(0x76);
	auth_data.append(0x87);
	auth_data.append(0xb8);
	auth_data.append(0x4b);
	auth_data.append(0x9b);
	auth_data.append(0xe5);
	auth_data.append(0x0);
	auth_data.append(0x6);
	auth_data.append(0x4f);
	auth_data.append(0x92);
	auth_data.append(0xe6);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xb1);
	sig.append(0x58);
	sig.append(0x6f);
	sig.append(0x84);
	sig.append(0xd8);
	sig.append(0xc2);
	sig.append(0x28);
	sig.append(0xb8);
	sig.append(0x2e);
	sig.append(0x7e);
	sig.append(0xcf);
	sig.append(0x57);
	sig.append(0xe8);
	sig.append(0x39);
	sig.append(0x13);
	sig.append(0xdf);
	sig.append(0x4);
	sig.append(0x85);
	sig.append(0xb7);
	sig.append(0xdb);
	sig.append(0x26);
	sig.append(0xf7);
	sig.append(0x29);
	sig.append(0xd8);
	sig.append(0x2b);
	sig.append(0x2e);
	sig.append(0xbd);
	sig.append(0x4a);
	sig.append(0xc);
	sig.append(0x74);
	sig.append(0xeb);
	sig.append(0xc8);
	sig.append(0x13);
	sig.append(0xfd);
	sig.append(0x1d);
	sig.append(0x4);
	sig.append(0x70);
	sig.append(0x33);
	sig.append(0x13);
	sig.append(0xf0);
	sig.append(0x5f);
	sig.append(0x32);
	sig.append(0x1d);
	sig.append(0x25);
	sig.append(0x6a);
	sig.append(0x55);
	sig.append(0x75);
	sig.append(0x40);
	sig.append(0xe6);
	sig.append(0x7);
	sig.append(0xe8);
	sig.append(0x34);
	sig.append(0x2a);
	sig.append(0x3f);
	sig.append(0xfe);
	sig.append(0x1);
	sig.append(0xdc);
	sig.append(0x0);
	sig.append(0xb1);
	sig.append(0x6);
	sig.append(0xdd);
	sig.append(0xb4);
	sig.append(0xd1);
	sig.append(0xae);
	let pk = PublicKey {
		 x: 9210146798417521074532790846713254886905012549563904459463684875677405754193, 
		 y: 48268238123855748742933246188156325532495708460164935711811573192615766120862
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
	hash.append(0xc);
	hash.append(0xdc);
	hash.append(0xaa);
	hash.append(0x20);
	hash.append(0xb2);
	hash.append(0x25);
	hash.append(0x8a);
	hash.append(0x44);
	hash.append(0xf3);
	hash.append(0x77);
	hash.append(0x97);
	hash.append(0x29);
	hash.append(0x78);
	hash.append(0x2c);
	hash.append(0x84);
	hash.append(0x62);
	hash.append(0x85);
	hash.append(0x1d);
	hash.append(0x75);
	hash.append(0x80);
	hash.append(0x93);
	hash.append(0x2a);
	hash.append(0x28);
	hash.append(0x4b);
	hash.append(0x7e);
	hash.append(0x98);
	hash.append(0x13);
	hash.append(0x8);
	hash.append(0x72);
	hash.append(0x20);
	hash.append(0x81);
	hash.append(0x4b);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xdc);
	auth_data.append(0xbd);
	auth_data.append(0xf5);
	auth_data.append(0xaa);
	auth_data.append(0xa);
	auth_data.append(0xf1);
	auth_data.append(0xb4);
	auth_data.append(0xb);
	auth_data.append(0xc7);
	auth_data.append(0x8c);
	auth_data.append(0xb);
	auth_data.append(0x76);
	auth_data.append(0x8e);
	auth_data.append(0x88);
	auth_data.append(0x44);
	auth_data.append(0xd1);
	auth_data.append(0xdd);
	auth_data.append(0x4c);
	auth_data.append(0x2e);
	auth_data.append(0x60);
	auth_data.append(0x7b);
	auth_data.append(0x17);
	auth_data.append(0xb9);
	auth_data.append(0x26);
	auth_data.append(0xf0);
	auth_data.append(0x4d);
	auth_data.append(0x1a);
	auth_data.append(0x6d);
	auth_data.append(0x0);
	auth_data.append(0xf8);
	auth_data.append(0x5c);
	auth_data.append(0x30);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x71);
	sig.append(0x78);
	sig.append(0xfa);
	sig.append(0x1a);
	sig.append(0xee);
	sig.append(0x4e);
	sig.append(0x28);
	sig.append(0xd6);
	sig.append(0xee);
	sig.append(0x78);
	sig.append(0x5b);
	sig.append(0x74);
	sig.append(0x77);
	sig.append(0x73);
	sig.append(0x26);
	sig.append(0x74);
	sig.append(0x74);
	sig.append(0xf5);
	sig.append(0xa0);
	sig.append(0x18);
	sig.append(0x3e);
	sig.append(0xe4);
	sig.append(0xfc);
	sig.append(0x9e);
	sig.append(0xcd);
	sig.append(0xb6);
	sig.append(0x99);
	sig.append(0xd2);
	sig.append(0xf7);
	sig.append(0x8e);
	sig.append(0x52);
	sig.append(0xa1);
	sig.append(0x1f);
	sig.append(0x17);
	sig.append(0xbb);
	sig.append(0x46);
	sig.append(0x11);
	sig.append(0xa0);
	sig.append(0x95);
	sig.append(0xe5);
	sig.append(0xc4);
	sig.append(0xa0);
	sig.append(0x2c);
	sig.append(0x3);
	sig.append(0xfc);
	sig.append(0x37);
	sig.append(0x9e);
	sig.append(0xfe);
	sig.append(0xf2);
	sig.append(0x49);
	sig.append(0x59);
	sig.append(0x1e);
	sig.append(0x51);
	sig.append(0x51);
	sig.append(0x70);
	sig.append(0xfa);
	sig.append(0xd2);
	sig.append(0x7f);
	sig.append(0x5f);
	sig.append(0x1a);
	sig.append(0xa8);
	sig.append(0xca);
	sig.append(0xa3);
	sig.append(0xa6);
	let pk = PublicKey {
		 x: 18875253968994105029729145203915284650509492277002212883189920940986828540029, 
		 y: 8245210122688056378181520457341894015835982836381514388367279605532353683417
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
	hash.append(0xc7);
	hash.append(0xe4);
	hash.append(0xcb);
	hash.append(0x7c);
	hash.append(0x5c);
	hash.append(0x7d);
	hash.append(0x98);
	hash.append(0x1a);
	hash.append(0x6);
	hash.append(0x32);
	hash.append(0x6f);
	hash.append(0x82);
	hash.append(0xaa);
	hash.append(0x6d);
	hash.append(0xef);
	hash.append(0x36);
	hash.append(0xff);
	hash.append(0xdd);
	hash.append(0x2f);
	hash.append(0x92);
	hash.append(0xaa);
	hash.append(0x84);
	hash.append(0xe9);
	hash.append(0x27);
	hash.append(0xc);
	hash.append(0xbb);
	hash.append(0x99);
	hash.append(0x87);
	hash.append(0x93);
	hash.append(0x9);
	hash.append(0x89);
	hash.append(0x29);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xbf);
	auth_data.append(0x21);
	auth_data.append(0x58);
	auth_data.append(0xd);
	auth_data.append(0xf7);
	auth_data.append(0x5f);
	auth_data.append(0xcf);
	auth_data.append(0x42);
	auth_data.append(0xaf);
	auth_data.append(0x4a);
	auth_data.append(0x9d);
	auth_data.append(0x68);
	auth_data.append(0x22);
	auth_data.append(0xba);
	auth_data.append(0xa2);
	auth_data.append(0xa1);
	auth_data.append(0x14);
	auth_data.append(0xc9);
	auth_data.append(0xd4);
	auth_data.append(0x47);
	auth_data.append(0xbc);
	auth_data.append(0xf3);
	auth_data.append(0xae);
	auth_data.append(0x4f);
	auth_data.append(0x6a);
	auth_data.append(0xa0);
	auth_data.append(0x20);
	auth_data.append(0x93);
	auth_data.append(0x7f);
	auth_data.append(0xee);
	auth_data.append(0x8f);
	auth_data.append(0x4d);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xe8);
	sig.append(0x1f);
	sig.append(0x41);
	sig.append(0x41);
	sig.append(0xc);
	sig.append(0x2e);
	sig.append(0x5);
	sig.append(0x27);
	sig.append(0xdd);
	sig.append(0xd7);
	sig.append(0x3);
	sig.append(0xc4);
	sig.append(0x1);
	sig.append(0x92);
	sig.append(0x98);
	sig.append(0x3e);
	sig.append(0xe);
	sig.append(0xcb);
	sig.append(0x7b);
	sig.append(0xd1);
	sig.append(0xdb);
	sig.append(0x39);
	sig.append(0x97);
	sig.append(0xfb);
	sig.append(0x70);
	sig.append(0xba);
	sig.append(0x14);
	sig.append(0xc7);
	sig.append(0x33);
	sig.append(0xe6);
	sig.append(0x32);
	sig.append(0x5);
	sig.append(0xf1);
	sig.append(0xaa);
	sig.append(0x3d);
	sig.append(0xca);
	sig.append(0x22);
	sig.append(0xfc);
	sig.append(0xfa);
	sig.append(0xd1);
	sig.append(0xd2);
	sig.append(0x9c);
	sig.append(0xa4);
	sig.append(0x14);
	sig.append(0xcd);
	sig.append(0x19);
	sig.append(0x7d);
	sig.append(0x1e);
	sig.append(0xcc);
	sig.append(0x56);
	sig.append(0x14);
	sig.append(0xd2);
	sig.append(0x3);
	sig.append(0x70);
	sig.append(0x7f);
	sig.append(0x2d);
	sig.append(0x2a);
	sig.append(0x68);
	sig.append(0x42);
	sig.append(0x61);
	sig.append(0xa3);
	sig.append(0x6e);
	sig.append(0x9);
	sig.append(0x83);
	let pk = PublicKey {
		 x: 71347818588264818365839506780999976770656186787258672829079434743738436766937, 
		 y: 54632621917727164055578405676603205850881128358587221021143660092131325095814
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
	hash.append(0xeb);
	hash.append(0x9a);
	hash.append(0x45);
	hash.append(0x6a);
	hash.append(0xb5);
	hash.append(0xe3);
	hash.append(0x19);
	hash.append(0xbf);
	hash.append(0x1f);
	hash.append(0x34);
	hash.append(0xf9);
	hash.append(0x3c);
	hash.append(0x2f);
	hash.append(0x19);
	hash.append(0xf2);
	hash.append(0x7c);
	hash.append(0x7b);
	hash.append(0xc3);
	hash.append(0x57);
	hash.append(0x46);
	hash.append(0x39);
	hash.append(0x19);
	hash.append(0xa4);
	hash.append(0x52);
	hash.append(0x6b);
	hash.append(0x2e);
	hash.append(0x0);
	hash.append(0xcc);
	hash.append(0xd2);
	hash.append(0x8c);
	hash.append(0x3d);
	hash.append(0x5);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xb);
	auth_data.append(0x19);
	auth_data.append(0xea);
	auth_data.append(0xa6);
	auth_data.append(0x9a);
	auth_data.append(0xeb);
	auth_data.append(0x48);
	auth_data.append(0xa3);
	auth_data.append(0xfe);
	auth_data.append(0x4);
	auth_data.append(0x1f);
	auth_data.append(0x75);
	auth_data.append(0x21);
	auth_data.append(0xd8);
	auth_data.append(0xbd);
	auth_data.append(0x50);
	auth_data.append(0x6c);
	auth_data.append(0xff);
	auth_data.append(0x3e);
	auth_data.append(0x1);
	auth_data.append(0x13);
	auth_data.append(0x3c);
	auth_data.append(0xf4);
	auth_data.append(0xc4);
	auth_data.append(0x89);
	auth_data.append(0xb1);
	auth_data.append(0x89);
	auth_data.append(0x52);
	auth_data.append(0xc6);
	auth_data.append(0x8);
	auth_data.append(0xbf);
	auth_data.append(0xbc);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x17);
	sig.append(0x1c);
	sig.append(0xdb);
	sig.append(0xc2);
	sig.append(0xaa);
	sig.append(0x22);
	sig.append(0xdd);
	sig.append(0xc8);
	sig.append(0x57);
	sig.append(0x59);
	sig.append(0x7c);
	sig.append(0x19);
	sig.append(0x44);
	sig.append(0xf4);
	sig.append(0xbf);
	sig.append(0x13);
	sig.append(0xec);
	sig.append(0x23);
	sig.append(0x8a);
	sig.append(0x13);
	sig.append(0xfe);
	sig.append(0xc5);
	sig.append(0xea);
	sig.append(0x62);
	sig.append(0x0);
	sig.append(0x68);
	sig.append(0x3c);
	sig.append(0x48);
	sig.append(0x33);
	sig.append(0xa0);
	sig.append(0x77);
	sig.append(0xc);
	sig.append(0x4);
	sig.append(0xb8);
	sig.append(0xb3);
	sig.append(0x3b);
	sig.append(0x6);
	sig.append(0x9e);
	sig.append(0x98);
	sig.append(0x4);
	sig.append(0x88);
	sig.append(0x97);
	sig.append(0x93);
	sig.append(0x22);
	sig.append(0xc3);
	sig.append(0xfd);
	sig.append(0x90);
	sig.append(0xfd);
	sig.append(0x3);
	sig.append(0x8f);
	sig.append(0xa7);
	sig.append(0xfe);
	sig.append(0x67);
	sig.append(0x5b);
	sig.append(0x3);
	sig.append(0x74);
	sig.append(0x4b);
	sig.append(0x18);
	sig.append(0x3f);
	sig.append(0x89);
	sig.append(0x8a);
	sig.append(0x3c);
	sig.append(0x59);
	sig.append(0xcd);
	let pk = PublicKey {
		 x: 99744936509244511448225966271527055015753371475882593311134011747822520703345, 
		 y: 17191005203385590478567998166204701584804517275473240173413905590470485125441
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
	hash.append(0x95);
	hash.append(0xd3);
	hash.append(0x72);
	hash.append(0x41);
	hash.append(0x3e);
	hash.append(0x59);
	hash.append(0x9a);
	hash.append(0xd2);
	hash.append(0x12);
	hash.append(0xea);
	hash.append(0x2a);
	hash.append(0x6a);
	hash.append(0xe2);
	hash.append(0x4e);
	hash.append(0x87);
	hash.append(0x85);
	hash.append(0xe3);
	hash.append(0xf1);
	hash.append(0x8f);
	hash.append(0xaf);
	hash.append(0x60);
	hash.append(0xfb);
	hash.append(0xc8);
	hash.append(0xe9);
	hash.append(0x58);
	hash.append(0x1d);
	hash.append(0xe6);
	hash.append(0x77);
	hash.append(0xd3);
	hash.append(0xd2);
	hash.append(0x5e);
	hash.append(0x95);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xc9);
	auth_data.append(0x51);
	auth_data.append(0x41);
	auth_data.append(0x8f);
	auth_data.append(0x78);
	auth_data.append(0x10);
	auth_data.append(0x81);
	auth_data.append(0x39);
	auth_data.append(0x7e);
	auth_data.append(0x2d);
	auth_data.append(0x2e);
	auth_data.append(0x8a);
	auth_data.append(0x32);
	auth_data.append(0xe9);
	auth_data.append(0xeb);
	auth_data.append(0x12);
	auth_data.append(0x0);
	auth_data.append(0xa);
	auth_data.append(0x19);
	auth_data.append(0xca);
	auth_data.append(0x17);
	auth_data.append(0xbd);
	auth_data.append(0xa4);
	auth_data.append(0x12);
	auth_data.append(0xbb);
	auth_data.append(0x9d);
	auth_data.append(0xee);
	auth_data.append(0xc9);
	auth_data.append(0xc4);
	auth_data.append(0x66);
	auth_data.append(0xc3);
	auth_data.append(0x3);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa1);
	sig.append(0x6f);
	sig.append(0x68);
	sig.append(0x8b);
	sig.append(0xe5);
	sig.append(0x1d);
	sig.append(0xb2);
	sig.append(0x8f);
	sig.append(0xe8);
	sig.append(0x87);
	sig.append(0xf);
	sig.append(0xfc);
	sig.append(0x62);
	sig.append(0xd8);
	sig.append(0x87);
	sig.append(0xf3);
	sig.append(0xd4);
	sig.append(0x69);
	sig.append(0x3c);
	sig.append(0x49);
	sig.append(0x3e);
	sig.append(0xa6);
	sig.append(0x6d);
	sig.append(0x2);
	sig.append(0x66);
	sig.append(0x47);
	sig.append(0x94);
	sig.append(0xd1);
	sig.append(0x1b);
	sig.append(0xe7);
	sig.append(0x45);
	sig.append(0xf6);
	sig.append(0x63);
	sig.append(0xef);
	sig.append(0x2f);
	sig.append(0xca);
	sig.append(0x3e);
	sig.append(0xd0);
	sig.append(0xfc);
	sig.append(0x4a);
	sig.append(0xd2);
	sig.append(0x92);
	sig.append(0xcd);
	sig.append(0xdf);
	sig.append(0x14);
	sig.append(0x71);
	sig.append(0x1c);
	sig.append(0x5d);
	sig.append(0x7b);
	sig.append(0xfa);
	sig.append(0xd0);
	sig.append(0xa8);
	sig.append(0xe5);
	sig.append(0xa8);
	sig.append(0x56);
	sig.append(0x5c);
	sig.append(0x26);
	sig.append(0x63);
	sig.append(0x1f);
	sig.append(0x94);
	sig.append(0xae);
	sig.append(0x31);
	sig.append(0x52);
	sig.append(0x74);
	let pk = PublicKey {
		 x: 60819400173357089058420453302317517005225906079403266569020455587016408321277, 
		 y: 72078087057884912988619895759261465603776392191937981189142073417854684187918
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
	hash.append(0xbf);
	hash.append(0x76);
	hash.append(0x6d);
	hash.append(0xde);
	hash.append(0xe9);
	hash.append(0xea);
	hash.append(0x5c);
	hash.append(0xe3);
	hash.append(0x84);
	hash.append(0x6d);
	hash.append(0xbb);
	hash.append(0x7c);
	hash.append(0x3b);
	hash.append(0x63);
	hash.append(0x1);
	hash.append(0x80);
	hash.append(0x5);
	hash.append(0xd7);
	hash.append(0xc4);
	hash.append(0x45);
	hash.append(0x38);
	hash.append(0xc5);
	hash.append(0x1c);
	hash.append(0x25);
	hash.append(0xf4);
	hash.append(0x38);
	hash.append(0x22);
	hash.append(0xb3);
	hash.append(0x73);
	hash.append(0xcb);
	hash.append(0xd);
	hash.append(0xa1);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xc7);
	auth_data.append(0xfe);
	auth_data.append(0xfb);
	auth_data.append(0x88);
	auth_data.append(0xc9);
	auth_data.append(0x8f);
	auth_data.append(0x7e);
	auth_data.append(0x67);
	auth_data.append(0x35);
	auth_data.append(0x31);
	auth_data.append(0x5e);
	auth_data.append(0xd9);
	auth_data.append(0xc);
	auth_data.append(0x5c);
	auth_data.append(0x88);
	auth_data.append(0x4c);
	auth_data.append(0x87);
	auth_data.append(0x79);
	auth_data.append(0x8e);
	auth_data.append(0xd7);
	auth_data.append(0x7f);
	auth_data.append(0xc1);
	auth_data.append(0x7f);
	auth_data.append(0x99);
	auth_data.append(0x14);
	auth_data.append(0x71);
	auth_data.append(0xe0);
	auth_data.append(0x6f);
	auth_data.append(0x47);
	auth_data.append(0xf8);
	auth_data.append(0xe1);
	auth_data.append(0x99);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xcf);
	sig.append(0x95);
	sig.append(0xc7);
	sig.append(0x5c);
	sig.append(0x97);
	sig.append(0x9c);
	sig.append(0xe5);
	sig.append(0x7a);
	sig.append(0x71);
	sig.append(0x9c);
	sig.append(0x8c);
	sig.append(0xf7);
	sig.append(0x7);
	sig.append(0xbd);
	sig.append(0x50);
	sig.append(0xdc);
	sig.append(0x9c);
	sig.append(0xdc);
	sig.append(0xd7);
	sig.append(0xc5);
	sig.append(0x29);
	sig.append(0xc7);
	sig.append(0x5a);
	sig.append(0xde);
	sig.append(0x1c);
	sig.append(0xf0);
	sig.append(0xbe);
	sig.append(0x88);
	sig.append(0xac);
	sig.append(0x82);
	sig.append(0xa1);
	sig.append(0xe3);
	sig.append(0x13);
	sig.append(0x3);
	sig.append(0xd0);
	sig.append(0xbd);
	sig.append(0xa9);
	sig.append(0x8f);
	sig.append(0xe4);
	sig.append(0x56);
	sig.append(0x98);
	sig.append(0x67);
	sig.append(0x4c);
	sig.append(0xd7);
	sig.append(0xf4);
	sig.append(0x92);
	sig.append(0x25);
	sig.append(0x9d);
	sig.append(0xbf);
	sig.append(0x9b);
	sig.append(0xa5);
	sig.append(0x9a);
	sig.append(0xf2);
	sig.append(0xca);
	sig.append(0x6);
	sig.append(0xe5);
	sig.append(0xec);
	sig.append(0x81);
	sig.append(0x5e);
	sig.append(0x37);
	sig.append(0xee);
	sig.append(0x91);
	sig.append(0xf6);
	sig.append(0xb9);
	let pk = PublicKey {
		 x: 57049812453368303214542066842575357357944561349706543370928308042334502654022, 
		 y: 59437295809581646598564344301356210598825847652099909437837469129859651475927
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
	hash.append(0x4b);
	hash.append(0x4f);
	hash.append(0x8f);
	hash.append(0xf9);
	hash.append(0x74);
	hash.append(0x43);
	hash.append(0xfe);
	hash.append(0x29);
	hash.append(0x37);
	hash.append(0x9b);
	hash.append(0x95);
	hash.append(0x29);
	hash.append(0xfb);
	hash.append(0xd8);
	hash.append(0x89);
	hash.append(0xb);
	hash.append(0x1d);
	hash.append(0xe7);
	hash.append(0x2);
	hash.append(0x49);
	hash.append(0xbe);
	hash.append(0xda);
	hash.append(0x53);
	hash.append(0x69);
	hash.append(0x27);
	hash.append(0xde);
	hash.append(0xfe);
	hash.append(0xb6);
	hash.append(0xab);
	hash.append(0x4d);
	hash.append(0xfd);
	hash.append(0x56);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xa4);
	auth_data.append(0x3f);
	auth_data.append(0xf8);
	auth_data.append(0xec);
	auth_data.append(0x98);
	auth_data.append(0x28);
	auth_data.append(0xb9);
	auth_data.append(0xc0);
	auth_data.append(0x78);
	auth_data.append(0xd3);
	auth_data.append(0x28);
	auth_data.append(0x80);
	auth_data.append(0x4b);
	auth_data.append(0x4f);
	auth_data.append(0x60);
	auth_data.append(0xf0);
	auth_data.append(0xaf);
	auth_data.append(0x82);
	auth_data.append(0xf5);
	auth_data.append(0x4a);
	auth_data.append(0x61);
	auth_data.append(0x6a);
	auth_data.append(0x33);
	auth_data.append(0x41);
	auth_data.append(0xb2);
	auth_data.append(0x3f);
	auth_data.append(0x4b);
	auth_data.append(0x34);
	auth_data.append(0x47);
	auth_data.append(0xb1);
	auth_data.append(0x6);
	auth_data.append(0x29);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x84);
	sig.append(0xa7);
	sig.append(0x84);
	sig.append(0xf8);
	sig.append(0x19);
	sig.append(0x1);
	sig.append(0x50);
	sig.append(0x76);
	sig.append(0xf0);
	sig.append(0xbf);
	sig.append(0x30);
	sig.append(0x51);
	sig.append(0x73);
	sig.append(0x89);
	sig.append(0xe1);
	sig.append(0x95);
	sig.append(0xa);
	sig.append(0xe4);
	sig.append(0x2a);
	sig.append(0xb3);
	sig.append(0x6e);
	sig.append(0x58);
	sig.append(0xce);
	sig.append(0x43);
	sig.append(0x43);
	sig.append(0xda);
	sig.append(0x1c);
	sig.append(0x81);
	sig.append(0xc6);
	sig.append(0x30);
	sig.append(0x78);
	sig.append(0x5);
	sig.append(0x91);
	sig.append(0xf8);
	sig.append(0x5);
	sig.append(0xf5);
	sig.append(0x59);
	sig.append(0x74);
	sig.append(0x76);
	sig.append(0xb9);
	sig.append(0x84);
	sig.append(0x70);
	sig.append(0x49);
	sig.append(0xe3);
	sig.append(0x50);
	sig.append(0x2e);
	sig.append(0x9);
	sig.append(0xd1);
	sig.append(0x63);
	sig.append(0x95);
	sig.append(0xd4);
	sig.append(0x23);
	sig.append(0xd7);
	sig.append(0xeb);
	sig.append(0x2);
	sig.append(0xe6);
	sig.append(0x9b);
	sig.append(0xde);
	sig.append(0xcd);
	sig.append(0xe4);
	sig.append(0x6c);
	sig.append(0x47);
	sig.append(0xb4);
	sig.append(0x99);
	let pk = PublicKey {
		 x: 31920096661951574145874463691645168914190884026377409780082363498374722018846, 
		 y: 34398141186765857067836196321981711521837703284960241815618043678281243223989
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
	hash.append(0x70);
	hash.append(0x45);
	hash.append(0x90);
	hash.append(0x86);
	hash.append(0x60);
	hash.append(0xec);
	hash.append(0x2);
	hash.append(0x76);
	hash.append(0x14);
	hash.append(0xb1);
	hash.append(0x8c);
	hash.append(0x59);
	hash.append(0xcc);
	hash.append(0x67);
	hash.append(0xe7);
	hash.append(0xb4);
	hash.append(0x5);
	hash.append(0x58);
	hash.append(0x40);
	hash.append(0x32);
	hash.append(0x6f);
	hash.append(0x23);
	hash.append(0x45);
	hash.append(0xe9);
	hash.append(0xcc);
	hash.append(0xe5);
	hash.append(0x2c);
	hash.append(0x4);
	hash.append(0x50);
	hash.append(0x1a);
	hash.append(0x6e);
	hash.append(0x4c);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x5d);
	auth_data.append(0x76);
	auth_data.append(0x47);
	auth_data.append(0xaf);
	auth_data.append(0xe4);
	auth_data.append(0x54);
	auth_data.append(0xa7);
	auth_data.append(0xe9);
	auth_data.append(0xe1);
	auth_data.append(0x69);
	auth_data.append(0x2d);
	auth_data.append(0xf2);
	auth_data.append(0xe8);
	auth_data.append(0xc2);
	auth_data.append(0xf8);
	auth_data.append(0x32);
	auth_data.append(0xc8);
	auth_data.append(0x79);
	auth_data.append(0x89);
	auth_data.append(0x4e);
	auth_data.append(0x83);
	auth_data.append(0xa7);
	auth_data.append(0x39);
	auth_data.append(0x84);
	auth_data.append(0xfb);
	auth_data.append(0x9d);
	auth_data.append(0x9a);
	auth_data.append(0xef);
	auth_data.append(0x23);
	auth_data.append(0x19);
	auth_data.append(0x8b);
	auth_data.append(0x2e);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x91);
	sig.append(0x3f);
	sig.append(0x60);
	sig.append(0x17);
	sig.append(0xd);
	sig.append(0xf1);
	sig.append(0x2d);
	sig.append(0x26);
	sig.append(0xe6);
	sig.append(0x5a);
	sig.append(0x5b);
	sig.append(0x5d);
	sig.append(0xdd);
	sig.append(0xe3);
	sig.append(0xec);
	sig.append(0x3d);
	sig.append(0xae);
	sig.append(0x3f);
	sig.append(0x6c);
	sig.append(0x70);
	sig.append(0xa6);
	sig.append(0xaf);
	sig.append(0x37);
	sig.append(0xa3);
	sig.append(0x9e);
	sig.append(0x31);
	sig.append(0xeb);
	sig.append(0xf4);
	sig.append(0xd1);
	sig.append(0x84);
	sig.append(0x6e);
	sig.append(0x5b);
	sig.append(0xb6);
	sig.append(0xc9);
	sig.append(0x76);
	sig.append(0xb5);
	sig.append(0x96);
	sig.append(0xdc);
	sig.append(0xd4);
	sig.append(0xf9);
	sig.append(0x60);
	sig.append(0xec);
	sig.append(0x16);
	sig.append(0x44);
	sig.append(0xc6);
	sig.append(0x32);
	sig.append(0xe8);
	sig.append(0xbc);
	sig.append(0xec);
	sig.append(0xea);
	sig.append(0x40);
	sig.append(0x2c);
	sig.append(0xe1);
	sig.append(0xe7);
	sig.append(0x44);
	sig.append(0xf4);
	sig.append(0xf7);
	sig.append(0x3d);
	sig.append(0x7);
	sig.append(0xb7);
	sig.append(0x36);
	sig.append(0x6d);
	sig.append(0x39);
	sig.append(0xe7);
	let pk = PublicKey {
		 x: 90208047141711920686397008582464232999727451871317418665874835856239733135371, 
		 y: 49889836923255760473972964645632543413552383866551362233225079971324342040297
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
	hash.append(0x3);
	hash.append(0x5d);
	hash.append(0x1b);
	hash.append(0x16);
	hash.append(0x93);
	hash.append(0x44);
	hash.append(0x3c);
	hash.append(0xb6);
	hash.append(0x8f);
	hash.append(0xd4);
	hash.append(0x13);
	hash.append(0xd0);
	hash.append(0xb9);
	hash.append(0x66);
	hash.append(0xe9);
	hash.append(0x78);
	hash.append(0x96);
	hash.append(0xf3);
	hash.append(0x17);
	hash.append(0xdd);
	hash.append(0x0);
	hash.append(0xa4);
	hash.append(0x21);
	hash.append(0x31);
	hash.append(0x3c);
	hash.append(0xf3);
	hash.append(0xce);
	hash.append(0xd4);
	hash.append(0xfa);
	hash.append(0x66);
	hash.append(0x16);
	hash.append(0x60);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xf3);
	auth_data.append(0x3b);
	auth_data.append(0xb5);
	auth_data.append(0x6d);
	auth_data.append(0x8d);
	auth_data.append(0x5e);
	auth_data.append(0xc0);
	auth_data.append(0x61);
	auth_data.append(0xb7);
	auth_data.append(0x9e);
	auth_data.append(0xd4);
	auth_data.append(0x76);
	auth_data.append(0xbf);
	auth_data.append(0x26);
	auth_data.append(0x1);
	auth_data.append(0xbb);
	auth_data.append(0x81);
	auth_data.append(0x60);
	auth_data.append(0x83);
	auth_data.append(0xae);
	auth_data.append(0x60);
	auth_data.append(0xe3);
	auth_data.append(0xf7);
	auth_data.append(0x86);
	auth_data.append(0xd3);
	auth_data.append(0xa3);
	auth_data.append(0xb0);
	auth_data.append(0x53);
	auth_data.append(0xaa);
	auth_data.append(0xab);
	auth_data.append(0x7c);
	auth_data.append(0x8c);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x27);
	sig.append(0x3e);
	sig.append(0x4a);
	sig.append(0x24);
	sig.append(0xc0);
	sig.append(0x1a);
	sig.append(0xb9);
	sig.append(0x61);
	sig.append(0x2f);
	sig.append(0x4c);
	sig.append(0x90);
	sig.append(0xca);
	sig.append(0x67);
	sig.append(0xa);
	sig.append(0xb1);
	sig.append(0x94);
	sig.append(0xfc);
	sig.append(0xdf);
	sig.append(0xf2);
	sig.append(0xcb);
	sig.append(0x12);
	sig.append(0xbd);
	sig.append(0xa2);
	sig.append(0x52);
	sig.append(0x1d);
	sig.append(0x6d);
	sig.append(0x10);
	sig.append(0x34);
	sig.append(0x17);
	sig.append(0x98);
	sig.append(0x66);
	sig.append(0xdf);
	sig.append(0x6);
	sig.append(0x8);
	sig.append(0xd);
	sig.append(0x1b);
	sig.append(0x4e);
	sig.append(0x14);
	sig.append(0x4);
	sig.append(0xf2);
	sig.append(0x81);
	sig.append(0x9b);
	sig.append(0x60);
	sig.append(0xe2);
	sig.append(0x7c);
	sig.append(0x42);
	sig.append(0xc);
	sig.append(0xf8);
	sig.append(0x75);
	sig.append(0x1e);
	sig.append(0x2b);
	sig.append(0x81);
	sig.append(0x66);
	sig.append(0x2e);
	sig.append(0xa7);
	sig.append(0x5f);
	sig.append(0x7e);
	sig.append(0x21);
	sig.append(0x1);
	sig.append(0x8c);
	sig.append(0x75);
	sig.append(0x4c);
	sig.append(0xfb);
	sig.append(0x14);
	let pk = PublicKey {
		 x: 106679475785641880372518297885521823182275144012791096044964092422329715836665, 
		 y: 39791542197370609437646961587037077175701339992648478915323317612156560107034
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
	hash.append(0x73);
	hash.append(0x9f);
	hash.append(0xb9);
	hash.append(0x2c);
	hash.append(0xf8);
	hash.append(0x6d);
	hash.append(0xb8);
	hash.append(0xb8);
	hash.append(0xbe);
	hash.append(0xb);
	hash.append(0xa0);
	hash.append(0x8e);
	hash.append(0xdc);
	hash.append(0x67);
	hash.append(0x8c);
	hash.append(0x53);
	hash.append(0x39);
	hash.append(0x19);
	hash.append(0x33);
	hash.append(0xa2);
	hash.append(0xb2);
	hash.append(0xfa);
	hash.append(0x43);
	hash.append(0x62);
	hash.append(0x65);
	hash.append(0x5a);
	hash.append(0x14);
	hash.append(0x91);
	hash.append(0x83);
	hash.append(0xf0);
	hash.append(0xf4);
	hash.append(0x89);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xec);
	auth_data.append(0x91);
	auth_data.append(0x8d);
	auth_data.append(0x71);
	auth_data.append(0x93);
	auth_data.append(0x71);
	auth_data.append(0x74);
	auth_data.append(0x96);
	auth_data.append(0x13);
	auth_data.append(0x34);
	auth_data.append(0x7b);
	auth_data.append(0xb6);
	auth_data.append(0xc6);
	auth_data.append(0xaf);
	auth_data.append(0x19);
	auth_data.append(0xf6);
	auth_data.append(0x8b);
	auth_data.append(0x50);
	auth_data.append(0xbb);
	auth_data.append(0x25);
	auth_data.append(0x2b);
	auth_data.append(0x4a);
	auth_data.append(0x85);
	auth_data.append(0xa7);
	auth_data.append(0xc2);
	auth_data.append(0x2f);
	auth_data.append(0x9b);
	auth_data.append(0x5c);
	auth_data.append(0xd3);
	auth_data.append(0x24);
	auth_data.append(0xc);
	auth_data.append(0x53);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x2e);
	sig.append(0x71);
	sig.append(0x9a);
	sig.append(0x72);
	sig.append(0xab);
	sig.append(0x30);
	sig.append(0x83);
	sig.append(0xcf);
	sig.append(0xb);
	sig.append(0x10);
	sig.append(0x96);
	sig.append(0xa3);
	sig.append(0x35);
	sig.append(0x79);
	sig.append(0x78);
	sig.append(0xcc);
	sig.append(0xa1);
	sig.append(0xb3);
	sig.append(0x48);
	sig.append(0xe9);
	sig.append(0x27);
	sig.append(0xe3);
	sig.append(0x13);
	sig.append(0xd6);
	sig.append(0x88);
	sig.append(0xfd);
	sig.append(0x70);
	sig.append(0x32);
	sig.append(0x89);
	sig.append(0x91);
	sig.append(0x4b);
	sig.append(0x71);
	sig.append(0x75);
	sig.append(0x57);
	sig.append(0x70);
	sig.append(0x90);
	sig.append(0x6b);
	sig.append(0xb5);
	sig.append(0x30);
	sig.append(0x4e);
	sig.append(0x8f);
	sig.append(0xda);
	sig.append(0x3a);
	sig.append(0x9f);
	sig.append(0xc2);
	sig.append(0x94);
	sig.append(0x7c);
	sig.append(0xc8);
	sig.append(0x13);
	sig.append(0xbd);
	sig.append(0xe7);
	sig.append(0x31);
	sig.append(0xba);
	sig.append(0x3a);
	sig.append(0x54);
	sig.append(0xe6);
	sig.append(0x96);
	sig.append(0xdf);
	sig.append(0xf6);
	sig.append(0x2b);
	sig.append(0x80);
	sig.append(0x7f);
	sig.append(0x21);
	sig.append(0x2c);
	let pk = PublicKey {
		 x: 56689770242595773257629730182645839768233926076951438121444067090492400781954, 
		 y: 13142977348236857102308518054293439318337647505759981476284475692225580356645
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


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
	hash.append(0x69);
	hash.append(0x99);
	hash.append(0x67);
	hash.append(0x3b);
	hash.append(0xa8);
	hash.append(0x8d);
	hash.append(0x4e);
	hash.append(0x63);
	hash.append(0x3f);
	hash.append(0x45);
	hash.append(0x95);
	hash.append(0xbf);
	hash.append(0xb2);
	hash.append(0x17);
	hash.append(0x2a);
	hash.append(0xcf);
	hash.append(0x8b);
	hash.append(0x91);
	hash.append(0x30);
	hash.append(0x45);
	hash.append(0x5f);
	hash.append(0x93);
	hash.append(0x5a);
	hash.append(0x6c);
	hash.append(0x6c);
	hash.append(0xeb);
	hash.append(0x23);
	hash.append(0xd7);
	hash.append(0x42);
	hash.append(0x50);
	hash.append(0x17);
	hash.append(0xdc);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xc7);
	auth_data.append(0x85);
	auth_data.append(0x6b);
	auth_data.append(0xd3);
	auth_data.append(0x26);
	auth_data.append(0x6a);
	auth_data.append(0x18);
	auth_data.append(0xfd);
	auth_data.append(0xaa);
	auth_data.append(0x7e);
	auth_data.append(0x37);
	auth_data.append(0xe8);
	auth_data.append(0x1d);
	auth_data.append(0x8d);
	auth_data.append(0x59);
	auth_data.append(0x57);
	auth_data.append(0xa);
	auth_data.append(0xff);
	auth_data.append(0xf3);
	auth_data.append(0x50);
	auth_data.append(0x3b);
	auth_data.append(0x3b);
	auth_data.append(0x8);
	auth_data.append(0x63);
	auth_data.append(0x96);
	auth_data.append(0x7);
	auth_data.append(0x83);
	auth_data.append(0xa2);
	auth_data.append(0x23);
	auth_data.append(0xae);
	auth_data.append(0xa1);
	auth_data.append(0x52);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x57);
	sig.append(0x81);
	sig.append(0xe7);
	sig.append(0xeb);
	sig.append(0x96);
	sig.append(0x4b);
	sig.append(0x94);
	sig.append(0x8b);
	sig.append(0x33);
	sig.append(0xfc);
	sig.append(0x7d);
	sig.append(0x6);
	sig.append(0x0);
	sig.append(0x91);
	sig.append(0x78);
	sig.append(0x65);
	sig.append(0x7b);
	sig.append(0xc8);
	sig.append(0x9e);
	sig.append(0xae);
	sig.append(0x96);
	sig.append(0xd5);
	sig.append(0x85);
	sig.append(0x69);
	sig.append(0x21);
	sig.append(0xac);
	sig.append(0x9);
	sig.append(0xac);
	sig.append(0x6b);
	sig.append(0xfd);
	sig.append(0xed);
	sig.append(0xcd);
	sig.append(0x39);
	sig.append(0xc3);
	sig.append(0x53);
	sig.append(0xcf);
	sig.append(0x8c);
	sig.append(0xc4);
	sig.append(0x22);
	sig.append(0xcf);
	sig.append(0xf4);
	sig.append(0x3b);
	sig.append(0x2a);
	sig.append(0x1);
	sig.append(0xb8);
	sig.append(0x78);
	sig.append(0x6e);
	sig.append(0xd0);
	sig.append(0x5b);
	sig.append(0x10);
	sig.append(0x1e);
	sig.append(0xcf);
	sig.append(0x48);
	sig.append(0x6);
	sig.append(0x35);
	sig.append(0xd2);
	sig.append(0xb8);
	sig.append(0x14);
	sig.append(0xd6);
	sig.append(0xe4);
	sig.append(0x89);
	sig.append(0xe3);
	sig.append(0xe7);
	sig.append(0x51);
	let pk = PublicKey {
		 x: 51408043095092227554849399307393705174680249934277257371321153206084160306816, 
		 y: 90761221789077830745254236447121898170913618096050170915030497009005087474606
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
	hash.append(0x4f);
	hash.append(0x7a);
	hash.append(0x7d);
	hash.append(0xe);
	hash.append(0xb);
	hash.append(0xfd);
	hash.append(0x7d);
	hash.append(0x5);
	hash.append(0x98);
	hash.append(0x8b);
	hash.append(0x55);
	hash.append(0x39);
	hash.append(0xe4);
	hash.append(0xae);
	hash.append(0xd5);
	hash.append(0xd6);
	hash.append(0xfd);
	hash.append(0xda);
	hash.append(0x6b);
	hash.append(0x96);
	hash.append(0xc4);
	hash.append(0x33);
	hash.append(0x64);
	hash.append(0x4d);
	hash.append(0x42);
	hash.append(0xf5);
	hash.append(0x41);
	hash.append(0x55);
	hash.append(0x64);
	hash.append(0x30);
	hash.append(0x7b);
	hash.append(0x81);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x88);
	auth_data.append(0xb);
	auth_data.append(0x2b);
	auth_data.append(0xe7);
	auth_data.append(0x83);
	auth_data.append(0x8b);
	auth_data.append(0x30);
	auth_data.append(0xab);
	auth_data.append(0x55);
	auth_data.append(0x53);
	auth_data.append(0x71);
	auth_data.append(0x10);
	auth_data.append(0xa6);
	auth_data.append(0xab);
	auth_data.append(0x8b);
	auth_data.append(0xd0);
	auth_data.append(0xfd);
	auth_data.append(0x91);
	auth_data.append(0xe9);
	auth_data.append(0x42);
	auth_data.append(0x52);
	auth_data.append(0x22);
	auth_data.append(0x70);
	auth_data.append(0x29);
	auth_data.append(0x34);
	auth_data.append(0x29);
	auth_data.append(0x7a);
	auth_data.append(0xc7);
	auth_data.append(0x98);
	auth_data.append(0x7);
	auth_data.append(0x71);
	auth_data.append(0x66);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x40);
	sig.append(0xb0);
	sig.append(0x12);
	sig.append(0x61);
	sig.append(0x7);
	sig.append(0x6c);
	sig.append(0x42);
	sig.append(0x86);
	sig.append(0xa);
	sig.append(0xdd);
	sig.append(0x3f);
	sig.append(0x67);
	sig.append(0xa4);
	sig.append(0x59);
	sig.append(0xf1);
	sig.append(0x64);
	sig.append(0xa3);
	sig.append(0xc1);
	sig.append(0x4c);
	sig.append(0xd2);
	sig.append(0xb0);
	sig.append(0x53);
	sig.append(0xa9);
	sig.append(0x89);
	sig.append(0xc0);
	sig.append(0xa0);
	sig.append(0x4);
	sig.append(0x97);
	sig.append(0xe);
	sig.append(0x4a);
	sig.append(0x87);
	sig.append(0xce);
	sig.append(0xe9);
	sig.append(0xc6);
	sig.append(0xbf);
	sig.append(0x9b);
	sig.append(0x6d);
	sig.append(0x47);
	sig.append(0xe4);
	sig.append(0xe1);
	sig.append(0x50);
	sig.append(0x89);
	sig.append(0xd5);
	sig.append(0x86);
	sig.append(0x91);
	sig.append(0x30);
	sig.append(0xd1);
	sig.append(0x86);
	sig.append(0x7);
	sig.append(0xfd);
	sig.append(0x28);
	sig.append(0x57);
	sig.append(0xbf);
	sig.append(0x47);
	sig.append(0xb8);
	sig.append(0xc7);
	sig.append(0x7a);
	sig.append(0xc4);
	sig.append(0x7f);
	sig.append(0x5b);
	sig.append(0x83);
	sig.append(0xa);
	sig.append(0xdc);
	sig.append(0x3);
	let pk = PublicKey {
		 x: 32226099742177504839791877288551291184392995723767343476567321835173453592127, 
		 y: 62630107590389101585445785620489353178997389886072627871770734121955013647235
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
	hash.append(0xcc);
	hash.append(0x37);
	hash.append(0x5e);
	hash.append(0x67);
	hash.append(0x49);
	hash.append(0x25);
	hash.append(0xbb);
	hash.append(0x63);
	hash.append(0xd9);
	hash.append(0x59);
	hash.append(0x44);
	hash.append(0x7b);
	hash.append(0xa);
	hash.append(0x7e);
	hash.append(0x9e);
	hash.append(0xdf);
	hash.append(0xf9);
	hash.append(0xd6);
	hash.append(0x61);
	hash.append(0xa9);
	hash.append(0xb4);
	hash.append(0xc2);
	hash.append(0x2c);
	hash.append(0xd4);
	hash.append(0xf6);
	hash.append(0x44);
	hash.append(0x4a);
	hash.append(0x9b);
	hash.append(0x21);
	hash.append(0x53);
	hash.append(0x51);
	hash.append(0x7e);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x88);
	auth_data.append(0xb);
	auth_data.append(0x2b);
	auth_data.append(0xe7);
	auth_data.append(0x83);
	auth_data.append(0x8b);
	auth_data.append(0x30);
	auth_data.append(0xab);
	auth_data.append(0x55);
	auth_data.append(0x53);
	auth_data.append(0x71);
	auth_data.append(0x10);
	auth_data.append(0xa6);
	auth_data.append(0xab);
	auth_data.append(0x8b);
	auth_data.append(0xd0);
	auth_data.append(0xfd);
	auth_data.append(0x91);
	auth_data.append(0xe9);
	auth_data.append(0x42);
	auth_data.append(0x52);
	auth_data.append(0x22);
	auth_data.append(0x70);
	auth_data.append(0x29);
	auth_data.append(0x34);
	auth_data.append(0x29);
	auth_data.append(0x7a);
	auth_data.append(0xc7);
	auth_data.append(0x98);
	auth_data.append(0x7);
	auth_data.append(0x71);
	auth_data.append(0x66);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa4);
	sig.append(0x3);
	sig.append(0x8e);
	sig.append(0xf5);
	sig.append(0x4f);
	sig.append(0x7f);
	sig.append(0x2f);
	sig.append(0x96);
	sig.append(0x2d);
	sig.append(0x4a);
	sig.append(0x9d);
	sig.append(0x4);
	sig.append(0x84);
	sig.append(0xc2);
	sig.append(0xa2);
	sig.append(0xf5);
	sig.append(0x58);
	sig.append(0x7f);
	sig.append(0xf9);
	sig.append(0x47);
	sig.append(0x67);
	sig.append(0x2c);
	sig.append(0xce);
	sig.append(0xda);
	sig.append(0xb2);
	sig.append(0xb9);
	sig.append(0xdd);
	sig.append(0xcc);
	sig.append(0x59);
	sig.append(0x7e);
	sig.append(0x5);
	sig.append(0x56);
	sig.append(0x58);
	sig.append(0xb1);
	sig.append(0xa0);
	sig.append(0xf7);
	sig.append(0x15);
	sig.append(0x73);
	sig.append(0xef);
	sig.append(0xc2);
	sig.append(0x7d);
	sig.append(0x34);
	sig.append(0x4b);
	sig.append(0x43);
	sig.append(0x25);
	sig.append(0xca);
	sig.append(0x94);
	sig.append(0x81);
	sig.append(0x1);
	sig.append(0xe2);
	sig.append(0xa5);
	sig.append(0x41);
	sig.append(0xea);
	sig.append(0xac);
	sig.append(0x8f);
	sig.append(0x4f);
	sig.append(0x3d);
	sig.append(0x3d);
	sig.append(0x19);
	sig.append(0x4f);
	sig.append(0xa5);
	sig.append(0x50);
	sig.append(0x5c);
	sig.append(0x94);
	let pk = PublicKey {
		 x: 3074572511745598317489593602754645911475631707501052953755111795112995405160, 
		 y: 67698228887214134181549206336324072921576315264006158518625559858214355983958
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
	hash.append(0x98);
	hash.append(0xc3);
	hash.append(0xbc);
	hash.append(0x11);
	hash.append(0x63);
	hash.append(0xd8);
	hash.append(0x9a);
	hash.append(0x58);
	hash.append(0xed);
	hash.append(0x19);
	hash.append(0x81);
	hash.append(0xa5);
	hash.append(0x86);
	hash.append(0xba);
	hash.append(0x9c);
	hash.append(0xd3);
	hash.append(0x87);
	hash.append(0xdd);
	hash.append(0xfd);
	hash.append(0xc0);
	hash.append(0xdb);
	hash.append(0x3);
	hash.append(0x5d);
	hash.append(0x80);
	hash.append(0x86);
	hash.append(0x67);
	hash.append(0x3b);
	hash.append(0xdb);
	hash.append(0x55);
	hash.append(0xc4);
	hash.append(0xac);
	hash.append(0xb7);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x82);
	auth_data.append(0xca);
	auth_data.append(0xb7);
	auth_data.append(0xdf);
	auth_data.append(0xa);
	auth_data.append(0xbf);
	auth_data.append(0xb9);
	auth_data.append(0xd9);
	auth_data.append(0x5d);
	auth_data.append(0xca);
	auth_data.append(0x4e);
	auth_data.append(0x59);
	auth_data.append(0x37);
	auth_data.append(0xce);
	auth_data.append(0x29);
	auth_data.append(0x68);
	auth_data.append(0xc7);
	auth_data.append(0x98);
	auth_data.append(0xc7);
	auth_data.append(0x26);
	auth_data.append(0xfe);
	auth_data.append(0xa4);
	auth_data.append(0x8c);
	auth_data.append(0x1);
	auth_data.append(0x6b);
	auth_data.append(0xf9);
	auth_data.append(0x76);
	auth_data.append(0x32);
	auth_data.append(0x21);
	auth_data.append(0xef);
	auth_data.append(0xda);
	auth_data.append(0x13);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x1d);
	sig.append(0x26);
	sig.append(0x34);
	sig.append(0xa0);
	sig.append(0xfc);
	sig.append(0x5);
	sig.append(0x73);
	sig.append(0xd9);
	sig.append(0xdd);
	sig.append(0xe6);
	sig.append(0x50);
	sig.append(0xdf);
	sig.append(0xc7);
	sig.append(0xdf);
	sig.append(0xe6);
	sig.append(0x37);
	sig.append(0xda);
	sig.append(0x20);
	sig.append(0xea);
	sig.append(0xd8);
	sig.append(0xdc);
	sig.append(0x29);
	sig.append(0x6e);
	sig.append(0xad);
	sig.append(0xc);
	sig.append(0x14);
	sig.append(0x8);
	sig.append(0xb8);
	sig.append(0x0);
	sig.append(0x23);
	sig.append(0x39);
	sig.append(0xf0);
	sig.append(0x83);
	sig.append(0xb9);
	sig.append(0x1b);
	sig.append(0x10);
	sig.append(0x8f);
	sig.append(0xf2);
	sig.append(0x78);
	sig.append(0xb6);
	sig.append(0x83);
	sig.append(0xff);
	sig.append(0x20);
	sig.append(0x86);
	sig.append(0x84);
	sig.append(0x82);
	sig.append(0x46);
	sig.append(0x12);
	sig.append(0xec);
	sig.append(0x53);
	sig.append(0xa0);
	sig.append(0x3e);
	sig.append(0x2e);
	sig.append(0x4);
	sig.append(0xd1);
	sig.append(0x15);
	sig.append(0xa1);
	sig.append(0x2c);
	sig.append(0x64);
	sig.append(0x31);
	sig.append(0xc4);
	sig.append(0xe2);
	sig.append(0xf3);
	sig.append(0xb5);
	let pk = PublicKey {
		 x: 61846430473516041738668651076652685037099435286723509009444656677701816687566, 
		 y: 73141345531484667330840879618219613642838105828374853764009810878744801513599
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


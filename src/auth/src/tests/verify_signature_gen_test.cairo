// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/test_gen_scripts/authverify_signature_test.py.py for details
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
	hash.append(0xeb);
	hash.append(0xf6);
	hash.append(0xf0);
	hash.append(0xaf);
	hash.append(0x7);
	hash.append(0x99);
	hash.append(0x56);
	hash.append(0xf8);
	hash.append(0x47);
	hash.append(0xf6);
	hash.append(0x8e);
	hash.append(0xd7);
	hash.append(0x2a);
	hash.append(0x2d);
	hash.append(0x3e);
	hash.append(0xb3);
	hash.append(0xe);
	hash.append(0x46);
	hash.append(0xb9);
	hash.append(0x75);
	hash.append(0xc4);
	hash.append(0xb0);
	hash.append(0xfc);
	hash.append(0x68);
	hash.append(0xd2);
	hash.append(0xbf);
	hash.append(0x65);
	hash.append(0x69);
	hash.append(0x71);
	hash.append(0x7b);
	hash.append(0x81);
	hash.append(0x2b);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xe);
	auth_data.append(0x9b);
	auth_data.append(0xcf);
	auth_data.append(0xf6);
	auth_data.append(0xd);
	auth_data.append(0x3d);
	auth_data.append(0xc5);
	auth_data.append(0x91);
	auth_data.append(0x32);
	auth_data.append(0x20);
	auth_data.append(0x7);
	auth_data.append(0xc4);
	auth_data.append(0x8b);
	auth_data.append(0x85);
	auth_data.append(0x51);
	auth_data.append(0x5d);
	auth_data.append(0x19);
	auth_data.append(0xc6);
	auth_data.append(0x9e);
	auth_data.append(0xc6);
	auth_data.append(0xf5);
	auth_data.append(0x1c);
	auth_data.append(0xfe);
	auth_data.append(0x6a);
	auth_data.append(0xa0);
	auth_data.append(0x2b);
	auth_data.append(0x7c);
	auth_data.append(0xdf);
	auth_data.append(0x63);
	auth_data.append(0x43);
	auth_data.append(0x42);
	auth_data.append(0x74);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x50);
	sig.append(0x63);
	sig.append(0x86);
	sig.append(0xa6);
	sig.append(0x6);
	sig.append(0x2c);
	sig.append(0x85);
	sig.append(0x1f);
	sig.append(0xcc);
	sig.append(0x38);
	sig.append(0x86);
	sig.append(0xa8);
	sig.append(0x61);
	sig.append(0x82);
	sig.append(0x20);
	sig.append(0x47);
	sig.append(0xcb);
	sig.append(0x1d);
	sig.append(0xe2);
	sig.append(0xf);
	sig.append(0x32);
	sig.append(0xc9);
	sig.append(0x24);
	sig.append(0x62);
	sig.append(0xdd);
	sig.append(0xfc);
	sig.append(0x3c);
	sig.append(0xd8);
	sig.append(0x34);
	sig.append(0x12);
	sig.append(0xca);
	sig.append(0x5);
	sig.append(0xee);
	sig.append(0xb4);
	sig.append(0x49);
	sig.append(0x59);
	sig.append(0x16);
	sig.append(0xb);
	sig.append(0xb2);
	sig.append(0xf0);
	sig.append(0xb1);
	sig.append(0x32);
	sig.append(0x83);
	sig.append(0x6);
	sig.append(0x2f);
	sig.append(0x19);
	sig.append(0x95);
	sig.append(0xf1);
	sig.append(0xc4);
	sig.append(0x91);
	sig.append(0xf9);
	sig.append(0x1d);
	sig.append(0x61);
	sig.append(0x62);
	sig.append(0x9a);
	sig.append(0x98);
	sig.append(0x78);
	sig.append(0x72);
	sig.append(0x7d);
	sig.append(0x20);
	sig.append(0x22);
	sig.append(0x3e);
	sig.append(0xf8);
	sig.append(0xf1);
	let pk = PublicKey {
		 x: 76908536486827712333552447765521681371233204553711222229584345546616118940262, 
		 y: 83405424936717017401679589608482908765980756244903691736782348753556241479595
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
	hash.append(0x42);
	hash.append(0xf7);
	hash.append(0xff);
	hash.append(0xea);
	hash.append(0x7e);
	hash.append(0xe1);
	hash.append(0x58);
	hash.append(0x3c);
	hash.append(0x8a);
	hash.append(0x90);
	hash.append(0xf);
	hash.append(0x2);
	hash.append(0xf5);
	hash.append(0xaa);
	hash.append(0x17);
	hash.append(0x91);
	hash.append(0xc2);
	hash.append(0xb1);
	hash.append(0xc0);
	hash.append(0x26);
	hash.append(0x12);
	hash.append(0x39);
	hash.append(0x2f);
	hash.append(0x0);
	hash.append(0xb4);
	hash.append(0x59);
	hash.append(0x50);
	hash.append(0x1f);
	hash.append(0xab);
	hash.append(0xaa);
	hash.append(0x67);
	hash.append(0xdb);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xab);
	auth_data.append(0x53);
	auth_data.append(0x4a);
	auth_data.append(0xe9);
	auth_data.append(0x14);
	auth_data.append(0xf6);
	auth_data.append(0xb3);
	auth_data.append(0x85);
	auth_data.append(0xb2);
	auth_data.append(0xd2);
	auth_data.append(0x49);
	auth_data.append(0xff);
	auth_data.append(0x1a);
	auth_data.append(0x5b);
	auth_data.append(0xb1);
	auth_data.append(0x6d);
	auth_data.append(0x8a);
	auth_data.append(0x29);
	auth_data.append(0x16);
	auth_data.append(0xee);
	auth_data.append(0xae);
	auth_data.append(0xef);
	auth_data.append(0x6a);
	auth_data.append(0xfa);
	auth_data.append(0x8e);
	auth_data.append(0x83);
	auth_data.append(0x24);
	auth_data.append(0x42);
	auth_data.append(0x29);
	auth_data.append(0xfe);
	auth_data.append(0x86);
	auth_data.append(0xd5);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x9c);
	sig.append(0x83);
	sig.append(0x1b);
	sig.append(0x13);
	sig.append(0x3d);
	sig.append(0xc9);
	sig.append(0x83);
	sig.append(0x0);
	sig.append(0x17);
	sig.append(0x5b);
	sig.append(0xf6);
	sig.append(0xb);
	sig.append(0x52);
	sig.append(0x6f);
	sig.append(0x7a);
	sig.append(0xae);
	sig.append(0xc9);
	sig.append(0xbf);
	sig.append(0xd3);
	sig.append(0x9f);
	sig.append(0xa4);
	sig.append(0x5b);
	sig.append(0x87);
	sig.append(0xca);
	sig.append(0xf7);
	sig.append(0xe6);
	sig.append(0x6d);
	sig.append(0xa2);
	sig.append(0x8f);
	sig.append(0xa5);
	sig.append(0xd0);
	sig.append(0x8d);
	sig.append(0xa3);
	sig.append(0x90);
	sig.append(0x9e);
	sig.append(0x31);
	sig.append(0x1a);
	sig.append(0x36);
	sig.append(0x67);
	sig.append(0xe);
	sig.append(0xe3);
	sig.append(0xf3);
	sig.append(0x16);
	sig.append(0x67);
	sig.append(0xc6);
	sig.append(0x47);
	sig.append(0xbc);
	sig.append(0x44);
	sig.append(0x41);
	sig.append(0x22);
	sig.append(0xd1);
	sig.append(0xa9);
	sig.append(0x99);
	sig.append(0x27);
	sig.append(0xfe);
	sig.append(0xb1);
	sig.append(0x30);
	sig.append(0x95);
	sig.append(0xe0);
	sig.append(0xa4);
	sig.append(0xfd);
	sig.append(0x79);
	sig.append(0x7);
	sig.append(0xd3);
	let pk = PublicKey {
		 x: 77167178047662267929945598085231594543029694838685128489312428155389465085259, 
		 y: 103229094929988773521623563631113415573075597590281515952805093193484046130711
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
	hash.append(0xa4);
	hash.append(0x3c);
	hash.append(0x39);
	hash.append(0x3f);
	hash.append(0xc1);
	hash.append(0x62);
	hash.append(0x58);
	hash.append(0xff);
	hash.append(0x10);
	hash.append(0x8a);
	hash.append(0xb2);
	hash.append(0x7d);
	hash.append(0x52);
	hash.append(0x2a);
	hash.append(0x38);
	hash.append(0x24);
	hash.append(0xb3);
	hash.append(0xd0);
	hash.append(0x58);
	hash.append(0xd7);
	hash.append(0x68);
	hash.append(0xc3);
	hash.append(0x84);
	hash.append(0x31);
	hash.append(0xaa);
	hash.append(0x24);
	hash.append(0x30);
	hash.append(0x98);
	hash.append(0xe7);
	hash.append(0xf9);
	hash.append(0xea);
	hash.append(0x46);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xd8);
	auth_data.append(0xad);
	auth_data.append(0x22);
	auth_data.append(0x34);
	auth_data.append(0xc7);
	auth_data.append(0x6d);
	auth_data.append(0x5e);
	auth_data.append(0x97);
	auth_data.append(0x4e);
	auth_data.append(0x89);
	auth_data.append(0x39);
	auth_data.append(0x9);
	auth_data.append(0x82);
	auth_data.append(0xae);
	auth_data.append(0x92);
	auth_data.append(0x93);
	auth_data.append(0x75);
	auth_data.append(0xb5);
	auth_data.append(0x17);
	auth_data.append(0xc2);
	auth_data.append(0xa0);
	auth_data.append(0x34);
	auth_data.append(0xa2);
	auth_data.append(0x1);
	auth_data.append(0x10);
	auth_data.append(0x16);
	auth_data.append(0x34);
	auth_data.append(0xd8);
	auth_data.append(0xfb);
	auth_data.append(0x37);
	auth_data.append(0x80);
	auth_data.append(0x66);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x3e);
	sig.append(0xf3);
	sig.append(0x2e);
	sig.append(0x81);
	sig.append(0x4a);
	sig.append(0x11);
	sig.append(0xfc);
	sig.append(0x4e);
	sig.append(0x7c);
	sig.append(0xc9);
	sig.append(0xb2);
	sig.append(0xb6);
	sig.append(0xce);
	sig.append(0x55);
	sig.append(0xc);
	sig.append(0x78);
	sig.append(0x41);
	sig.append(0xc7);
	sig.append(0x3f);
	sig.append(0xe2);
	sig.append(0x60);
	sig.append(0x94);
	sig.append(0xb9);
	sig.append(0x54);
	sig.append(0x26);
	sig.append(0xe6);
	sig.append(0x6e);
	sig.append(0xae);
	sig.append(0x54);
	sig.append(0x6f);
	sig.append(0x4d);
	sig.append(0x24);
	sig.append(0x2);
	sig.append(0xa3);
	sig.append(0x10);
	sig.append(0xff);
	sig.append(0x29);
	sig.append(0x4f);
	sig.append(0x67);
	sig.append(0x26);
	sig.append(0x8b);
	sig.append(0x8b);
	sig.append(0xd);
	sig.append(0x70);
	sig.append(0x95);
	sig.append(0x68);
	sig.append(0x28);
	sig.append(0x2);
	sig.append(0xc5);
	sig.append(0xa4);
	sig.append(0x7a);
	sig.append(0xf8);
	sig.append(0xf1);
	sig.append(0x55);
	sig.append(0x1a);
	sig.append(0x1c);
	sig.append(0xff);
	sig.append(0x4e);
	sig.append(0xec);
	sig.append(0xb3);
	sig.append(0xb1);
	sig.append(0xa4);
	sig.append(0xfb);
	sig.append(0x38);
	let pk = PublicKey {
		 x: 78223185593876975892493315043010194318862318164529545493002409431671664966442, 
		 y: 50293295593076718383737758715910011757930989766754768618308395472563100012937
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
	hash.append(0x62);
	hash.append(0x49);
	hash.append(0xaf);
	hash.append(0xc9);
	hash.append(0x61);
	hash.append(0x82);
	hash.append(0x52);
	hash.append(0x98);
	hash.append(0x34);
	hash.append(0x97);
	hash.append(0x92);
	hash.append(0xb4);
	hash.append(0xb);
	hash.append(0xf8);
	hash.append(0xc3);
	hash.append(0x40);
	hash.append(0xdc);
	hash.append(0xad);
	hash.append(0xe5);
	hash.append(0xc);
	hash.append(0xc1);
	hash.append(0xed);
	hash.append(0xd0);
	hash.append(0xcc);
	hash.append(0xbd);
	hash.append(0x74);
	hash.append(0xf5);
	hash.append(0xba);
	hash.append(0x8f);
	hash.append(0x9);
	hash.append(0xc3);
	hash.append(0xa7);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x3);
	auth_data.append(0xd7);
	auth_data.append(0x87);
	auth_data.append(0xa5);
	auth_data.append(0x0);
	auth_data.append(0xb7);
	auth_data.append(0x5f);
	auth_data.append(0x64);
	auth_data.append(0x69);
	auth_data.append(0xb3);
	auth_data.append(0x8b);
	auth_data.append(0x9d);
	auth_data.append(0xc8);
	auth_data.append(0x7f);
	auth_data.append(0xf4);
	auth_data.append(0x5);
	auth_data.append(0x7d);
	auth_data.append(0x33);
	auth_data.append(0xb3);
	auth_data.append(0x72);
	auth_data.append(0x3);
	auth_data.append(0xab);
	auth_data.append(0x94);
	auth_data.append(0x35);
	auth_data.append(0x39);
	auth_data.append(0xcb);
	auth_data.append(0x62);
	auth_data.append(0x90);
	auth_data.append(0x87);
	auth_data.append(0xa8);
	auth_data.append(0x6b);
	auth_data.append(0xb5);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x3f);
	sig.append(0x70);
	sig.append(0xa6);
	sig.append(0xb9);
	sig.append(0x37);
	sig.append(0x11);
	sig.append(0x81);
	sig.append(0x7a);
	sig.append(0x23);
	sig.append(0xf4);
	sig.append(0x54);
	sig.append(0x28);
	sig.append(0xef);
	sig.append(0x23);
	sig.append(0xee);
	sig.append(0x56);
	sig.append(0xa8);
	sig.append(0x24);
	sig.append(0x0);
	sig.append(0x1b);
	sig.append(0x18);
	sig.append(0xca);
	sig.append(0xa1);
	sig.append(0x2a);
	sig.append(0xe0);
	sig.append(0xd4);
	sig.append(0x2c);
	sig.append(0x7d);
	sig.append(0x43);
	sig.append(0x40);
	sig.append(0xec);
	sig.append(0x31);
	sig.append(0x1b);
	sig.append(0xe7);
	sig.append(0xb3);
	sig.append(0x45);
	sig.append(0x1e);
	sig.append(0xfa);
	sig.append(0xa1);
	sig.append(0x1f);
	sig.append(0x42);
	sig.append(0x46);
	sig.append(0xcf);
	sig.append(0x56);
	sig.append(0xd7);
	sig.append(0xe0);
	sig.append(0xe1);
	sig.append(0x38);
	sig.append(0x8);
	sig.append(0x9b);
	sig.append(0x9c);
	sig.append(0x28);
	sig.append(0xe7);
	sig.append(0x70);
	sig.append(0x5e);
	sig.append(0xb6);
	sig.append(0x27);
	sig.append(0x1a);
	sig.append(0x2f);
	sig.append(0x45);
	sig.append(0x7d);
	sig.append(0x31);
	sig.append(0x7b);
	sig.append(0x57);
	let pk = PublicKey {
		 x: 40337101150900903124666570874083393220664452805825405280932931999592705577993, 
		 y: 16195611863439963777027278201161702988493903866579069461464990603034068908950
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
	hash.append(0xf2);
	hash.append(0x67);
	hash.append(0xdb);
	hash.append(0xba);
	hash.append(0xe4);
	hash.append(0xd9);
	hash.append(0xfc);
	hash.append(0x11);
	hash.append(0x4c);
	hash.append(0xb0);
	hash.append(0x2c);
	hash.append(0x93);
	hash.append(0x6a);
	hash.append(0xf2);
	hash.append(0xea);
	hash.append(0x94);
	hash.append(0xb1);
	hash.append(0x83);
	hash.append(0xe0);
	hash.append(0xfa);
	hash.append(0xf3);
	hash.append(0x3f);
	hash.append(0x82);
	hash.append(0x6e);
	hash.append(0x97);
	hash.append(0xc5);
	hash.append(0x33);
	hash.append(0x50);
	hash.append(0x16);
	hash.append(0x5f);
	hash.append(0xd8);
	hash.append(0xed);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0xc5);
	auth_data.append(0x62);
	auth_data.append(0x47);
	auth_data.append(0x99);
	auth_data.append(0x8c);
	auth_data.append(0x50);
	auth_data.append(0x86);
	auth_data.append(0x9b);
	auth_data.append(0xd2);
	auth_data.append(0x6a);
	auth_data.append(0x38);
	auth_data.append(0x5e);
	auth_data.append(0x5c);
	auth_data.append(0x7a);
	auth_data.append(0x77);
	auth_data.append(0xcc);
	auth_data.append(0xa1);
	auth_data.append(0xca);
	auth_data.append(0x2f);
	auth_data.append(0x98);
	auth_data.append(0xf1);
	auth_data.append(0xb3);
	auth_data.append(0xd6);
	auth_data.append(0x54);
	auth_data.append(0x84);
	auth_data.append(0x52);
	auth_data.append(0xf);
	auth_data.append(0xe1);
	auth_data.append(0x1b);
	auth_data.append(0xed);
	auth_data.append(0xe6);
	auth_data.append(0xf5);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x67);
	sig.append(0xba);
	sig.append(0xf7);
	sig.append(0x25);
	sig.append(0xfe);
	sig.append(0x2a);
	sig.append(0x5f);
	sig.append(0x9d);
	sig.append(0xbe);
	sig.append(0xab);
	sig.append(0xec);
	sig.append(0xf7);
	sig.append(0x23);
	sig.append(0x83);
	sig.append(0xbf);
	sig.append(0x7b);
	sig.append(0x4a);
	sig.append(0xb6);
	sig.append(0xe5);
	sig.append(0x57);
	sig.append(0xef);
	sig.append(0xc1);
	sig.append(0x13);
	sig.append(0x14);
	sig.append(0xac);
	sig.append(0xe1);
	sig.append(0x76);
	sig.append(0x49);
	sig.append(0x5);
	sig.append(0x50);
	sig.append(0x1c);
	sig.append(0x41);
	sig.append(0x1c);
	sig.append(0x69);
	sig.append(0xe8);
	sig.append(0x82);
	sig.append(0x37);
	sig.append(0x31);
	sig.append(0x84);
	sig.append(0x6d);
	sig.append(0x32);
	sig.append(0xc9);
	sig.append(0x48);
	sig.append(0xba);
	sig.append(0x84);
	sig.append(0xcd);
	sig.append(0xf4);
	sig.append(0x8f);
	sig.append(0x3);
	sig.append(0x80);
	sig.append(0xe1);
	sig.append(0xef);
	sig.append(0x6c);
	sig.append(0xa3);
	sig.append(0x81);
	sig.append(0x35);
	sig.append(0xe);
	sig.append(0x34);
	sig.append(0x72);
	sig.append(0xe);
	sig.append(0xb4);
	sig.append(0x40);
	sig.append(0x86);
	sig.append(0xed);
	let pk = PublicKey {
		 x: 28330447244782216785452638438266637631287537939138706554399406805023677290696, 
		 y: 45019835595304669617631098596385711924785924057610387270920974458676877793222
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
	hash.append(0xa7);
	hash.append(0xca);
	hash.append(0xed);
	hash.append(0xf7);
	hash.append(0x5a);
	hash.append(0x32);
	hash.append(0x50);
	hash.append(0xde);
	hash.append(0xe2);
	hash.append(0x47);
	hash.append(0x8c);
	hash.append(0x4d);
	hash.append(0x6c);
	hash.append(0x34);
	hash.append(0xe7);
	hash.append(0xee);
	hash.append(0xb1);
	hash.append(0x2c);
	hash.append(0x18);
	hash.append(0x6);
	hash.append(0xd9);
	hash.append(0xb7);
	hash.append(0x95);
	hash.append(0x83);
	hash.append(0x4e);
	hash.append(0x94);
	hash.append(0x3);
	hash.append(0xa0);
	hash.append(0x2a);
	hash.append(0x59);
	hash.append(0x36);
	hash.append(0x72);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x24);
	auth_data.append(0x3b);
	auth_data.append(0xaa);
	auth_data.append(0xe9);
	auth_data.append(0x41);
	auth_data.append(0xc4);
	auth_data.append(0x8);
	auth_data.append(0x6a);
	auth_data.append(0x57);
	auth_data.append(0xba);
	auth_data.append(0x2);
	auth_data.append(0xf2);
	auth_data.append(0x9e);
	auth_data.append(0x99);
	auth_data.append(0x1a);
	auth_data.append(0x99);
	auth_data.append(0x7e);
	auth_data.append(0x8);
	auth_data.append(0xb9);
	auth_data.append(0xa);
	auth_data.append(0x4e);
	auth_data.append(0xc3);
	auth_data.append(0x62);
	auth_data.append(0x71);
	auth_data.append(0x8);
	auth_data.append(0xf1);
	auth_data.append(0x1);
	auth_data.append(0x6c);
	auth_data.append(0x68);
	auth_data.append(0xee);
	auth_data.append(0x27);
	auth_data.append(0xb0);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xb2);
	sig.append(0x4f);
	sig.append(0x3d);
	sig.append(0xee);
	sig.append(0x4e);
	sig.append(0xf3);
	sig.append(0x9a);
	sig.append(0xb);
	sig.append(0xf8);
	sig.append(0x37);
	sig.append(0x18);
	sig.append(0xda);
	sig.append(0x26);
	sig.append(0x3a);
	sig.append(0x17);
	sig.append(0xf8);
	sig.append(0x29);
	sig.append(0xe0);
	sig.append(0x8b);
	sig.append(0x25);
	sig.append(0x2d);
	sig.append(0x79);
	sig.append(0x7f);
	sig.append(0xf6);
	sig.append(0xa1);
	sig.append(0xc8);
	sig.append(0x8);
	sig.append(0x9f);
	sig.append(0x13);
	sig.append(0x8b);
	sig.append(0xac);
	sig.append(0x6f);
	sig.append(0xe0);
	sig.append(0x6f);
	sig.append(0xad);
	sig.append(0x46);
	sig.append(0x1e);
	sig.append(0xe1);
	sig.append(0x2c);
	sig.append(0xed);
	sig.append(0x2e);
	sig.append(0x3a);
	sig.append(0xe6);
	sig.append(0x17);
	sig.append(0xd5);
	sig.append(0xc6);
	sig.append(0xbb);
	sig.append(0x0);
	sig.append(0xf4);
	sig.append(0x7e);
	sig.append(0x3);
	sig.append(0xbd);
	sig.append(0x2d);
	sig.append(0x13);
	sig.append(0xab);
	sig.append(0x59);
	sig.append(0x58);
	sig.append(0x11);
	sig.append(0x89);
	sig.append(0xbe);
	sig.append(0x4f);
	sig.append(0x2f);
	sig.append(0xee);
	sig.append(0xa7);
	let pk = PublicKey {
		 x: 107518838113146520113604855540204232990742210020993418195566801484953907542294, 
		 y: 81678104179347630273001351061062535095983959638968217228874025799961022081724
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
	hash.append(0xae);
	hash.append(0x4b);
	hash.append(0xa1);
	hash.append(0x61);
	hash.append(0xe);
	hash.append(0xa0);
	hash.append(0xb9);
	hash.append(0x15);
	hash.append(0x79);
	hash.append(0x83);
	hash.append(0x1c);
	hash.append(0xbf);
	hash.append(0xc8);
	hash.append(0x57);
	hash.append(0x2a);
	hash.append(0xb6);
	hash.append(0x17);
	hash.append(0x8);
	hash.append(0x44);
	hash.append(0x96);
	hash.append(0xe4);
	hash.append(0xc8);
	hash.append(0x45);
	hash.append(0x2d);
	hash.append(0xa7);
	hash.append(0xc2);
	hash.append(0xa9);
	hash.append(0x9f);
	hash.append(0x9c);
	hash.append(0xdb);
	hash.append(0x97);
	hash.append(0xc1);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x30);
	auth_data.append(0xd2);
	auth_data.append(0xb8);
	auth_data.append(0x22);
	auth_data.append(0x92);
	auth_data.append(0xcd);
	auth_data.append(0x33);
	auth_data.append(0x41);
	auth_data.append(0xd8);
	auth_data.append(0x73);
	auth_data.append(0x55);
	auth_data.append(0x34);
	auth_data.append(0xd);
	auth_data.append(0xef);
	auth_data.append(0xfe);
	auth_data.append(0x5f);
	auth_data.append(0xaa);
	auth_data.append(0x9a);
	auth_data.append(0x58);
	auth_data.append(0x45);
	auth_data.append(0xa8);
	auth_data.append(0xe6);
	auth_data.append(0x9e);
	auth_data.append(0xdd);
	auth_data.append(0x8f);
	auth_data.append(0x4a);
	auth_data.append(0x16);
	auth_data.append(0xc2);
	auth_data.append(0x5e);
	auth_data.append(0x25);
	auth_data.append(0x68);
	auth_data.append(0x9b);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x2e);
	sig.append(0x4c);
	sig.append(0x9e);
	sig.append(0xb2);
	sig.append(0x4b);
	sig.append(0x5a);
	sig.append(0xa7);
	sig.append(0xa3);
	sig.append(0xca);
	sig.append(0x71);
	sig.append(0xed);
	sig.append(0x4b);
	sig.append(0xb2);
	sig.append(0x29);
	sig.append(0x26);
	sig.append(0x15);
	sig.append(0x26);
	sig.append(0x1b);
	sig.append(0x87);
	sig.append(0xea);
	sig.append(0x31);
	sig.append(0x16);
	sig.append(0xe4);
	sig.append(0x5f);
	sig.append(0x65);
	sig.append(0x45);
	sig.append(0xd7);
	sig.append(0xb9);
	sig.append(0x96);
	sig.append(0x52);
	sig.append(0x39);
	sig.append(0x6b);
	sig.append(0xa0);
	sig.append(0xfb);
	sig.append(0x99);
	sig.append(0x59);
	sig.append(0x15);
	sig.append(0x83);
	sig.append(0x85);
	sig.append(0x8b);
	sig.append(0x57);
	sig.append(0x9b);
	sig.append(0xd7);
	sig.append(0x1);
	sig.append(0xf);
	sig.append(0x4f);
	sig.append(0xeb);
	sig.append(0x38);
	sig.append(0x32);
	sig.append(0xbd);
	sig.append(0xf3);
	sig.append(0x67);
	sig.append(0xbb);
	sig.append(0xd2);
	sig.append(0xd7);
	sig.append(0x9a);
	sig.append(0x9);
	sig.append(0x5b);
	sig.append(0xfd);
	sig.append(0x66);
	sig.append(0xbe);
	sig.append(0xc4);
	sig.append(0xce);
	sig.append(0xd9);
	let pk = PublicKey {
		 x: 15193611809056409808874424566113496047725072474057837011201667076405995846099, 
		 y: 100406599613618223760315230958146852622725086156522631451066811548630392023178
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
	hash.append(0x5a);
	hash.append(0xa4);
	hash.append(0x73);
	hash.append(0x94);
	hash.append(0x18);
	hash.append(0xe3);
	hash.append(0x7b);
	hash.append(0xe);
	hash.append(0xa9);
	hash.append(0x3c);
	hash.append(0xff);
	hash.append(0xd3);
	hash.append(0x51);
	hash.append(0xc);
	hash.append(0xe5);
	hash.append(0xca);
	hash.append(0xad);
	hash.append(0x27);
	hash.append(0xd6);
	hash.append(0xc4);
	hash.append(0x18);
	hash.append(0xe1);
	hash.append(0xa5);
	hash.append(0xcc);
	hash.append(0x63);
	hash.append(0x55);
	hash.append(0x9c);
	hash.append(0x23);
	hash.append(0xb6);
	hash.append(0x9d);
	hash.append(0x6e);
	hash.append(0xac);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x53);
	auth_data.append(0x48);
	auth_data.append(0x62);
	auth_data.append(0xa8);
	auth_data.append(0x10);
	auth_data.append(0x24);
	auth_data.append(0x4);
	auth_data.append(0xd6);
	auth_data.append(0x85);
	auth_data.append(0x95);
	auth_data.append(0x47);
	auth_data.append(0x4e);
	auth_data.append(0x39);
	auth_data.append(0xbf);
	auth_data.append(0x5b);
	auth_data.append(0x75);
	auth_data.append(0x49);
	auth_data.append(0x85);
	auth_data.append(0x87);
	auth_data.append(0x67);
	auth_data.append(0x24);
	auth_data.append(0x6f);
	auth_data.append(0x6e);
	auth_data.append(0x6);
	auth_data.append(0x19);
	auth_data.append(0xb2);
	auth_data.append(0xcd);
	auth_data.append(0x25);
	auth_data.append(0x0);
	auth_data.append(0xc0);
	auth_data.append(0xc6);
	auth_data.append(0x64);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x52);
	sig.append(0x54);
	sig.append(0x33);
	sig.append(0xc0);
	sig.append(0x13);
	sig.append(0x70);
	sig.append(0xc2);
	sig.append(0x25);
	sig.append(0x12);
	sig.append(0xf1);
	sig.append(0x89);
	sig.append(0xa5);
	sig.append(0x9b);
	sig.append(0x4e);
	sig.append(0x39);
	sig.append(0x13);
	sig.append(0x36);
	sig.append(0x84);
	sig.append(0x2f);
	sig.append(0xec);
	sig.append(0x9c);
	sig.append(0xa2);
	sig.append(0x5d);
	sig.append(0xe3);
	sig.append(0x21);
	sig.append(0x69);
	sig.append(0xd0);
	sig.append(0x37);
	sig.append(0x3d);
	sig.append(0xf8);
	sig.append(0x4e);
	sig.append(0x2e);
	sig.append(0xda);
	sig.append(0x8e);
	sig.append(0xdb);
	sig.append(0xfe);
	sig.append(0xfc);
	sig.append(0xda);
	sig.append(0x5a);
	sig.append(0x7e);
	sig.append(0xbc);
	sig.append(0x47);
	sig.append(0xd2);
	sig.append(0xb4);
	sig.append(0x8);
	sig.append(0x5a);
	sig.append(0x31);
	sig.append(0x81);
	sig.append(0x72);
	sig.append(0xcc);
	sig.append(0x3d);
	sig.append(0x1a);
	sig.append(0xfe);
	sig.append(0xc7);
	sig.append(0x9f);
	sig.append(0x32);
	sig.append(0xd5);
	sig.append(0x1);
	sig.append(0x8e);
	sig.append(0x4e);
	sig.append(0x4b);
	sig.append(0x93);
	sig.append(0x32);
	sig.append(0x1b);
	let pk = PublicKey {
		 x: 6304703047035522076305562908666903071445378311936741097664569888275754835951, 
		 y: 53198410416618636037299512234272406721927920147656339181447107525995277259233
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
	hash.append(0xe6);
	hash.append(0x43);
	hash.append(0x45);
	hash.append(0x1c);
	hash.append(0xd1);
	hash.append(0x5a);
	hash.append(0xf0);
	hash.append(0xd3);
	hash.append(0x3a);
	hash.append(0xfd);
	hash.append(0x24);
	hash.append(0x52);
	hash.append(0xb8);
	hash.append(0x70);
	hash.append(0x5);
	hash.append(0x52);
	hash.append(0x72);
	hash.append(0xc6);
	hash.append(0x56);
	hash.append(0xa6);
	hash.append(0x1f);
	hash.append(0xd8);
	hash.append(0xdb);
	hash.append(0xba);
	hash.append(0x8c);
	hash.append(0x54);
	hash.append(0xbd);
	hash.append(0x7a);
	hash.append(0xc4);
	hash.append(0x78);
	hash.append(0x19);
	hash.append(0xd3);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x4c);
	auth_data.append(0x4b);
	auth_data.append(0xff);
	auth_data.append(0x14);
	auth_data.append(0x7d);
	auth_data.append(0x28);
	auth_data.append(0xd0);
	auth_data.append(0xdc);
	auth_data.append(0x20);
	auth_data.append(0xa6);
	auth_data.append(0x58);
	auth_data.append(0x75);
	auth_data.append(0xe);
	auth_data.append(0x60);
	auth_data.append(0x5c);
	auth_data.append(0xc4);
	auth_data.append(0x75);
	auth_data.append(0x56);
	auth_data.append(0x33);
	auth_data.append(0x9a);
	auth_data.append(0x5f);
	auth_data.append(0x9e);
	auth_data.append(0xeb);
	auth_data.append(0xaa);
	auth_data.append(0xa3);
	auth_data.append(0xf5);
	auth_data.append(0x67);
	auth_data.append(0x92);
	auth_data.append(0x9);
	auth_data.append(0x3a);
	auth_data.append(0xe5);
	auth_data.append(0xe4);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0xa0);
	sig.append(0xd0);
	sig.append(0xec);
	sig.append(0x32);
	sig.append(0x55);
	sig.append(0x3d);
	sig.append(0xf0);
	sig.append(0x62);
	sig.append(0xf);
	sig.append(0x9d);
	sig.append(0x7b);
	sig.append(0xfb);
	sig.append(0xc4);
	sig.append(0x58);
	sig.append(0x8c);
	sig.append(0x88);
	sig.append(0x9b);
	sig.append(0xe2);
	sig.append(0x7f);
	sig.append(0x39);
	sig.append(0xc);
	sig.append(0x82);
	sig.append(0xee);
	sig.append(0x67);
	sig.append(0x77);
	sig.append(0xe5);
	sig.append(0x3a);
	sig.append(0xe5);
	sig.append(0x3d);
	sig.append(0xad);
	sig.append(0x15);
	sig.append(0x50);
	sig.append(0xcf);
	sig.append(0xd8);
	sig.append(0x26);
	sig.append(0x9a);
	sig.append(0x6a);
	sig.append(0x81);
	sig.append(0x6c);
	sig.append(0x4a);
	sig.append(0x7d);
	sig.append(0xa3);
	sig.append(0x9e);
	sig.append(0x60);
	sig.append(0x8c);
	sig.append(0xbf);
	sig.append(0x1f);
	sig.append(0xe5);
	sig.append(0x48);
	sig.append(0x63);
	sig.append(0x61);
	sig.append(0x44);
	sig.append(0x51);
	sig.append(0xa0);
	sig.append(0x2a);
	sig.append(0xeb);
	sig.append(0x18);
	sig.append(0x1);
	sig.append(0xcb);
	sig.append(0x7b);
	sig.append(0x5e);
	sig.append(0x6b);
	sig.append(0xff);
	sig.append(0xe8);
	let pk = PublicKey {
		 x: 38149929428158434065922391434012984621798664433389354974107978565621060935787, 
		 y: 84040370344963330020131377339273966638073175536667301930637871741667557160617
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
	hash.append(0x10);
	hash.append(0xef);
	hash.append(0xb2);
	hash.append(0x48);
	hash.append(0x3a);
	hash.append(0x64);
	hash.append(0x42);
	hash.append(0xdf);
	hash.append(0xfc);
	hash.append(0xd9);
	hash.append(0xa);
	hash.append(0x91);
	hash.append(0xad);
	hash.append(0x81);
	hash.append(0xa8);
	hash.append(0x4);
	hash.append(0xa8);
	hash.append(0x58);
	hash.append(0x43);
	hash.append(0x41);
	hash.append(0xe5);
	hash.append(0x79);
	hash.append(0x7b);
	hash.append(0x36);
	hash.append(0x62);
	hash.append(0xb6);
	hash.append(0x48);
	hash.append(0xe4);
	hash.append(0x5c);
	hash.append(0x3b);
	hash.append(0x50);
	let mut auth_data: Array<u8> = ArrayTrait::new();
	auth_data.append(0x19);
	auth_data.append(0xdf);
	auth_data.append(0x20);
	auth_data.append(0xc7);
	auth_data.append(0x45);
	auth_data.append(0xef);
	auth_data.append(0xc8);
	auth_data.append(0x3b);
	auth_data.append(0xa1);
	auth_data.append(0xa4);
	auth_data.append(0xc9);
	auth_data.append(0xef);
	auth_data.append(0xc6);
	auth_data.append(0x7a);
	auth_data.append(0x74);
	auth_data.append(0x5c);
	auth_data.append(0xa1);
	auth_data.append(0x13);
	auth_data.append(0xce);
	auth_data.append(0x7d);
	auth_data.append(0xa);
	auth_data.append(0xd8);
	auth_data.append(0xd4);
	auth_data.append(0x4e);
	auth_data.append(0xa9);
	auth_data.append(0xdd);
	auth_data.append(0xb0);
	auth_data.append(0xf9);
	auth_data.append(0xf3);
	auth_data.append(0x7a);
	auth_data.append(0x5f);
	auth_data.append(0x76);
	auth_data.append(0xa0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x0);
	auth_data.append(0x1);
	let mut sig: Array<u8> = ArrayTrait::new();
	sig.append(0x9d);
	sig.append(0x3a);
	sig.append(0xc0);
	sig.append(0xb7);
	sig.append(0xa7);
	sig.append(0x81);
	sig.append(0x58);
	sig.append(0x31);
	sig.append(0xd2);
	sig.append(0x2b);
	sig.append(0xac);
	sig.append(0x2b);
	sig.append(0x67);
	sig.append(0xe2);
	sig.append(0x58);
	sig.append(0x10);
	sig.append(0x36);
	sig.append(0x90);
	sig.append(0x5d);
	sig.append(0x81);
	sig.append(0x40);
	sig.append(0xee);
	sig.append(0xa0);
	sig.append(0x2d);
	sig.append(0xd5);
	sig.append(0x1c);
	sig.append(0xe0);
	sig.append(0x50);
	sig.append(0x26);
	sig.append(0x8b);
	sig.append(0x81);
	sig.append(0xb3);
	sig.append(0x87);
	sig.append(0x82);
	sig.append(0x54);
	sig.append(0xd);
	sig.append(0x64);
	sig.append(0xa2);
	sig.append(0x3a);
	sig.append(0x87);
	sig.append(0xfd);
	sig.append(0x22);
	sig.append(0x6a);
	sig.append(0xae);
	sig.append(0x8f);
	sig.append(0x85);
	sig.append(0x9a);
	sig.append(0x64);
	sig.append(0x44);
	sig.append(0x1c);
	sig.append(0xdb);
	sig.append(0xe0);
	sig.append(0xf);
	sig.append(0x22);
	sig.append(0x51);
	sig.append(0x7b);
	sig.append(0xcc);
	sig.append(0x1);
	sig.append(0x4b);
	sig.append(0x89);
	sig.append(0x8a);
	sig.append(0x9e);
	sig.append(0xb);
	sig.append(0xd8);
	let pk = PublicKey {
		 x: 108810523620643739845347902499848770820825730741117865649978122003340027645905, 
		 y: 93094115122263986670409689719530460295977212530683093926748379048550537391220
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


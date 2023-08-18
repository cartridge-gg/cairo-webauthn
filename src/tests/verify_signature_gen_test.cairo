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
	hash.append(0xb5);
	hash.append(0xa2);
	hash.append(0xc9);
	hash.append(0x62);
	hash.append(0x50);
	hash.append(0x61);
	hash.append(0x23);
	hash.append(0x66);
	hash.append(0xea);
	hash.append(0x27);
	hash.append(0x2f);
	hash.append(0xfa);
	hash.append(0xc6);
	hash.append(0xd9);
	hash.append(0x74);
	hash.append(0x4a);
	hash.append(0xaf);
	hash.append(0x4b);
	hash.append(0x45);
	hash.append(0xaa);
	hash.append(0xcd);
	hash.append(0x96);
	hash.append(0xaa);
	hash.append(0x7c);
	hash.append(0xfc);
	hash.append(0xb9);
	hash.append(0x31);
	hash.append(0xee);
	hash.append(0x3b);
	hash.append(0x55);
	hash.append(0x82);
	hash.append(0x59);
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
	sig.append(0x49);
	sig.append(0x9a);
	sig.append(0x6f);
	sig.append(0x38);
	sig.append(0x17);
	sig.append(0xb4);
	sig.append(0x5);
	sig.append(0x2d);
	sig.append(0x20);
	sig.append(0x93);
	sig.append(0xbe);
	sig.append(0xef);
	sig.append(0x81);
	sig.append(0x19);
	sig.append(0x88);
	sig.append(0x14);
	sig.append(0xc0);
	sig.append(0x9e);
	sig.append(0x5f);
	sig.append(0x84);
	sig.append(0xcf);
	sig.append(0xdb);
	sig.append(0x72);
	sig.append(0x26);
	sig.append(0x39);
	sig.append(0xa4);
	sig.append(0xcc);
	sig.append(0xaa);
	sig.append(0x5d);
	sig.append(0x42);
	sig.append(0x5);
	sig.append(0xf6);
	sig.append(0x66);
	sig.append(0x96);
	sig.append(0x6b);
	sig.append(0x13);
	sig.append(0xa1);
	sig.append(0xc5);
	sig.append(0xa7);
	sig.append(0xb2);
	sig.append(0x2d);
	sig.append(0x2);
	sig.append(0x68);
	sig.append(0x9d);
	sig.append(0xa2);
	sig.append(0xee);
	sig.append(0xa3);
	sig.append(0xec);
	sig.append(0xe7);
	sig.append(0xe4);
	sig.append(0xe2);
	sig.append(0x81);
	sig.append(0xd6);
	sig.append(0xe1);
	sig.append(0xbe);
	sig.append(0x99);
	sig.append(0xcb);
	sig.append(0x12);
	sig.append(0x43);
	sig.append(0xb7);
	sig.append(0xfe);
	sig.append(0x73);
	sig.append(0x2f);
	sig.append(0x6f);
	let pk = PublicKey {
		 x: 65957347653002202121750765822877183189872373141098466928304824121924341028076, 
		 y: 77235295904347846788821084904308544625347076878481818221128019391322539512400
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
	hash.append(0xb5);
	hash.append(0xa2);
	hash.append(0xc9);
	hash.append(0x62);
	hash.append(0x50);
	hash.append(0x61);
	hash.append(0x23);
	hash.append(0x66);
	hash.append(0xea);
	hash.append(0x27);
	hash.append(0x2f);
	hash.append(0xfa);
	hash.append(0xc6);
	hash.append(0xd9);
	hash.append(0x74);
	hash.append(0x4a);
	hash.append(0xaf);
	hash.append(0x4b);
	hash.append(0x45);
	hash.append(0xaa);
	hash.append(0xcd);
	hash.append(0x96);
	hash.append(0xaa);
	hash.append(0x7c);
	hash.append(0xfc);
	hash.append(0xb9);
	hash.append(0x31);
	hash.append(0xee);
	hash.append(0x3b);
	hash.append(0x55);
	hash.append(0x82);
	hash.append(0x59);
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
	sig.append(0x4e);
	sig.append(0xbf);
	sig.append(0x1f);
	sig.append(0xbb);
	sig.append(0xf);
	sig.append(0xa1);
	sig.append(0xde);
	sig.append(0x5e);
	sig.append(0xff);
	sig.append(0xb5);
	sig.append(0xdc);
	sig.append(0xae);
	sig.append(0x73);
	sig.append(0x8b);
	sig.append(0xa8);
	sig.append(0x15);
	sig.append(0xde);
	sig.append(0x83);
	sig.append(0xb6);
	sig.append(0xb2);
	sig.append(0x66);
	sig.append(0x4);
	sig.append(0x90);
	sig.append(0x13);
	sig.append(0x26);
	sig.append(0xb5);
	sig.append(0xdb);
	sig.append(0x6a);
	sig.append(0xc);
	sig.append(0x89);
	sig.append(0x79);
	sig.append(0xe);
	sig.append(0xa6);
	sig.append(0x36);
	sig.append(0x51);
	sig.append(0x8);
	sig.append(0xf4);
	sig.append(0x62);
	sig.append(0xbf);
	sig.append(0x51);
	sig.append(0xd4);
	sig.append(0xe3);
	sig.append(0x94);
	sig.append(0x70);
	sig.append(0xa7);
	sig.append(0x71);
	sig.append(0x93);
	sig.append(0xfe);
	sig.append(0x5c);
	sig.append(0xc1);
	sig.append(0xa1);
	sig.append(0xfc);
	sig.append(0xf7);
	sig.append(0xcf);
	sig.append(0x22);
	sig.append(0x7b);
	sig.append(0x4a);
	sig.append(0xb3);
	sig.append(0xad);
	sig.append(0xd4);
	sig.append(0xfb);
	sig.append(0x74);
	sig.append(0x87);
	sig.append(0x6b);
	let pk = PublicKey {
		 x: 31604801059082006981866649414115712025087254759588529251934034432747374259003, 
		 y: 20513305764686666624285148369660985011879901534199397204909793135551282401597
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
	hash.append(0xb5);
	hash.append(0xa2);
	hash.append(0xc9);
	hash.append(0x62);
	hash.append(0x50);
	hash.append(0x61);
	hash.append(0x23);
	hash.append(0x66);
	hash.append(0xea);
	hash.append(0x27);
	hash.append(0x2f);
	hash.append(0xfa);
	hash.append(0xc6);
	hash.append(0xd9);
	hash.append(0x74);
	hash.append(0x4a);
	hash.append(0xaf);
	hash.append(0x4b);
	hash.append(0x45);
	hash.append(0xaa);
	hash.append(0xcd);
	hash.append(0x96);
	hash.append(0xaa);
	hash.append(0x7c);
	hash.append(0xfc);
	hash.append(0xb9);
	hash.append(0x31);
	hash.append(0xee);
	hash.append(0x3b);
	hash.append(0x55);
	hash.append(0x82);
	hash.append(0x59);
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
	sig.append(0xb5);
	sig.append(0xfd);
	sig.append(0x33);
	sig.append(0xbd);
	sig.append(0x4);
	sig.append(0x53);
	sig.append(0x3f);
	sig.append(0x3e);
	sig.append(0xe3);
	sig.append(0x79);
	sig.append(0x68);
	sig.append(0x12);
	sig.append(0x11);
	sig.append(0x35);
	sig.append(0xdd);
	sig.append(0x99);
	sig.append(0x9);
	sig.append(0x14);
	sig.append(0x5c);
	sig.append(0xfd);
	sig.append(0x81);
	sig.append(0x93);
	sig.append(0xad);
	sig.append(0x26);
	sig.append(0xb4);
	sig.append(0x17);
	sig.append(0x25);
	sig.append(0xc4);
	sig.append(0xb);
	sig.append(0x79);
	sig.append(0xe7);
	sig.append(0xbb);
	sig.append(0xc4);
	sig.append(0xca);
	sig.append(0x9f);
	sig.append(0x8a);
	sig.append(0x5);
	sig.append(0xbd);
	sig.append(0x49);
	sig.append(0x91);
	sig.append(0x2a);
	sig.append(0x7b);
	sig.append(0x85);
	sig.append(0xae);
	sig.append(0x1f);
	sig.append(0x5);
	sig.append(0x67);
	sig.append(0xd9);
	sig.append(0x7f);
	sig.append(0xf2);
	sig.append(0x29);
	sig.append(0x5);
	sig.append(0x92);
	sig.append(0x99);
	sig.append(0x6b);
	sig.append(0x6);
	sig.append(0xf3);
	sig.append(0xcb);
	sig.append(0xc5);
	sig.append(0x49);
	sig.append(0x6e);
	sig.append(0x25);
	sig.append(0x1d);
	sig.append(0x37);
	let pk = PublicKey {
		 x: 1717227382127804304288646568230854248763191298470621389050495408715099615677, 
		 y: 23848080381514904119137572670093466666453805417903442263516167965616084095485
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
	hash.append(0xb5);
	hash.append(0xa2);
	hash.append(0xc9);
	hash.append(0x62);
	hash.append(0x50);
	hash.append(0x61);
	hash.append(0x23);
	hash.append(0x66);
	hash.append(0xea);
	hash.append(0x27);
	hash.append(0x2f);
	hash.append(0xfa);
	hash.append(0xc6);
	hash.append(0xd9);
	hash.append(0x74);
	hash.append(0x4a);
	hash.append(0xaf);
	hash.append(0x4b);
	hash.append(0x45);
	hash.append(0xaa);
	hash.append(0xcd);
	hash.append(0x96);
	hash.append(0xaa);
	hash.append(0x7c);
	hash.append(0xfc);
	hash.append(0xb9);
	hash.append(0x31);
	hash.append(0xee);
	hash.append(0x3b);
	hash.append(0x55);
	hash.append(0x82);
	hash.append(0x59);
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
	sig.append(0xfa);
	sig.append(0x5);
	sig.append(0x75);
	sig.append(0x0);
	sig.append(0xb7);
	sig.append(0x1a);
	sig.append(0x31);
	sig.append(0xe6);
	sig.append(0xfb);
	sig.append(0x50);
	sig.append(0xde);
	sig.append(0xc1);
	sig.append(0x17);
	sig.append(0x28);
	sig.append(0x29);
	sig.append(0x1c);
	sig.append(0x0);
	sig.append(0xb9);
	sig.append(0xa7);
	sig.append(0x69);
	sig.append(0x8b);
	sig.append(0x9c);
	sig.append(0x41);
	sig.append(0xe2);
	sig.append(0xb8);
	sig.append(0x8c);
	sig.append(0xa3);
	sig.append(0x78);
	sig.append(0xaa);
	sig.append(0xa2);
	sig.append(0xbe);
	sig.append(0xd3);
	sig.append(0xbf);
	sig.append(0x35);
	sig.append(0x43);
	sig.append(0xd3);
	sig.append(0x97);
	sig.append(0xd0);
	sig.append(0xd5);
	sig.append(0x4);
	sig.append(0xf9);
	sig.append(0x89);
	sig.append(0x33);
	sig.append(0x8a);
	sig.append(0x11);
	sig.append(0xd8);
	sig.append(0xd4);
	sig.append(0xd5);
	sig.append(0x9c);
	sig.append(0x62);
	sig.append(0xde);
	sig.append(0x25);
	sig.append(0xef);
	sig.append(0xf1);
	sig.append(0x5c);
	sig.append(0xc9);
	sig.append(0x96);
	sig.append(0xd7);
	sig.append(0x1e);
	sig.append(0x3a);
	sig.append(0x56);
	sig.append(0x2f);
	sig.append(0xd3);
	sig.append(0xe3);
	let pk = PublicKey {
		 x: 64293282761527284792259444688305377976488260281146987483556973443698595531668, 
		 y: 111815950773379210308518545996032349777724607004763132108673419586261796482343
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


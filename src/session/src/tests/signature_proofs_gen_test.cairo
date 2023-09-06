// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/session/signature_proofs_test.py for details
use core::traits::Into;
use core::option::OptionTrait;
use array::ArrayTrait;
use webauthn_session::signature::ImplSignatureProofs;

#[test]
#[available_gas(300000)]
fn test_signature_proofs_3() {
	let mut proofs: Array<felt252> = ArrayTrait::new();
	proofs.append(0x0);
	proofs.append(0x1);
	proofs.append(0x2);
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 1).unwrap();
		assert(option.len() == 3, 'Wrong length');
		assert(option.at(0).len() == 1, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(2).at(0) == 2, 'Should equal');
		assert(*option.at(2).at(0) == 2, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 2) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 3).unwrap();
		assert(option.len() == 1, 'Wrong length');
		assert(option.at(0).len() == 3, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(0).at(2) == 2, 'Should equal');
	}
	
}

#[test]
#[available_gas(1200000)]
fn test_signature_proofs_12() {
	let mut proofs: Array<felt252> = ArrayTrait::new();
	proofs.append(0x0);
	proofs.append(0x1);
	proofs.append(0x2);
	proofs.append(0x3);
	proofs.append(0x4);
	proofs.append(0x5);
	proofs.append(0x6);
	proofs.append(0x7);
	proofs.append(0x8);
	proofs.append(0x9);
	proofs.append(0xa);
	proofs.append(0xb);
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 1).unwrap();
		assert(option.len() == 12, 'Wrong length');
		assert(option.at(0).len() == 1, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(11).at(0) == 11, 'Should equal');
		assert(*option.at(11).at(0) == 11, 'Should equal');
	}
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 2).unwrap();
		assert(option.len() == 6, 'Wrong length');
		assert(option.at(0).len() == 2, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(5).at(0) == 10, 'Should equal');
		assert(*option.at(5).at(1) == 11, 'Should equal');
	}
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 3).unwrap();
		assert(option.len() == 4, 'Wrong length');
		assert(option.at(0).len() == 3, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(3).at(0) == 9, 'Should equal');
		assert(*option.at(3).at(2) == 11, 'Should equal');
	}
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 4).unwrap();
		assert(option.len() == 3, 'Wrong length');
		assert(option.at(0).len() == 4, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(2).at(0) == 8, 'Should equal');
		assert(*option.at(2).at(3) == 11, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 5) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 6).unwrap();
		assert(option.len() == 2, 'Wrong length');
		assert(option.at(0).len() == 6, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(1).at(0) == 6, 'Should equal');
		assert(*option.at(1).at(5) == 11, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 7) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 8) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 9) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 10) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 11) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 12).unwrap();
		assert(option.len() == 1, 'Wrong length');
		assert(option.at(0).len() == 12, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(0).at(11) == 11, 'Should equal');
	}
	
}

#[test]
#[available_gas(10000000)]
fn test_signature_proofs_100() {
	let mut proofs: Array<felt252> = ArrayTrait::new();
	proofs.append(0x0);
	proofs.append(0x1);
	proofs.append(0x2);
	proofs.append(0x3);
	proofs.append(0x4);
	proofs.append(0x5);
	proofs.append(0x6);
	proofs.append(0x7);
	proofs.append(0x8);
	proofs.append(0x9);
	proofs.append(0xa);
	proofs.append(0xb);
	proofs.append(0xc);
	proofs.append(0xd);
	proofs.append(0xe);
	proofs.append(0xf);
	proofs.append(0x10);
	proofs.append(0x11);
	proofs.append(0x12);
	proofs.append(0x13);
	proofs.append(0x14);
	proofs.append(0x15);
	proofs.append(0x16);
	proofs.append(0x17);
	proofs.append(0x18);
	proofs.append(0x19);
	proofs.append(0x1a);
	proofs.append(0x1b);
	proofs.append(0x1c);
	proofs.append(0x1d);
	proofs.append(0x1e);
	proofs.append(0x1f);
	proofs.append(0x20);
	proofs.append(0x21);
	proofs.append(0x22);
	proofs.append(0x23);
	proofs.append(0x24);
	proofs.append(0x25);
	proofs.append(0x26);
	proofs.append(0x27);
	proofs.append(0x28);
	proofs.append(0x29);
	proofs.append(0x2a);
	proofs.append(0x2b);
	proofs.append(0x2c);
	proofs.append(0x2d);
	proofs.append(0x2e);
	proofs.append(0x2f);
	proofs.append(0x30);
	proofs.append(0x31);
	proofs.append(0x32);
	proofs.append(0x33);
	proofs.append(0x34);
	proofs.append(0x35);
	proofs.append(0x36);
	proofs.append(0x37);
	proofs.append(0x38);
	proofs.append(0x39);
	proofs.append(0x3a);
	proofs.append(0x3b);
	proofs.append(0x3c);
	proofs.append(0x3d);
	proofs.append(0x3e);
	proofs.append(0x3f);
	proofs.append(0x40);
	proofs.append(0x41);
	proofs.append(0x42);
	proofs.append(0x43);
	proofs.append(0x44);
	proofs.append(0x45);
	proofs.append(0x46);
	proofs.append(0x47);
	proofs.append(0x48);
	proofs.append(0x49);
	proofs.append(0x4a);
	proofs.append(0x4b);
	proofs.append(0x4c);
	proofs.append(0x4d);
	proofs.append(0x4e);
	proofs.append(0x4f);
	proofs.append(0x50);
	proofs.append(0x51);
	proofs.append(0x52);
	proofs.append(0x53);
	proofs.append(0x54);
	proofs.append(0x55);
	proofs.append(0x56);
	proofs.append(0x57);
	proofs.append(0x58);
	proofs.append(0x59);
	proofs.append(0x5a);
	proofs.append(0x5b);
	proofs.append(0x5c);
	proofs.append(0x5d);
	proofs.append(0x5e);
	proofs.append(0x5f);
	proofs.append(0x60);
	proofs.append(0x61);
	proofs.append(0x62);
	proofs.append(0x63);
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 1).unwrap();
		assert(option.len() == 100, 'Wrong length');
		assert(option.at(0).len() == 1, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(99).at(0) == 99, 'Should equal');
		assert(*option.at(99).at(0) == 99, 'Should equal');
	}
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 2).unwrap();
		assert(option.len() == 50, 'Wrong length');
		assert(option.at(0).len() == 2, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(49).at(0) == 98, 'Should equal');
		assert(*option.at(49).at(1) == 99, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 3) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 4).unwrap();
		assert(option.len() == 25, 'Wrong length');
		assert(option.at(0).len() == 4, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(24).at(0) == 96, 'Should equal');
		assert(*option.at(24).at(3) == 99, 'Should equal');
	}
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 5).unwrap();
		assert(option.len() == 20, 'Wrong length');
		assert(option.at(0).len() == 5, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(19).at(0) == 95, 'Should equal');
		assert(*option.at(19).at(4) == 99, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 6) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 7) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 8) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 9) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 10).unwrap();
		assert(option.len() == 10, 'Wrong length');
		assert(option.at(0).len() == 10, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(9).at(0) == 90, 'Should equal');
		assert(*option.at(9).at(9) == 99, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 11) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 12) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 13) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 14) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 15) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 16) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 17) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 18) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 19) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 20).unwrap();
		assert(option.len() == 5, 'Wrong length');
		assert(option.at(0).len() == 20, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(4).at(0) == 80, 'Should equal');
		assert(*option.at(4).at(19) == 99, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 21) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 22) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 23) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 24) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 25).unwrap();
		assert(option.len() == 4, 'Wrong length');
		assert(option.at(0).len() == 25, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(3).at(0) == 75, 'Should equal');
		assert(*option.at(3).at(24) == 99, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 26) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 27) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 28) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 29) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 30) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 31) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 32) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 33) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 34) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 35) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 36) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 37) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 38) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 39) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 40) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 41) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 42) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 43) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 44) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 45) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 46) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 47) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 48) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 49) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 50).unwrap();
		assert(option.len() == 2, 'Wrong length');
		assert(option.at(0).len() == 50, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(1).at(0) == 50, 'Should equal');
		assert(*option.at(1).at(49) == 99, 'Should equal');
	}
	match ImplSignatureProofs::try_new(proofs.span(), 51) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 52) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 53) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 54) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 55) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 56) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 57) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 58) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 59) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 60) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 61) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 62) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 63) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 64) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 65) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 66) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 67) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 68) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 69) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 70) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 71) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 72) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 73) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 74) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 75) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 76) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 77) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 78) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 79) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 80) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 81) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 82) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 83) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 84) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 85) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 86) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 87) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 88) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 89) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 90) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 91) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 92) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 93) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 94) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 95) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 96) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 97) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 98) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	match ImplSignatureProofs::try_new(proofs.span(), 99) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 100).unwrap();
		assert(option.len() == 1, 'Wrong length');
		assert(option.at(0).len() == 100, 'Wrong length');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(0).at(0) == 0, 'Should equal');
		assert(*option.at(0).at(99) == 99, 'Should equal');
	}
	
}


// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/session/signature_proofs_test.py for details
use core::traits::Into;
use core::option::OptionTrait;
use array::ArrayTrait;
use webauthn_session::signature::ImplSignatureProofs;

#[test]
#[available_gas(200000000000)]
fn test_length_3() {
	let mut proofs: Array<felt252> = ArrayTrait::new();
	proofs.append(0x0);
	proofs.append(0x1);
	proofs.append(0x2);
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 1).unwrap();
		assert(option.len() == 3, 'Wrong length')
	}
	match ImplSignatureProofs::try_new(proofs.span(), 2) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 3).unwrap();
		assert(option.len() == 1, 'Wrong length')
	}
	
}

#[test]
#[available_gas(200000000000)]
fn test_length_12() {
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
		assert(option.len() == 12, 'Wrong length')
	}
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 2).unwrap();
		assert(option.len() == 6, 'Wrong length')
	}
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 3).unwrap();
		assert(option.len() == 4, 'Wrong length')
	}
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 4).unwrap();
		assert(option.len() == 3, 'Wrong length')
	}
	match ImplSignatureProofs::try_new(proofs.span(), 5) {
	    Option::Some(_) => assert(false, 'Should be None!'),
	    Option::None => ()
	};
	{
		let option = ImplSignatureProofs::try_new(proofs.span(), 6).unwrap();
		assert(option.len() == 2, 'Wrong length')
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
		assert(option.len() == 1, 'Wrong length')
	}
	
}


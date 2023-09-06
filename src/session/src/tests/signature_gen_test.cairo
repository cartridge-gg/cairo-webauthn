// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/session/signature_test.py for details
use core::traits::Into;
use core::option::OptionTrait;
use array::ArrayTrait;
use core::pedersen::pedersen;
use webauthn_session::signature::FeltSpanTryIntoSignature;

#[test]
#[available_gas(200000000000)]
fn test_span_into_signature() {
	let mut sig: Array<felt252> = ArrayTrait::new();
	sig.append(0x0);
	sig.append(0x726);
	sig.append(0x747);
	sig.append(0x77e);
	sig.append(0x64fa2283);
	sig.append(0x782);
	sig.append(0x2);
	sig.append(0x4);
	sig.append(0x0);
	sig.append(0x1);
	sig.append(0x2);
	sig.append(0x3);
	sig.append(0x5);
	sig.append(0x0);
	sig.append(0x1);
	sig.append(0x2);
	sig.append(0x3);
	sig.append(0x4);
	FeltSpanTryIntoSignature::try_into(sig.span()).unwrap();
}


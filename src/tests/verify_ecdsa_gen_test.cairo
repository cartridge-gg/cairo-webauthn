// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/verify_ecdsa_test.py for details
use core::traits::Into;
use core::option::OptionTrait;
use webauthn::ecdsa::{verify_ecdsa, VerifyEcdsaError};
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1Point;
use starknet::SyscallResultTrait;

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa_short(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    93352604873803779223172166510729858837404943442755729671208797670350494908254,
	    76159172765179470423742298040382623870521854359697303903962556384388400771954
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 32212753620011331989713102639901828196850676077704767930065313314638602823880;
	let s = 62213006989327774746760671975167574315716943185243200531644472763916144838781;
	let msg_hash = 49;
	match verify_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => (),
	    Result::Err(m) => assert(false, m.into())
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    108866320290541081081348629823124070281148361153282284843219609651296987761253,
	    77865402465938567486457524302851893562525737538217613937839612992877880770064
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 53497272370749464741861589121511441865624366829355481509156213688715364416737;
	let s = 108955948887130409861559843634412233773283480619954358104743697547787732825019;
	let msg_hash = 22405534230753928650781647905;
	match verify_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => (),
	    Result::Err(m) => assert(false, m.into())
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa_long(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    86788068712599794996815093009505589740099574096443774693897034297543785728447,
	    66918682640962713701947372206680477334432388665641907761202240841387734805759
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 100526995336814342814405858772124760982131056349816253648417309593486759000976;
	let s = 56691368798128472201180717851831870921446722935290164121504604876854065639282;
	let msg_hash = 149135777980097582634002128993283245052269503470703527156581804847063441697;
	match verify_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => (),
	    Result::Err(m) => assert(false, m.into())
	}
}

#[test]
#[available_gas(200000000000)]
fn test_ecdsa_wrong_arguments(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    93255511091532337179772540325218469654426395396897309064438494728585984508899,
	    76652540580936833078565879957369159759497122309058933948286471647162019359313
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 0;
	let s = 0;
	let msg_hash = 6214289900658384436962189733492;
	match verify_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => assert(false, 'Should Error!'),
	    Result::Err(m) => match m {
	        VerifyEcdsaError::WrongArgument => (),
	        VerifyEcdsaError::InvalidSignature =>assert(false, 'Wrong Error!'),
	        VerifyEcdsaError::SyscallError => assert(false, 'Wrong Error!'),
	    }
	}
}

#[test]
#[available_gas(200000000000)]
fn test_ecdsa_invalid_signature(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    44415418079666810331913576677532584264850044122698769068901674273949435211573,
	    101851915479188902035336810657956282723799121103284993948440208233282586354079
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 77753179145587542391112895739610350715520903874352395672655547289933002350436;
	let s = 33702440978749562211824061668730773802157740359413514524002425835021880126102;
	let msg_hash = 111110000011111;
	match verify_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => assert(false, 'Should Error!'),
	    Result::Err(m) => match m {
	        VerifyEcdsaError::WrongArgument => assert(false, 'Wrong Error!'),
	        VerifyEcdsaError::InvalidSignature => (),
	        VerifyEcdsaError::SyscallError => assert(false, 'Wrong Error!'),
	    }
	}
}


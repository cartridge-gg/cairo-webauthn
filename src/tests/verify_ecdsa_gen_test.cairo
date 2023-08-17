// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/verify_ecdsa_test.py for details
use core::traits::Into;
use core::option::OptionTrait;
use webauthn::ecdsa::{verify_ecdsa, verify_hashed_ecdsa, VerifyEcdsaError};
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1Point;
use starknet::SyscallResultTrait;

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa_short(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    98322004939931917498971385946253010055243558015633735717609972076980566602893,
	    96636101338074535981584365508826257461228215353733168132885260562510800483904
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 51383191023979644091555888661471702856285643435412040734561917848294952020776;
	let s = 46142509014743430460832267619828997356532167732311028620744151172480747096794;
	let msg_hash = 49;
	
	match verify_hashed_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => (),
	    Result::Err(m) => assert(false, m.into())
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    50961193030563810415149359243827940448654998643312874797103817416275891164465,
	    67879384053870890258494745938089102375313231559111359203541379556917390731358
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 28158711859165226489508749676735928745648992248639564826391538392777094919740;
	let s = 66805438473267147281109568581055614906179381538466765793787993893181327719173;
	let msg_hash = 22405534230753928650781647905;
	
	match verify_hashed_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => (),
	    Result::Err(m) => assert(false, m.into())
	}
}

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa_long(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    16357067140351399265891057725074840464377518315551915591279300579109222260533,
	    95982846770210524992408130958053648448491206343247140478468516701459098813537
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 92776524394523761631824929554350451246816609763383156948694885189685482236511;
	let s = 20090371487530335347805087194255619000271333514454270467514093015795921093434;
	let msg_hash = 149135777980097582634002128993283245052269503470703527156581804847063441697;
	
	match verify_hashed_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => (),
	    Result::Err(m) => assert(false, m.into())
	}
}

#[test]
#[available_gas(200000000000)]
fn test_ecdsa_wrong_arguments(){
	let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
	    104891844100355493110720021690679957043163054565987601626689081415421001198089,
	    74628068066590702206596885670107534920837997777551644267487975848194875814601
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 0;
	let s = 0;
	let msg_hash = 6214289900658384436962189733492;
	
	match verify_hashed_ecdsa(pub_key, msg_hash, r, s) {
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
	    17145245118833373127396141137382742778405443168453257224733123885085036603018,
	    26387729475238278271583284898950294280081580202593103489638619585134615630968
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 65708037039989962580086541082369095986272624888530425720873829533153408801294;
	let s = 66424821973150561137612976133864239727862305968552985501769746997602903033524;
	let msg_hash = 111110000011111;
	
	match verify_hashed_ecdsa(pub_key, msg_hash, r, s) {
	    Result::Ok => assert(false, 'Should Error!'),
	    Result::Err(m) => match m {
	        VerifyEcdsaError::WrongArgument => assert(false, 'Wrong Error!'),
	        VerifyEcdsaError::InvalidSignature => (),
	        VerifyEcdsaError::SyscallError => assert(false, 'Wrong Error!'),
	    }
	}
}


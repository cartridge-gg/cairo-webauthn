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
	    24730947460681734663025027456364991470285264713598674912781083089276211838134,
	    74531813759614006891883015863961688643322180451584482566553571110942000119378
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 5555685989920338858011939526247797742168259423611498066804829147479352075246;
	let s = 51484330699593893408489896002974826486713723409396364255078994709079790958421;
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
	    83038990252865740639490098837499461303530703387889194981031292773798729089569,
	    40192864237261864669223335101800483861854394324061806469177338238027662483589
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 49560783588800727377953689443454673347200744732980829082442354385477565668400;
	let s = 115319249898744960979717831880471505168871852646168762766805831934004919311551;
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
	    21245078693677463620447316236447061435907974242795535721008916903034089700388,
	    3576019002012647489886085051645837867054007498465377010559066017915795941375
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 5336937750138724707254653133625095691633024409305602640670834088288273689486;
	let s = 77138048327142919899477522541698513896814324293908978772661051761228249655482;
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
	    25042368485734778143395104250377827704131622204929569349449750957165578280667,
	    66960455418148666888459829997148040388620217118367920752996910234603262063128
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
	    20707582804829299052303906502397285209331357691404944574975726280508894057787,
	    13159591300455546320397663912768673433902175744899165740200022781521963553076
	)
	    .unwrap_syscall()
	    .unwrap();
	let r = 36758864452054703793024246352303970299550269685815803326191438655392806641889;
	let s = 96051295934501569296733828734534729321946777406619557974851154927936642876186;
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


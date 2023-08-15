use core::traits::Into;
use core::option::OptionTrait;
use webauthn::ecdsa::{verify_ecdsa, VerifyEcdsaError};
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1Point;
use starknet::{
    SyscallResultTrait
};

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa_0() {
    let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
        16025858321261595685239921820533475307596570326672519128231805961961131050269,
        10914467046209739139010699492835491471829405877771131743676714776864370698303
    )
    .unwrap_syscall()
    .unwrap();

    let r = 62520418880875393019237974236799160433050528768835207573280366856803910997379;
    let s = 264906697722068631494923929531427850315993504893667084568822619175646396014;

    let msg_hash = 22405534230753928650781647905;

    match verify_ecdsa(pub_key, msg_hash, r, s) {
        Result::Ok => (),
        Result::Err(m) => assert(false, m.into())
    }
}



#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa_1() {
    let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
        35366169203407072024988105544493365594092016393038958660463525874913389188686,
        1039524470230514584083648691307018066944426250754669746649659540327342486485
    )
    .unwrap_syscall()
    .unwrap();

    let r = 77890695546337321736251770367848525254749071568799296195058962812358136149818;
    let s = 106272600822509440344350312128826568110501012555371078859041307520727861121780;

    let msg_hash = 149135777980097582634002128993283245052269503470703527156581804847063441697;

    match verify_ecdsa(pub_key, msg_hash, r, s) {
        Result::Ok => (),
        Result::Err(m) => assert(false, m.into())
    }
}

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa_wrong_arguments() {
    let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
        35366169203407072024988105544493365594092016393038958660463525874913389188686,
        1039524470230514584083648691307018066944426250754669746649659540327342486485
    )
    .unwrap_syscall()
    .unwrap();

    // R and S outside of the domain
    let r = 0;
    let s = 0;

    let msg_hash = 149135777980097582634002128993283245052269503470703527156581804847063441697;

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
fn test_verify_ecdsa_invalid_signature() {
    let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
        35366169203407072024988105544493365594092016393038958660463525874913389188686,
        1039524470230514584083648691307018066944426250754669746649659540327342486485
    )
    .unwrap_syscall()
    .unwrap();

    let r = 77890695546337321736251770367848525254749071568799296195058962812358136149818;
    let s = 106272600822509440344350312128826568110501012555371078859041307520727861121780;

    //Wrong hash given the public key and (r, s)
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

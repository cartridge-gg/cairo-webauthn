use core::starknet::secp256_trait::Secp256PointTrait;
use starknet::secp256r1::Secp256r1Point;
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1PointImpl;
use option::OptionTrait;
use result::ResultTrait;
use alexandria_math::BitShift;
use alexandria_math::sha256::sha256;
use core::traits::Into;

use webauthn::mod_arithmetic::{mod_inv, mod_mul};

fn verify_ecdsa(
    public_key_pt: Secp256r1Point, msg: Array<u8>, r: u256, s: u256
) -> Result<(), VerifyEcdsaError> {
    let hash = sha256_u256(msg);
    verify_hashed_ecdsa(public_key_pt, hash, r, s)
}

// Verifies the signature of the hash given the other parameters (public key, r, s)
// Return value: 
// - Result::Ok if the signature is correct, 
// - Result::Err(VerifyEcdsaError) otherwise
//
// According to: https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm
fn verify_hashed_ecdsa(
    public_key_pt: Secp256r1Point, msg_hash: u256, r: u256, s: u256
) -> Result<(), VerifyEcdsaError> {
    if check_bounds(r, s) == false {
        return Result::Err(VerifyEcdsaError::WrongArgument);
    }

    let n = Secp256r1Impl::get_curve_size();
    let G = Secp256r1Impl::get_generator_point();

    let s_inv = match mod_inv(s, n) {
        Option::Some(inv) => inv,
        Option::None => {
            return Result::Err(VerifyEcdsaError::WrongArgument);
        }
    };

    //Possible optimisation: Shamir's trick can be used
    let u_1 = mod_mul((msg_hash, s_inv), n);
    let u_2 = mod_mul((r, s_inv), n);

    let G_times_u_1 = match G.mul(u_1) {
        Result::Ok(p) => p,
        Result::Err => {
            return Result::Err(VerifyEcdsaError::SyscallError);
        }
    };
    let Q_times_u_2 = match public_key_pt.mul(u_2) {
        Result::Ok(p) => p,
        Result::Err => {
            return Result::Err(VerifyEcdsaError::SyscallError);
        }
    };
    let P = match G_times_u_1.add(Q_times_u_2) {
        Result::Ok(p) => p,
        Result::Err => {
            return Result::Err(VerifyEcdsaError::SyscallError);
        }
    };
    let (P_x, _P_y) = match P.get_coordinates() {
        Result::Ok(cords) => cords,
        Result::Err => {
            return Result::Err(VerifyEcdsaError::SyscallError);
        }
    };

    if r == (P_x % n) {
        Result::Ok(())
    } else {
        Result::Err(VerifyEcdsaError::InvalidSignature)
    }
}

//Possible verify_ecdsa(...) errors
#[derive(Drop)]
enum VerifyEcdsaError {
    WrongArgument, // At least one argument is not correct (eg. outside of the domain)
    InvalidSignature, // The hash and other parameters don't match
    SyscallError, // There was an internal error during syscall invocation
}

impl ImplVerifyEcdsaErrorIntoFelt252 of Into<VerifyEcdsaError, felt252> {
    fn into(self: VerifyEcdsaError) -> felt252 {
        match self {
            VerifyEcdsaError::WrongArgument => 'Wrong Argument!',
            VerifyEcdsaError::InvalidSignature => 'Invalid Signature!',
            VerifyEcdsaError::SyscallError => 'Syscall Error!',
        }
    }
}

fn sha256_u256(mut data: Array<u8>) -> u256 {
    let mut msg_hash_u256 = 0_u256;
    let msg_hash = sha256(data);
    msg_hash_u256 = msg_hash_u256 | BitShift::shl((*msg_hash[0]).into(), 0 * 8);
    msg_hash_u256 = msg_hash_u256 | BitShift::shl((*msg_hash[1]).into(), 1 * 8);
    msg_hash_u256 = msg_hash_u256 | BitShift::shl((*msg_hash[2]).into(), 2 * 8);
    msg_hash_u256 = msg_hash_u256 | BitShift::shl((*msg_hash[3]).into(), 3 * 8);
    msg_hash_u256 = msg_hash_u256 | BitShift::shl((*msg_hash[4]).into(), 4 * 8);
    msg_hash_u256 = msg_hash_u256 | BitShift::shl((*msg_hash[5]).into(), 5 * 8);
    msg_hash_u256 = msg_hash_u256 | BitShift::shl((*msg_hash[6]).into(), 6 * 8);
    msg_hash_u256 = msg_hash_u256 | BitShift::shl((*msg_hash[7]).into(), 7 * 8);
    msg_hash_u256
}


#[derive(Drop)]
fn check_bounds(r: u256, s: u256) -> bool {
    let n = Secp256r1Impl::get_curve_size();
    if r > n {
        false
    } else if s > n {
        false
    } else if r < 1 {
        false
    } else if s < 1 {
        false
    } else {
        true
    }
}

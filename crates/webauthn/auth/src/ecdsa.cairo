use core::array::ArrayTrait;
use core::debug::PrintTrait;
use core::starknet::secp256_trait::{Secp256PointTrait, is_signature_entry_valid};
use starknet::secp256r1::Secp256r1Point;
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1PointImpl;
use core::option::OptionTrait;
use core::result::ResultTrait;
use alexandria_math::BitShift;
use alexandria_math::sha256::sha256;
use core::traits::Into;

use webauthn_auth::mod_arithmetic::{mod_inv, mod_mul};
use webauthn_auth::helpers::extract_u256_from_u8_array;


// Verifies the signature
// Return value: 
// - Result::Ok if the signature is correct, 
// - Result::Err(VerifyEcdsaError) otherwise
// See verified_hashed_ecdsa(...) for details
fn verify_ecdsa(
    public_key_pt: Secp256r1Point, msg: Array<u8>, r: u256, s: u256
) -> Result<(), VerifyEcdsaError> {
    let previous = core::testing::get_available_gas();
    let hash = sha256(msg);
    println!("Gas usage of the \"sha256\": {}\n", previous - core::testing::get_available_gas());

    let previous = core::testing::get_available_gas();
    let hash_u256 = match extract_u256_from_u8_array(@hash, 0) {
        Option::Some(h) => h,
        Option::None => { return Result::Err(VerifyEcdsaError::WrongArgument); }
    };
    println!("Gas usage of the \"extract_u256_from_u8_array\": {}\n", previous - core::testing::get_available_gas());
    
    let previous = core::testing::get_available_gas();
    let output = verify_hashed_ecdsa(public_key_pt, hash_u256, r, s);
    println!("Gas usage of the \"verify_hashed_ecdsa\": {}\n", previous - core::testing::get_available_gas());
    output
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
    if !is_signature_entry_valid::<Secp256r1Point>(r)
        || !is_signature_entry_valid::<Secp256r1Point>(s) {
        return Result::Err(VerifyEcdsaError::WrongArgument);
    }

    let n = Secp256r1Impl::get_curve_size();
    let G = Secp256r1Impl::get_generator_point();

    let s_inv = match mod_inv(s, n) {
        Option::Some(inv) => inv,
        Option::None => { return Result::Err(VerifyEcdsaError::WrongArgument); }
    };

    //Possible optimisation: Shamir's trick can be used
    let u_1 = mod_mul((msg_hash, s_inv), n);
    let u_2 = mod_mul((r, s_inv), n);

    let G_times_u_1 = match G.mul(u_1) {
        Result::Ok(p) => p,
        Result::Err => { return Result::Err(VerifyEcdsaError::SyscallError); }
    };
    let Q_times_u_2 = match public_key_pt.mul(u_2) {
        Result::Ok(p) => p,
        Result::Err => { return Result::Err(VerifyEcdsaError::SyscallError); }
    };
    let P = match G_times_u_1.add(Q_times_u_2) {
        Result::Ok(p) => p,
        Result::Err => { return Result::Err(VerifyEcdsaError::SyscallError); }
    };
    let (P_x, _P_y) = match P.get_coordinates() {
        Result::Ok(cords) => cords,
        Result::Err => { return Result::Err(VerifyEcdsaError::SyscallError); }
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

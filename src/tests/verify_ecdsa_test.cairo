use core::result::ResultTrait;
use core::option::OptionTrait;
use webauthn::verify::extended_gcd;
use webauthn::verify::find_mod_inv;
use webauthn::verify::verify_ecdsa;
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1Point;
use starknet::{
    EthAddress, secp256_trait::{Secp256Trait, Secp256PointTrait}, SyscallResult, SyscallResultTrait
};
use alexandria_math::sha256::sha256;
use array::ArrayTrait;
use webauthn::webauthn::sha256_u256;

#[test]
#[available_gas(200000000000)]
fn test_verify_ecdsa() {
    let pub_key = Secp256r1Impl::secp256_ec_new_syscall(
        87219695023686739746094515658084989152920619753382836749359549415870157275357, 
        10178486840038205405550216497339138582694795346561871690814580180758681032990
    ).unwrap_syscall().unwrap();

    let mut msg: Array<u8> = ArrayTrait::new();
    msg.append(84); // b'T'
    let r = 31242720761732233828893259662340581656350080308705252579869746448807626086349_u256;
    let s = 19736370785599894853478220872636946533247277793949041026178837471671431190475_u256;
    
    let msg_hash = sha256_u256(msg);
    
    match verify_ecdsa(pub_key, msg_hash, r, s) {
        Result::Ok => (),
        Result::Err(m) => assert(false, m)
    }
}

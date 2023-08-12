use core::debug::PrintTrait;
use core::starknet::secp256_trait::Secp256PointTrait;
use core::traits::TryInto;
use core::traits::Into;
use starknet::secp256r1::Secp256r1Point;
use starknet::secp256r1::Secp256r1Impl;
use starknet::secp256r1::Secp256r1PointImpl;
use option::OptionTrait;
use result::ResultTrait;
use integer::u32_wrapping_add;
use integer::u256_wide_mul;
use integer::u512_safe_div_rem_by_u256;
use integer::U256TryIntoNonZero;
use core::zeroable;

#[derive(Drop)]

fn check_bounds(r: u256, s: u256) -> bool {
    if r > Secp256r1Impl::get_curve_size() {
        false
    } else if s > Secp256r1Impl::get_curve_size() {
        false
    } else if r < 1 {
        false
    } else if s < 1 {
        false
    } else {
        true
    }
    
}

// According to: https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm
fn verify_ecdsa(public_key_pt : Secp256r1Point, msg_hash : u256, r : u256, s : u256) -> Result<(), felt252> {
    if check_bounds(r, s) == false {
        return Result::Err('r or s outside of bounds');
    }

    let n = Secp256r1Impl::get_curve_size();
    let n_no_zero: NonZero<u256> = n.try_into().unwrap();
    let L_n = 256;
    let z = msg_hash;
    let G = Secp256r1Impl::get_generator_point();

    let s_inv = match find_mod_inv(s, n) {
        Option::Some(inv) => inv,
        Option::None => {
            return Result::Err('No inverse found for s!');
        }
    };

    //Possible improvement: Shamir's trick can be used
    let (_, u_1) = u512_safe_div_rem_by_u256(u256_wide_mul(z, s_inv), n_no_zero);
    let (_, u_2) = u512_safe_div_rem_by_u256(u256_wide_mul(r, s_inv), n_no_zero);

    let G_times_u_1 = match G.mul(u_1) {
        Result::Ok(p) => p,
        Result::Err => {
            return Result::Err('Unable to multiply by a scalar!');
        }
    };
    let Q_times_u_2 = match public_key_pt.mul(u_2) {
        Result::Ok(p) => p,
        Result::Err => {
            return Result::Err('Unable to multiply by a scalar!');
        }
    };
    let result_pt = match G_times_u_1.add(Q_times_u_2){
        Result::Ok(p) => p,
        Result::Err => {
            return Result::Err('Unable to add points together!');
        }
    };
    let (x_1, y_1) = match result_pt.get_coordinates(){
        Result::Ok(cords) => cords,
        Result::Err => {
            return Result::Err('Unable to get coordinates!');
        }
    };

    if (r % n) == (x_1 % n) {
        Result::Ok(())
    } else {
        Result::Err('r not congruent to x_1')
    }    
}

fn find_mod_inv(a: u256, n: u256) -> Option<u256> {
    let (gcd, x, _) = extended_gcd(a, n);
    if gcd == 1 {
        Option::Some(x % n)
    } else {
        Option::None(())
    }
}

//Unconventional implementation due to u256 constraint of size and unsignedness
fn extended_gcd(a: u256, b: u256) -> (u256, u256, u256) {
    let (mut r0, mut r1) = (a, b);
    let (mut s0, mut s1) = (1, 0);
    let (mut t0, mut t1) = (0, 1);
    let mut counter = 0_u256;
    loop {
        if r1 == 0 {
            break;
        };

        let q = r0 / r1;

        r0 = if r0 > q * r1 {
            r0 - q * r1
        } else {
            q * r1 - r0
        };
        let temp = r0; r0 = r1; r1 = temp; //swap(r0, s1)

        s0 = s0 + q * s1;
        let temp = s0; s0 = s1; s1 = temp; //swap(s0, s1)

        t0 = t0 + q * t1;
        let temp = t0; t0 = t1; t1 = temp; //swap(t0, t1)

        counter += 1;
    };
    if (counter % 2) == 1 {
        s0 = b - s0;
    } else {
        t0 = a - t0;
    }
    (r0, s0, t0)
}

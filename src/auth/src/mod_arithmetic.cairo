use integer::u512_safe_div_rem_by_u256;
use integer::U256TryIntoNonZero;
use core::traits::TryInto;
use option::OptionTrait;
use integer::u256_wide_mul;

fn mod_inv(a: u256, n: u256) -> Option<u256> {
    let (gcd, x, _) = extended_gcd(a, n);
    if gcd == 1 {
        Option::Some(x % n)
    } else {
        Option::None(())
    }
}

fn mod_mul(factors: (u256, u256), modulo: u256) -> u256 {
    let (a, b) = factors;
    match U256TryIntoNonZero::try_into(modulo) {
        Option::Some(modulo) => {
            let (_, reminder) = u512_safe_div_rem_by_u256(u256_wide_mul(a, b), modulo);
            reminder
        },
        Option::None => 0,
    }
}

//Unconventional implementation due to u256 constraint of size and unsignedness
fn extended_gcd(a: u256, b: u256) -> (u256, u256, u256) {
    let (mut r0, mut r1) = (a, b);
    let (mut s0, mut s1) = (1, 0);
    let (mut t0, mut t1) = (0, 1);
    let mut parity = false;
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
        let temp = r0;
        r0 = r1;
        r1 = temp; //swap(r0, s1)

        s0 = s0 + q * s1;
        let temp = s0;
        s0 = s1;
        s1 = temp; //swap(s0, s1)

        t0 = t0 + q * t1;
        let temp = t0;
        t0 = t1;
        t1 = temp; //swap(t0, t1)

        parity = !parity;
    };
    if parity {
        s0 = b - s0;
    } else {
        t0 = a - t0;
    }
    (r0, s0, t0)
}

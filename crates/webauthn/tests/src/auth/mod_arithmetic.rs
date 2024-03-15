use cairo_args_runner::{Arg, Felt252};

use crate::prelude::*;

/// ```extended_gcd(u256, u256) -> (u256, u256, u256)```
const EXTENDED_GCD: Function<GCDParser, ConstLenExtractor<6>> =
    Function::new_webauthn("extended_gcd", GCDParser, ConstLenExtractor::new());

struct GCDParser;
impl ArgumentParser for GCDParser {
    type Args = Vec<u128>;
    fn parse(&self, args: Self::Args) -> Vec<Arg> {
        args.into_iter()
            .map(|arg| Arg::Value(Felt252::from(arg)))
            .collect()
    }
}

#[test]
fn test_gcd_basic_1() {
    let [gcd, ..]: [Felt252; 6] = EXTENDED_GCD.run(vec![2, 0, 2, 0]);
    assert_eq!(gcd, 2.into());
}

#[test]
fn test_gcd_basic_2() {
    let [gcd, ..]: [Felt252; 6] = EXTENDED_GCD.run(vec![100, 0, 200, 0]);
    assert_eq!(gcd, 100.into());
}

#[test]
fn test_gcd_basic_3() {
    let [gcd, ..]: [Felt252; 6] = EXTENDED_GCD.run(vec![1234, 0, 5678, 0]);
    assert_eq!(gcd, 2.into());
}

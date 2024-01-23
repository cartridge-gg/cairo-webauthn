use cairo_args_runner::felt_vec;

use crate::{Function, FunctionReturnLength, FunctionTrait};

/// ```extended_gcd(u256, u256) -> (u256, u256, u256)```
const EXTENDED_GCD: FunctionReturnLength<6> = Function::new("extended_gcd");

#[test]
fn test_gcd_basic_1() {
    let [gcd, ..] = EXTENDED_GCD.run(felt_vec!(2, 0, 2, 0));
    assert_eq!(gcd, 2.into());
}

#[test]
fn test_gcd_basic_2() {
    let [gcd, ..] = EXTENDED_GCD.run(felt_vec!(100, 0, 200, 0));
    assert_eq!(gcd, 100.into());
}

#[test]
fn test_gcd_basic_3() {
    let [gcd, ..] = EXTENDED_GCD.run(felt_vec!(1234, 0, 5678, 0));
    assert_eq!(gcd, 2.into());
}

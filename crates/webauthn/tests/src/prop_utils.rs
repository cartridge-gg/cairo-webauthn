use cairo_args_runner::Felt252;
use proptest::prelude::*;
use proptest::strategy::Strategy;

#[derive(Debug, Clone, Copy)]
pub struct Felt252Strategy;

impl Felt252Strategy {
    pub fn new() -> impl Strategy<Value = Felt252> {
        prop::collection::vec(any::<u8>(), 32..=32).prop_map(|b| Felt252::from_bytes_be(&b))
    }
}

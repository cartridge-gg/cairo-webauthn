use cairo_args_runner::Felt252;
use proptest::prelude::*;
use proptest::strategy::Strategy;

use crate::session::signature_proofs::SIGNATURE_PROOFS;
use crate::utils::FunctionTrait;

fn felt252_strategy() -> impl Strategy<Value = Felt252> {
    prop::collection::vec(any::<u8>(), 32..=32).prop_map(|b| Felt252::from_bytes_be(&b))
}

fn vec_vec_felt252_strategy(
    outer_len: usize,
    inner_len: usize,
) -> impl Strategy<Value = (Vec<Vec<Felt252>>, usize)> {
    (
        prop::collection::vec(
            prop::collection::vec(felt252_strategy(), inner_len..=inner_len),
            outer_len..=outer_len,
        ),
        Just(inner_len),
    )
}

proptest! {
    #[test]
    fn test_signature_proofs_proptest(
        (proofs, len) in (1_usize..=100, 1_usize..=20)
            .prop_flat_map(|(a, b)| vec_vec_felt252_strategy(a, b))
    ) {
        let result = SIGNATURE_PROOFS.run((proofs.clone(), len));
        assert_eq!(result, proofs);
    }
}

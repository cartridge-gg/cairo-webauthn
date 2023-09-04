use core::pedersen::pedersen;
use core::traits::PartialOrd;
use core::bool;
use result::ResultTrait;

fn merkle_verify(
    leaf: felt252, root: felt252, proof_len: usize, proofs: Span<felt252>
) -> Result<(), ()> {
    if root == calc_merkle_root(leaf, proof_len, proofs) {
        Result::Ok(())
    } else {
        Result::Err(())
    }
}

fn calc_merkle_root(curr: felt252, proof_len: usize, proofs: Span<felt252>) -> felt252 {
    if proof_len == 0 {
        return curr;
    }
    let proof_elem = *proofs.at(0);

    let node = match is_le_felt(curr, proof_elem) {
        bool::False => pedersen(proof_elem, curr),
        bool::True => pedersen(curr, proof_elem)
    };
    calc_merkle_root(node, proof_len - 1, proofs.slice(1, proofs.len()))
}

fn is_le_felt(a: felt252, b: felt252) -> bool {
    let a_u256: u256 = a.into();
    let b_u256: u256 = b.into();
    a_u256 <= b_u256
}

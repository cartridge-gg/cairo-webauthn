use starknet::{core::types::FieldElement, macros::felt};
use starknet_crypto::{poseidon_hash, PoseidonHasher};

use crate::abigen::account::{Call, SessionSignature};

// needs to behave anologously to https://github.com/keep-starknet-strange/alexandria,
// which uses starknets hash, reimplemented here https://github.com/starkware-libs/cairo-lang/blob/12ca9e91bbdc8a423c63280949c7e34382792067/src/starkware/cairo/common/poseidon_hash.py#L46

// H('StarkNetDomain(chainId:felt)')
const STARKNET_DOMAIN_TYPE_HASH: FieldElement =
    felt!("0x13cda234a04d66db62c06b8e3ad5f91bd0c67286c2c7519a826cf49da6ba478");
// H('Session(key:felt,expires:felt,root:merkletree)')
const SESSION_TYPE_HASH: FieldElement =
    felt!("0x1aa0e1c56b45cf06a54534fa1707c54e520b842feb21d03b7deddb6f1e340c");
// H(Policy(contractAddress:felt,selector:selector))
const POLICY_TYPE_HASH: FieldElement =
    felt!("0x2f0026e78543f036f33e26a8f5891b88c58dc1e20cbbfaf0bb53274da6fa568");

const STARKNET_MESSAGE_FELT: FieldElement = felt!("0x537461726b4e6574204d657373616765");

fn hash_two_elements(a: FieldElement, b: FieldElement) -> FieldElement {
    let mut hasher = PoseidonHasher::new();
    hasher.update(a);
    hasher.update(b);
    hasher.finalize()
}

pub fn compute_session_hash(
    signature: SessionSignature,
    chain_id: FieldElement,
    account: FieldElement,
) -> FieldElement {
    let domain_hash = hash_domain(chain_id);
    let message_hash = hash_message(
        signature.session_key,
        signature.session_expires.into(),
        signature.root,
    );
    let mut hasher = PoseidonHasher::new();
    hasher.update(STARKNET_MESSAGE_FELT);
    hasher.update(domain_hash);
    hasher.update(account.into());
    hasher.update(message_hash);
    hasher.finalize()
}

pub fn compute_call_hash(call: &Call) -> FieldElement {
    let mut hasher = PoseidonHasher::new();
    hasher.update(POLICY_TYPE_HASH);
    hasher.update((call.to).into());
    hasher.update(call.selector);
    hasher.finalize()
}

pub fn hash_domain(chain_id: FieldElement) -> FieldElement {
    let mut hasher = PoseidonHasher::new();
    hasher.update(STARKNET_DOMAIN_TYPE_HASH);
    hasher.update(chain_id);
    hasher.finalize()
}

pub fn hash_message(
    session_key: FieldElement,
    session_expires: FieldElement,
    root: FieldElement,
) -> FieldElement {
    let mut hasher = PoseidonHasher::new();
    hasher.update(SESSION_TYPE_HASH);
    hasher.update(session_key);
    hasher.update(session_expires);
    hasher.update(root);
    hasher.finalize()
}

// based on: https://github.com/keep-starknet-strange/alexandria/blob/ecc881e2aee668332441bdfa32336e3404cf8eb1/src/merkle_tree/src/merkle_tree.cairo#L182C4-L215
pub fn compute_proof(mut nodes: Vec<FieldElement>, index: usize, proof: &mut Vec<FieldElement>) {
    // Break if we have reached the top of the tree
    if nodes.len() == 1 {
        return;
    }

    // If odd number of nodes, add a null virtual leaf
    if nodes.len() % 2 != 0 {
        nodes.push(FieldElement::ZERO);
    }

    // Compute next level
    let next_level = get_next_level(nodes.clone());

    // Find neighbor node
    let index_parent;
    let mut i = 0usize;
    loop {
        if i == index {
            index_parent = i / 2;
            if i % 2 == 0 {
                proof.push(nodes[i + 1]);
            } else {
                proof.push(nodes[i - 1]);
            }
            break;
        }
        i += 1;
    }

    compute_proof(next_level, index_parent, proof)
}

fn get_next_level(mut nodes: Vec<FieldElement>) -> Vec<FieldElement> {
    let mut next_level: Vec<FieldElement> = Vec::with_capacity(nodes.len() / 2);
    while !nodes.is_empty() {
        let left = nodes.remove(0);
        let right = nodes.remove(0);

        let node = if left < right {
            hash_two_elements(left, right)
        } else {
            hash_two_elements(right, left)
        };
        next_level.push(node);
    }
    next_level
}

// Example from https://github.com/keep-starknet-strange/alexandria/blob/ecc881e2aee668332441bdfa32336e3404cf8eb1/src/merkle_tree/src/tests/merkle_tree_test.cairo#L104-L151
#[test]
fn merkle_tree_poseidon_test() {
    // [Setup] Merkle tree.
    let root = felt!("0x7abc09d19c8a03abd4333a23f7823975c7bdd325170f0d32612b8baa1457d47");
    let leaf = 0x1;
    let valid_proof = vec![
        felt!("0x2"),
        felt!("0x47ef3ad11ad3f8fc055281f1721acd537563ec134036bc4bd4de2af151f0832"),
    ];
    let leaves = vec![felt!("0x1"), felt!("0x2"), felt!("0x3")];

    // // [Assert] Compute merkle root.
    // let computed_root = compute_root(leaf, valid_proof);
    // assert(computed_root == root, 'compute valid root failed');

    // [Assert] Compute merkle proof.
    let mut input_leaves = leaves;
    let index = 0;
    let mut computed_proof = vec![];
    compute_proof(input_leaves, index, &mut computed_proof);
    assert_eq!(computed_proof, valid_proof, "compute valid proof failed");

    // // [Assert] Verify a valid proof.
    // let result = MerkleTreeImpl::<
    //     _, PoseidonHasherImpl
    // >::verify(ref merkle_tree, root, leaf, valid_proof);
    // assert(result, 'verify valid proof failed');

    // // [Assert] Verify an invalid proof.
    // let invalid_proof = array![
    //     0x2 + 1, 0x68ba2a188dd231112c1cb5aaa5d18be6d84f6c8683e5c3a6638dee83e727acc
    // ]
    //     .span();
    // let result = MerkleTreeImpl::<
    //     _, PoseidonHasherImpl
    // >::verify(ref merkle_tree, root, leaf, invalid_proof);
    // assert(!result, 'verify invalid proof failed');

    // // [Assert] Verify a valid proof with an invalid leaf.
    // let invalid_leaf = 0x1 + 1;
    // let result = MerkleTreeImpl::<
    //     _, PoseidonHasherImpl
    // >::verify(ref merkle_tree, root, invalid_leaf, valid_proof);
    // assert(!result, 'wrong result');
}

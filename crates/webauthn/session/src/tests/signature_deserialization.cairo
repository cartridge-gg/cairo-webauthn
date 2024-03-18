use webauthn_session::signature::SignatureProofsTrait;
use alexandria_data_structures::array_ext::ArrayTraitExt;
use core::box::BoxTrait;
use core::array::SpanTrait;
use starknet::info::{TxInfo, get_tx_info, get_block_timestamp};
use core::{TryInto, Into};
use starknet::{contract_address::ContractAddress};
use webauthn_session::signature::{SessionSignature, SignatureProofs};
use webauthn_session::hash::{compute_session_hash, compute_call_hash};
use alexandria_merkle_tree::merkle_tree::{
    Hasher, MerkleTree, pedersen::PedersenHasherImpl, MerkleTreeTrait
};


use core::ecdsa::check_ecdsa_signature;


#[test]
#[available_gas(200000000000)]
fn test_session() {
    let mut sig = array![0x42, 0x43, 0x69, 18446744073709551615, 0x0, 0x1, 0x1, 0x44, 0x1, 0x2137,]
        .span();

    let deser: SessionSignature = Serde::<SessionSignature>::deserialize(ref sig).unwrap();
    assert(deser.r == 0x42, 'invalid r');
    assert(deser.proofs.len() == 1, 'invalid proofs len');
}

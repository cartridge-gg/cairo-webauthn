use core::integer::U32Div;
use core::Into;

// The layout of the span should look like:
// [r, s, session_key, session_expires, root, proof_len, proofs_len, { proofs ... } , session_token_len, { session_token ... }]

#[derive(Copy, Drop, Serde)]
struct SessionSignature {
    signature_type: felt252,
    r: felt252,
    s: felt252,
    session_key: felt252,
    session_expires: u64,
    root: felt252,
    proofs: SignatureProofs,
    session_token: Span<felt252>
}

#[derive(Copy, Drop, Serde)]
struct SignatureProofs {
    single_proof_len: usize,
    proofs_flat: Span<felt252>,
}

#[generate_trait]
impl ImplSignatureProofs of SignatureProofsTrait {
    fn try_new(proofs_flat: Span<felt252>, single_proof_len: usize) -> Option<SignatureProofs> {
        if proofs_flat.len() % single_proof_len != 0 {
            return Option::None(());
        }
        Option::Some(SignatureProofs { proofs_flat, single_proof_len })
    }

    fn len(self: SignatureProofs) -> usize {
        if self.single_proof_len == 0 {
            return 1; // When there is only one leaf, it is equal to the root, so the only proof is empty
        }
        U32Div::div(self.proofs_flat.len(), self.single_proof_len)
    }

    fn at(self: SignatureProofs, index: usize) -> Span<felt252> {
        self.proofs_flat.slice(index * self.single_proof_len, self.single_proof_len)
    }
}

#[cfg(test)]
mod tests {
    use alexandria_data_structures::array_ext::ArrayTraitExt;
    use alexandria_merkle_tree::merkle_tree::{
        Hasher, MerkleTree, pedersen::PedersenHasherImpl, MerkleTreeTrait
    };
    use core::box::BoxTrait;
    use core::array::SpanTrait;
    use core::{TryInto, Into};
    use core::ecdsa::check_ecdsa_signature;
    use starknet::info::{TxInfo, get_tx_info, get_block_timestamp};
    use starknet::{contract_address::ContractAddress};
    use webauthn_session::hash::{compute_session_hash, compute_call_hash};

    use super::{SessionSignature, SignatureProofs, SignatureProofsTrait};

    #[test]
    #[available_gas(200000000000)]
    fn test_session_deserialize() {
        let mut sig = array![
            0x1, 0x42, 0x43, 0x69, 18446744073709551615, 0x0, 0x1, 0x1, 0x44, 0x1, 0x2137,
        ]
            .span();

        let deser: SessionSignature = Serde::<SessionSignature>::deserialize(ref sig).unwrap();
        assert(deser.r == 0x42, 'invalid r');
        assert(deser.proofs.len() == 1, 'invalid proofs len');
    }
}

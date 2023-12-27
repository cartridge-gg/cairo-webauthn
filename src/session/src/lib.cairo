use alexandria_data_structures::array_ext::ArrayTraitExt;
use core::box::BoxTrait;
use core::array::SpanTrait;
use starknet::info::{TxInfo, get_tx_info, get_block_timestamp};
use starknet::account::Call;
use result::ResultTrait;
use option::OptionTrait;
use array::ArrayTrait;
use core::{TryInto, Into};
use starknet::contract_address::ContractAddress;
use alexandria_merkle_tree::merkle_tree::{Hasher, MerkleTree, poseidon::PoseidonHasherImpl, MerkleTreeTrait};

use core::ecdsa::check_ecdsa_signature;

use webauthn_session::signature::{SessionSignature, FeltSpanTryIntoSignature, SignatureProofs, SignatureProofsTrait};
use webauthn_session::hash::{compute_session_hash, compute_call_hash};


mod hash;
mod signature;

#[cfg(test)]
mod tests;

#[starknet::interface]
trait ISession<TContractState> {
    fn validate_session_abi(self: @TContractState, signature: SessionSignature, calls: Span<Call>);
    fn validate_session(self: @TContractState, public_key: felt252, signature: Span<felt252>, calls: Span<Call>) -> felt252;
    fn revoke_session(ref self: TContractState, token: felt252);

    fn compute_proof(self: @TContractState, calls: Array<Call>, position: u64) -> Span<felt252>;
    fn compute_root(self: @TContractState, call: Call, proof: Span<felt252>) -> felt252;
    fn compute_session_hash(self: @TContractState, unsigned_signature: SessionSignature) -> felt252;
}

// Based on https://github.com/argentlabs/starknet-plugin-account/blob/3c14770c3f7734ef208536d91bbd76af56dc2043/contracts/plugins/SessionKey.cairo
#[starknet::component]
mod session_component {
    use core::result::ResultTrait;
    use super::check_policy;
    use starknet::info::{TxInfo, get_tx_info, get_block_timestamp};
    use starknet::account::Call;
    use webauthn_session::signature::{SessionSignature, FeltSpanTryIntoSignature, SignatureProofs, SignatureProofsTrait};
    use webauthn_session::hash::{compute_session_hash, compute_call_hash};
    use ecdsa::check_ecdsa_signature;
    use alexandria_merkle_tree::merkle_tree::{Hasher, MerkleTree, poseidon::PoseidonHasherImpl, MerkleTreeTrait};
    use starknet::contract_address::ContractAddress;
    use starknet::get_contract_address;

    #[storage]
    struct Storage {
        revoked: LegacyMap::<felt252, u64>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        TokenRevoked: TokenRevoked,
    }

    #[derive(Drop, starknet::Event)]
    struct TokenRevoked {
        token: felt252,
    }

    mod Errors {
        const LENGHT_MISMATCH: felt252 = 'Length of proofs mismatched';
        const SESSION_EXPIRED: felt252 = 'Session expired';
        const SESSION_REVOKED: felt252 = 'Session has been revoked';
        const SESSION_SIGNATURE_INVALID: felt252 = 'Session signature is invalid';
        const SESSION_TOKEN_INVALID: felt252 = 'Session token not a valid sig';
        const POLICY_CHECK_FAILED: felt252 = 'Policy invalid for given calls';
    }

    #[embeddable_as(Session)]
    impl SessionImpl<
        TContractState, +HasComponent<TContractState>
    > of super::ISession<ComponentState<TContractState>> {
        fn validate_session_abi(self: @ComponentState<TContractState>, signature: SessionSignature, calls: Span<Call>) {
        }

        fn validate_session(self: @ComponentState<TContractState>, public_key: felt252, mut signature: Span<felt252>, calls: Span<Call>) -> felt252 {
            let sig: SessionSignature = Serde::<SessionSignature>::deserialize(ref signature).unwrap();

            match self.validate_signature(public_key, sig, calls) {
                Result::Ok(_) => {
                    starknet::VALIDATED
                },
                Result::Err(e) => {
                    e
                }
            }
        }

        fn revoke_session(
            ref self: ComponentState<TContractState>, token: felt252,
        ) {
            self.revoked.write(token, 1);
            self.emit(TokenRevoked { token: token });
        }

        fn compute_proof(self: @ComponentState<TContractState>, mut calls: Array<Call>, position: u64) -> Span<felt252> {
            assert(calls.len() > 0, 'No calls provided');
            let mut merkle: MerkleTree<Hasher> = MerkleTreeTrait::new();

            let mut leaves = array![];

            // Hashing all the calls
            loop {
                let pub_key = match calls.pop_front() {
                    Option::Some(single) => {
                        leaves.append(compute_call_hash(@single));
                    },
                    Option::None(_) => { break; },
                };
            };

            merkle.compute_proof(leaves.clone(), 0) 
        }

        fn compute_root(self: @ComponentState<TContractState>, call: Call, proof: Span<felt252>) -> felt252 {
            let mut merkle: MerkleTree<Hasher> = MerkleTreeTrait::new();
            let leaf = compute_call_hash(@call);

            merkle.compute_root(leaf, proof)
        }

        fn compute_session_hash(self: @ComponentState<TContractState>, unsigned_signature: SessionSignature) -> felt252 {
            let tx_info = get_tx_info().unbox();
            let session_hash: felt252 = compute_session_hash(
                unsigned_signature, tx_info.chain_id, get_contract_address()
            );
            session_hash
        }
    }

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        fn validate_signature(self: @ComponentState<TContractState>, public_key: felt252, signature: SessionSignature, calls: Span<Call>) -> Result<(), felt252> {
            if signature.proofs.len() != calls.len() {
                return Result::Err(Errors::LENGHT_MISMATCH);
            };

            let now = get_block_timestamp();
            if signature.session_expires <= now {
                return Result::Err(Errors::SESSION_EXPIRED);
            }

            // check if in the revoked list
            let session_token = *signature.session_token.at(0);
            if self.revoked.read(session_token) != 0 {
                return Result::Err(Errors::SESSION_REVOKED);
            }

            // check validity of token
            let tx_info = get_tx_info().unbox();
            let session_hash = compute_session_hash(
                signature, tx_info.chain_id, tx_info.account_contract_address
            );
            let token_r = *signature.session_token.at(0);
            let token_s = *signature.session_token.at(1);

            let valid_token = check_ecdsa_signature(
                session_hash, public_key, token_r, token_s
            );
            if !valid_token {
                return Result::Err(Errors::SESSION_TOKEN_INVALID);
            }
    
            // check signature
            let valid_signature = check_ecdsa_signature(
                tx_info.transaction_hash, signature.session_key, signature.r, signature.s
            );
            if !valid_signature {
                return Result::Err(Errors::SESSION_SIGNATURE_INVALID);
            }

            if check_policy(calls, signature.root, signature.proofs).is_err() {
                return Result::Err(Errors::POLICY_CHECK_FAILED);
            }

            Result::Ok(())
        }
    }
}

fn check_policy(
    call_array: Span<Call>, root: felt252, proofs: SignatureProofs,
) -> Result<(), ()> {
    let mut i = 0_usize;
    loop {
        if i >= call_array.len() {
            break Result::Ok(());
        }
        let leaf = compute_call_hash(call_array.at(i));
        let mut merkle: MerkleTree<Hasher> = MerkleTreeTrait::new();

        if merkle.verify(root, leaf, proofs.at(i)) == false {
            break Result::Err(());
        };
        i += 1;
    }
}

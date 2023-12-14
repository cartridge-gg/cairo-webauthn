use webauthn_session::signature::SignatureProofsTrait;
use alexandria_data_structures::array_ext::ArrayTraitExt;
use core::box::BoxTrait;
use core::array::SpanTrait;
use starknet::info::{TxInfo, get_tx_info, get_block_timestamp};
use starknet::account::Call;
use result::ResultTrait;
use option::OptionTrait;
use array::ArrayTrait;
use core::{TryInto, Into};
use starknet::{contract_address::ContractAddress};

use webauthn_session::signature::{TxInfoSignature, FeltSpanTryIntoSignature, SignatureProofs};
use webauthn_session::hash::{compute_session_hash, compute_call_hash};
use alexandria_merkle_tree::merkle_tree::{Hasher, MerkleTree, pedersen::PedersenHasherImpl, MerkleTreeTrait};


use core::ecdsa::check_ecdsa_signature;

mod hash;
mod signature;

#[cfg(test)]
mod tests;

#[starknet::interface]
trait ISession<TContractState> {
    fn validate_session(self: @TContractState, signature: Span<felt252>, calls: Array<CustomCall>);
    fn revoke_session(ref self: TContractState, token: felt252, expires: u64);
}

// Based on https://github.com/argentlabs/starknet-plugin-account/blob/3c14770c3f7734ef208536d91bbd76af56dc2043/contracts/plugins/SessionKey.cairo
#[starknet::component]
mod session_component {
    use core::result::ResultTrait;
    use super::CustomCall;
    use super::check_policy;
    use starknet::info::{TxInfo, get_tx_info, get_block_timestamp};
    use starknet::account::Call;
    use webauthn_session::signature::{TxInfoSignature, FeltSpanTryIntoSignature, SignatureProofs, SignatureProofsTrait};
    use webauthn_session::hash::{compute_session_hash, compute_call_hash};
    use ecdsa::check_ecdsa_signature;

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
        const POLICY_CHECK_FAILED: felt252 = 'Policy invalid for given calls';
    }

    #[embeddable_as(Session)]
    impl SessionImpl<
        TContractState, +HasComponent<TContractState>
    > of super::ISession<ComponentState<TContractState>> {
        fn validate_session(self: @ComponentState<TContractState>, mut signature: Span<felt252>, calls: Span<Call>) {
            let sig: TxInfoSignature = Serde::<TxInfoSignature>::deserialize(ref signature).unwrap();

            self.validate_signature(sig, calls).unwrap();
        }

        fn revoke_session(
            ref self: ComponentState<TContractState>, token: felt252,
        ) {
            self.revoked.write(token, 1);
            self.emit(TokenRevoked { token: token });
        }
    }

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        fn validate_signature(ref self: ComponentState<TContractState>, signature: TxInfoSignature, calls: Array<CustomCall>) -> Result<(), felt252> {
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

            // check signature
            let tx_info = get_tx_info().unbox();
            let session_hash: felt252 = compute_session_hash(
                signature, tx_info.chain_id, tx_info.account_contract_address
            );

            let session_hash = 2137;

            let valid_signature = check_ecdsa_signature(
                tx_info.transaction_hash, signature.session_key, signature.r, signature.s
            );
            if !valid_signature {
                return Result::Err(Errors::SESSION_SIGNATURE_INVALID);
            }

            // if check_policy(calls, signature.root, signature.proofs).is_err() {
            //     return Result::Err(Errors::POLICY_CHECK_FAILED);
            // }

            Result::Ok(())
        }
    }
}


#[derive(Drop, Copy, Serde)]
struct CustomCall {
    to: felt252,
    selector: felt252,
    data_offset: felt252,
    data_len: felt252,
}


fn check_policy(
    call_array: Array<Call>, root: felt252, proofs: SignatureProofs,
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

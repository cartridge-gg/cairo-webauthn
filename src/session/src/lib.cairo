use webauthn_session::signature::SignatureProofsTrait;
use alexandria_data_structures::array_ext::ArrayTraitExt;
use core::box::BoxTrait;
use core::array::SpanTrait;
use starknet::info::{TxInfo, get_tx_info, get_block_timestamp};
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

type ValidationResult = Result<(), ()>;


trait RevokedSessionKeyStorageTrait<T> {
    fn contains_revoked_key(self: @T, key: felt252) -> bool;
}

// This trait makes the validation more generic and provides easier testing.
trait TxInfoProviderTrait<T> {
    fn get_tx_info(self: @T) -> TxInfo;
}


#[derive(Drop)]
struct SessionValidator<
    S, impl StoreImpl: RevokedSessionKeyStorageTrait<S>, T, impl TxInfoImpl: TxInfoProviderTrait<T>,
> {
    storage: S,
    tx_info_provider: T
}

impl StImpl of RevokedSessionKeyStorageTrait<Array<felt252>> {
    fn contains_revoked_key(self: @Array<felt252>, key: felt252) -> bool {
        self.contains(key)
    }
}

impl TxInfoImpl of TxInfoProviderTrait<()> {
    fn get_tx_info(self: @()) -> TxInfo {
        get_tx_info().unbox()
    }
}

fn void() {
    let a: SessionValidator<Array<felt252>, StImpl, (), TxInfoImpl> = SessionValidator {
        storage: ArrayTrait::new(), tx_info_provider: ()
    };
    a.validate_session(ArrayTrait::new());
}

#[derive(Drop, Copy)]
struct Call {
    to: felt252,
    selector: felt252,
    data_offset: felt252,
    data_len: felt252,
}

#[generate_trait]
impl SessionValidatorImpl<
    S, impl StoreImpl: RevokedSessionKeyStorageTrait<S>, T, impl TxInfoImpl: TxInfoProviderTrait<T>,
> of SessionValidatorTrait<S, StoreImpl, T, TxInfoImpl> {
    fn validate_session(
        self: @SessionValidator<S, StoreImpl, T, TxInfoImpl>, call_array: Array<Call>,
    ) -> ValidationResult {
        let tx_info = self.tx_info_provider.get_tx_info();
        let sig: TxInfoSignature = match tx_info.signature.try_into() {
            Option::Some(s) => s,
            Option::None => {
                return Result::Err(());
            }
        };

        if sig.proofs.len() != call_array.len() {
            return Result::Err(());
        };

        let now = get_block_timestamp();
        if sig.session_expires <= now {
            return Result::Err(());
        }

        let session_hash: felt252 = compute_session_hash(
            sig, tx_info.chain_id, tx_info.account_contract_address
        );

        if is_valid_signature(
            tx_info.account_contract_address, session_hash, sig.session_token
        ) == false {
            return Result::Err(());
        }

        if self.storage.contains_revoked_key(sig.session_key) {
            return Result::Err(());
        }

        if check_ecdsa_signature(tx_info.transaction_hash, sig.session_key, sig.r, sig.s) == false {
            return Result::Err(());
        }

        check_policy(call_array, sig.root, sig.proofs)?;

        Result::Ok(())
    }
}


fn check_policy(
    call_array: Array<Call>, root: felt252, proofs: SignatureProofs,
) -> Result<(), ()> {
    let mut i = 0_usize;
    loop {
        if i >= call_array.len() {
            break Result::Ok(());
        }
        let leaf = compute_call_hash(*call_array.at(i));
        let mut merkle: MerkleTree<Hasher> = MerkleTreeTrait::new();
        if merkle.verify(root, leaf, proofs.at(i)) == false {
            break Result::Err(());
        };
        i += 1;
    }
}

// https://github.com/argentlabs/starknet-plugin-account/blob/3c14770c3f7734ef208536d91bbd76af56dc2043/contracts/plugins/SessionKey.cairo#L118-L122
// https://github.com/argentlabs/starknet-plugin-account/blob/3c14770c3f7734ef208536d91bbd76af56dc2043/contracts/plugins/SessionKey.cairo#L36-L37
fn is_valid_signature(
    contract_address: ContractAddress, hash: felt252, session_token: Span<felt252>
) -> bool {
    //TODO: See what this method should do and if the implementation is required here or somewhere else
    true
}


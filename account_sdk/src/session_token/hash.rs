use starknet::{core::types::FieldElement, macros::felt};
use starknet_crypto::PoseidonHasher;

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

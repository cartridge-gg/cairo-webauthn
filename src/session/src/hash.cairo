use core::hash::HashStateTrait;
use core::poseidon::{PoseidonImpl, PoseidonTrait};

use starknet::{contract_address::ContractAddress};

use webauthn_session::signature::TxInfoSignature;
use webauthn_session::Call;

// H('StarkNetDomain(chainId:felt)')
const STARKNET_DOMAIN_TYPE_HASH: felt252 =
    0x13cda234a04d66db62c06b8e3ad5f91bd0c67286c2c7519a826cf49da6ba478;
// H('Session(key:felt,expires:felt,root:merkletree)')
const SESSION_TYPE_HASH: felt252 = 0x1aa0e1c56b45cf06a54534fa1707c54e520b842feb21d03b7deddb6f1e340c;
// H(Policy(contractAddress:felt,selector:selector))
const POLICY_TYPE_HASH: felt252 = 0x2f0026e78543f036f33e26a8f5891b88c58dc1e20cbbfaf0bb53274da6fa568;

// https://github.com/starkware-libs/cairo/blob/1cd1d242883787392f38f5a775ab045b5e2201f3/corelib/src/hash.cairo#L4
// https://github.com/starkware-libs/cairo/blob/1cd1d242883787392f38f5a775ab045b5e2201f3/examples/hash_chain.cairo#L4
fn compute_session_hash(
    signature: TxInfoSignature, chain_id: felt252, account: ContractAddress
) -> felt252 {
    let domain_hash = hash_domain(chain_id);
    let message_hash = hash_message(
        signature.session_key, signature.session_expires.into(), signature.root
    );
    PoseidonImpl::new()
        .update('StarkNet Message')
        .update(domain_hash)
        .update(account.into())
        .update(message_hash)
        .finalize()
}

fn compute_call_hash(call: Call) -> felt252 {
    PoseidonImpl::new().update(POLICY_TYPE_HASH).update(call.to).update(call.selector).finalize()
}

fn hash_domain(chain_id: felt252) -> felt252 {
    PoseidonImpl::new().update(STARKNET_DOMAIN_TYPE_HASH).update(chain_id).finalize()
}

fn hash_message(session_key: felt252, session_expires: felt252, root: felt252) -> felt252 {
    PoseidonImpl::new()
        .update(SESSION_TYPE_HASH)
        .update(session_key)
        .update(session_expires)
        .update(root)
        .finalize()
}

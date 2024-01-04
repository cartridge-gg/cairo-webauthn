use starknet::account::Call;

use webauthn_session::signature::{SessionSignature, SignatureProofs, SignatureProofsTrait};


#[starknet::interface]
trait ISession<TContractState> {
    fn validate_session(self: @TContractState, public_key: felt252, signature: SessionSignature, calls: Span<Call>) -> felt252;
    fn validate_session_serialized(self: @TContractState, public_key: felt252, signature: Span<felt252>, calls: Span<Call>) -> felt252;
    fn revoke_session(ref self: TContractState, token: Span<felt252>);

    fn compute_proof(self: @TContractState, calls: Array<Call>, position: u64) -> Span<felt252>;
    fn compute_root(self: @TContractState, call: Call, proof: Span<felt252>) -> felt252;
    fn compute_session_hash(self: @TContractState, unsigned_signature: SessionSignature) -> felt252;
}

#[starknet::interface]
trait ISessionCamel<TContractState> {
    fn validateSession(self: @TContractState, publicKey: felt252, signature: SessionSignature, calls: Span<Call>) -> felt252;
    fn validateSessionSerialized(self: @TContractState, publicKey: felt252, signature: Span<felt252>, calls: Span<Call>) -> felt252;
    fn revokeSession(ref self: TContractState, token: Span<felt252>);

    fn computeProof(self: @TContractState, calls: Array<Call>, position: u64) -> Span<felt252>;
    fn computeRoot(self: @TContractState, call: Call, proof: Span<felt252>) -> felt252;
    fn computeSessionHash(self: @TContractState, unsignedSignature: SessionSignature) -> felt252;
}


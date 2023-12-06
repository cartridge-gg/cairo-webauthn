// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts for Cairo v0.7.0 (account/interface.cairo)

use starknet::ContractAddress;
use starknet::account::Call;

const ISRC6_ID: felt252 = 0x2ceccef7f994940b3962a6c67e0ba4fcd37df7d131417c604f91e03caecc1cd;

#[starknet::interface]
trait ISRC6<TState> {
    fn __execute__(self: @TState, calls: Array<Call>) -> Array<Span<felt252>>;
    fn __validate__(self: @TState, calls: Array<Call>) -> felt252;
    fn is_valid_signature(self: @TState, hash: felt252, signature: Array<felt252>) -> felt252;
}

#[starknet::interface]
trait ISRC6CamelOnly<TState> {
    fn isValidSignature(self: @TState, hash: felt252, signature: Array<felt252>) -> felt252;
}

#[starknet::interface]
trait IDeclarer<TState> {
    fn __validate_declare__(self: @TState, class_hash: felt252) -> felt252;
}

#[starknet::interface]
trait AccountABI<TState> {
    fn __execute__(self: @TState, calls: Array<Call>) -> Array<Span<felt252>>;
    fn __validate__(self: @TState, calls: Array<Call>) -> felt252;
    fn __validate_declare__(self: @TState, class_hash: felt252) -> felt252;
    fn __validate_deploy__(
        self: @TState, class_hash: felt252, contract_address_salt: felt252, _public_key: felt252
    ) -> felt252;
    fn set_public_key(ref self: TState, new_public_key: felt252);
    fn get_public_key(self: @TState) -> felt252;
    fn is_valid_signature(self: @TState, hash: felt252, signature: Array<felt252>) -> felt252;
    fn supports_interface(self: @TState, interface_id: felt252) -> bool;
}

// Entry points case-convention is enforced by the protocol
#[starknet::interface]
trait AccountCamelABI<TState> {
    fn __execute__(self: @TState, calls: Array<Call>) -> Array<Span<felt252>>;
    fn __validate__(self: @TState, calls: Array<Call>) -> felt252;
    fn __validate_declare__(self: @TState, classHash: felt252) -> felt252;
    fn __validate_deploy__(
        self: @TState, classHash: felt252, contractAddressSalt: felt252, _publicKey: felt252
    ) -> felt252;
    fn setPublicKey(ref self: TState, newPublicKey: felt252);
    fn getPublicKey(self: @TState) -> felt252;
    fn isValidSignature(self: @TState, hash: felt252, signature: Array<felt252>) -> felt252;
    fn supportsInterface(self: @TState, interfaceId: felt252) -> bool;
    fn verifyWebauthnSigner(
        ref self: TState, 
        pub_x: u256,
        pub_y: u256, // public key as point on elliptic curve
        // r: u256, // 'r' part from ecdsa
        // s: u256, // 's' part from ecdsa
        // type_offset: usize, // offset to 'type' field in json
        // challenge_offset: usize, // offset to 'challenge' field in json
        // origin_offset: usize, // offset to 'origin' field in json
        // client_data_json: Array<u8>, // json with client_data as 1-byte array 
        // challenge: Array<u8>, // challenge as 1-byte array
        // origin: Array<u8>, //  array origin as 1-byte array
        // authenticator_data: Array<u8>
    ) -> Array<felt252>;
}

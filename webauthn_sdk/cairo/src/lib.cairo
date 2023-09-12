use core::option::OptionTrait;
use debug::PrintTrait;
use webauthn_session::is_valid_signature;
use starknet::Felt252TryIntoContractAddress;
use array::ArrayTrait;
fn main() -> bool {
    'Hello, World!'.print();
    is_valid_signature(Felt252TryIntoContractAddress::try_into(0_felt252).unwrap(), 0_felt252, ArrayTrait::new().span())
}
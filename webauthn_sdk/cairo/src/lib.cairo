use core::option::OptionTrait;
use debug::PrintTrait;
use webauthn_session::is_valid_signature;
use starknet::Felt252TryIntoContractAddress;
use array::ArrayTrait;

#[derive(Drop)]
struct MyStruct {
    size: u8,
    members: Array<felt252>,
}

fn testing(a: MyStruct, b: Array<felt252>) -> u256 {
    a.size.print();
    a.members.print();
    '---'.print();
    b.print();
    0_u256
}

fn main(number: felt252) {
    'Hello, World!'.print();
    number.print();
}

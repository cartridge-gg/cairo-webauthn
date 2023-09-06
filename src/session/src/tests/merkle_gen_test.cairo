// This file is script-generated.
// Don't modify it manually!
// See test_gen_scripts/session/merkle_test.py for details
use core::traits::Into;
use core::option::OptionTrait;
use array::ArrayTrait;
use core::pedersen::pedersen;

#[test]
#[available_gas(200000000000)]
fn test_merkle() {
	assert(pedersen(987, 456) == 1499725662987053184146006021639423595377136451331166909132435579998737194738, 'Expect equal');
	
}


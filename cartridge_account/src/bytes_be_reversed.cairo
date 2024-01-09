use core::traits::Into;
use core::traits::DivRem;
trait BytesBeReversed {
    fn bytes_be_reversed(self: felt252) -> Array<u8>;
}

impl BytesBeReversedImpl of BytesBeReversed {
    fn bytes_be_reversed(self: felt252) -> Array<u8> {
        let mut new_arr = array![];

        let mut num: u256 = self.into();
        loop {
            if num == 0 {
                break;
            }
            let (quotient, remainder) = DivRem::div_rem(
                num, 256_u256.try_into().expect('Division by 0')
            );
            new_arr.append(remainder.try_into().unwrap());
            num = quotient;
        };
        loop {
            if new_arr.len() >= 32 {
                break;
            }
            new_arr.append(0_u8);
        };
        new_arr
    }
}
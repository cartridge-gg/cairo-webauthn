use cairo_felt::Felt252;

pub fn decode_hex(str: &str) -> Option<Vec<u8>> {
    if str.len() % 2 == 1 {
        return None;
    }
    (0..str.len())
        .step_by(2)
        .map(|i| u8::from_str_radix(&str[i..i + 2], 16).ok())
        .collect()
}

pub fn extract_u128_pair(arr: [u8; 32]) -> (u128, u128) {
    (
        u128::from_be_bytes(arr[0..16].try_into().unwrap()),
        u128::from_be_bytes(arr[16..32].try_into().unwrap()),
    )
}

pub trait ToFelts {
    fn into_felts(&self) -> Vec<Felt252>;
}

impl<'a, T: 'a> ToFelts for Vec<T>
where
    Felt252: From<T>,
    T: Copy,
{
    fn into_felts(&self) -> Vec<Felt252> {
        self.into_iter().map(|i| Felt252::from(*i)).collect()
    }
}

use cairo_args_runner::{arg_array, arg_value, felt_vec, Arg, Felt252};

mod expand_auth_data;
mod mod_arithmetic;
mod verify_ecdsa;
mod verify_signature;

#[derive(Debug)]
pub struct ArgsBuilder {
    args: Vec<Arg>,
}

pub struct CairoU256 {
    low: Felt252,
    high: Felt252,
}

impl CairoU256 {
    pub fn new(low: Felt252, high: Felt252) -> Self {
        Self { low, high }
    }
    pub fn from_bytes_be(low: &[u8; 16], high: &[u8; 16]) -> Self {
        Self::new(Felt252::from_bytes_be(low), Felt252::from_bytes_be(high))
    }
    pub fn from_byte_slice_be(bytes: &[u8; 32]) -> Self {
        let (low, high): (&[u8; 16], &[u8; 16]) = (
            bytes[16..].try_into().unwrap(),
            bytes[..16].try_into().unwrap(),
        );
        Self::from_bytes_be(low, high)
    }
}

impl FeltSerialize for CairoU256 {
    fn to_felts(self) -> Vec<Felt252> {
        vec![self.low, self.high]
    }
}

struct P256r1PublicKey {
    x: CairoU256,
    y: CairoU256,
}

impl P256r1PublicKey {
    pub fn new(x: CairoU256, y: CairoU256) -> Self {
        Self { x, y }
    }
    pub fn from_bytes_be(x: &[u8; 32], y: &[u8; 32]) -> Self {
        Self::new(
            CairoU256::from_byte_slice_be(x),
            CairoU256::from_byte_slice_be(y),
        )
    }
}

impl FeltSerialize for P256r1PublicKey {
    fn to_felts(self) -> Vec<Felt252> {
        self.x
            .to_felts()
            .into_iter()
            .chain(self.y.to_felts())
            .collect()
    }
}

impl ArgsBuilder {
    pub fn new() -> Self {
        Self { args: Vec::new() }
    }
    #[allow(dead_code)]
    pub fn add_one(mut self, arg: impl Into<Felt252>) -> Self {
        self.args.push(Arg::Value(arg.into()));
        self
    }
    pub fn add_struct(mut self, args: impl IntoIterator<Item = impl Into<Felt252>>) -> Self {
        self.args
            .extend(args.into_iter().map(|arg| Arg::Value(arg.into())));
        self
    }
    pub fn add_array(mut self, args: impl IntoIterator<Item = impl Into<Felt252>>) -> Self {
        self.args
            .push(Arg::Array(args.into_iter().map(|arg| arg.into()).collect()));
        self
    }
    pub fn build(self) -> Vec<Arg> {
        self.args
    }
}

pub trait FeltSerialize {
    fn to_felts(self) -> Vec<Felt252>;
}

#[test]
fn test_contains_trait() {
    let target = "../../../target/dev/webauthn_auth.sierra.json";
    let function = "test_array_contains";
    let args = vec![
        arg_array![5, 1, 2, 4, 8, 16, 6, 1, 2, 3, 4, 5, 6],
        arg_value!(2),
    ];
    let result = cairo_args_runner::run(target, function, &args).unwrap();

    assert_eq!(result.len(), 1);
    assert_eq!(result[0], true.into());
}

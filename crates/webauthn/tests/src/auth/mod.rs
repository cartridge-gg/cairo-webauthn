use cairo_args_runner::{arg_array, arg_value, felt_vec, Arg, Felt252};

mod mod_arithmetic;
mod verify_signature;

pub struct ArgsBuilder {
    args: Vec<Arg>,
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

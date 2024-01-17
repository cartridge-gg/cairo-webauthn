use cairo_args_runner::{Arg, Felt252};

pub const SIERRA_TARGET: &'static str = "../../../target/dev/webauthn_auth.sierra.json";

#[derive(Debug, Clone, Copy)]
pub struct FunctionReturnLength<'a, const N: usize> {
    pub name: &'a str,
}

#[derive(Debug, Clone, Copy)]
pub struct FunctionUnspecified<'a> {
    pub name: &'a str,
}

pub enum Function {}

impl Function {
    pub const fn new<'a, const N: usize>(name: &'a str) -> FunctionReturnLength<'a, N> {
        FunctionReturnLength { name }
    }
    pub const fn new_unspecified<'a>(name: &'a str) -> FunctionUnspecified<'a> {
        FunctionUnspecified { name }
    }
}

pub trait FunctionTrait<T, P>
where
    T: Into<Vec<Felt252>>,
{
    fn run(&self, args: Vec<P>) -> T;
}

impl<'a, const N: usize, P> FunctionTrait<[Felt252; N], P> for FunctionReturnLength<'a, N>
where
    P: Into<Arg>,
{
    fn run(&self, args: Vec<P>) -> [Felt252; N] {
        cairo_args_runner::run(
            SIERRA_TARGET,
            &self.name,
            &args.into_iter().map(Into::into).collect::<Vec<_>>(),
        )
        .unwrap()
        .try_into()
        .unwrap()
    }
}

impl<'a, P> FunctionTrait<Vec<Felt252>, P> for FunctionUnspecified<'a>
where
    P: Into<Arg>,
{
    fn run(&self, args: Vec<P>) -> Vec<Felt252> {
        cairo_args_runner::run(
            SIERRA_TARGET,
            &self.name,
            &args.into_iter().map(Into::into).collect::<Vec<_>>(),
        )
        .unwrap()
    }
}

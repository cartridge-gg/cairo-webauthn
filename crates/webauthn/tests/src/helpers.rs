use cairo_args_runner::errors::SierraRunnerError;
use cairo_args_runner::SuccessfulRun;
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

pub trait FunctionTrait<T, P> {
    fn run(&self, args: P) -> T {
        self.transform_result(cairo_args_runner::run_capture_memory(
            SIERRA_TARGET,
            self.name(),
            &self.transform_arguments(args),
        ))
    }
    fn transform_arguments(&self, args: P) -> Vec<Arg>;
    fn transform_result(&self, result: Result<SuccessfulRun, SierraRunnerError>) -> T;
    fn name(&self) -> &str;
}

#[derive(Debug, PartialEq)]
pub struct SpecifiedResultMemory<T> {
    result: T,
    memory: Vec<Option<Felt252>>,
}

impl<'a, const N: usize, P> FunctionTrait<[Felt252; N], Vec<P>> for FunctionReturnLength<'a, N>
where
    P: Into<Arg>,
{
    fn transform_arguments(&self, args: Vec<P>) -> Vec<Arg> {
        args.into_iter().map(Into::into).collect()
    }

    fn transform_result(&self, result: Result<SuccessfulRun, SierraRunnerError>) -> [Felt252; N] {
        result.unwrap().value.try_into().unwrap()
    }

    fn name(&self) -> &str {
        self.name
    }
}

impl<'a, P> FunctionTrait<Vec<Felt252>, Vec<P>> for FunctionUnspecified<'a>
where
    P: Into<Arg>,
{
    fn transform_arguments(&self, args: Vec<P>) -> Vec<Arg> {
        args.into_iter().map(Into::into).collect()
    }

    fn transform_result(&self, result: Result<SuccessfulRun, SierraRunnerError>) -> Vec<Felt252> {
        result.unwrap().value
    }

    fn name(&self) -> &str {
        self.name
    }
}

use anyhow::Error;
use cairo_felt::Felt252;
use cairo_lang_runner::Arg;

mod utils;
pub mod verify_function;

pub trait IntoArguments {
    fn into_arguments(self) -> Vec<Arg>;
}

pub trait IntoFunctionExecution<Args: IntoArguments> {
    fn into_execution(self, args: Args) -> FunctionExecution<Args>;
}

pub struct FunctionExecution<Args: IntoArguments> {
    pub(crate) name: String,
    pub(crate) args: Args,
}

impl<Args: IntoArguments> FunctionExecution<Args> {
    pub fn new(name: impl Into<String>, args: Args) -> Self {
        FunctionExecution {
            name: name.into(),
            args,
        }
    }
}

#[derive(Debug)]
pub enum FunctionResult {
    Success,
    Failure,
}

impl TryFrom<Vec<Felt252>> for FunctionResult {
    type Error = Error;

    fn try_from(value: Vec<Felt252>) -> Result<Self, Self::Error> {
        if value.len() != 1 {
            Err(Error::msg(""))
        } else if value[0] == Felt252::from(0) {
            Ok(FunctionResult::Success)
        } else {
            Ok(FunctionResult::Failure)
        }
    }
}

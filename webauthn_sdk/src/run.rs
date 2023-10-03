use std::fmt;

use cairo_felt::Felt252;
use cairo_lang_runner::{Arg, SierraCasmRunner, StarknetState};
use cairo_lang_sierra::program::Program;
use cairo_lang_starknet::contract::ContractInfo;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;

pub enum DevRunnerError {
    FailedSettingUp(String),
    FailedFindingFunction,
    FailedRunning,
    Panicked(Vec<Felt252>),
}

impl fmt::Display for DevRunnerError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            DevRunnerError::FailedSettingUp(e) => write!(f, "Failed setting up: {}", e),
            DevRunnerError::FailedFindingFunction => write!(f, "Failed finding function"),
            DevRunnerError::FailedRunning => write!(f, "Failed running"),
            DevRunnerError::Panicked(_) => write!(f, "Panicked"),
        }
    }
}

impl fmt::Debug for DevRunnerError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        fmt::Display::fmt(&self, f)
    }
}

impl std::error::Error for DevRunnerError {}

pub trait DevRunner<T> {
    fn run_with_contracts_info(
        self,
        name: &str,
        arguments: &Vec<Arg>,
        contracts_info: OrderedHashMap<Felt252, ContractInfo>,
    ) -> Result<Vec<Felt252>, DevRunnerError>;
    fn run(self, name: &str, arguments: &Vec<Arg>) -> Result<Vec<Felt252>, DevRunnerError>;
}

pub struct SierraRunner {
    progarm: Program,
}

impl SierraRunner {
    pub fn new(progarm: Program) -> Self {
        SierraRunner { progarm }
    }
}

#[macro_export]
macro_rules! arg_vec {
    ($($a:expr),*) => {
        vec![$(Felt252::from($a)),*]
    };
}

#[macro_export]
macro_rules! arg_val {
    ($a:expr) => {
        Arg::Value(Felt252::from($a))
    };
}

pub use arg_val;

impl DevRunner<Vec<Felt252>> for SierraRunner {
    fn run_with_contracts_info(
        self,
        name: &str,
        arguments: &Vec<Arg>,
        contracts_info: OrderedHashMap<Felt252, ContractInfo>,
    ) -> Result<Vec<Felt252>, DevRunnerError> {
        let runner =
            match SierraCasmRunner::new(self.progarm, Some(Default::default()), contracts_info) {
                Ok(runner) => runner,
                Err(e) => {
                    return Err(DevRunnerError::FailedSettingUp(e.to_string()));
                }
            };
        let Ok(function) = runner.find_function(name) else {return Err(DevRunnerError::FailedFindingFunction)};
        let result = match runner.run_function_with_starknet_context(
            function,
            arguments,
            Some(usize::MAX),
            StarknetState::default(),
        ) {
            Ok(r) => r,
            Err(e) => {
                println!("{:?}", e);
                return Err(DevRunnerError::FailedRunning);
            }
        };
        match result.value {
            cairo_lang_runner::RunResultValue::Success(values) => Ok(values),
            cairo_lang_runner::RunResultValue::Panic(values) => {
                Err(DevRunnerError::Panicked(values))
            }
        }
    }
    fn run(self, name: &str, arguments: &Vec<Arg>) -> Result<Vec<Felt252>, DevRunnerError> {
        self.run_with_contracts_info(name, arguments, OrderedHashMap::default())
    }
}

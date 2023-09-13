use std::fmt;

use cairo_lang_runner::{SierraCasmRunner, StarknetState};
use cairo_lang_sierra::program::Program;
use cairo_lang_starknet::contract::ContractInfo;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use cairo_felt::Felt252;

pub enum RunnerError {
    FailedSettingUp,
    FailedFindingFunction,
    FailedRunning,
    Panicked(Vec<Felt252>)
}

impl fmt::Display for RunnerError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            RunnerError::FailedSettingUp => write!(f, "Failed setting up"),
            RunnerError::FailedRunning => write!(f, "Failed running"),
            RunnerError::Panicked(_) => write!(f, "Panicked"),
            RunnerError::FailedFindingFunction => write!(f, "Failed finding function"),
        }
    }
}

impl fmt::Debug for RunnerError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        fmt::Display::fmt(&self, f)
    }
}


impl std::error::Error for RunnerError {}


pub trait DevRunner {
    fn run(self: Box<Self>) -> Result<Vec<Felt252>, RunnerError>;
}



pub struct SingleFunctionRunner{
    progarm: Program,
    function: String,
    contracts_info: OrderedHashMap<Felt252, ContractInfo>
}

impl SingleFunctionRunner {
    pub fn new(progarm: Program, function: String) -> Box<Self> {
        Self::with_contracts_info(progarm, function, OrderedHashMap::default())
    }
    pub fn with_contracts_info(progarm: Program, function: String, contracts_info: OrderedHashMap<Felt252, ContractInfo>) -> Box<Self> {
        Box::new(SingleFunctionRunner { progarm, function, contracts_info })
    }
}



impl DevRunner for SingleFunctionRunner {
    fn run(self: Box<Self>) -> Result<Vec<Felt252>, RunnerError> {
        let Ok(runner) = SierraCasmRunner::new(
            self.progarm,
            None,
            self.contracts_info,
        ) else {return Err(RunnerError::FailedSettingUp)};
        let Ok(function) = runner.find_function(&self.function) else {return Err(RunnerError::FailedFindingFunction)};
        let Ok(result) = runner
            .run_function_with_starknet_context(
                function,
                &[],
                None,
                StarknetState::default(),
            ) else {return Err(RunnerError::FailedRunning)};
        match result.value {
            cairo_lang_runner::RunResultValue::Success(values) => Ok(values),
            cairo_lang_runner::RunResultValue::Panic(values) => Err(RunnerError::Panicked(values))
        }
    }
}
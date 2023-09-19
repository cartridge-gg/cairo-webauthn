use std::fmt;

use cairo_felt::Felt252;
use cairo_lang_runner::{Arg, SierraCasmRunner, StarknetState};
use cairo_lang_sierra::program::Program;
use cairo_lang_starknet::contract::ContractInfo;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;

use crate::function::DevFunction;

pub enum DevRunnerError {
    FailedSettingUp,
    FailedFindingFunction,
    FailedRunning,
    Panicked(Vec<Felt252>),
}

impl fmt::Display for DevRunnerError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            DevRunnerError::FailedSettingUp => write!(f, "Failed setting up"),
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
    fn run(self) -> Result<T, DevRunnerError>;
}

pub struct SingleFunctionRunner {
    progarm: Program,
    function: DevFunction,
    contracts_info: OrderedHashMap<Felt252, ContractInfo>,
}

impl SingleFunctionRunner {
    pub fn new(progarm: Program, function: DevFunction) -> Self {
        Self::with_contracts_info(progarm, function, OrderedHashMap::default())
    }
    pub fn with_contracts_info(
        progarm: Program,
        function: DevFunction,
        contracts_info: OrderedHashMap<Felt252, ContractInfo>,
    ) -> Self {
        SingleFunctionRunner {
            progarm,
            function,
            contracts_info,
        }
    }
}

impl DevRunner<Vec<Felt252>> for SingleFunctionRunner {
    fn run(self) -> Result<Vec<Felt252>, DevRunnerError> {
        let Ok(runner) = SierraCasmRunner::new(
            self.progarm,
            None,
            self.contracts_info,
        ) else {return Err(DevRunnerError::FailedSettingUp)};
        let Ok(function) = runner.find_function(&self.function.name) else {return Err(DevRunnerError::FailedFindingFunction)};
        let result = match runner
            .run_function_with_starknet_context(
                function,
                &self.function.arguments,
                None,
                StarknetState::default(),
            ) {
                Ok(r) => r,
                Err(e) => {
                    println!("{:?}", e);
                    return Err(DevRunnerError::FailedRunning);
                }
            } ;
        match result.value {
            cairo_lang_runner::RunResultValue::Success(values) => Ok(values),
            cairo_lang_runner::RunResultValue::Panic(values) => Err(DevRunnerError::Panicked(values)),
        }
    }
}

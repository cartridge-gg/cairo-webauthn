use anyhow::{Result, Context, Error};
use cairo_lang_runner::{SierraCasmRunner, StarknetState};
use cairo_lang_sierra::program::Program;
use cairo_lang_starknet::contract::ContractInfo;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use cairo_felt::Felt252;

pub trait DevRunner {
    fn run(self: Box<Self>) -> Result<()>;
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
    fn run(self: Box<Self>) -> Result<()> {
        let runner = SierraCasmRunner::new(
            self.progarm,
            None,
            self.contracts_info,
        )
        .with_context(|| "Failed setting up runner.")?;
        let result = runner
            .run_function_with_starknet_context(
                runner.find_function(&self.function)?,
                &[],
                None,
                StarknetState::default(),
            )
            .with_context(|| "Failed to run the function.")?;
        match result.value {
            cairo_lang_runner::RunResultValue::Success(_values) => Ok(()),
            cairo_lang_runner::RunResultValue::Panic(_) => Err(Error::msg("The progam has panicked!"))
        }
    }
}
use cairo_felt::Felt252;

use crate::prepare::run::{DevRunner, SierraRunner};

use anyhow::Result;

use self::functions::{FunctionExecution, IntoArguments};

pub mod functions;

pub struct FunctionRunner {
    sierra_runner: SierraRunner,
}

impl FunctionRunner {
    pub fn new(sierra_runner: SierraRunner) -> Self {
        FunctionRunner { sierra_runner }
    }

    pub fn run<Args, OutputT, TryFromErr>(self, fe: FunctionExecution<Args>) -> Result<OutputT>
    where
        Args: IntoArguments,
        OutputT: TryFrom<Vec<Felt252>, Error = TryFromErr>,
        anyhow::Error: From<TryFromErr>,
    {
        Ok(OutputT::try_from(
            self.sierra_runner
                .run(&fe.name, &fe.args.into_arguments())?,
        )?)
    }
}

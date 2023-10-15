use std::env;

use anyhow::{Ok, Result};
use webauthn_sdk::{
    prepare::Preper,
    run::{
        functions::{
            verify_function::{VerifyArguments, VerifyFunction},
            FunctionResult, IntoFunctionExecution,
        },
        FunctionRunner,
    },
};

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();

    let (origin, challenge) = match &args[..] {
        [_, o, c] => (o, c),
        _ => {
            return Result::Err(anyhow::Error::msg("Usage: cargo run [origin] [challenge]"));
        }
    };

    let runner = FunctionRunner::new(Preper::new("cairo", "dev_sdk").prepare()?);
    let function_execution = VerifyFunction.into_execution(VerifyArguments::new(origin, challenge));
    println!(
        "Result of the execution: {:?}",
        runner.run(function_execution)
    );

    Ok(())
}

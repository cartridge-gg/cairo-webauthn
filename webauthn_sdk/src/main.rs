use std::vec;

use anyhow::Result;


use compile::DevCompiler;
use function::DevFunction;
use generate::{DummyGenerator, DevGenerator};
use logger::{LoggerGenerator, LoggerCompiler, LoggerParser, LoggerRunner};
use parse::DevParser;
use run::DevRunner;

extern crate termcolor;

mod compile;
mod parse;
mod generate;
mod run;
mod logger;
mod function;

fn main() -> Result<()> {
    let generator = LoggerGenerator::new(DummyGenerator::new("cairo", "dev_sdk", vec![DevFunction::new("testing")]));
    let compiler = LoggerCompiler::new(generator.generate()?);
    let parser = LoggerParser::new(compiler.compile()?);
    let runners = LoggerRunner::new_vec(parser.parse()?);
    for runner in runners {
        runner.run()?;
    };
    Ok(())
}

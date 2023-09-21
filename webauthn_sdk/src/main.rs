use std::vec;

use anyhow::Result;


use cairo_felt::Felt252;
use cairo_lang_runner::Arg;
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
    let generator = LoggerGenerator::new(
        DummyGenerator::new("cairo", "dev_sdk", vec![
                DevFunction::with_arguments("testing", vec![
                        Arg::Value(Felt252::new(0xF1)),
                        Arg::Array(vec![0x11, 0x12, 0x13, 0x14].into_iter().map(Felt252::new).collect()),
                        Arg::Array(vec![0x21, 0x22, 0x23, 0x24].into_iter().map(Felt252::new).collect()),
                        Arg::Array(vec![0x31, 0x32, 0x33, 0x34].into_iter().map(Felt252::new).collect()),
                        Arg::Value(Felt252::new(0xF2))
                    ]
                ),
                DevFunction::new("verify_authentication_assertion_interface")
            ]
        )
    );
    let compiler = LoggerCompiler::new(generator.generate()?);
    let parser = LoggerParser::new(compiler.compile()?);
    let runners = LoggerRunner::new_vec(parser.parse()?);
    for runner in runners {
        let _ = runner.run();
    };
    Ok(())
}

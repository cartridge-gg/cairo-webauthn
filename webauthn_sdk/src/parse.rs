use std::fs;

use cairo_lang_sierra::ProgramParser;
use anyhow::{Result, Context};

use crate::{run::SingleFunctionRunner, function::DevFunction};


pub trait DevParser<T>{
    fn parse(self) -> Result<T>;
}

pub struct SingleFileParser{
    file_name: String,
    functions: Vec<DevFunction>
}

impl SingleFileParser {
    pub fn new(file_name: String, functions: Vec<DevFunction>) -> Self {
        SingleFileParser { file_name, functions }
    }
}

impl DevParser<Vec<SingleFunctionRunner>> for SingleFileParser {
    fn parse(self) -> Result<Vec<SingleFunctionRunner>> {
        let sierra_code = fs::read_to_string(self.file_name).with_context(|| "Could not read file!")?;
        let Ok(sierra_program) = ProgramParser::new().parse(&sierra_code) else {
            anyhow::bail!("Failed to parse sierra program.")
        };
        Ok(self.functions.into_iter().map(|f| SingleFunctionRunner::new(sierra_program.clone(), f)).collect())
    }
}

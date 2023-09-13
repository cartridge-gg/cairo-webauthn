use std::fs;

use cairo_lang_sierra::ProgramParser;
use anyhow::{Result, Context};

use crate::run::{DevRunner, SingleFunctionRunner};


pub trait DevParser{
    fn parse(self: Box<Self>) -> Result<Vec<Box<dyn DevRunner>>>;
}

pub struct SingleFileParser{
    file_name: String,
    functions: Vec<String>
}

impl SingleFileParser {
    pub fn new(file_name: String, functions: Vec<String>) -> Box<Self> {
        Box::new(SingleFileParser { file_name, functions })
    }
}

impl DevParser for SingleFileParser {
    fn parse(self: Box<Self>) -> Result<Vec<Box<dyn DevRunner>>> {
        let sierra_code = fs::read_to_string(self.file_name).with_context(|| "Could not read file!")?;
        let Ok(sierra_program) = ProgramParser::new().parse(&sierra_code) else {
            anyhow::bail!("Failed to parse sierra program.")
        };
        Ok(self.functions.into_iter().map(|f| SingleFunctionRunner::new(sierra_program.clone(), f) as _).collect())
    }
}

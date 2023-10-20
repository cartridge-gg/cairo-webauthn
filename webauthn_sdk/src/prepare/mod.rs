use self::{
    compile::DevCompiler,
    generate::{DevGenerator, DummyGenerator},
    logger::{LoggerCompiler, LoggerGenerator, LoggerParser},
    parse::DevParser,
    run::SierraRunner,
};

extern crate termcolor;

pub mod compile;
pub mod generate;
pub mod logger;
pub mod parse;
pub mod run;

use anyhow::Result;

pub struct Preper {
    folder: String,
    package: String,
}

impl Preper {
    pub fn new(folder: &str, package: &str) -> Self {
        Preper {
            folder: folder.into(),
            package: package.into(),
        }
    }
    pub fn prepare(&self) -> Result<SierraRunner> {
        let generator = LoggerGenerator::new(DummyGenerator::new(&self.folder, &self.package));
        let compiler = LoggerCompiler::new(generator.generate()?);
        let parser = LoggerParser::new(compiler.compile()?);
        parser.parse()
    }
}

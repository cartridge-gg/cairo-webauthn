use crate::{generate::DevGenerator, compile::DevCompiler, parse::DevParser, run::DevRunner};
use anyhow::Result;
use std::io::Write;
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};
use crate::run::RunnerError;
use cairo_felt::Felt252;

pub struct LoggerGenerator(pub Box<dyn DevGenerator>);
pub struct LoggerCompiler(pub Box<dyn DevCompiler>);
pub struct LoggerParser(pub Box<dyn DevParser>);
pub struct LoggerRunner(pub Box<dyn DevRunner>, String);

impl LoggerGenerator {
    pub fn new(generator: Box<dyn DevGenerator>) -> Box<Self> {
        Box::new(LoggerGenerator(generator))
    }
}

impl DevGenerator for LoggerGenerator {
    fn generate(self: Box<Self>) -> Result<Box<dyn DevCompiler>> {
        print_blue("Generating cairo code...\n");
        Ok(Box::new(LoggerCompiler(self.0.generate()?)))
    }
}

impl DevCompiler for LoggerCompiler {
    fn compile(self: Box<Self>) -> Result<Box<dyn DevParser>> {
        print_blue("Compiling cairo to sierra...\n");
        Ok(Box::new(LoggerParser(self.0.compile()?)))
    }
}

impl DevParser for LoggerParser {
    fn parse(self: Box<Self>) -> Result<Vec<Box<dyn DevRunner>>>  {
        print_blue("Parsing sierra code...\n");
        Ok(self.0.parse()?.into_iter().enumerate().map(|(i, r)| Box::new(LoggerRunner(r, format!("Runner {}", i + 1))) as _).collect())
    }
}

impl DevRunner for LoggerRunner {
    fn run(self: Box<Self>) -> Result<Vec<Felt252>, RunnerError> {
        print_blue(format!("[{}] Running...\n", self.1));
        let result = self.0.run();
        match &result {
            Ok(_) => print_color(format!("[{}] Run successful!\n", self.1), Color::Green),
            Err(_) => print_color(format!("[{}] Run failed!\n", self.1), Color::Red),
        }
        result
    }
}

fn print_blue(message: impl Into<String>) {
    print_color(message, Color::Blue)
}

fn print_color(message: impl Into<String>, color: Color) {
    let mut stdout = StandardStream::stdout(ColorChoice::Always);
    let mut binding = ColorSpec::new();
    binding.set_fg(Some(color)).set_bold(true);
    stdout.set_color(&binding).unwrap();
    write!(stdout, "{}", message.into()).unwrap();
    stdout.reset().unwrap();
}
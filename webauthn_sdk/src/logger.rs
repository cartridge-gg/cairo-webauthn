use crate::{compile::DevCompiler, generate::DevGenerator, parse::DevParser, run::DevRunner};
use anyhow::Result;
use std::{io::Write, marker::PhantomData};
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};

pub struct LoggerGenerator<T, U>(pub T, PhantomData<U>)
where
    T: DevGenerator<U>;
pub struct LoggerCompiler<T, U>(pub T, PhantomData<U>)
where
    T: DevCompiler<U>;
pub struct LoggerParser<T, U>(pub T, PhantomData<U>)
where
    T: DevParser<U>;
pub struct LoggerRunner<T, U>(pub T, String, PhantomData<U>)
where
    T: DevRunner<U>;

impl<T, U> LoggerGenerator<T, U>
where
    T: DevGenerator<U>,
{
    pub fn new(generator: T) -> Self {
        LoggerGenerator(generator, PhantomData)
    }
}

impl<T, U> LoggerCompiler<T, U>
where
    T: DevCompiler<U>,
{
    pub fn new(compiler: T) -> Self {
        LoggerCompiler(compiler, PhantomData)
    }
}

impl<T, U> LoggerParser<T, U>
where
    T: DevParser<U>,
{
    pub fn new(parser: T) -> Self {
        LoggerParser(parser, PhantomData)
    }
}

impl<T, U> LoggerRunner<T, U>
where
    T: DevRunner<U>,
{
    #[allow(dead_code)]
    pub fn new(runner: T) -> Self {
        LoggerRunner::with_name(runner, "")
    }

    pub fn with_name(runner: T, name: impl Into<String>) -> Self {
        LoggerRunner(runner, name.into(), PhantomData)
    }

    pub fn new_vec(runners: Vec<T>) -> Vec<Self> {
        runners
            .into_iter()
            .enumerate()
            .map(|(i, r)| LoggerRunner::with_name(r, format!("Runner {}", i + 1)))
            .collect()
    }
}

impl<T, U> DevGenerator<U> for LoggerGenerator<T, U>
where
    T: DevGenerator<U>,
{
    fn generate(self) -> Result<U> {
        print_blue("Generating cairo code...\n");
        self.0.generate()
    }
}

impl<T, U> DevCompiler<U> for LoggerCompiler<T, U>
where
    T: DevCompiler<U>,
{
    fn compile(self) -> Result<U> {
        print_blue("Compiling cairo to sierra...\n");
        self.0.compile()
    }
}

impl<T, U> DevParser<U> for LoggerParser<T, U>
where
    T: DevParser<U>,
{
    fn parse(self) -> Result<U> {
        print_blue("Parsing sierra code...\n");
        self.0.parse()
    }
}

// impl<T, U> DevRunner<U> for LoggerRunner<T, U>
// where
//     T: DevRunner<U>,
//     U: Debug,
// {
//     fn run(self) -> Result<U, DevRunnerError> {
//         print_blue(format!("[{}] Running...\n", self.1));
//         let result = self.0.run();
//         match &result {
//             Ok(v) => print_color(
//                 format!("[{}] Run successful!\nReturning:\n{:?}\n", self.1, v),
//                 Color::Green,
//             ),
//             Err(e) => print_color(
//                 format!("[{}] Run failed!\nReturning:\n{}\n", self.1, e),
//                 Color::Red,
//             ),
//         }
//         result
//     }
// }

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

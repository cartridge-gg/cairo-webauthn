use anyhow::Result;


use generate::{DummyGenerator, DevGenerator};

extern crate termcolor;

use std::io::Write;
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};


mod compile;
mod parse;
mod generate;
mod run;

fn main() -> Result<()> {
    print_blue("Compiling cairo to sierra:\n");
    let parser = DummyGenerator::new("cairo", "dev_sdk").generate()?.compile()?;
    print_blue("Parsing sierra:\n");
    let runner = parser.parse()?;
    print_blue("Running sierra program:\n");
    match runner.run() {
        Ok(values) => {
            print_blue("Run completed succesfully!\n");
            println!("Returning {values:?}")
        }
        Err(_) => {
            print_color("Run failed!\n", Color::Red);
        }
    }
    // print!("Full memory: [");
    // for cell in &result.memory {
    //     match cell {
    //         None => print!("_, "),
    //         Some(value) => print!("{value}, "),
    //     }
    // }
    // println!("]");
    Ok(())
}

fn print_blue(message: &str) {
    print_color(message, Color::Blue)
}

fn print_color(message: &str, color: Color) {
    let mut stdout = StandardStream::stdout(ColorChoice::Always);
    let mut binding = ColorSpec::new();
    binding.set_fg(Some(color)).set_bold(true);
    stdout.set_color(&binding).unwrap();
    write!(stdout, "{}", message).unwrap();
    stdout.reset().unwrap();
}
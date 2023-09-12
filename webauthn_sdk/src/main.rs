use anyhow::{Result, Context};
use cairo_lang_runner::{SierraCasmRunner, StarknetState, short_string::as_cairo_short_string};
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use scarb::core::Config;
use scarb::ops;

extern crate termcolor;

use std::{io::Write, fs};
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};
use cairo_lang_sierra::ProgramParser;

const CAIRO_TOMBL: &str = "cairo/Scarb.toml";
const SIERRA_TARGET: &str = "cairo/target/dev/dev_sdk.sierra";

fn main() -> Result<()> {
    print_blue("Compiling cairo to sierra:\n");
    let manifest_path = ops::find_manifest_path(Some(CAIRO_TOMBL.into()))?;
    let config = Config::builder(manifest_path).build()?;
    let ws = ops::read_workspace(config.manifest_path(), &config)?;
    let packages = ws.members().map(|m| m.id).collect();
    ops::compile(packages, &ws)?;
    print_blue("Compiling cairo to sierra:\n");
    let sierra_code = fs::read_to_string(SIERRA_TARGET).with_context(|| "Could not read file!")?;
    let Ok(sierra_program) = ProgramParser::new().parse(&sierra_code) else {
        anyhow::bail!("Failed to parse sierra program.")
    };
    print_blue("Running sierra program:\n");
    let contracts_info = OrderedHashMap::default();

    let runner = SierraCasmRunner::new(
        sierra_program,
        None,
        contracts_info,
    )
    .with_context(|| "Failed setting up runner.")?;
    let result = runner
        .run_function_with_starknet_context(
            runner.find_function("::main")?,
            &[],
            None,
            StarknetState::default(),
        )
        .with_context(|| "Failed to run the function.")?;
    match result.value {
        cairo_lang_runner::RunResultValue::Success(values) => {
            print_blue("Run completed succesfully!\n");
            println!("Returning {values:?}")
        }
        cairo_lang_runner::RunResultValue::Panic(values) => {
            print!("Run panicked with [");
            for value in &values {
                match as_cairo_short_string(value) {
                    Some(as_string) => print!("{value} ('{as_string}'), "),
                    None => print!("{value}, "),
                }
            }
            println!("].")
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
    let mut stdout = StandardStream::stdout(ColorChoice::Always);
    let mut binding = ColorSpec::new();
    binding.set_fg(Some(Color::Blue)).set_bold(true);
    stdout.set_color(&binding).unwrap();
    write!(stdout, "{}", message).unwrap();
    stdout.reset().unwrap();
}
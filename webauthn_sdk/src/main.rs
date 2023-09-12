use anyhow::Result;
use scarb::core::Config;
use scarb::ops;

extern crate termcolor;

use std::io::Write;
use termcolor::{Color, ColorChoice, ColorSpec, StandardStream, WriteColor};

fn main() -> Result<()> {
    print_blue("Compiling cairo to sierra:\n");
    let manifest_path = ops::find_manifest_path(Some("cairo/Scarb.toml".into()))?;
    let config = Config::builder(manifest_path).build()?;
    let ws = ops::read_workspace(config.manifest_path(), &config)?;
    let packages = ws.members().map(|m| m.id).collect();
    ops::compile(packages, &ws)
}

fn print_blue(message: &str) {
    let mut stdout = StandardStream::stdout(ColorChoice::Always);
    let mut binding = ColorSpec::new();
    binding.set_fg(Some(Color::Blue)).set_bold(true);
    stdout.set_color(&binding).unwrap();
    write!(stdout, "{}", message).unwrap();
    stdout.reset().unwrap();
}
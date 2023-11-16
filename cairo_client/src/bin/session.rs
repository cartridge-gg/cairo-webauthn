use anyhow::Result;

use cairo_client::compile::DevCompiler;
use cairo_client::generate::{DevGenerator, DummyGenerator};
use cairo_client::logger::{LoggerCompiler, LoggerGenerator, LoggerParser};
use cairo_client::parse::DevParser;
fn main() -> Result<()> {
    let generator = LoggerGenerator::new(DummyGenerator::new("../src/session", "webauthn_session"));
    let compiler = LoggerCompiler::new(generator.generate()?);
    let parser = LoggerParser::new(compiler.compile()?);
    let runner = parser.parse()?;
    Ok(())
}

use scarb::ops;
use scarb::core::Config;
use anyhow::Result;

use crate::parse::{DevParser, SingleFileParser};

pub trait DevCompiler where{
    fn compile(self: Box<Self>) -> Result<Box<dyn DevParser>>;
}

pub struct ProjectCompiler {
    folder: String,
    package: String,
    functions: Vec<String>
}

impl ProjectCompiler {
    pub fn new(folder: String, package: String, functions: Vec<String>) -> Box<Self> {
        Box::new(ProjectCompiler { folder, package, functions })
    }
}

impl DevCompiler for ProjectCompiler {
    fn compile(self: Box<Self>) -> Result<Box<dyn DevParser>> {
        let manifest_path = ops::find_manifest_path(Some((self.folder.clone() + "/Scarb.toml").as_str().into()))?;
        let config = Config::builder(manifest_path).build()?;
        let ws = ops::read_workspace(config.manifest_path(), &config)?;
        let packages = ws.members().map(|m| m.id).collect();
        ops::compile(packages, &ws)?;
        Ok(SingleFileParser::new(self.folder + "/target/dev/" + &self.package + ".sierra", self.functions))
    }
}

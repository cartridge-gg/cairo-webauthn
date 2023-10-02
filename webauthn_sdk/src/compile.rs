use anyhow::Result;
use scarb::core::Config;
use scarb::ops;

use crate::function::DevFunction;
use crate::parse::SingleFileParser;

pub trait DevCompiler<T> {
    fn compile(self) -> Result<T>;
}

pub struct ProjectCompiler {
    folder: String,
    package: String,
    functions: Vec<DevFunction>,
}

impl ProjectCompiler {
    pub fn new(folder: String, package: String, functions: Vec<DevFunction>) -> Self {
        ProjectCompiler {
            folder,
            package,
            functions,
        }
    }
}

impl DevCompiler<SingleFileParser> for ProjectCompiler {
    fn compile(self) -> Result<SingleFileParser> {
        let manifest_path =
            ops::find_manifest_path(Some((self.folder.clone() + "/Scarb.toml").as_str().into()))?;
        let config = Config::builder(manifest_path).build()?;
        let ws = ops::read_workspace(config.manifest_path(), &config)?;
        let packages = ws.members().map(|m| m.id).collect();
        ops::compile(packages, &ws)?;
        Ok(SingleFileParser::new(
            self.folder + "/target/dev/" + &self.package + ".sierra",
            self.functions,
        ))
    }
}

use crate::compile::{DevCompiler, ProjectCompiler};
use anyhow::Result;

pub trait DevGenerator {
    fn generate(self: Box<Self>) -> Result<Box<dyn DevCompiler>>;
}

pub struct DummyGenerator {
    folder: String,
    package: String,
}

impl DummyGenerator {
    pub fn new(folder: impl Into<String>, package: impl Into<String>) -> Box<Self> {
        Box::new(DummyGenerator { folder: folder.into(), package: package.into() })
    }
}

impl DevGenerator for DummyGenerator {
    fn generate(self: Box<Self>) -> Result<Box<dyn DevCompiler>> {
        Ok(ProjectCompiler::new(self.folder, self.package, vec!["main".to_string(), "main2".to_string()]))
    }
}
use crate::{compile::ProjectCompiler, function::DevFunction};
use anyhow::Result;

pub trait DevGenerator<T> {
    fn generate(self) -> Result<T>;
}

pub struct DummyGenerator {
    folder: String,
    package: String,
    functions: Vec<DevFunction>,
}

impl DummyGenerator {
    pub fn new(
        folder: impl Into<String>,
        package: impl Into<String>,
        functions: Vec<DevFunction>,
    ) -> Self {
        DummyGenerator {
            folder: folder.into(),
            package: package.into(),
            functions,
        }
    }
}

impl DevGenerator<ProjectCompiler> for DummyGenerator {
    fn generate(self) -> Result<ProjectCompiler> {
        Ok(ProjectCompiler::new(
            self.folder,
            self.package,
            self.functions,
        ))
    }
}

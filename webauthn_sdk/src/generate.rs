use crate::compile::ProjectCompiler;
use anyhow::Result;

pub trait DevGenerator<T> {
    fn generate(self) -> Result<T>;
}

pub struct DummyGenerator {
    folder: String,
    package: String,
}

impl DummyGenerator {
    pub fn new(folder: impl Into<String>, package: impl Into<String>) -> Self {
        DummyGenerator {
            folder: folder.into(),
            package: package.into(),
        }
    }
}

impl DevGenerator<ProjectCompiler> for DummyGenerator {
    fn generate(self) -> Result<ProjectCompiler> {
        Ok(ProjectCompiler::new(self.folder, self.package))
    }
}

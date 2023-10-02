use cairo_lang_runner::Arg;

pub struct DevFunction {
    pub name: String,
    pub arguments: Vec<Arg>,
}

impl DevFunction {
    #[allow(dead_code)]
    pub fn new(name: impl Into<String>) -> Self {
        DevFunction::with_arguments(name, vec![])
    }

    pub fn with_arguments(name: impl Into<String>, arguments: Vec<Arg>) -> Self {
        DevFunction {
            name: name.into(),
            arguments,
        }
    }
}

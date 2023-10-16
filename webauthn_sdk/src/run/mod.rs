use std::marker::PhantomData;

use cairo_lang_runner::Arg;

pub trait IntoArguments {
    fn into_arguments(self) -> Vec<Arg>;
}

pub struct Function<Args: IntoArguments> {
    name: String,
    arg_phantom: PhantomData<Args>,
}
impl<Args: IntoArguments> Function<Args> {
    pub fn new(name: &str) -> Self {
        Function {
            name: name.into(),
            arg_phantom: PhantomData,
        }
    }

    pub fn to_execution(&self, args: Args) -> FunctionExecution<Args> {
        FunctionExecution {
            name: self.name.clone(),
            args,
        }
    }
}

pub struct FunctionExecution<Args: IntoArguments> {
    name: String,
    args: Args,
}

use std::error::Error;
use crate::interface::compiler_options::CompilerOptions;
use crate::ir::expr::{Expr, LValue};

pub struct Compiler
{

}

impl Compiler {
    pub fn new() -> Compiler {
        Compiler{ }
    }

    pub fn compile(&self, options: &CompilerOptions) -> Result<(), Box<dyn Error>> {
        Expr::Value(LValue::Int(5));
        println!("compile successful");
        Ok(())
    }
}
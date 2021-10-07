mod interface;
mod ir;
mod symbol_table;

use std::{env, process};
use crate::interface::compiler_options::CompilerOptions;
use crate::interface::compiler::Compiler;
use crate::interface::interpreter::Interpreter;

fn main() {
    // let args: Vec<String> = env::args().collect();
    // let options = CompilerOptions::new(&args).unwrap_or_else(|err| {
    //     println!("{}", err);
    //     process::exit(-1);
    // });
    //
    // let compiler = Compiler::new();
    // if let Err(err) = compiler.compile(&options) {
    //     println!("{}", err);
    //     process::exit(-1);
    // }
    Interpreter::new().run();
}

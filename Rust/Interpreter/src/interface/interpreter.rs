use crate::ir::expr::{LValue, Expr, LParameter, LFunction, LArgs, LSymbol};
use crate::symbol_table::SymbolTable;
use std::fmt;
use crate::ir::expr::LValue::Nil;
use std::collections::HashMap;
use std::rc::Rc;

pub struct Interpreter {
    evaluator: Evaluator,
}

impl Interpreter {
    pub fn new() -> Self {
        Interpreter { evaluator: Evaluator::new() }
    }

    pub fn run(&mut self) -> &Self {
        self.evaluator.eval(&Expr::Value(LValue::Nil));
        self
    }
}

type EvalEnv = SymbolTable<Rc<LValue>>;

pub struct Evaluator {
    env: EvalEnv,
}

impl Evaluator {
    pub fn new() -> Self {
        Evaluator { env: SymbolTable::new() }
    }

    pub fn eval(&mut self, expr: &Expr) -> Result<Rc<LValue>, String> {
        match expr {
            Expr::Define(symbol, value) => {
                if let Some(_) = self.env.insert(symbol.clone(), Rc::from(value.clone())) {
                    match self.env.look_up(&symbol) {
                        Some(v) => {
                            Ok((*v).clone())
                        }
                        None => {
                            Err(format!("symbol:{} already defined", symbol))
                        }
                    }
                }
                else {
                    Err("err".to_string())
                }
            }
            Expr::If(cond, if_expr, else_expr) => {
                match **cond {
                    Expr::Value(LValue::Bool(b)) => {
                        if b {
                            self.eval(if_expr)
                        } else {
                            self.eval(else_expr)
                        }
                    }
                    _ => {
                        Err("if condition is not a valid boolean".to_string())
                    }
                }
            }
            Expr::Call(symbol, args) => {
                self.eval_fun(&symbol, &args)
            }
            Expr::Value(v) => {
                println!("{:?}", v);
                Ok(Rc::from(v.clone()))
            }
        }
    }

    fn eval_fun(&mut self, symbol: &LSymbol, args: &LArgs) -> Result<Rc<LValue>, String> {
        if let Some(fun) = self.env.look_up(symbol) {
            match &**fun {
                LValue::Fun(LFunction { name, param, body }) => {
                    // param value -> env[args]
                    let args_value = param.into_iter().map(|name|{
                        self.env.look_up(&name)
                    });
                    self.env.enter_function(HashMap::default());
                    let ret = self.eval(&*body);
                    self.env.exit_function();
                    ret
                }
                _ => {
                    Err("invalid function".to_string())
                }
            }
        }
        else {
            Err("symbol not found".to_string())
        }
    }
}

#[cfg(test)]
mod tests {}
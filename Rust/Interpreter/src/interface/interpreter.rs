use crate::ir::expr::{LValue, Expr, LParameter, LFunction, LArgs};
use crate::symbol_table::SymbolTable;
use std::fmt;
use crate::ir::expr::LValue::Nil;

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

type EvalEnv = SymbolTable<LValue>;

pub struct Evaluator {
    env: EvalEnv,
}

impl Evaluator {
    pub fn new() -> Self {
        Evaluator { env: SymbolTable::new() }
    }

    pub fn eval(&mut self, expr: &Expr) -> Result<LValue, String> {
        match expr {
            Expr::Define(symbol, value) => {
                if let _ = self.env.look_up(symbol) {
                    Err(format!("symbol:{} already defined", symbol))
                } else {
                    Ok(self.env.insert(symbol.clone(), value.clone()).unwrap())
                }
            }
            Expr::If(cond, if_expr, else_expr) => {
                if let _ = self.eval_condition(cond) {
                    self.eval(if_expr)
                } else {
                    self.eval(else_expr)
                }
            }
            Expr::Call(symbol, param) => {
                if let Some(callable) = self.env.look_up(symbol) {
                    self.eval_fun(callable, param)
                } else {
                    return Err(format!("Symbol{:?} Not Found", symbol));
                }
            }
            Expr::Value(v) => {
                println!("{:?}", v);
                Ok(v.clone())
            }
        }
    }

    fn eval_fun(&mut self, fun: &LValue, param: &LArgs) -> Result<LValue, String> {
        match fun {
            LValue::Fun(LFunction { name, param, body }) => {
                self.env.new_env_run(|| {
                    self.eval(body)
                })
            }
            _ => {
                Err("invalid function".to_string())
            }
        }
    }

    // todo:limit LValue is Bool
    fn eval_condition(&self, expr: &Expr) -> Result<bool, String> {
        match expr {
            Expr::Value(LValue::Bool(b)) => {
                Ok(b.clone())
            }
            _ => {
                Err("if condition is not a valid boolean".to_string())
            }
        }
    }
}

#[cfg(test)]
mod tests {
    
}
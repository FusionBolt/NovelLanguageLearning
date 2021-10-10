use std::collections::HashMap;

pub type LSymbol = String;

pub type LParameter = Vec<String>;
pub type LArgs = Vec<String>;

#[derive(Clone, Debug)]
pub struct LFunction {
    pub name: LSymbol,
    pub param: LParameter,
    pub body: Box<Expr>
}

#[derive(Clone, Debug)]
pub enum LValue {
    Fun(LFunction),
    Int(i64),
    Float(f64),
    Str(String),
    Bool(bool),
    Nil
}

#[derive(Clone, Debug)]
pub enum Expr {
    Define(LSymbol, LValue),
    If(Box<Expr>, Box<Expr>, Box<Expr>),
    Call(LSymbol, LArgs),
    Value(LValue)
}
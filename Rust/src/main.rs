use crate::closure::learn_closure;
use crate::learn_trait::learn_trait;

mod closure;
mod generic;
mod functional;
mod learn_trait;

fn main() {
    learn_trait();
    learn_closure();
}
use crate::closure::learn_closure;
use crate::learn_trait::learn_trait;
use crate::pattern_match::learn_pattern_match;

mod closure;
mod generic;
mod functional;
mod learn_trait;
mod pattern_match;

fn main() {
    learn_trait();
    learn_closure();
    learn_pattern_match();
}
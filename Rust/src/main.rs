#![feature(box_syntax)]
#![feature(box_patterns)]
#![feature(default_free_fn)]

use crate::closure::learn_closure;
use crate::learn_trait::learn_trait;
use crate::pattern_match::learn_pattern_match;

mod closure;
mod generic;
mod functional;
mod learn_trait;
mod pattern_match;
mod test;
mod unstable_feature;
mod recursive_type;

fn main() {
    learn_trait();
    learn_closure();
    learn_pattern_match();
}
#![feature(box_syntax)]
#![feature(box_patterns)]
#![feature(default_free_fn)]
#![feature(let_chains)]

use crate::closure::learn_closure;
use crate::learn_trait::learn_trait;
use crate::pattern_match::learn_pattern_match;
use crate::lifetime::learning_life_time;

mod closure;
mod generic;
mod functional;
mod learn_trait;
mod pattern_match;
mod test;
mod unstable_feature;
mod recursive_type;
mod smart_ptr;
mod lifetime;
mod compare_string;
mod learn_macro;
mod to_iter;
mod error_handle;

fn main() {
    learn_trait();
    learn_closure();
    learn_pattern_match();
    learning_life_time();
}
fn pass_a_fn_pointer(fun: fn(usize) -> usize) {

}

// closure is a trait, will throw error when no type constraint spec
fn pass_a_closure<F, T>(closure: F) -> T
    where F : Fn() -> T {
    closure()
}

fn learn_functional() {
    pass_a_closure(||println!("pass closure"));
}
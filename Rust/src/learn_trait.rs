use std::collections::HashMap;

// if no clone, will error
// pub trait Copy: Clone {
//                  ----- required by this bound in `Copy`
#[derive(Copy, Clone)]
struct CopyStructure {
    a: usize,
    b: bool
}

#[derive(Clone)]
struct DeriveCloneStructure {
    a: String,
    b: HashMap<String, String>
}

// box(deep copy)
// rc(ref count + 1)
struct ManualCloneStructure {
    a: String,
    b: HashMap<String, String>
}

impl ManualCloneStructure {
    fn new(a: String, b: HashMap<String, String>) -> ManualCloneStructure {
        ManualCloneStructure{a, b}
    }
}
impl Clone for ManualCloneStructure {
    fn clone(&self) -> Self {
         ManualCloneStructure::new(self.a.clone(), self.b.clone())
    }
    // fn clone_from(&mut self, source: &Self)
    // clone_from call clone
}

struct DropStructure {
}

impl Drop for DropStructure {
    fn drop(&mut self) {
        println!("this obj has be dropped");
    }
}

fn pass_by_copy<T>(c: T) where T: Copy{
    println!("pass by copy")
}

pub fn learn_trait() {
    let copy_s = CopyStructure { a: 0, b: false };
    pass_by_copy(copy_s);
    let clone_s = DeriveCloneStructure{ a: "str".to_string(), b: Default::default() };
    // pass clone will compile error
    // the trait `Copy` is not implemented for `DeriveCloneStructure`
    // pass_by_copy(clone_s);
}
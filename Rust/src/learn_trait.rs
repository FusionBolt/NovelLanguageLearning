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

#[derive(Clone)]
struct GenericAndTrait<T: Clone> {
    v: T
}

impl<T: Clone> Drop for GenericAndTrait<T> {
    fn drop(&mut self) {
        todo!()
    }
}

pub fn learn_trait() {
    let copy_s = CopyStructure { a: 0, b: false };
    pass_by_copy(copy_s);
    let _ = DeriveCloneStructure{ a: "str".to_string(), b: Default::default() };
    let _ = DropStructure {};
    // pass clone will compile error
    // the trait `Copy` is not implemented for `DeriveCloneStructure`
    // pass_by_copy(clone_s);
}

struct ManualDefaultTrait {
    a: usize,
    b: bool
}

impl Default for ManualDefaultTrait {
    fn default() -> Self {
        ManualDefaultTrait {
            a: 0,
            b: false
        }
    }
}

#[derive(Default)]
struct DeriveDefaultStructure {
    a: usize,
    b: bool
}

#[cfg(test)]
mod tests {
    use crate::learn_trait::ManualDefaultTrait;
    use crate::learn_trait::DeriveDefaultStructure;
    use std::default::default;

    #[test]
    fn test_default_trait() {
        let v1 = ManualDefaultTrait::default();
        let v2 = DeriveDefaultStructure::default();
        assert_eq!(v1.a, v2.a);
        assert_eq!(v1.b, v2.b);
        let v3 = ManualDefaultTrait {
            a: 0,
            ..ManualDefaultTrait::default()
        };
        // feature:default_free_fn
        let v3 = ManualDefaultTrait {
            a: 0,
            ..default()
        };
        assert_eq!(v1.a, v3.a);
        assert_eq!(v1.b, v3.b);
    }
}

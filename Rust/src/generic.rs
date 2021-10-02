pub trait SomeTrait : Clone {}

struct SymbolTable<T: Default + SomeTrait> {
    v: T
}

impl<T: Default + SomeTrait> SymbolTable<T> {
    fn new() -> Self {
        SymbolTable { v: T::default() }
    }
}
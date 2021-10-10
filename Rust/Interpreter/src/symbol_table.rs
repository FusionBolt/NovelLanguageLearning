use std::collections::HashMap;

#[derive(Default)]
pub struct SymbolTable<V> {
    env: HashMap<String, V>,
}

impl<V: Clone> SymbolTable<V> {
    pub fn new() -> Self {
        SymbolTable { env: Default::default() }
    }

    pub fn look_up(&self, sym: &String) -> Option<&V> {
        self.env.get(sym)
    }

    pub fn insert(&mut self, sym: String, value: V) -> Option<V> {
        self.env.insert(sym, value)
    }

    // pub fn new_env_run<F: FnMut()-> T, T>(&mut self, fun: F) -> T {
    //     // todo:replace this with raii(drop)
    //     self.enter_function();
    //     let ret = fun();
    //     self.exit_function();
    //     ret
    // }

    pub fn enter_function(&mut self, new_env: HashMap<String, V>) {

    }

    pub fn exit_function(&mut self) {}
}
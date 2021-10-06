fn pass_a_fn_pointer(fun: fn(usize) -> usize) {}

// closure is a trait, will throw error when no type constraint spec
fn pass_a_closure<F, T>(closure: F) -> T
    where F: Fn() -> T {
    closure()
}

fn return_a_usize() -> usize {
    1
}

struct RAII<'a> {
    construction: Vec<Box<dyn FnMut() + 'a>>,
    deconstruction: Vec<Box<dyn FnMut() + 'a>>,
}

impl<'a> Drop for RAII<'a> {
    fn drop(&mut self) {
        for deconstruction in &mut self.deconstruction {
            deconstruction();
        }
    }
}

impl<'a> RAII<'a> {
    pub fn new() -> RAII<'a> {
        RAII { construction: Default::default(), deconstruction: Default::default() }
    }

    pub fn sub_scope(&mut self) -> &RAII<'a> {
        // todo:clone maybe a error
        for construction in &mut self.construction {
            construction();
        }
        self
    }

    // todo:closure copy?? or move
    fn register_constructor_fun<T: FnMut() + 'a>(&mut self, fun: T) {
        self.construction.push(Box::from(fun));
    }

    fn register_deconstruct_fun<T: FnMut() + 'a>(&mut self, fun: T) {
        self.deconstruction.push(Box::from(fun));
    }
}

struct Scope<'a> {
    raii: RAII<'a>
}

impl<'a> Scope<'a> {
    fn new() -> Scope<'a> {
        Scope{raii: RAII::new()}
    }

    // todo:what is the mut fun???
    pub fn new_env_run<F: FnMut()-> T, T>(&mut self, mut fun: F) -> T {
        self.raii.sub_scope();
        println!("new env run");
        fun()
    }
}

// todo:split a maker and a RAII
fn learn_functional() {
    pass_a_closure(|| println!("pass closure"));
    pass_a_closure(|| return_a_usize());
    let mut r = RAII::new();
    r.register_constructor_fun(||{
        println!("constructor");
    });
    r.register_deconstruct_fun(||{
        println!("deconstruct");
    });
    Scope::new().new_env_run(|| println!("run print in sub Scope"));
}
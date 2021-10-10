use std::collections::HashMap;
use std::sync::Arc;

fn run_closure<F: FnMut()>(mut fun: F) {
    fun()
}

struct LifeTimeTest {
    env: HashMap<String, String>
}

impl LifeTimeTest {
    fn new() -> Self {
        let mut env = HashMap::new();
        env.insert("k".to_string(), "v".to_string());
        LifeTimeTest { env }
    }

    // fn error_usage(&mut self) {
    //     // 2 problem
    //     // 1. value maybe changed in mut_method
    //     // 2, when insert, HashMap maybe reallocate, &obj address changed
    //     if let Some(v) = self.env.get("k") {
    //         self.mut_method(v);
    //     }
    // }

    fn mut_method(&mut self, str: &String) {

    }

    fn normal_method(&self) -> Option<String> {
        let s = "str".to_string();
        Some(s)
        // let f = || {
        //     self.f3()
        // };
        // f()
    }

    fn f3(&self) {
        println!("call lifetime test")
    }
}

pub fn learning_life_time() {
    let mut l = LifeTimeTest::new();
    match_lifetime();
}

enum TestEnum {
    ValueA,
    ValueB
}

// is move_match and
fn match_lifetime() {
    let v = TestEnum::ValueA;
    // ref match
    match &v {
        ValueA => {

        }
        _ => {

        }
    }
    // move match
    match v {
        ValueA => {

        }
        _ => {

        }
    }
}
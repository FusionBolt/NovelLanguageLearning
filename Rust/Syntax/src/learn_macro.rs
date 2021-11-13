// in match patterns
// ($name:expr)
// name->used in expanded code
// expr: designator
// item, block, stmt, pat...

#[macro_export]
macro_rules! simple {
    // match patterns => expanded code
    ($name:expr) => { println!("{:?}", $name)};
}

#[macro_export]
macro_rules! repeat {
    ($($x:expr), *) => {
        $(
            println!("{:?}", $x);
        )*
    }
}

macro_rules! hash {
    ($key:expr => $value:expr) => {
        println!("{:?} => {:?}", $key, $value);
    }
}

macro_rules! multi_hash {
    ($($key:expr => $value:expr), *) => {
        $(
            println!("{:?} => {:?}", $key, $value);
        )*
    }
}

macro_rules! multi_pattern {
    () => {
        println!("multi_pattern: empty pattern")
    };
    ($s:expr) => {
        println!("multi_pattern: {:?}", $s)
    }
}

mod tests {
    #[test]
    fn test_normal_macro() {
        simple!("str");
        simple!(233);
        repeat!("a", "b", 123);
        hash!("a" => "b");
        multi_hash!("a" => "b", "rua" => "nya!");
        multi_pattern!();
        multi_pattern!("str");
    }
}
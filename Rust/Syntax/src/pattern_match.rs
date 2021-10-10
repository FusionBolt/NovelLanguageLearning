use crate::pattern_match::Expr::Int;

#[derive(PartialEq)]
enum Expr{
    Int(i64),
    Bool(bool)
}

pub fn learn_pattern_match() {
    match_box(Box::from(Expr::Int(4)));
    match_box(Box::from(Expr::Bool(true)));
}

fn match_box(expr: Box<Expr>) {
    match *expr {
        Expr::Int(i) => {
            println!("Int Expr Value:{:?}", i);
        }
        Expr::Bool(b) => {
            println!("Bool Expr Value:{:?}", b);
        }
    }
}

#[cfg(test)]
mod tests {
    use crate::pattern_match::Expr;

    fn get_enum_false() -> Expr {
        Expr::Bool(false)
    }

    #[test]
    fn test_match_bool() {
        assert!(matches!(get_enum_false(), Expr::Bool(false)));
        // not recommend
        if let Expr::Bool(true) = get_enum_false() {
            assert!(false)
        }
    }
}
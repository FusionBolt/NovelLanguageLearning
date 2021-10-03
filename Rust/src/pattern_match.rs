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
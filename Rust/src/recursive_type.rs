enum Expr {
    Define(String, Box<Expr>),
    Value(bool)
}

#[cfg(test)]
mod tests {
    use crate::recursive_type::Expr;

    #[test]
    fn test_recursive_type() {
        let expr = Expr::Define("bool_v".to_string(), Box::from(Expr::Value(true)));
        if let Expr::Define(s, box (Expr::Value(bool_v))) = expr {
            assert!(bool_v);
        }
    }
}
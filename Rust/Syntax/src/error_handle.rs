
#[cfg(test)]
mod tests {

    #[test]
    fn panic() {
        panic!("error info")
    }

    struct OptionChain {
        v: Option<Option<i32>>
    }
    #[test]
    fn options() {
        let chains = OptionChain { v: None };
        // chains.v?.v?
        // a.map().map()

        let option_i = Some(5);

        // will panic
        assert_eq!(10, option_i.unwrap() * 2);

        // get value or return current fun
        // same as unwrap with no panic
        // str?;

        // if none then none, else process, likely functor
        // return a option<T>
        option_i.map(|x| x * 2);

        // flatmap
        // if none then none, else option<option<T>> translate to option<T> in f
        // reduce multi match None, maybe can be called "fold once option"
        match Some(Some(5)) {
            None => { None }
            Some(v) => {
                match v {
                    None => { None }
                    Some(x) => { Some(x * 2) }
                }
            }
        };
        Some(Some(5)).and_then(|x|
            x.map(|v| v * 2)
        );

        // set default value
        // when none return val which passed
        option_i.unwrap_or(5);
        // lazy eval
        // exec f when None, return T: Some(T)
        option_i.unwrap_or_else(||{
            println!("this is process when none");
            10
        });

        // when is not None, return a option<T>
        option_i.and(Some(5));
        assert_eq!(option_i.and::<i32>(None), None);

        option_i.expect("when none will panic this msg");

        // switch option and result(other monad is also ok)
        // some(v) -> f(v): T
        // none -> default: T
        option_i.map_or(Err("some error"), |r: i32| Ok(Some(r * 2)));
        Some("str").map_or(42, |v| v.len());
        // lazy eval
        Some("str").map_or_else(|| 42, |v| v.len());

        // map to Result
        // ok_or
        // ok_or_else
    }

    #[test]
    fn result() {
        // let a = Ok(1);

        // a.err();
        // a.map_err();
        // a.into_err();
        // a.unwrap_err();
        // a.unwrap_err_unchecked();
        // a.try_into();

        // a.strip_prefix_of()
    }
}
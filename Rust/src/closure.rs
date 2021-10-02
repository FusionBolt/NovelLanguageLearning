pub fn learn_closure() {
    create_closure();
    //let test_closure = get_closure();
    //println!("test_closure: {:?}", test_closure(4));
}

fn create_closure() {
    let normal_closure = |num| {
        println!("normal_closure, num:{:?}", num);
    };
    normal_closure(7);

    let minimal_closure = || println!("minimal_closure");
    minimal_closure();

    let closure_n = 3;
    let type_annotation_closure = |num: usize| -> usize {
        num * closure_n
    };
    let n = 2;
    println!("type_annotation_closure, {:?} * {:?} = {:?}",closure_n, n, type_annotation_closure(n));

}

// closure impl Fn, FnMut, FnOnce
fn save_closure_in_struct() {
    struct ClosureSaver<T>
        where T: Fn(usize) -> usize
    {
        closure: T
    }
}

// fn get_closure<T>() -> T {
//     let mut a = 1;
//     let mut test_closure = |num: usize| -> usize {
//         a += 1;
//         a + num
//     };
//     test_closure
// }
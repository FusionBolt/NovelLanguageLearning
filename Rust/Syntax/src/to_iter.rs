#[cfg(test)]
mod tests {
    #[test]
    fn iter() {
        // iter: &self
        // into_iter: self
        // iter_mui: &mut self
        let v = vec![1, 2, 3, 4, 5];
        v.iter().map(|x| println!("test:{:?}", x));
        v.iter().map(|&x| println!("test:{:?}", x));
        v.into_iter().map(|x| x).collect::<Vec<i32>>();
        // v can't be used after into_iter, because v is moved
        // this stmt will throw error: use of moved value: `v`
        // v.into_iter().map(|x| x).collect::<Vec<i32>>();
    }

    #[test]
    fn iter_mut() {
        let mut v = vec![1, 2, 3, 4, 5];
        v.iter_mut().map(|x| *x *= 2);
        assert_eq!(v, vec![1, 2, 3, 4, 5]);
    }
}
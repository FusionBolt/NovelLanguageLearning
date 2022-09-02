module Lib(

) where
  

-- shortest quicksort
-- sort [] = []
-- sort (x:xs) = sort [y | y <- xs, y < x] ++ [x] ++ sort [y | y <- xs, y >= x]
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
  let smallerSorted = quicksort [a | a <- xs, a <= x]
      biggerSorted = quicksort [a | a <- xs, a > x]
  in smallerSorted ++ [x] ++ biggerSorted

quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) = 
  let smallerSorted = quicksort' $ filter (<=x) xs
      biggerSorted = quicksort' $ filter (>x) xs
  in smallerSorted ++ [x] ++ biggerSorted
  
fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

head' :: [a] -> a
head' (x:xs) = x

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x, y) : (zip' xs ys)

max' :: (Ord a) => a -> a -> a
max' y = (\x -> if x > y then x else y)

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
-- filter' f (x:xs) = if f x then [x] else [] ++ (filter' f xs)
-- filter' f (x:xs) = filter' f xs : if f x then [x] else []
filter' f (x:xs) = 
  let l = if f x then [x] else []
    in l ++ filter' f xs

filp' :: (a -> b -> c) -> b -> a -> c
filp' f = \x y -> f y x
-- flip' f x y = f y x

sum'' :: (Num a) => [a] -> a
sum'' [] = 0
sum'' (x:xs) = x + sum'' xs

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs


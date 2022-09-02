module H(

) where
  
doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100
                      then x
                      else doubleMe x
doubleSmallerNumber' x = (if x > 100 then x else 2*x) + 1

h'kl = "Haskell!"

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

test1 = [ x | x <- [10..20], x /= 13, x /= 15, x /= 19]
test2 = [ x*y | x <-[2,5,10], y <- [8,10,11], x*y > 50]

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24]

addThree :: Int -> Int -> Int -> Int  
addThree x y z = x + y + z

head' :: [a] -> a  
head' [] = error "Can't call head on an empty list, dummy!"  
head' (x:_) = x

tell :: (Show a) => [a] -> String  
tell [] = "The list is empty"  
tell (x:[]) = "The list has one element: " ++ show x  
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y  
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

length' :: (Num b) => [a] -> b  
length' [] = 0  
length' (_:xs) = 1 + length' xs

capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
-- all@(x:xs) save all,x and xs, x + xs == all

myCompare :: (Ord a) => a -> a -> Ordering  
a `myCompare` b  
    | a > b     = GT  
    | a == b    = EQ  
    | otherwise = LT

initials :: String -> String -> String  
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
    where (f:_) = firstname  
          (l:_) = lastname

calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis xs = [bmi w h | (w, h) <- xs] 
    where bmi weight height = weight / height ^ 2

maxi :: (Ord a) => [a] -> a
maxi [] = error "empty list"
maxi [x] = x
maxi (x:xs) = max x (maxi xs)

fac :: (Integral a) => a -> a
fac 0 = 1
fac x = x * fac(x-1)

maxValInList :: (Ord a) => [a] -> a
maxValInList [] = error "empty list"
maxValInList [x] = x
maxValInList (x:xs) = max x (maxValInList xs)

rep :: (Num i, Ord i) => i -> a -> [a]
rep n x
    | n <= 0 = []
    | otherwise = x:rep (n-1) x

take' ::(Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x : take' (n-1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

repeat' :: a -> [a]
repeat' x = x:repeat' x

zip' :: [a] -> [b] -> [(a, b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs) 
    | a == x    = True
    | otherwise = a `elem'` xs

quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) = 
  let smallerSorted = quicksort' [a | a <- xs, a <= x]
      biggerSorted = quicksort' [a | a <- xs, a > x]
  in smallerSorted ++ [x] ++ biggerSorted

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort(filter(<=x) xs)
        biggerSorted = quicksort(filter(>x) xs)
    in smallerSorted ++ [x] ++ biggerSorted

divideByTen :: (Floating a) => a -> a
divideByTen = (/10)

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]  
zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip'1 :: (a -> b -> c) -> (b -> a -> c)  
flip'1 f = g  
    where g x y = f y x

flip' :: (a -> b -> c) -> b -> a -> c  
flip' f y x = f x y

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

f1 = sum (takeWhile (<10000) (filter odd (map (^2) [1..]))) 

chain :: (Integral a) => a -> [a]  
chain 1 = [1]  
chain n  
    | even n =  n:chain (n `div` 2)  
    | odd n  =  n:chain (n*3 + 1)

numLongChains' :: Int  
numLongChains' = length (filter isLong (map chain [1..100]))  
    where isLong xs = length xs > 15

numLongChains :: Int  
numLongChains = length (filter (\xs -> length xs > 15) (map chain [1..100]))

eleml' :: (Eq a) => a -> [a] -> Bool
eleml' y ys = foldl (\acc x -> if x == y then True else acc) False ys

map'' :: (a -> b) -> [a] -> [b]
map'' f xs = foldr (\x acc -> f x : acc) [] xs


max' :: (Ord a) => a -> a -> a
max' y = (\x -> if x > y then x else y)


--data Exp = Val Int | Var Name | App Op Exp Exp deriving (Show, Eq)
--data Op = Add | Sub | Mul | Div deriving (Show, Eq)
--data Prog = Assign Name Exp
--          | If Exp Prog Prog
--          | While Exp Prog
--          | Seqn [Prog] deriving (Show, Eq)


countChange :: Integer -> [Integer] -> Integer
countChange amount coins
  | amount == 0 = 1
  | amount < 0 || length coins == 0 = 0
  | otherwise = foldl (+) 0 $ map (\x -> countChange (amount - x) coins) coins

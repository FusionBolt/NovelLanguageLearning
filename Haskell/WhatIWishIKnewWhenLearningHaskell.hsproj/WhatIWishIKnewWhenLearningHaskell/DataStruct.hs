module DataStruct() where
  
data List a = LEmpty | LVal a (List a) deriving (Show)

data Tree a = TEmpty | Node a (Tree a) (Tree a) deriving (Show)

type Queue = List







type Stack = []

pop :: Stack a -> (a, Stack a)
pop (x:xs) = (x, xs)

push :: a -> Stack a -> Stack a
push x xs = x:xs

len :: Stack a -> Int
len xs = length xs
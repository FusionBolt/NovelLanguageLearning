module Basics() where
  
-- import Data.List hiding(head)
-- head can be masked by user defined symbol of the same name

-- curry

add x y = x + y
uncurryAdd = uncurry add
-- c = uncurryAdd 1 is error
curryAdd = curry uncurryAdd


-- Algebraic Datatypes

data Point = Point Int Int
-- data Point = Point { x :: Int, y :: Int }
data Suit = Clubs | Diamonds | Hearts | Spades
data Color = Red | Yellow | Blue
data Value = One | Two | Three | Queen
 deriving (Eq, Ord)
data Card = Card { suit :: Suit , color :: Color , value :: Value }

-- queenDiamonds = Card Diamonds Red Queen
queenDiamonds = Card { suit = Diamonds, color = Red, value = Queen }

data List a = Nil | List a (List a)
list :: List Integer
list = List 1 (List 2 (List 3 Nil))

--infixr 5 :-:
--data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)Octotree
--t = 1 :+: 2 :+: Empty
--t = 1 + 2 + Empty
-- if no infixr 5 :-: need
-- :set -XFlexibleContexts
{-# LANGUAGE FlexibleContexts #-}


-- Lists

iteration = iterate (\x->x*2) 1 -- infinte 1


-- Pattern Matching

data Example = Example Int Int Int
example1 x = case x of
  Example a b c -> a + b + c
 
example2 (Example a b c) = a + b + c

getValue v = case v of
  One -> 1
  Two -> 2
  Three -> 3
  
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

--fib m = case m of
--  0 -> 0
--  1 -> 1
--  n -> fib (n-1) + fib(n-2)

addOne :: [Int] -> [Int]
addOne (x : xs) = (x+1) : (addOne xs)
addOne [] = []


-- Guards
absolute n
  | n < 0 = -n
  | otherwise = n
  
absoluteJust n = case n of
  Nothing -> Nothing
  Just n
    | n < 0 -> Just (-n)
    | otherwise -> Just n
    

-- let and where

-- where is not an expr
var_let = let x = 1; y = 2 in (x+y)
var_where = x + y where x = 1; y = 1
var_where2 = x + y
  where
    x = 1
    y = 1
    

-- conditionals
absolute_if n = if n < 0 then -n else n
absolute_if_case n = case (n < 0) of
  True  -> (-n)
  False -> n
  

-- Function Composition
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- f . g = \x -> f (g x)


--fex1 = f1 . f2 . f3 . f4 $ input -- with ($)
--fex2 = input & f1 . f2 . f3 . f4 -- with (&)
--fex3 = (f1 . f2 . f3 . f4) input -- with explicit parens


-- List Comprehensions
factorial n = product [1..n]

-- 每一次调用都是一次过滤，除以前面的数余数为0则去掉
-- [2,3,4,5,6,7,8,9]
-- 2 : [3,5,7,9] -- mod 2 > 0
-- 2 :3 : [5,7] -- mod 3 > 0
primes = sieve [2..] 
  where sieve (p:xs) = p : sieve [n | n <- xs, n `mod` p > 0]


-- comments
{-|
when have pipe, comment will be used to generate doc
modules also have, to P49
this is a multi-line comment
-}

-- type class
-- 1.define class
-- 2.implement

-- likely define interface
class Equal a where 
  equal :: a -> a -> Bool
  
-- implement interface
instance Equal Bool where 
  equal True True = True 
  equal False False = True 
  equal True False = False 
  equal False True = False
  
instance Equal () where 
  equal () () = True
  
data Ordering = LT | EQ | GT

--instance Equal Ordering
--  where 
--    equal LT LT = True
--    equal EQ EQ = True
--    equal GT GT = True
--    equal _ _   = False
 
-- (Equal a) is type constrain
-- different type has own implement, compare [a] with Bool
instance (Equal a) => Equal [a] where
  equal [] [] = True -- Empty lists are equal
  equal [] ys = False -- Lists of unequal size are not equal
  equal xs [] = False
-- equal x y is only allowed here due to the constraint (Equal a) 
  equal (x:xs) (y:ys) = equal x y && equal xs ys

instance (Equal a, Equal b) => Equal (a,b) where 
  equal (x0, x1) (y0, y1) = equal x0 y0 && equal x1 y1


-- :info Num -- show typeclass implementation

--data List a
--  = Cons a (List a)
--  | Nil
--  deriving (Eq, Ord, Show)

newtype Velocity = Velocity Double
newtype_val = Velocity 2.0


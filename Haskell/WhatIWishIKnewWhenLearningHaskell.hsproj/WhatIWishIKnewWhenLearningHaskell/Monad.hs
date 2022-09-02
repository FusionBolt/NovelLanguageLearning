{-# LANGUAGE FlexibleContexts #-}
module Monad() where
  
import Control.Monad.Writerrt

-- 如果count和sum互换会出问题
type SumT = Int
getSome :: SumT -> Int -> Maybe SumT
getSome count sum
 | rest > 0 = Just rest
 | otherwise = Nothing
 where rest = sum - count

putSome :: SumT -> Int -> Maybe SumT
putSome count sum
 | newSum < 10 = Just newSum
 | otherwise = Nothing
 where newSum = sum + count
 

data T = T1 | T2
test x = do
  tell ("some str")
  return (x / 5)

half x = 
  if even x
  -- then Just $ x / 2 is error
  -- :t / and :t div are difference
  then Just $ x `div` 2
  else Nothing
  
multi x = 
  if x == 0
  then Nothing
  else Just (*x)
  
-- example to show Monad
-- getLine >>= putStrLn
-- getLine >>= readFile >>= putStrLn

-- example to show Functor
-- (++"!") <$> getLine


--import Data.Char  
--import Data.List 
--main = do line <- fmap (intersperse '-' . reverse . map toUpper) getLine  
--          putStrLn line

-- reverse param's type is array
-- fmap param's type should (\x->x)


applyLog :: (Monoid m) => (a,m) -> (a -> (b,m)) -> (b,m)  
applyLog (x,log) f = let (y,newLog) = f x in (y,log `mappend` newLog)


type Food = String  
type Price = Sum Int  

addDrink :: Food -> (Food,Price)  
addDrink "beans" = ("milk", Sum 25)  
addDrink "jerky" = ("whiskey", Sum 99)  
addDrink _ = ("beer", Sum 30)

--("dogmeat", Sum 5) `applyLog` addDrink `applyLog` addDrink  
--("beer",Sum {getSum = 65})



-- Writer
gcd'' :: Int -> Int -> Int  
gcd'' a b   
    | b == 0    = a  
    | otherwise = gcd'' b (a `mod` b)
    

gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
    | b == 0 = do
        tell ["Finished with" ++ show a]
        return a    
    | otherwise = do
        tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
        gcd' b (a `mod` b)
        -- gcd' return a Writer, so don't need return
       
-- also can be 
-- Writer (a, ["Finished with " ++ show a])


trackAdd :: Int -> Int -> Writer [String] Int
trackAdd x y = do
  a <- return x
  b <- return y
  tell ["a is:" ++ show a]
  tell ["b is:" ++ show b]
  tell ["result is :" ++ show (x+y)]
  return (x+y)


-- Reader

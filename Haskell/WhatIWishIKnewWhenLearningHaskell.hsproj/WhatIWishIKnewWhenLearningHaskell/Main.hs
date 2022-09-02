import Control.Monad.Reader

pro n
  | n `mod` 3 == 0 = n
  | n `mod` 5 == 0 = n
  | otherwise = 0

solution :: Integer -> Integer
solution number = sum $ map f [1..number-1]
  where f n
          | n `mod` 3 == 0 = n
          | n `mod` 5 == 0 = n
          | otherwise = 0
      
main :: IO ()
main = do
  print "Hello Haskell"
  print "Enter a Number"
  n <- getLine
  print ("you entered: " ++ n)
  


data MyContext = MyContext { 
  foo :: String,
  bar :: Int
} deriving (Show)

computation :: Reader MyContext (Maybe String)
computation = do
  n <- asks bar
  x <- asks foo
  if n > 0
    then return (Just x)
    else return Nothing
    
ex1 :: Maybe String
ex1 = runReader computation $ MyContext "hello" 1

ex2 :: Maybe String
ex2 = runReader computation $ MyContext "haskell" 0


example :: [(Int, Int, Int)]
example = do
  a <- [1,2]
  b <- [10,20]
  c <- [100,200]
  return (a,b,c)




data St = St
  { s :: String
  , i :: Int
  } deriving(Show)
  

com :: Reader St (Maybe String)
com = do
  n <- asks s
  return (Just n)


m = runReader com $ St "str" 2

get = id




data ExcpCtrl a = Raise | Return a deriving Show

raise = Raise

instance Monad ExcpCtrl where
    return = Return
    p >>= q = case p of
                Raise -> Raise
                Return x -> q x

calc :: ExcpCtrl Int
calc = do
    a <- return 8
    b <- return 2
    if b == 0 then raise else return $ quot a b

calc_excp :: ExcpCtrl Int
calc_excp = do
    a <- return 8
    b <- return 0
    if b == 0 then raise else return $ quot a b
    return $ quot 8 2
    

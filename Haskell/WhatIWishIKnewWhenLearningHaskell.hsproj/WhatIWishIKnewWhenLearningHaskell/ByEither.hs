module ByEither() where

import Data.Either

data Error = ErrorInfo String | ErrorCode Int deriving (Show)

data ConnectHandle = ConnectHandle Int deriving (Show)
type IP = String
connect :: IP -> Either Error ConnectHandle
connect ip
  | length ip == 9 = Right $ ConnectHandle 1
  | otherwise = Left $ ErrorInfo "ip not valid"
  

type Response = String
recv :: ConnectHandle -> Either Error Response
recv handle = Right "hello Haskell"

applyEither :: Either c a -> (a -> Either c b) -> Either c b
applyEither (Left x) f = Left x
applyEither (Right x) f = f x


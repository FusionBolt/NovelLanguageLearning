import System.IO
import Data.Char(toUpper)

str2action :: String -> IO()
str2action input = putStrLn ("Data:" ++ input)

list2actions :: [String] -> [IO()]
list2actions = map str2action

numbers :: [Int]
numbers = [1..10]

strings = map show numbers

actions:: [IO()]
actions = list2actions strings

printitall :: IO()
printitall = runall actions

runall :: [IO()] -> IO()
runall [] = return ()
runall (firstElement:otherElements) = 
    do firstElement
       runall otherElements

main = do str2action "start program"
          printitall
          str2action "done"

isYes :: String -> Bool
isYes inpStr = (toUpper . head $ inpStr) == 'Y'

isGreen :: IO Bool
isGreen =
    do putStrLn "Is green your favorite color?"
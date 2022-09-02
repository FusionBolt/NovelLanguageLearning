import System.IO

str2action :: String -> IO()
str2action input = putStrLn ("Data:" ++ input)

list2actions = map str2action

numbers :: [Int]
numbers = [1..10]

strings = map show numbers

actions:: [IO()]
actions = list2actions strings

printitall :: IO() -> IO()
printitall = runall actions

runall :: [IO()] -> IO()
runall [] = return ()
runall (firstElement:otherElements) = 
    do firstElement
       runall otherElements

main = do str2action "start program"
          printitall
          str2action "done"
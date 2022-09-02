import System.IO

str2action :: String -> IO()
str2action input = putStrLn ("Data:" ++ input)


numbers :: [Int]
numbers = [1..10]

printitall :: IO() -> IO()
printitall = runall 

runall :: IO() -> IO()
runall 
runall (firstElement:otherElements) = 
    do firstElement
       runall otherElements

main = do str2action "start program"
          printitall
          str2action "done"
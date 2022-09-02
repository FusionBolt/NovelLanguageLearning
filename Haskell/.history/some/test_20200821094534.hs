import System.IO

str2action :: String -> IO()
str2action input = putStrLn ("Data:" ++ input)


main = do str2action "start program"
          print
import System.IO

str2action :: String -> IO()
str2action input = putStrLn ("Data:" ++ input)


printi
main = do str2action "start program"
          printitall
          str2action "done"
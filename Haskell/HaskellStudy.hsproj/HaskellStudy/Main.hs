import System.IO
import System.Directory
import Data.List
import Data.Char(toUpper)

sort2 :: (Ord a) => a -> a -> (a,a)
sort2 x y = if x > y then (x,y) else (y,x)

fun :: [a] -> [a]
fun x@(x1:x2) = x

-- concat [1,2,3],[2,3,4]]
-- [1,2,3,2,3,4]

--main = do
--    handle <- openFile "todo.txt" ReadMode
--    (tempName, tempHandle) <- openTempFile "." "temp"
--    contents <- hGetContents handle
--    let todoTasks = lines contents
--    numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
--    putStrLn "These are your TO-DO items:"
--    putStr $ unlines numberedTasks
--    putStrLn "Which one do you want to delete?"
--    numberString <- getLine
--    let number = read numberString
--    newTodoItems = delete (todoTasks !! number) todoTasks
--    hPutStr tempHandle $ unlines newTodoItems
--    hClose handle
--    hClose tempHandle
--    removeFile "todo.txt"
--    renameFile tempName "todo.txt"

f = take 100.repeat

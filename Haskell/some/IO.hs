import Data.Char
import Control.Monad
import System.IO

main = do
    line <- getLine
    if null line
        then return ()
        else do
            putStrLn $ reverseWords line
            main

reverseWords :: String -> String
reverseWords = unwords . map reverse . words


main1 = do
    a <- return "hell"
    b <- return "yeah!"
    putStrLn $ a ++ " " ++ b

putStr' :: String -> IO()
putStr' [] = return ()
putStr' (x:xs) = do
    putChar x
    putStr' xs

main2 = do
    rs <- sequence [getLine, getLine, getLine]
    print rs

-- sequence(map print [1,2,3,4,5])  sequence:make a I/O action string to a I/O action
-- mapM print [1,2,3]
-- mapM_ print [1,2,3] don't have [(),(),()]

whenMain = do
    c <- getChar
    when (c /= ' ') $ do
        putChar c
        whenMain

foreverMain = forever $ do
    putStr "Give me some input: "
    l <- getLine
    putStrLn $ map toUpper l

formMain = do
    colors <- forM [1,2,3,4] (\a -> do
        putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"
        color <- getLine
        return color)
    putStrLn "The colors that you associate with 1, 2, 3 and 4 are: "
    mapM putStrLn colors
-- forM is same as mapM, only parameter list's sequence is opposite


contextMain = do
    contents <- getContents
    putStr (shortLinesOnly contents)

shortLinesOnly :: String -> String
shortLinesOnly input =
    let allLines = lines input
        shortLines = filter (\line -> length line < 10) allLines
        result = unlines shortLines
    in result

shortMain = interact $ unlines . filter((<10) . length) . lines


--respondPalindromes contents = unlines (map (\xs ->
--    if isPalindrome xs then "palindrome" else "not a palindrome") (lines contents))
--        where isPalindrome xs = xs == reverse xs
respondPalindromes = unlines . map (\xs ->
    if isPalindrome xs then "palindrome" else "not a palindrome") . lines
        where isPalindrome xs = xs == reverse xs
respMain = interact respondPalindromes

fsMain = do
    handle <- openFile "Exec.c" ReadMode -- get file handle
    contents <- hGetContents handle
    putStr contents
    hClose handle

mn str = do
    handle <- openFile str ReadMode
    contents <- hGetContents handle
    let to = lines contents
    -- putStr contents
    hClose handle

fileLambdaMain = do
    withFile "Exec.c" ReadMode (\handle -> do
        contents <- hGetContents handle
        putStr contents)

withFile' :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
withFile' path mode f = do
    handle <- openFile path mode
    result <- f handle
    hClose handle
    return result

readfileMain = do
    contents <- readFile "Exec.c"
    putStr contents
-- writeFile and appendFile

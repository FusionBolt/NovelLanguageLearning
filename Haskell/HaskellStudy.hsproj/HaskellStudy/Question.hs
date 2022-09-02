module Question where
  
import Data.List
import Data.List.Split
import Data.Char

-- List question

-- 1 find the last element
-- myLast (x:xs) = if xs == [] then x else f xs
myLast [] = error "Empty Lists"
myLast x = x !! (length x - 1)
-- myLast = head . reverse

-- 2 find [1,2,3,4]->3 
-- myButLast = head . tail . reverse
myButLast = head . reverse . init
-- myButLast x = reverse x !! 1

--3 find K'th element
elementAt :: [a] -> Int -> a
elementAt (x:_) 1 = x
elementAt [] _ = error "Index out of bounds"
elementAt (_:xs) k
  | k < 1 = error "Index out of bounds"
  | otherwise = elementAt xs (k-1)
-- elementAt ls x = ls !! (x - 1)

--4 find number of elemments
myLength :: (Num b) => [a] -> b
myLength = foldl (\acc _ -> acc + 1) 0 
--myLength = foldr (\_ acc -> acc + 1) 0 

--myLength :: (Num b) => [a] -> b
--myLength [] = 0
--myLength (_:xs) = 1 + myLength xs
-- myLength (x:xs) = 1 + myLength xs

--5 reverse a list
myReverse :: [a] -> [a]
-- myReverse [] = []
-- myReverse (x:xs) = (myReverse xs) ++ [x]
myReverse = foldl (\acc x -> x:acc) []

--6 isPalindrome
isPalindrome xs = xs == (reverse xs)

data NestedList a = Elem a | List [NestedList a]

--7 flatten a nested list structure
--my-flatten (x:xs)
--  | xs == [] = xs
--  | otherwise = (my-flatten [x]) ++ (my-flatten [xs])
-- mf (x:xs) = if xs == [] then x else ((mf [x]) ++ (mf [xs]))

--8 Eliminate consecutive duplicates of list elements.
compress :: Eq a => [a] -> [a]
compress = map head.group





-- CodeWars
reverseWords :: String -> String
reverseWords = unlines . map reverse . lines

---- comp as bs = (sum (map (\x ->x^2`elem`bs) as)) == (length as)
--comp :: [Integer] -> [Integer] -> Bool
--comp as bs = if aLength /= bLength then False
--              else length(filter (\x ->x^2`elem` bs) as) == aLength
--  where aLength = length as
--        bLength = length bs



--comp as bs
--  | aLength /= bLength = False
--  | aLength == 0 = True
--  | otherwise = (length(filter (\x ->x^2`elem` bs) as) == aLength)
--  where aLength = length as
--        bLength = length bs

comp :: [Integer] -> [Integer] -> Bool     
comp as bs
  | aLength /= bLength = False
  | aLength == 0 = True
  | otherwise = aS == bS
  where aS = sort $ map (^2) as
        bS = sort bs
        aLength = length as
        bLength = length bs


--"abcd"->["ab","cd"]
--"abcde"->["ab","cd","e_"]
solution ::String -> [String]
solution [] = []
solution (x:[]) = [[x, '_']]
solution (x:y:xs) = [x,y] : (solution xs)

toWeirdCase :: String -> String
toWeirdCase str = unwords . map f $ words str
  where f [] = []
        f (x:[]) = [toUpper x]
        f (x:y:xs) = [toUpper x, toLower y] ++ (f xs)


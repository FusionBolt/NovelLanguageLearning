module Monoids() where
  
import Data.Monoid
import Control.Monad

lengthCompare :: String -> String -> Ordering  
lengthCompare x y = (length x `compare` 5) `mappend`  
                    (x `compare` y)
                    


--guard :: (MonadPlus m) => Bool -> m ()  
--guard True = return ()  
--guard False = mzero

type Pos = (Int, Int)

maxX = 10
maxY = 10
  
inScpoe (x, y) 
  | x < 0 = False
  | x > maxX = False
  | y < 0 = False
  | y > maxY = False
  | otherwise = True
 
-- error version
-- if (x > 0 && x < maxX) is true, will exec this, although y < 0
--inScpoe (x, y) 
--  | y > 0 && y < maxY = True
--  | x > 0 && x < maxX = True
--  | otherwise = False
  
--move :: Pos -> [Pos]
--move (x, y) = do 
--   (x', y') <- [(x+1, y), (x-1, y), (x, y+1), (x, y-1)]
--   guard $ inScpoe (x', y')
--   -- guard (x' `elem` [1..8] && y' `elem` [1..8])
--   return (x', y') -- if guard is empty, will return this
--   
move :: Pos -> [Pos]
move (x, y) = filter inScpoe 
   [(x+1, y), (x-1, y), (x, y+1), (x, y-1)]
   
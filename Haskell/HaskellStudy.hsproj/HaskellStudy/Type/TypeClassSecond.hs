module Type.TypeClassSecond (

) where
  
-- class be used to define new typeclass
-- instance be used tell about instance of a typeclass

-- default define

--class Eq a where
--    (==) :: a -> a -> Bool
--    (/=) :: a -> a -> Bool
--    x == y = not (x /= y)
--    x /= y = not (x == y)

data TrafficLight = Red | Yellow | Green

instance Eq TrafficLight where
    Red == Red = True
    Green == Green = True
    Yellow == Yellow = True
    _ == _ = False
    
instance Show TrafficLight where
    show Red = "Red light"
    show Yellow = "Yellow light"
    show Green = "Green light"
    

-- default define
--instance (Eq m) => Eq (Maybe m) where
--    Just x == Just y = x == y
--    Nothing == Nothing = True
--    _ == _ = False

class YesNo a where
  yesno :: a -> Bool

instance YesNo Int where
  yesno 0 = False
  yesno _ = True
-- yesno $ Just 0
  
instance YesNo [a] where
  yesno [] = False
  yesno _ = True
    
instance YesNo Bool where
  yesno = id -- recive a val and return same
  
instance YesNo (Maybe a) where
    yesno (Just _) = True
    yesno Nothing = False
    
instance YesNo TrafficLight where
    yesno Red = False
    yesno _ = True
    
yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf yesnoVal yesResult noResult =
    if yesno yesnoVal then yesResult else noResult
    

--class Functor f where
--    fmap :: (a -> b) -> f a -> f b
--instance Functor [] where
--    fmap = map
--instance Functor Maybe where
--    fmap f (Just x) = Just (f x)
--    fmap f Nothing = Nothing
--instance Functor Tree where
--    fmap f EmptyTree = EmptyTree
--    fmap f (Node x leftsub rightsub) =
--        Node (f x) (fmap f leftsub) (fmap f rightsub)

--instance Functor (Either a) where
--    fmap f (Right x) = Right (f x)
--    fmap f (Left x) = Left x

--data Either a b = Left a | Right b


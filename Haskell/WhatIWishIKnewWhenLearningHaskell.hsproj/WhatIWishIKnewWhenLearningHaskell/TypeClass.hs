module TypeClass() where
  
data Animal = Cat | Dog | Bird deriving (Show)

data Vehicle = Car | Bus | Boat | Airplane deriving (Show)

class Action a where
  canRun :: a -> Bool
  canFly :: a -> Bool
  calls :: a -> String
  
instance Action Vehicle where
  canRun Boat = False
  canRun _ = True
  canFly Airplane = True
  canFly _ = False
  calls a = show a
  
getVehicleCalls :: Vehicle -> String
getVehicleCalls x = calls x


--class (Num a) => UNum a where
--  (+) :: a -> a -> a
--  abs :: a -> a
  
--instance UNum Action where
--  (+) a b = a + b
  
-- instance Num Float

data Option a = Some a | None

getOp (Some v) = 1
getOp None = 0
getOptionVal option = case option of 
                        Some v -> 1
                        None -> 0
                        
data Point = Point Int Int
-- move :: (Point a, Int b) => a -> b -> b -> a
--move :: Point -> Int -> Int -> Point
--move (Point px py) x y = Point (px+x) (py+y)


type ErrCode = Int
type ErrStr = String
data ErrInfo = Error ErrCode ErrStr | Success
maybe_getV (Error code str) = Just str
maybe_getV (Success) = Nothing

select_id id
  | id > 1 = Left id
  | otherwise = Right $ Error 1 "not valid id" 


show_id_data (Left val) = val
show_id_data (Right (Error id str)) = id



data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
           deriving (Eq, Ord, Show, Read, Bounded, Enum)



--class TwoClass (a b) where
--  two_f :: a -> b -> a  
--  

type Birds = Int  
type Pole = (Birds,Birds)
-- 定义Int的同义形态
-- type synonym

class T a where
  f :: a -> Bool
  
--instance T (Maybe a) where
--  f x = x

instance (T m) => T (Maybe m) where
    f (Just x) = True
    f Nothing = False

instance T [a] where
  f [a] = True
  f [] = False

instance T Day where
  f _ = True


--j a == *
--a == *
--j == (* -> *)
--j a -> t j a
--t == (* -> *)
--j a -> t a j
--t == (* -> (* -> *) -> *)


-- is ok
-- data FF a b = FF b a
-- FF 1 2
-- b a is two value constructor params
-- a b is same

-- data FF a b = FF { v :: a b }
-- a b is v's type constrains

-- both are true
-- (* -> *) -> * -> *
-- data FF a b = FF { mm :: a b }
-- FF $ Just "str" :: Maybe [Char]
-- FF "str" :: Char []

-- * -> (* -> *) -> *
-- data FF a b = FF { mm :: b a }
-- FF $ Just "str" :: [Char] Maybe
-- FF "str" :: [] Char


-- if tofu is -> t j a,
-- then Frank should also be a b
class Tofu t where
    tofu :: j a -> t a j
    
data Frank a b  = Frank {frankField :: b a} deriving (Show)

instance Tofu Frank where
  tofu x = Frank x
  
data Barry t k p = Barry { yabba :: p, dabba :: t k }

-- :k Barry
-- (* -> *) -> * -> * -> *
-- partially apply two type
-- (* -> *)
-- receive a type to generate a type (* -> *)
-- The type passed in is the type of the manipulated variable
-- 最后剩下的一个type(其他的partially apply) 用于fmap要f的那一部分的type
instance Functor (Barry a b) where
  fmap f (Barry {yabba = x, dabba = y}) = Barry {yabba = f x, dabba = y}
  
-- partially apply, one type left
newtype Pair a b = Pair { getPair :: (b, a) }
instance Functor (Pair c) where  
    fmap f (Pair (x,y)) = Pair (f x, y)
  
-- same some, only changed order

-- newtype Pair a b = Pair { getPair :: (a,b) }
-- instance Functor (Pair c) where  
--     fmap f (Pair (x,y)) = Pair (x, f y)
  
-- newtype lazy
newtype LazyT = LazyT { info :: String }

getInfo (LazyT _ ) = "Lazy eval, not raise undefined error. If define LazyT by data, will raise error"






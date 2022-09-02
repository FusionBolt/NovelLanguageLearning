module Type.Type(

) where


-- record syntax

data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavor :: String
                     } deriving (Show)


-- type parameters

-- data Car = Car { company :: String
--                  , model :: String
--                  , year :: Int
--                  } deriving (Show)

data Car a b c = Car { company :: a
                       , model :: b
                       , year :: c
                        } deriving (Show)

-- let newCar = Car {company="Ford", model="Mustang", year=1967}

-- data Maybe a = Nothing | Just a

data Vector a = Vector a a a deriving (Show)
vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)
vectMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)
scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
           deriving (Eq, Ord, Show, Read, Bounded, Enum)

-- data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)


module Applicative() where
  
import Control.Applicative

f1 = (+).(+3).(*100) 

f2 = (+) <$> (*3) <$> (*100)

f3 = (+) <$> (*3) <*> (*100)

val = (\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5 

 
-- +3 x 和 *100 x的结果再相加
-- fmap ((+).(+3)) (*100) 5

-- (\x -> (+x))(\y -> y + 3)  
f = (+).(*3)

-- data Test a = Test { ffff :: [a] }

-- data包含一个型别，执行的时候有解开的成本
-- newtype zero-cost
-- newtype 只是包装现有类型，lazy eval
newtype Test a = Test { ffff :: [a] }
-- newtype 需要单一值构造子，且值构造子只有一个字段
-- 也就意味着sumtype不能用了
-- newtype 构造出的新的型别并不会被自动定义成原有型别所属的 typeclass 的一个 instance，所以我们必须自己来 derive 他们。
newtype CharList = CharList { getCharList :: [Char] } deriving (Eq, Show)

newtype Pair a b = Pair { getPair :: (b, a) }
-- newtype Pair b a = Pair { getPair :: (a, b) }
instance Functor (Pair c) where
  fmap f (Pair (x, y)) = Pair (f x, y)
  
-- 使用 data 关键字是为了定义自己的型别。他们可以在 algebraic data type 中放任意数量的构造子跟字段。可以定义的东西从 list, Maybe 到 tree。
-- 如果你只是希望你的 type signature 看起来比较干净，你可以只需要 type synonym。如果你想要将现有的型别包起来并定义成一个 type class 的 instance，你可以尝试使用 newtype。如果你想要定义完全新的型别，那你应该使用 data 关键字。


newtype Any = Any { getAny :: Bool }  
    deriving (Eq, Ord, Read, Show, Bounded)

instance Monoid Any where  
    mempty = Any False  
    Any x `mappend` Any y = Any (x || y)


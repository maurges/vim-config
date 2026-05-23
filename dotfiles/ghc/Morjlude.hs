{-# LANGUAGE FunctionalDependencies, FlexibleInstances #-}
module Morjlude
    ( egcd, modInverse
    , showHex
    , unwrap
    ) where

import qualified Numeric

showHex :: Integral a => a -> String
showHex a = Numeric.showHex a ""

egcd :: Integer -> Integer -> (Integer, Integer, Integer)
egcd a 0 = (a, 1, 0)
egcd a m = (g, y, x - (a `div` m) * y)
  where
    (g, x, y) = egcd m (a `mod` m)

modInverse :: Integer -> Integer -> Maybe Integer
modInverse a m
    | m <= 0  = Nothing
    | g /= 1  = Nothing -- not coprime
    | otherwise  = Just $ (x `mod` m + m) `mod` m
    where
        (g, x, _) = egcd a m

class Unwrap w a | w -> a where
    unwrap :: w -> a

instance Unwrap (Maybe a) a where
    unwrap Nothing = error "Nothing"
    unwrap (Just x) = x

instance Show e => Unwrap (Either e a) a where
    unwrap (Left e) = error $ "Left: " <> show e
    unwrap (Right x) = x

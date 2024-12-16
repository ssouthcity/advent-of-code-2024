{-# OPTIONS_GHC -Wno-type-defaults #-}

module Vec2 where

type Vec2 = (Int, Int)

zero :: Vec2
zero = (0, 0)

north :: Vec2
north = (0, -1)

east :: Vec2
east = (1, 0)

south :: Vec2
south = (0, 1)

west :: Vec2
west = (-1, 0)

add :: Vec2 -> Vec2 -> Vec2
add (x, y) (x', y') = (x + x', y + y')

normalize :: Vec2 -> Vec2
normalize (x, y) = (normalize' x, normalize' y)
  where
    normalize' n
      | n > 0 = 1
      | n < 0 = -1
      | otherwise = 0

distance :: Vec2 -> Vec2 -> Float
distance (x, y) (x', y') = sqrt $ fromIntegral ((x - x') ^ 2 + (y - y') ^ 2)

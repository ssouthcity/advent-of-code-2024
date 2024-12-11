module Day11 where

import Data.MemoTrie

digits :: Int -> Int
digits 0 = 1
digits n = floor (logBase (10 :: Double) (fromIntegral (abs n))) + 1

splitNumber :: Int -> (Int, Int)
splitNumber x = (x `div` divisor, x `mod` divisor)
  where
    divisor = 10 ^ (digits x `div` 2)

blink :: Int -> [Int]
blink 0 = [1]
blink n
  | (even . digits) n = let (x, y) = splitNumber n in [x, y]
blink n = [n * 2024]

blinkTrie :: Int -> Int -> Int
blinkTrie = memo2 go
  where
    go 0 _ = 1
    go iters n = sum $ blinkTrie (iters - 1) <$> blink n

blinks :: Int -> [Int] -> Int
blinks n = sum . map (blinkTrie n)

solvePart1 :: String -> String
solvePart1 = show . blinks 25 . map read . words

solvePart2 :: String -> String
solvePart2 = show . blinks 75 . map read . words

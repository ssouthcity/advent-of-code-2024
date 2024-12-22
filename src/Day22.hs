module Day22 where

import Data.Bits (xor)
import Data.Function (on)
import Data.List (groupBy, sortOn, tails)
import qualified Data.Map as Map

mix :: Int -> Int -> Int
mix x y = x `xor` y

prune :: Int -> Int
prune x = x `mod` magicPruneNum
  where
    magicPruneNum = 16777216

generateSecretNumber :: Int -> Int
generateSecretNumber x = x'''
  where
    x' = prune $ mix (x * 64) x
    x'' = prune $ mix (x' `div` 32) x'
    x''' = prune $ mix (x'' * 2048) x''

lastDigit :: Int -> Int
lastDigit n = abs n `mod` 10

diffs :: [Int] -> [Int]
diffs xs = zipWith (-) (tail xs) xs

groupsOfN :: Int -> [a] -> [[a]]
groupsOfN n xs = [take n (drop x xs) | x <- [0 .. length xs - n]]

zipWithDiffs :: [Int] -> [([Int], Int)]
zipWithDiffs xs = zip (replicate 4 [] ++ map (take 4) (tails (diffs xs))) xs

sumSameSequences :: [(Char, Int)] -> [(Char, Int)]
sumSameSequences xs = map sumGroup grouped
  where
    grouped = groupBy ((==) `on` fst) (sortOn fst xs)
    sumGroup grp = (fst (head grp), sum (map snd grp))

solvePart1 :: String -> String
solvePart1 = show . sum . map (last . take 2001 . iterate generateSecretNumber . read) . lines

solvePart2 :: String -> String
solvePart2 = show . maximum . foldr (Map.unionWith (+) . Map.delete [] . Map.fromList . reverse . zipWithDiffs . map lastDigit . take 2001 . iterate generateSecretNumber . read) Map.empty . lines

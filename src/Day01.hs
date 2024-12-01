module Day01 where

import Data.List (group, sort)
import Data.Maybe (fromMaybe)

parseInput :: String -> ([Int], [Int])
parseInput input =
  let matrix = map (map read . words) (lines input)
      pairs = [(x, y) | [x, y] <- matrix]
   in unzip pairs

solvePart1 :: String -> String
solvePart1 input =
  let (left, right) = parseInput input
      diffs = zipWith (-) (sort left) (sort right)
   in show $ sum $ map abs diffs

solvePart2 :: String -> String
solvePart2 input =
  let (left, right) = parseInput input
      occurances = map (\xs -> (head xs, length xs)) $ group $ sort right
      weightedOccurance x = x * fromMaybe 0 (lookup x occurances)
   in show $ sum $ map weightedOccurance left

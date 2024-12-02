module Day02 where

parseInput :: String -> [[Int]]
parseInput input = map (map read . words) (lines input)

isSafe :: [Int] -> Bool
isSafe xs =
  let diffs = zipWith (-) xs (tail xs)
      inRange x = x >= 1 && x <= 3
      allSorted = all (> 0) diffs || all (< 0) diffs
   in allSorted && all (inRange . abs) diffs

removeOne :: [a] -> [[a]]
removeOne xs = [take i xs ++ drop (i + 1) xs | i <- [0 .. length xs - 1]]

solvePart1 :: String -> String
solvePart1 input =
  show . length . filter isSafe $ parseInput input

solvePart2 :: String -> String
solvePart2 input =
  show . length . filter (any isSafe . removeOne) $ parseInput input

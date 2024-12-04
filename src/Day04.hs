module Day04 where

import Data.List (isPrefixOf, tails, transpose)

parseInput :: String -> [String]
parseInput = lines

diagonals [] = []
diagonals ([] : xss) = xss
diagonals xss =
  zipWith
    (++)
    (map ((: []) . head) xss ++ repeat [])
    ([] : diagonals (map tail xss))

countInList :: (Eq a) => [a] -> [a] -> Int
countInList seq xs = length $ filter (seq `isPrefixOf`) (tails xs)

rotate :: [[a]] -> [[a]]
rotate = reverse . transpose

countInMatrix :: (Eq a) => [a] -> [[a]] -> Int
countInMatrix seq matrix =
  sum (map (countInList seq) matrix) -- Horizontally
    + sum (map (countInList seq . reverse) matrix) -- Horizontally Reverse
    + sum (map (countInList seq) (transpose matrix)) -- Vertically
    + sum (map (countInList seq . reverse) (transpose matrix)) -- Vertically Reverse
    + sum (map (countInList seq) (diagonals matrix)) -- Bottom Left to Top Right
    + sum (map (countInList seq . reverse) (diagonals matrix)) -- Bottom Left to Top Right Reverse
    + sum (map (countInList seq) (diagonals $ rotate matrix)) -- Top Left to Bottom Right
    + sum (map (countInList seq . reverse) (diagonals $ rotate matrix)) -- Top Left to Bottom Right Reverse

patterns :: [[(Int, Int, Char)]]
patterns =
  [ [(-1, -1, 'M'), (0, 0, 'A'), (1, 1, 'S'), (-1, 1, 'S'), (1, -1, 'M')],
    [(-1, -1, 'M'), (0, 0, 'A'), (1, 1, 'S'), (-1, 1, 'M'), (1, -1, 'S')],
    [(-1, -1, 'S'), (0, 0, 'A'), (1, 1, 'M'), (-1, 1, 'S'), (1, -1, 'M')],
    [(-1, -1, 'S'), (0, 0, 'A'), (1, 1, 'M'), (-1, 1, 'M'), (1, -1, 'S')]
  ]

isXmas :: [[Char]] -> Int -> Int -> Bool
isXmas matrix i j = any (all (\(di, dj, c) -> isValid matrix (i + di) (j + dj) c)) patterns
  where
    isValid matrix i j c = i >= 0 && j >= 0 && i < length matrix && j < length (head matrix) && matrix !! i !! j == c

allXmas :: [String] -> [(Int, Int)]
allXmas matrix =
  [ (i, j) | i <- [1 .. length matrix - 2], j <- [1 .. length (head matrix) - 2], isXmas matrix i j
  ]

solvePart1 :: String -> String
solvePart1 input =
  let parsed = parseInput input
      word = "XMAS"
   in show $ countInMatrix word parsed

solvePart2 :: String -> String
solvePart2 input =
  let parsed = parseInput input
   in show $ length $ allXmas parsed

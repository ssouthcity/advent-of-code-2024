module Day08 where

import Data.List (nub, subsequences)

type Coord = (Int, Int)

parseInput :: String -> (Coord, [(Char, [Coord])])
parseInput input =
  let uniqueChars = nub . filter (not . (`elem` ".\n"))
      matrix = lines input
      bounds = (length $ head matrix, length matrix)
      nodes = [(c, [(x, y) | (y, row) <- zip [0 ..] matrix, (x, cell) <- zip [0 ..] row, cell == c]) | c <- uniqueChars input]
   in (bounds, nodes)

everyCombo2 :: [a] -> [(a, a)]
everyCombo2 xs = concatMap toPair (filter ((== 2) . length) (subsequences xs))
  where
    toPair [x, y] = [(x, y), (y, x)]
    toPair _ = []

inBounds :: Coord -> Coord -> Bool
inBounds (maxX, maxY) (x, y) = x >= 0 && x < maxX && y >= 0 && y < maxY

resonance :: Coord -> Coord -> [Coord]
resonance original@(x, y) (a, b) =
  let diffX = a - x
      diffY = b - y
      antinode = (x - diffX, y - diffY)
   in antinode : resonance antinode original

solvePart1 :: String -> String
solvePart1 input =
  let (bounds, nodes) = parseInput input
   in show $ length $ nub $ concatMap (concatMap (filter (inBounds bounds) . take 1 . uncurry resonance) . everyCombo2 . snd) nodes

solvePart2 :: String -> String
solvePart2 input =
  let (bounds, nodes) = parseInput input
      resonance' (a, b) = a : b : takeWhile (inBounds bounds) (resonance a b)
   in show $ length $ nub $ concatMap (concatMap resonance' . everyCombo2 . snd) nodes

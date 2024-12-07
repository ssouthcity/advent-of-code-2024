{-# LANGUAGE TupleSections #-}

module Day06 where

import Data.List as List
import Data.Set as Set

type Coord = (Int, Int)

data Dir = N | E | S | W deriving (Eq, Ord, Show, Enum, Bounded)

clockwise :: Dir -> Dir
clockwise d = if d == maxBound then minBound else succ d

move :: Dir -> Coord -> Coord
move N (x, y) = (x, y - 1)
move E (x, y) = (x + 1, y)
move S (x, y) = (x, y + 1)
move W (x, y) = (x - 1, y)

parseInput :: String -> (Set Coord, Coord, Dir, Coord)
parseInput input = (obstacles, bounds, guardDir, guardPos)
  where
    matrix = lines input
    obstacles = fromList [(x, y) | (y, row) <- zip [0 ..] matrix, (x, char) <- zip [0 ..] row, char == '#']
    bounds = (length $ head matrix, length matrix)
    guardDir = N
    guardPos = head [(x, y) | (y, row) <- zip [0 ..] matrix, (x, char) <- zip [0 ..] row, char == '^']

inBounds :: Coord -> Coord -> Bool
inBounds (cols, rows) (x, y) = x >= 0 && x < cols && y >= 0 && y < rows

isFacingObstacle :: Set Coord -> Dir -> Coord -> Bool
isFacingObstacle obstacles dir pos = move dir pos `member` obstacles

patrol :: (Set Coord, Coord, Dir, Coord) -> [(Coord, Dir)]
patrol (obstacles, bounds, dir, pos)
  | outOfBounds = []
  | facingObstacle = (pos, dir) : patrol (obstacles, bounds, clockwise dir, pos)
  | otherwise = (pos, dir) : patrol (obstacles, bounds, dir, nextPos)
  where
    nextPos = move dir pos
    outOfBounds = not (inBounds bounds pos)
    facingObstacle = nextPos `member` obstacles

traps :: (Set Coord, Coord, Dir, Coord) -> [Coord]
traps state@(obstacles, bounds, _, _) = List.map (\p -> move (snd (head p)) (fst (head p))) $ List.filter go $ backtrackPatrol state
  where
    backtrackPatrol = tails . reverse . patrol
    moveUntilObstacle dir pos = takeWhile (\p -> inBounds bounds p && not (p `member` obstacles)) (iterate (move dir) pos)
    go ((pos', dir') : xs) = any (`elem` xs) fakePath
      where
        fakePath = List.map (,clockwise dir') $ moveUntilObstacle (clockwise dir') pos'
    go _ = False

test (obstacles, bounds, dir, pos) = isFacingObstacle obstacles E (myMove pos)
  where
    myMove = move N . move N . move N . move N . move N . move E . move E . move E . move E

solvePart1 :: String -> String
solvePart1 = show . length . nub . List.map fst . patrol . parseInput

solvePart2 :: String -> String
solvePart2 = show . length . nub . traps . parseInput

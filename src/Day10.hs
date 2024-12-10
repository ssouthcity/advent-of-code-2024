module Day10 where

import Data.Char (digitToInt)
import Data.List (nub)

type TopoMap = [[Int]]

type Coord = (Int, Int)

topomap :: String -> TopoMap
topomap = map (map digitToInt) . lines

trailheads :: TopoMap -> [Coord]
trailheads topo = [(x, y) | (y, row) <- zip [0 ..] topo, (x, h) <- zip [0 ..] row, h == 0]

bounds :: TopoMap -> Coord
bounds topo = (length (head topo), length topo)

inBounds :: Coord -> Coord -> Bool
inBounds (maxX, maxY) (x, y) = x >= 0 && x < maxX && y >= 0 && y < maxY

adjacents :: TopoMap -> Coord -> [Coord]
adjacents tmap (x, y) = filter (inBounds (bounds tmap)) [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)]

isPlusOne :: TopoMap -> Coord -> Coord -> Bool
isPlusOne tmap (a, b) (c, d) = (tmap !! d !! c) - (tmap !! b !! a) == 1

reachablePeaks :: TopoMap -> Coord -> [Coord]
reachablePeaks tmap current@(x, y)
  | tmap !! y !! x == 9 = [current]
  | otherwise = concatMap (reachablePeaks tmap) $ filter (isPlusOne tmap current) (adjacents tmap current)

trailscore :: TopoMap -> Coord -> Int
trailscore tmap trail = length . nub $ reachablePeaks tmap trail

solvePart1 :: String -> String
solvePart1 input =
  let tmap = topomap input
   in show $ sum $ map (trailscore tmap) $ trailheads tmap

solvePart2 :: String -> String
solvePart2 input = "unimplemented"

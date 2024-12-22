module Day14 where

import Data.Attoparsec.Text hiding (take)
import Data.Either (fromRight)
import Data.Function (on)
import Data.Functor
import Data.List (group, minimumBy, sort)
import Data.Maybe (mapMaybe)
import Data.Ord (comparing)
import qualified Data.Set as Set
import Data.Text (pack)
import Vec2 (Vec2)
import qualified Vec2

data Robot = Robot
  { position :: Vec2,
    velocity :: Vec2
  }
  deriving (Show, Eq)

signedDecimal :: Parser Int
signedDecimal = do
  sign <- option 1 (char '-' $> -1)
  num <- decimal
  return $ sign * num

vec2Parser :: Parser Vec2
vec2Parser = do
  x <- signedDecimal
  _ <- char ','
  y <- signedDecimal
  return (x, y)

robotParser :: Parser Robot
robotParser = do
  _ <- char 'p'
  _ <- char '='
  p <- vec2Parser
  _ <- skipSpace
  _ <- char 'v'
  _ <- char '='
  v <- vec2Parser
  return Robot {position = p, velocity = v}

robotsParser :: Parser [Robot]
robotsParser = robotParser `sepBy` endOfLine

addVec2s :: Vec2 -> Vec2 -> Vec2
addVec2s (a, b) (c, d) = (a + c, b + d)

moveRobo :: Vec2 -> Robot -> Robot
moveRobo (maxX, maxY) robot = robot {position = (x `mod` maxX, y `mod` maxY)}
  where
    (x, y) = addVec2s (position robot) (velocity robot)

timelapse :: Vec2 -> Int -> [Robot] -> [Robot]
timelapse bs ns = map (moveRobo' ns)
  where
    moveRobo' 0 robo = robo
    moveRobo' n robo = moveRobo' (n - 1) (moveRobo bs robo)

quadrant :: Vec2 -> Vec2 -> Maybe Int
quadrant (bx, by) (x, y)
  | x == cx || y == cy = Nothing
  | x >= cx && y > cy = Just 1
  | x < cx && y >= cy = Just 2
  | x <= cx && y < cy = Just 3
  | x > cx && y <= cy = Just 4
  | otherwise = Nothing
  where
    (cx, cy) = (bx `div` 2, by `div` 2)

countQuadrants :: Vec2 -> [Vec2] -> [Int]
countQuadrants bs = map length . group . sort . mapMaybe (quadrant bs)

safetyScore :: Vec2 -> [Robot] -> Int
safetyScore bounds = product . countQuadrants bounds . map position

findTree :: Vec2 -> [Robot] -> (Int, [Robot])
findTree bounds robots = minimumBy (comparing entropy `on` snd) $ robotIterations 1 robots
  where
    timelapse' = timelapse bounds 1

    robotIterations :: Int -> [Robot] -> [(Int, [Robot])]
    robotIterations n rs
      | robots == rs' = []
      | otherwise = (n, rs') : robotIterations (n + 1) rs'
      where
        rs' = timelapse' rs

    entropy :: [Robot] -> Float
    entropy rs = sum distances
      where
        points = map position rs
        center = (fst bounds `div` 2, snd bounds `div` 2)
        distances = map (Vec2.distance center) points

-- debugging function
renderMap :: Vec2 -> [Robot] -> String
renderMap (width, height) robots = unlines [[if (x, y) `Set.member` positions then '#' else '.' | x <- [0 .. width - 1]] | y <- [0 .. height - 1]]
  where
    positions = Set.fromList $ map position robots

solvePart1 :: String -> String
solvePart1 input = show $ safetyScore bounds $ timelapse bounds 100 robots
  where
    robots = fromRight (error "") (parseOnly robotsParser (pack input))
    bounds = (101, 103)

solvePart2 :: String -> String
solvePart2 input = show $ fst $ findTree bounds robots
  where
    robots = fromRight (error "") (parseOnly robotsParser (pack input))
    bounds = (101, 103)

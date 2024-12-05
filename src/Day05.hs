module Day05 where

import Data.Attoparsec.Text hiding (take)
import Data.Either (fromRight)
import Data.Graph (buildG, topSort)
import qualified Data.Map as Map
import Data.Text (pack)

-- Type Definitions
type Rule = (Int, Int)

type Print = [Int]

-- Parsers
ruleParser :: Parser Rule
ruleParser = do
  before <- decimal
  _ <- char '|'
  after <- decimal
  return (before, after)

printParser :: Parser Print
printParser = decimal `sepBy` char ','

inputParser :: Parser ([Rule], [Print])
inputParser = do
  rules <- ruleParser `sepBy` endOfLine
  _ <- endOfLine
  prints <- printParser `sepBy` endOfLine
  return (rules, filter (not . null) prints)

findRules :: [Rule] -> Int -> [Int]
findRules rules page = [after | (before, after) <- rules, before == page]

median :: [a] -> a
median xs = xs !! (length xs `div` 2)

isCorrectOrder :: [Rule] -> Print -> Bool
isCorrectOrder rules pages = all checkOrder (zip [0 ..] pages)
  where
    checkOrder (i, x) = all (`notElem` findRules rules x) (take i pages)

topologicalSort :: (Int -> [Int]) -> [Int] -> [Int]
topologicalSort getRules xs =
  let nodeIndices = Map.fromList (zip xs [0 ..])
      toIndex n = Map.lookup n nodeIndices
      edges = [(from, to) | x <- xs, y <- getRules x, Just from <- [toIndex y], Just to <- [toIndex x]]
      graph = buildG (0, length xs - 1) edges
   in map (xs !!) (topSort graph)

solvePart1 :: String -> String
solvePart1 input =
  let result = fromRight (error "Unable to parse input") (parseOnly inputParser (pack input))
      (rules, prints) = result
   in show $ sum $ map median $ filter (isCorrectOrder rules) prints

solvePart2 :: String -> String
solvePart2 input =
  let result = fromRight (error "Unable to parse input") (parseOnly inputParser (pack input))
      (rules, prints) = result
   in show $ sum $ map (median . topologicalSort (findRules rules)) (filter (not . isCorrectOrder rules) prints)

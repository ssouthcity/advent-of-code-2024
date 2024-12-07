module Day07 where

import Data.Attoparsec.Text
import Data.Either (fromRight)
import Data.Text (pack)

type Operator = Int -> Int -> Int

type Equation = (Int, [Int])

cat :: Operator
cat x y = read (show x ++ show y)

parseEquation :: Parser Equation
parseEquation = do
  answer <- decimal
  _ <- char ':'
  _ <- char ' '
  members <- decimal `sepBy` char ' '
  return (answer, members)

parseEquations :: Parser [Equation]
parseEquations = parseEquation `sepBy` endOfLine

mustParseEquations :: String -> [Equation]
mustParseEquations = fromRight (error "Unexpected parsing failure") . parseOnly parseEquations . pack

isCalibrateable :: [Operator] -> Equation -> Bool
isCalibrateable _ (_, []) = False
isCalibrateable _ (x, [y]) = x == y
isCalibrateable ops (answer, x : y : xs) =
  any (\op -> isCalibrateable ops (answer, op x y : xs)) ops

totalCalibrationResult :: [Operator] -> [Equation] -> Int
totalCalibrationResult ops = sum . map fst . filter (isCalibrateable ops)

solvePart1 :: String -> String
solvePart1 = show . totalCalibrationResult [(+), (*)] . mustParseEquations

solvePart2 :: String -> String
solvePart2 = show . totalCalibrationResult [(+), (*), cat] . mustParseEquations

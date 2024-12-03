{-# LANGUAGE OverloadedStrings #-}

module Day03 where

import Control.Applicative
import Data.Attoparsec.Text
import Data.Either (fromRight)
import Data.Text (Text, pack)

doParser :: Parser (Text, Int, Int)
doParser = do
  op <- string "do"
  _ <- char '('
  _ <- char ')'
  return (op, 0, 0)

dontParser :: Parser (Text, Int, Int)
dontParser = do
  op <- string "don't"
  _ <- char '('
  _ <- char ')'
  return (op, 0, 0)

mulParser :: Parser (Text, Int, Int)
mulParser = do
  op <- string "mul"
  _ <- char '('
  x <- decimal
  _ <- char ','
  y <- decimal
  _ <- char ')'
  return (op, x, y)

opParser :: Parser (Text, Int, Int)
opParser =
  mulParser
    <|> doParser
    <|> dontParser

tryOpParser :: Parser (Text, Int, Int)
tryOpParser = opParser <|> (anyChar *> tryOpParser)

manyOpParser :: Parser [(Text, Int, Int)]
manyOpParser = many' tryOpParser

calculateMults :: [(Text, Int, Int)] -> Int
calculateMults ops = go ops 0
  where
    go [] total = total
    go (("mul", x, y) : ops') total = go ops' total + x * y
    go (_ : ops') total = go ops' total

calculateOps :: [(Text, Int, Int)] -> Int
calculateOps ops = go ops True 0
  where
    go [] _ total = total
    go (("don't", _, _) : ops') _ total = go ops' False total
    go (("do", _, _) : ops') _ total = go ops' True total
    go (("mul", _, _) : ops') False total = go ops' False total
    go (("mul", x, y) : ops') True total = go ops' True total + x * y
    go (_ : ops') ignore total = go ops' ignore total

solvePart1 :: String -> String
solvePart1 input =
  let parsed = parseOnly manyOpParser (pack input)
      ops = fromRight (error "parsing failed") parsed
   in show $ calculateMults ops

solvePart2 :: String -> String
solvePart2 input =
  let parsed = parseOnly manyOpParser (pack input)
      ops = fromRight (error "parsing failed") parsed
   in show $ calculateOps ops

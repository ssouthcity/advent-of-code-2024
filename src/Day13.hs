{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module Day13 where

import Control.Applicative
import Data.Attoparsec.Text
import Data.Text (pack)

type Vec2 = (Int, Int)

data Game = Game
  { buttonA :: Vec2,
    buttonB :: Vec2,
    prize :: Vec2
  }
  deriving (Show, Eq)

vec2Parser :: Parser Vec2
vec2Parser = do
  _ <- char 'X'
  _ <- char '+' <|> char '='
  x <- decimal
  _ <- string ", Y"
  _ <- char '+' <|> char '='
  y <- decimal
  return (x, y)

gameParser :: Parser Game
gameParser = do
  _ <- string "Button A: "
  a <- vec2Parser
  _ <- endOfLine

  _ <- string "Button B: "
  b <- vec2Parser
  _ <- endOfLine

  _ <- string "Prize: "
  p <- vec2Parser
  _ <- endOfLine

  return $ Game a b p

gamesParser :: Parser [Game]
gamesParser = gameParser `sepBy` skipMany1 endOfLine

crossProduct :: Vec2 -> Vec2 -> Int
crossProduct (ax, ay) (bx, by) = ay * bx - ax * by

factorize :: Vec2 -> Vec2 -> Vec2 -> Maybe Vec2
factorize a@(ax, _) b@(bx, _) p@(px, _)
  | r == 0 = Just (x, y)
  | otherwise = Nothing
  where
    (y, r1) = crossProduct a p `divMod` crossProduct a b
    (x, r2) = (px - bx * y) `divMod` ax
    r = r1 + r2

factorizeGame :: Game -> Maybe Vec2
factorizeGame game = factorize (buttonA game) (buttonB game) (prize game)

sumOfGame :: Maybe Vec2 -> Int
sumOfGame v = case v of
  Just (x, y) -> x * 3 + y
  Nothing -> 0

increasePrizes :: Game -> Game
increasePrizes game = game {prize = (x + 10 ^ 13, y + 10 ^ 13)}
  where
    (x, y) = prize game

solvePart1 :: String -> String
solvePart1 input =
  case parseOnly gamesParser (pack input) of
    Left err -> show $ "Parsing error: " ++ err
    Right game -> show $ sum $ map (sumOfGame . factorizeGame) game

solvePart2 :: String -> String
solvePart2 input =
  case parseOnly gamesParser (pack input) of
    Left err -> show $ "Parsing error: " ++ err
    Right game -> show $ sum $ map (sumOfGame . factorizeGame . increasePrizes) game

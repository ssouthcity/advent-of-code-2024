module Day06Spec (tests) where

import qualified Day06
import Test.HUnit

sample :: String
sample =
  unlines
    [ "....#.....",
      ".........#",
      "..........",
      "..#.......",
      ".......#..",
      "..........",
      ".#..^.....",
      "........#.",
      "#.........",
      "......#..."
    ]

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "41"
   in TestCase $ assertEqual "" answer $ Day06.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = sample
      answer = "6"
   in TestCase $ assertEqual "" answer $ Day06.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 06 - Part 1" testPart1,
      TestLabel "Day 06 - Part 2" testPart2
    ]

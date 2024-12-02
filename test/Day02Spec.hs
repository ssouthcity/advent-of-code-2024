module Day02Spec (tests) where

import qualified Day02
import Test.HUnit

sample :: String
sample =
  unlines
    [ "7 6 4 2 1",
      "1 2 7 8 9",
      "9 7 6 2 1",
      "1 3 2 4 5",
      "8 6 4 4 1",
      "1 3 6 7 9"
    ]

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "2"
   in TestCase $ assertEqual "" answer $ Day02.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = sample
      answer = "4"
   in TestCase $ assertEqual "" answer $ Day02.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 02 - Part 1" testPart1,
      TestLabel "Day 02 - Part 2" testPart2
    ]

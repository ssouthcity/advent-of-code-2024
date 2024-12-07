module Day07Spec (tests) where

import qualified Day07
import Test.HUnit

sample :: String
sample =
  unlines
    [ "190: 10 19",
      "3267: 81 40 27",
      "83: 17 5",
      "156: 15 6",
      "7290: 6 8 6 15",
      "161011: 16 10 13",
      "192: 17 8 14",
      "21037: 9 7 18 13",
      "292: 11 6 16 20"
    ]

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "3749"
   in TestCase $ assertEqual "" answer $ Day07.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = sample
      answer = "11387"
   in TestCase $ assertEqual "" answer $ Day07.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 07 - Part 1" testPart1,
      TestLabel "Day 07 - Part 2" testPart2
    ]

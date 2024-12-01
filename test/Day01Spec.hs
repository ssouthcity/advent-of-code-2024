module Day01Spec (tests) where

import qualified Day01
import Test.HUnit

exampleList :: String
exampleList =
  unlines
    [ "3   4",
      "4   3",
      "2   5",
      "1   3",
      "3   9",
      "3   3"
    ]

testPart1 :: Test
testPart1 =
  let input = exampleList
      answer = "11"
   in TestCase $ assertEqual "" answer $ Day01.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = exampleList
      answer = "31"
   in TestCase $ assertEqual "" answer $ Day01.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 01 - Part 1" testPart1,
      TestLabel "Day 01 - Part 2" testPart2
    ]

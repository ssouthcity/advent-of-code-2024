module Day14Spec (tests) where

import qualified Day14
import Test.HUnit

sample :: String
sample =
  unlines
    [ "p=0,4 v=3,-3",
      "p=6,3 v=-1,-3",
      "p=10,3 v=-1,2",
      "p=2,0 v=2,-1",
      "p=0,0 v=1,3",
      "p=3,0 v=-2,-2",
      "p=7,6 v=-1,-3",
      "p=3,0 v=-1,-2",
      "p=9,3 v=2,3",
      "p=7,3 v=-1,2",
      "p=2,4 v=2,-3",
      "p=9,5 v=-3,-3"
    ]

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "12"
   in TestCase $ assertEqual "" answer $ Day14.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day14.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 14 - Part 1" testPart1,
      TestLabel "Day 14 - Part 2" testPart2
    ]

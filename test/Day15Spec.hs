module Day15Spec (tests) where

import qualified Day15
import Test.HUnit

testPart1 :: Test
testPart1 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day15.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day15.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 15 - Part 1" testPart1,
      TestLabel "Day 15 - Part 2" testPart2
    ]

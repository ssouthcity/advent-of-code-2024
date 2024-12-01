module Day07Spec (tests) where

import qualified Day07
import Test.HUnit

testPart1 :: Test
testPart1 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day07.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day07.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 07 - Part 1" testPart1,
      TestLabel "Day 07 - Part 2" testPart2
    ]

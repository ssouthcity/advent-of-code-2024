module Day23Spec (tests) where

import qualified Day23
import Test.HUnit

testPart1 :: Test
testPart1 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day23.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day23.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 23 - Part 1" testPart1,
      TestLabel "Day 23 - Part 2" testPart2
    ]

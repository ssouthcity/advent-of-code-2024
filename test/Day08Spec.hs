module Day08Spec (tests) where

import qualified Day08
import Test.HUnit

testPart1 :: Test
testPart1 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day08.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = ""
      answer = "unimplemented"
   in TestCase $ assertEqual "" answer $ Day08.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 08 - Part 1" testPart1,
      TestLabel "Day 08 - Part 2" testPart2
    ]

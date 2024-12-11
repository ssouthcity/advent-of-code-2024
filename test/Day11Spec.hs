module Day11Spec (tests) where

import qualified Day11
import Test.HUnit

sample :: String
sample = "125 17"

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "55312"
   in TestCase $ assertEqual "" answer $ Day11.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = sample
      answer = "65601038650482"
   in TestCase $ assertEqual "" answer $ Day11.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 11 - Part 1" testPart1,
      TestLabel "Day 11 - Part 2" testPart2
    ]

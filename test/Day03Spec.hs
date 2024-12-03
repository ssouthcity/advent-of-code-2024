module Day03Spec (tests) where

import qualified Day03
import Test.HUnit

testPart1 :: Test
testPart1 =
  let input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
      answer = "161"
   in TestCase $ assertEqual "" answer $ Day03.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      answer = "48"
   in TestCase $ assertEqual "" answer $ Day03.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 03 - Part 1" testPart1,
      TestLabel "Day 03 - Part 2" testPart2
    ]

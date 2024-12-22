module Day14Spec (tests) where

import Test.HUnit

testPart1 :: Test
testPart1 =
  let input = "untestable"
      answer = "untestable"
   in TestCase $ assertEqual "" answer input

testPart2 :: Test
testPart2 =
  let input = "untestable"
      answer = "untestable"
   in TestCase $ assertEqual "" answer input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 14 - Part 1" testPart1,
      TestLabel "Day 14 - Part 2" testPart2
    ]

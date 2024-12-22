module Day22Spec (tests) where

import qualified Day22
import Input
import Test.HUnit

testPart1 :: Test
testPart1 = TestCase $ do
  input <- readSampleInputForDay 22
  let answer = "37327623"
  assertEqual "" answer $ Day22.solvePart1 input

testPart2 :: Test
testPart2 = TestCase $ do
  input <- readSampleInputForDay 22
  let answer = "24"
  assertEqual "" answer $ Day22.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 22 - Part 1" testPart1,
      TestLabel "Day 22 - Part 2" testPart2
    ]

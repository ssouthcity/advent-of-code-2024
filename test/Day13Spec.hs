module Day13Spec (tests) where

import qualified Day13
import Test.HUnit

sample :: String
sample =
  unlines
    [ "Button A: X+94, Y+34",
      "Button B: X+22, Y+67",
      "Prize: X=8400, Y=5400",
      "",
      "Button A: X+26, Y+66",
      "Button B: X+67, Y+21",
      "Prize: X=12748, Y=12176",
      "",
      "Button A: X+17, Y+86",
      "Button B: X+84, Y+37",
      "Prize: X=7870, Y=6450",
      "",
      "Button A: X+69, Y+23",
      "Button B: X+27, Y+71",
      "Prize: X=18641, Y=10279"
    ]

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "480"
   in TestCase $ assertEqual "" answer $ Day13.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = sample
      answer = "875318608908"
   in TestCase $ assertEqual "" answer $ Day13.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 13 - Part 1" testPart1,
      TestLabel "Day 13 - Part 2" testPart2
    ]

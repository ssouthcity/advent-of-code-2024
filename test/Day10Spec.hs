module Day10Spec (tests) where

import qualified Day10
import Test.HUnit

sample :: String
sample =
  unlines
    [ "89010123",
      "78121874",
      "87430965",
      "96549874",
      "45678903",
      "32019012",
      "01329801",
      "10456732"
    ]

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "36"
   in TestCase $ assertEqual "" answer $ Day10.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = sample
      answer = "81"
   in TestCase $ assertEqual "" answer $ Day10.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 10 - Part 1" testPart1,
      TestLabel "Day 10 - Part 2" testPart2
    ]

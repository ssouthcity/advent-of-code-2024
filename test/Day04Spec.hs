module Day04Spec (tests) where

import qualified Day04
import Test.HUnit

sample :: String
sample =
  unlines
    [ "MMMSXXMASM",
      "MSAMXMSMSA",
      "AMXSXMAAMM",
      "MSAMASMSMX",
      "XMASAMXAMM",
      "XXAMMXXAMA",
      "SMSMSASXSS",
      "SAXAMASAAA",
      "MAMMMXMMMM",
      "MXMXAXMASX"
    ]

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "18"
   in TestCase $ assertEqual "" answer $ Day04.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = sample
      answer = "9"
   in TestCase $ assertEqual "" answer $ Day04.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 04 - Part 1" testPart1,
      TestLabel "Day 04 - Part 2" testPart2
    ]

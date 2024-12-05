module Day05Spec (tests) where

import qualified Day05
import Test.HUnit

sample :: String
sample =
  unlines
    [ "47|53",
      "97|13",
      "97|61",
      "97|47",
      "75|29",
      "61|13",
      "75|53",
      "29|13",
      "97|29",
      "53|29",
      "61|53",
      "97|53",
      "61|29",
      "47|13",
      "75|47",
      "97|75",
      "47|61",
      "75|61",
      "47|29",
      "75|13",
      "53|13",
      "75,47,61,53,29",
      "97,61,53,29,13",
      "75,29,13",
      "75,97,47,61,53",
      "61,13,29",
      "97,13,75,29,47"
    ]

testPart1 :: Test
testPart1 =
  let input = sample
      answer = "143"
   in TestCase $ assertEqual "" answer $ Day05.solvePart1 input

testPart2 :: Test
testPart2 =
  let input = sample
      answer = "123"
   in TestCase $ assertEqual "" answer $ Day05.solvePart2 input

tests :: Test
tests =
  TestList
    [ TestLabel "Day 05 - Part 1" testPart1,
      TestLabel "Day 05 - Part 2" testPart2
    ]

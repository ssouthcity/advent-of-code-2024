module Main (main) where

import qualified Day01Spec
import qualified Day02Spec
import qualified Day03Spec
import qualified Day04Spec
import qualified Day05Spec
import qualified Day06Spec
import qualified Day07Spec
import qualified Day08Spec
import qualified Day09Spec
import qualified Day10Spec
import qualified Day11Spec
import qualified Day12Spec
import qualified Day13Spec
import qualified Day14Spec
import qualified Day15Spec
import qualified Day16Spec
import qualified Day17Spec
import qualified Day18Spec
import qualified Day19Spec
import qualified Day20Spec
import qualified Day21Spec
import qualified Day22Spec
import qualified Day23Spec
import qualified Day24Spec
import qualified Day25Spec
import Test.HUnit (Test (TestList), runTestTTAndExit)

tests :: Test
tests =
  TestList
    [ Day01Spec.tests,
      Day02Spec.tests,
      Day03Spec.tests,
      Day04Spec.tests,
      Day05Spec.tests,
      Day06Spec.tests,
      Day07Spec.tests,
      Day08Spec.tests,
      Day09Spec.tests,
      Day10Spec.tests,
      Day11Spec.tests,
      Day12Spec.tests,
      Day13Spec.tests,
      Day14Spec.tests,
      Day15Spec.tests,
      Day16Spec.tests,
      Day17Spec.tests,
      Day18Spec.tests,
      Day19Spec.tests,
      Day20Spec.tests,
      Day21Spec.tests,
      Day22Spec.tests,
      Day23Spec.tests,
      Day24Spec.tests,
      Day25Spec.tests
    ]

main :: IO ()
main = runTestTTAndExit tests

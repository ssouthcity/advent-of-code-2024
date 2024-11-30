module Solvers (solversForDay) where

import qualified Day01
import qualified Day02
import qualified Day03
import qualified Day04
import qualified Day05
import qualified Day06
import qualified Day07
import qualified Day08
import qualified Day09
import qualified Day10
import qualified Day11
import qualified Day12
import qualified Day13
import qualified Day14
import qualified Day15
import qualified Day16
import qualified Day17
import qualified Day18
import qualified Day19
import qualified Day20
import qualified Day21
import qualified Day22
import qualified Day23
import qualified Day24
import qualified Day25

solversForDay :: [(Int, (String -> String, String -> String))]
solversForDay =
  [ (01, (Day01.solvePart1, Day01.solvePart2)),
    (02, (Day02.solvePart1, Day02.solvePart2)),
    (03, (Day03.solvePart1, Day03.solvePart2)),
    (04, (Day04.solvePart1, Day04.solvePart2)),
    (05, (Day05.solvePart1, Day05.solvePart2)),
    (06, (Day06.solvePart1, Day06.solvePart2)),
    (07, (Day07.solvePart1, Day07.solvePart2)),
    (08, (Day08.solvePart1, Day08.solvePart2)),
    (09, (Day09.solvePart1, Day09.solvePart2)),
    (10, (Day10.solvePart1, Day10.solvePart2)),
    (11, (Day11.solvePart1, Day11.solvePart2)),
    (12, (Day12.solvePart1, Day12.solvePart2)),
    (13, (Day13.solvePart1, Day13.solvePart2)),
    (14, (Day14.solvePart1, Day14.solvePart2)),
    (15, (Day15.solvePart1, Day15.solvePart2)),
    (16, (Day16.solvePart1, Day16.solvePart2)),
    (17, (Day17.solvePart1, Day17.solvePart2)),
    (18, (Day18.solvePart1, Day18.solvePart2)),
    (19, (Day19.solvePart1, Day19.solvePart2)),
    (20, (Day20.solvePart1, Day20.solvePart2)),
    (21, (Day21.solvePart1, Day21.solvePart2)),
    (22, (Day22.solvePart1, Day22.solvePart2)),
    (23, (Day23.solvePart1, Day23.solvePart2)),
    (24, (Day24.solvePart1, Day24.solvePart2)),
    (25, (Day25.solvePart1, Day25.solvePart2))
  ]

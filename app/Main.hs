module Main where

import Input (readInputForDay)
import Solvers (solversForDay)
import System.Environment (getArgs)
import Text.Printf (printf)

main :: IO ()
main = do
  args <- getArgs

  let day = if null args then 1 else read (head args) :: Int

  case lookup day solversForDay of
    Just (part1, part2) -> do
      input <- readInputForDay day
      putStrLn $ printf "Day %02d" day
      putStrLn $ printf "  Part 1: %s" (part1 input)
      putStrLn $ printf "  Part 2: %s" (part2 input)
    Nothing -> do
      putStrLn $ printf "%02d is not a day of advent!" day
      putStrLn "please enter a day between 1-25"

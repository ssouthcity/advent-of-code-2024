module Input (readInputForDay, readSampleInputForDay) where

import Text.Printf (printf)

readInputForDay :: Int -> IO String
readInputForDay day = readFile $ printf "input/day%02d.txt" day

readSampleInputForDay :: Int -> IO String
readSampleInputForDay = readFile . printf "input/day%02d.sample.txt"

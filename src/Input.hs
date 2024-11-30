module Input (readInputForDay) where

import Text.Printf (printf)

readInputForDay :: Int -> IO String
readInputForDay day = readFile $ printf "input/day%02d.txt" day

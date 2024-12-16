{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}

module Day15 where

import Data.Set (Set)
import qualified Data.Set as Set
import Vec2 (Vec2)
import qualified Vec2

data Warehouse = Warehouse
  { robot :: Vec2,
    boxes :: Set Vec2,
    walls :: Set Vec2
  }
  deriving (Show)

parseWarehouse :: [String] -> Warehouse
parseWarehouse grid = Warehouse {robot, boxes, walls}
  where
    chars = [((x, y), c) | (y, row) <- zip [0 ..] grid, (x, c) <- zip [0 ..] row]
    robot = head [pos | (pos, c) <- chars, c == '@']
    boxes = Set.fromList [pos | (pos, c) <- chars, c == 'O']
    walls = Set.fromList [pos | (pos, c) <- chars, c == '#']

parseInstructions :: String -> [Vec2]
parseInstructions = map $ \case
  '^' -> Vec2.north
  '>' -> Vec2.east
  'v' -> Vec2.south
  '<' -> Vec2.west
  _ -> Vec2.zero

parseInput :: String -> (Warehouse, [Vec2])
parseInput input =
  let (top, bottom) = break null (lines input)
      warehouse = parseWarehouse top
      instructions = parseInstructions (unlines $ drop 1 bottom)
   in (warehouse, instructions)

tryMoveBox :: Warehouse -> Vec2 -> Vec2 -> (Warehouse, Bool)
tryMoveBox warehouse box direction
  | box' `Set.member` walls warehouse = (warehouse, False)
  | box' `Set.member` boxes warehouse = tryMoveBox warehouse box direction'
  | otherwise = (warehouse {boxes = boxes'}, True)
  where
    box' = Vec2.add box direction
    boxes' = Set.insert box' $ Set.delete box $ boxes warehouse
    direction' = Vec2.add direction (Vec2.normalize direction)

performInstruction :: Warehouse -> Vec2 -> Warehouse
performInstruction warehouse instruction
  | robot' `Set.member` walls warehouse = warehouse
  | robot' `Set.member` boxes warehouse =
      let (warehouse', ok) = tryMoveBox warehouse robot' instruction
       in if ok then warehouse' {robot = robot'} else warehouse
  | otherwise = warehouse {robot = robot'}
  where
    robot' = Vec2.add (robot warehouse) instruction

lanternFishSum :: Warehouse -> Int
lanternFishSum = sum . Set.map (\(x, y) -> 100 * y + x) . boxes

solvePart1 :: String -> String
solvePart1 = show . lanternFishSum . uncurry (foldl performInstruction) . parseInput

solvePart2 :: String -> String
solvePart2 input = "unimplemented"

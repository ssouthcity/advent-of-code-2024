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

tryMoveBox :: Warehouse -> Vec2 -> Vec2 -> Maybe Warehouse
tryMoveBox warehouse box direction
  | box' `Set.member` walls warehouse = Nothing
  | box' `Set.member` boxes warehouse = tryMoveBox warehouse box direction'
  | otherwise = Just warehouse {boxes = boxes'}
  where
    box' = Vec2.add box direction
    boxes' = Set.insert box' $ Set.delete box $ boxes warehouse
    direction' = Vec2.add direction (Vec2.normalize direction)

performInstruction :: Warehouse -> Vec2 -> Warehouse
performInstruction warehouse instruction
  | robot' `Set.member` walls warehouse = warehouse
  | robot' `Set.member` boxes warehouse = case tryMoveBox warehouse robot' instruction of
      Just warehouse' -> warehouse' {robot = robot'}
      Nothing -> warehouse
  | otherwise = warehouse {robot = robot'}
  where
    robot' = Vec2.add (robot warehouse) instruction

lanternFishSum :: Warehouse -> Int
lanternFishSum = sum . Set.map (\(x, y) -> 100 * y + x) . boxes

expandWarehouse :: Warehouse -> Warehouse
expandWarehouse warehouse = warehouse {walls = walls', boxes = boxes'}
  where
    walls' = Set.map (Vec2.mult (2, 1)) (walls warehouse)
    boxes' = Set.map (Vec2.mult (2, 1)) (boxes warehouse)

tryMoveBox2 :: Warehouse -> Vec2 -> Vec2 -> Maybe Warehouse
tryMoveBox2 warehouse box direction
  | isWall = Nothing
  | isBox = Nothing
  | otherwise = Just warehouse {boxes = boxes'}
  where
    box' = Vec2.add box direction
    box'' = Vec2.add Vec2.east box'
    boxes' = Set.insert box' $ Set.delete box $ boxes warehouse
    isWall = box' `Set.member` walls warehouse || box'' `Set.member` walls warehouse
    isBox = box' `Set.member` boxes warehouse || box'' `Set.member` boxes warehouse

performInstruction2 :: Warehouse -> Vec2 -> Warehouse
performInstruction2 warehouse instruction
  | inWall = warehouse
  | inBox = case tryMoveBox2 warehouse robot' instruction of
      Just warehouse' -> warehouse' {robot = robot'}
      Nothing -> warehouse
  | otherwise = warehouse {robot = robot'}
  where
    robot' = Vec2.add (robot warehouse) instruction
    robot'' = Vec2.add Vec2.east robot'
    inWall = robot' `Set.member` walls warehouse || robot'' `Set.member` walls warehouse
    inBox = robot' `Set.member` boxes warehouse || robot'' `Set.member` boxes warehouse

solvePart1 :: String -> String
solvePart1 = show . lanternFishSum . uncurry (foldl performInstruction) . parseInput

solvePart2 :: String -> String
solvePart2 = show . expandWarehouse . fst . parseInput

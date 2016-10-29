-- | Countdown -- Inspired by https://www.futurelearn.com/courses/functional-programming-haskell/1/steps/120287
module Lib
  (
    -- * Domain types
    Operation
  , Solution
  , Value(..)
  -- * Exported function
  , countdown
  -- * Helper function
  , solve
  , generateSolutions
  , ops
  ) where

import Control.Arrow ((&&&))
import Data.List (subsequences, (\\))
import Data.Maybe (listToMaybe)

-- | The possible operations to reach the solution
type Operation = Int -> Int -> Int

-- | The stack of operations and numbers that will lead to a solution
type Solution = [Value]

-- | A value that can be put on the stack for execution
data Value = Op Operation | Val Int

instance Eq Value where
  (Op opx) == (Op opy) = 2 `opx` 10 == 2 `opy` 10
  (Val x) == (Val y) = x == y
  _ == _ = False

instance Show Value where
  show (Op opx) =
    let result = 2 `opx` 10
        value x | x == 2 * 10 = "*"
        value x | x == 2 + 10 = "+"
        value x | x == 2 `div` 10 = "/"
        value x | x == 2 - 10 = "-"
        value _ = "??"
    in value result
  show (Val x) = show x

-- | Give the solution for the countdown problem for the given numbers and target
countdown :: Int -- ^ The target
          -> [Int] -- ^ The numbers to use
          -> Maybe Solution -- ^ The solution
countdown target ins =
  listToMaybe
  $ map fst
  $ filter ((== Just target) . snd)
  $ map (id &&& solve)
  $ generateSolutions ins

-- | Generate all possible solutions for the given numbers
generateSolutions :: [Int] -> [Solution]
generateSolutions [] = subsequences ops
generateSolutions xs = do
  p <- tail $ subsequences xs
  o <- subsequences ops
  other <- generateSolutions $ xs \\ p
  return $ map Val p ++ o ++ other

-- | The possible operations
ops :: [Value]
ops = [Op (+), Op (-), Op (*), Op div]

-- | Calculate the result of the given Solution
solve :: Solution -> Maybe Int
solve s =
  let (sol:rest) = reduce s []
  in if null rest then Just sol else Nothing

-- | Reduce the Solution as far as possible
reduce :: Solution -> [Int] -> [Int]
reduce [] xs = xs
reduce (Val x:rest) xs = reduce rest (x:xs)
reduce (Op op:rest) (x:y:xs) = reduce rest (x `op` y:xs)
reduce _ xs = xs

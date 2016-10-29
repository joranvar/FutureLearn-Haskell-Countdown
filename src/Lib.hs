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
  ) where

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

-- | Give the solution for the countdown problem for the given numbers and target
countdown :: Int -- ^ The target
          -> [Int] -- ^ The numbers to use
          -> Maybe Solution -- ^ The solution
countdown = undefined

-- | Calculate the result of the given Solution
solve :: Solution -> Maybe Int
solve s =
  let (sol:rest) = reduce s []
  in if null rest then Just sol else Nothing

-- | Reduce the Solution as far as possible
reduce :: Solution -> [Int] -> [Int]
reduce [] xs = xs
reduce (Val x:rest) xs = reduce rest (x:xs)
reduce (Op op:rest) (x:y:xs) = reduce rest (y `op` x:xs)
reduce _ xs = xs

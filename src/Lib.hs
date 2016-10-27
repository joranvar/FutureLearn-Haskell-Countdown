-- | Countdown -- Inspired by https://www.futurelearn.com/courses/functional-programming-haskell/1/steps/120287
module Lib
  (
    -- * Domain types
    Operation(..)
  , Solution
  , Value(..)
  -- * Exported function
  , countdown
  -- * Helper function
  , solve
  ) where

-- | The possible operations to reach the solution
data Operation = Plus | Minus | Times | DivideBy

-- | The stack of operations and numbers that will lead to a solution
type Solution = [Value]

-- | A value that can be put on the stack for execution
data Value = Op Operation | Val Int

-- | Give the solution for the countdown problem for the given numbers and target
countdown :: Int -- ^ The target
          -> [Int] -- ^ The numbers to use
          -> Maybe Solution -- ^ The solution
countdown = undefined

-- | Calculate the result of the given Solution
solve :: Solution -> Maybe Int
solve = undefined

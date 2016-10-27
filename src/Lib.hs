-- | Countdown -- Inspired by https://www.futurelearn.com/courses/functional-programming-haskell/1/steps/120287
module Lib
  (
    -- * Domain types
    Operation(..)
  , Solution
  , Value(..)
  ) where

-- | The possible operations to reach the solution
data Operation = Plus | Minus | Times | DivideBy

-- | The stack of operations and numbers that will lead to a solution
type Solution = [Value]

-- | A value that can be put on the stack for execution
data Value = Op Operation | Val Int

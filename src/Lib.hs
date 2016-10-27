-- | Countdown -- Inspired by https://www.futurelearn.com/courses/functional-programming-haskell/1/steps/120287
module Lib
  (
    -- * Domain types
    Operation(..)
  ) where

-- | The possible operations to reach the solution
data Operation = Plus | Minus | Times | DivideBy

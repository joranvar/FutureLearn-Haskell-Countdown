{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.SmallCheck
import Test.SmallCheck.Series

import Lib
instance (Monad m, Enum a, Bounded a) => Serial m a where
  series = generate (\d -> take d [minBound .. maxBound])

main :: IO ()
main = defaultMain $ testGroup "all-tests" tests

tests :: [TestTree]
tests =
  [ testGroup "SmallCheck" scTests
  , testGroup "Unit tests" huTests
  ]

scTests :: [TestTree]
scTests =
  [ testProperty "id x == x" $
    \x -> id (x::Int) == x
  ]

huTests :: [TestTree]
huTests =
  [ testCase "solve [1,1,+] == Just 2" $
    solve [Val 1, Val 1, Op (+)] @?= Just 2
  , testCase "countdown 2 [1,1] == Just [1,1,+]" $
    countdown 2 [1,1] @?= Just [Val 1, Val 1, Op (+)]
  , testCase "countdown 927 [27,42,12,9,54,5] == Just [27,42,12,9,-,*,54,-,5,*,+] " $
    countdown 927 [27,42,12,9,54,5] @?= Just [Val 27, Val 42, Val 12, Val 9,Op (-), Op (*), Val 54, Op (-), Val 5, Op (*), Op (+)]
  ]

module Handler.Temp (getTempR) where

import Import

-- A standard Haskell technique for creating an infinite list of fibonacci values.
temp :: Int -> Int -> Double -> Double
temp from to temp = ft to $ ff from temp
    where
        ff 1 cels = cels + 273.15
        ff 2 farh = (farh-32.0) / 1.8 + 273.15
        ff _ kelv = kelv

        ft 1 kelv = kelv - 273.15
        ft 2 kelv = (kelv - 273.15) * 1.8 + 32.0
        ft _ kelv = kelv

getTempR :: Int -> Int -> String -> Handler Value
getTempR fr to t = return $ object ["value" .= temp fr to (read t)]
module Handler.BMI where

import Import

-- A standard Haskell technique for creating an infinite list of fibonacci values.
bmi :: Double -> Double -> Double
bmi m g = m / (g*g)

-- Unlike Handler.Home, our getFibR returns a Value result, which is the datatype
-- used for JSON values. We return our result as a JSON object, and place
-- our integral result under the "value" key.
getBmiR :: String -> String -> Handler Value
getBmiR m g = return $ object ["value" .= bmi (td m) (td g)]
    where
        td :: String -> Double
        td = read
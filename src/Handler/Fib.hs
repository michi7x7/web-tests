module Handler.Fib where

import Import

-- A standard Haskell technique for creating an infinite list of fibonacci values.
fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

-- Unlike Handler.Home, our getFibR returns a Value result, which is the datatype
-- used for JSON values. We return our result as a JSON object, and place
-- our integral result under the "value" key.
getFibR :: Int -> Handler Value
getFibR i = return $ object ["value" .= show (fibs !! abs (min 250 i)) ]
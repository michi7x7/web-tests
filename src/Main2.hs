module Main where

import           Handler.Fib
import           Handler.Home
import           Handler.Markdown
import           Handler.BMI
import           Handler.Temp
import           Import

mkYesodDispatch "App" resourcesApp

main :: IO ()
main = warpEnv App

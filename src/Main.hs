module Main where

import           Handler.Fib
import           Handler.Home
import           Handler.Markdown
import           Handler.BMI
import           Import

{-

We've now defined all of our handler functions. The last step is
create a dispatch function which will reference all of them. The
mkYesodDispatch function does this, following the standard naming
scheme we've used in our handler modules to get the appropriate
function names.

This function creates an instance of YesodDispatch. That instance is
used by warpEnv to create an application that the Warp webserver is
able to execute.

-}

mkYesodDispatch "App" resourcesApp

main :: IO ()
main = warpEnv App

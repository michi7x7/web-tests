module Handler.Home where

import Import

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    let target = "end of the lesson!" :: String
    setTitle "Michi's Playground!"
    addScriptRemote "//ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"
    $(widgetFile "home")
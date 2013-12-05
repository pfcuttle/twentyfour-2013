{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class
import Data.Aeson hiding (json)
import Network.HTTP.Types
import Web.Scotty


chrstmsly :: ScottyM ()
chrstmsly = do
    get "/" showLandingPage
    post "/register" register
    post "/register" registrationFailure


showLandingPage :: ActionM ()
showLandingPage = do
    setHeader "Content-Type" "text/html"
    file "landing.html"


registerInterest :: String -> IO (Maybe String)
registerInterest x = return $ if '@' `elem` x
    then Nothing
    else Just "I broke :("


register :: ActionM ()
register = do
    emailAddress <- param "email" `rescue` const next
    registered <- liftIO (registerInterest emailAddress)
    case registered of
        Just errorMessage -> do
            json $ object [ "error" .= errorMessage ]
            status internalServerError500

        Nothing ->
            json $ object [ "ok" .= ("ok" :: String) ]


registrationFailure :: ActionM ()
registrationFailure = do
    json $ object [ "error" .= ("Invalid request" :: String) ]
    status badRequest400


main :: IO ()
main = scotty 9176 chrstmsly

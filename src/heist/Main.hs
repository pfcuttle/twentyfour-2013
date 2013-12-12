{-# LANGUAGE OverloadedStrings #-}

module Main where

import Blaze.ByteString.Builder (toByteString)
import qualified Data.ByteString.Char8 as BS
import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Trans.Either
import Data.Monoid (mempty)
import Data.Foldable (forM_)
import Data.Text hiding (unlines)
import Heist
import Heist.Interpreted

billy :: IO ()
billy = eitherT (putStrLn . unlines) return $ do
  heist <- initHeist mempty
    { hcTemplateLocations = [ loadTemplates "templates" ]
    , hcInterpretedSplices = defaultInterpretedSplices
    }

  Just (output, _) <- renderTemplate heist "billy"

  liftIO . BS.putStrLn . toByteString $ output


names :: IO ()
names = eitherT (putStrLn . unlines) return $ do
  heist <- initHeist mempty
    { hcTemplateLocations = [ loadTemplates "templates" ]
    , hcInterpretedSplices = defaultInterpretedSplices
    }

  names <- liftIO getNames

  forM_ names $ \name -> do
    Just (output, _) <- renderTemplate
      (bindSplice "kiddo" (textSplice name) heist)
      "merry-christmas"

    liftIO . BS.putStrLn . toByteString $ output


getNames :: IO [Text]
getNames = return [ "Tom", "Dick", "Harry" ]


summary :: IO ()
summary = eitherT (putStrLn . unlines) return $ do
  heist <- initHeist mempty
    { hcTemplateLocations = [ loadTemplates "templates" ]
    , hcInterpretedSplices = defaultInterpretedSplices
    }

  Just (output, _) <- renderTemplate
    (bindSplice "names" namesSplice heist)
    "summary"

  liftIO . BS.putStrLn . toByteString $ output


namesSplice :: HeistT (EitherT [String] IO) (EitherT [String] IO) Template
namesSplice =
  liftIO getNames >>=
    mapSplices (\name -> runChildrenWithText ("name" ## name))


main :: IO ()
main = summary

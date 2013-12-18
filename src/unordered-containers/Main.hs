{-# LANGUAGE DefaultSignatures, DeriveGeneric #-}

module Main where

import Control.Monad

import Data.Hashable
import Data.HashMap.Lazy
import Generics.Deriving


data Child = Child
    { childName :: String
    , childLocation :: String
    } deriving (Eq, Generic, Show)

data Priority = Please | PrettyPlease | PleasePleasePlease
    deriving (Eq, Generic, Show)

data Request = Request
    { requestPresent :: String
    , requestPriority :: Priority
    }  deriving (Eq, Generic, Show)


instance Hashable Child

instance Hashable Priority

instance Hashable Request


olliesWishList :: HashMap Child [Request]
olliesWishList =
    let
        ollie = Child
            { childName = "ocharles"
            , childLocation = "London"
            }
        requests =
            [ Request "Artisan Coffee" Please
            , Request "Dependent Types in Haskell" PleasePleasePlease
            , Request "Lambda Fridge Magnets" PrettyPlease
            ]
    in
        fromList [(ollie, requests)]


main :: IO ()
main = void $ traverseWithKey showWishList olliesWishList
  where
    showWishList child wants = do
        putStrLn $ childName child ++ " wants..."
        mapM_ (putStrLn . requestPresent) wants

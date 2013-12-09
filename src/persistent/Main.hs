{-# LANGUAGE EmptyDataDecls, FlexibleContexts, GADTs, OverloadedStrings,
QuasiQuotes, TemplateHaskell, TypeFamilies #-}

module Main where

import Control.Monad.IO.Class

import Control.Monad.Logger
import Control.Monad.Trans.Control
import Control.Monad.Trans.Resource.Internal
import Data.Text
import Data.Time
import Database.Esqueleto
import Database.Persist.Sqlite hiding ((==.))
import Database.Persist.TH


share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name Text
    deriving Show

StatusUpdate
    producer PersonId
    update Text
    createdAt UTCTime
    mood Text Maybe
    deriving Show
|]


main :: IO ()
main = runSqlite ":memory:" $ do
    runMigration migrateAll
    ollie <- insert (Person "Oliver Charles")
    now <- liftIO getCurrentTime
    _ <- insertMany
        [ StatusUpdate ollie "Writing another blog post!" now Nothing
        , StatusUpdate ollie "I <3 24 Days of Hackage" now (Just "^.^")
        ]

    sortedNames >>= mapM_ (liftIO . print)
    latestUpdates >>= mapM_ (liftIO . print)

    return ()


sortedNames :: (MonadBaseControl IO m, MonadIO m, MonadLogger m, MonadThrow m, MonadUnsafeIO m)
            => SqlPersistT m [Value Text]
sortedNames =
    select $
    from $ \person -> do
    orderBy [asc (person ^. PersonName)]
    limit 5
    return $ person ^. PersonName


latestUpdates :: (MonadBaseControl IO m, MonadIO m, MonadLogger m, MonadThrow m, MonadUnsafeIO m)
              => SqlPersistT m [(Value Text, Value Text)]
latestUpdates =
    select $
    from $ \(person `InnerJoin` update) -> do
    on (person ^. PersonId ==. update ^. StatusUpdateProducer)
    orderBy [asc (update ^. StatusUpdateCreatedAt)]
    limit 5
    return (person ^. PersonName, update ^. StatusUpdateUpdate)

{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application where

------------------------------------------------------------------------------
import Control.Lens
import Control.Monad.State (get)
import Control.Monad.Reader (local)
import Snap.Snaplet
import Snap.Snaplet.Heist

------------------------------------------------------------------------------
data App = App
	{ _heist :: Snaplet (Heist App)
	}

makeLenses ''App

instance HasHeist App where
    heistLens = subSnaplet heist

------------------------------------------------------------------------------
type AppHandler = Handler App App



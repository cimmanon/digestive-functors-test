{-# LANGUAGE OverloadedStrings #-}

module Form.TestItem
	( TestItem(..)
	, testItemForm
	) where

import Control.Applicative ((<$>), (<*>))
import Control.Monad.IO.Class (MonadIO)
import Data.Text (Text)
import Text.Digestive
--import Text.Digestive.Heist
import Text.Digestive.Snap (runForm)

import Form.Internal.Common (editDisabled)

----------------------------------------------------------------------

data TestItem = TestItem
	{ code :: Text
	, name :: Text
	}

testItemForm :: (Functor m, Monad m) => Maybe TestItem -> Form Text m TestItem
testItemForm x = TestItem
	<$> editDisabled x ("code" .: text (code <$> x))
	<*> "name" .: text (name <$> x)

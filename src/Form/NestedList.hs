{-# LANGUAGE OverloadedStrings #-}

module Form.NestedList
	( nestedListForm
	) where

import Control.Applicative ((<$>), (<*>))
import Control.Monad.IO.Class (MonadIO)
import Data.Text (Text)
import Text.Digestive
--import Text.Digestive.Heist
import Text.Digestive.Snap (runForm)

import Form.TestItem
import Form.Internal.Common (editDisabled)

----------------------------------------------------------------------

testItemTupleForm :: (Functor m, Monad m) => Maybe (TestItem, [TestItem]) -> Form Text m (TestItem, [TestItem])
testItemTupleForm x = ( , )
	<$> "item" .: testItemForm (fst <$> x)
	<*> "list" .: listOf (\x' -> "nested" .: testItemForm x') (maybe Nothing (Just . snd) x)

nestedListForm :: (Functor m, Monad m) => Maybe [(TestItem, [TestItem])] -> Form Text m [(TestItem, [TestItem])]
nestedListForm x = "nested-list" .: listOf testItemTupleForm x

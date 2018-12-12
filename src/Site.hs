{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
	( app
	) where

------------------------------------------------------------------------------
--import Control.Applicative
import Data.ByteString (ByteString)
import qualified Data.Text as T
import Snap.Core (ifTop)
import Snap.Snaplet
import Snap.Snaplet.Heist
import Snap.Util.FileServe
import Heist
import Heist.Interpreted
------------------------------------------------------------------------------
import Application

import Control.Monad.IO.Class (MonadIO)
import Text.Digestive
import Text.Digestive.Heist (digestiveSplices)
import Text.Digestive.Heist.Extras
import Text.Digestive.Heist.Extras.Conditional (dfIfEnabled, dfIfDisabled)
import Text.Digestive.Heist.Extras.Debug (dfShowView)
import Text.Digestive.Snap (runForm)

import Form.TestItem (TestItem(..))
import Form.NestedList
import Form.GroupBool

----------------------------------------------------------------------

digestiveSplicesCustom :: (Monad m, MonadIO m) => View T.Text -> Splices (Splice m)
digestiveSplicesCustom = digestiveSplicesWith customSplices
	where
		--customSplices :: (Monad m) => AppendableSplice m
		customSplices s v = do
			let
				nextSplices = addSplices customSplices s
			"dfSubView" ## dfSubView nextSplices v
			"dfInputList" ## dfInputListCustom nextSplices v
			"dfListGroup" ## dfListGroup nextSplices v
			"dfShowView" ## dfShowView v
			"dfIfEnabled" ## dfIfEnabled v
			"dfIfDisabled" ## dfIfDisabled v


dfListGroup :: Monad m => AppendableSplice m -> View T.Text -> Splice m
dfListGroup splices view =
	let
		splices' s v = do
			splices s v
			"dfGroupRadioChoice" ## dfGroupRadioChoice view v
			"dfGroupRadioText" ## dfGroupRadioText view v
	in
		dfInputListCustom splices' view

------------------------------------------------------------------------------
-- | The application's routes.

routes :: [(ByteString, Handler App App ())]
routes =
	[ ("/", ifTop $ render "index")
	-- NestedList
	, ("/nested-list/empty", renderFormH "forms/nested_list" nestedListForm Nothing)
	, ("/nested-list/populated", renderFormH "forms/nested_list" nestedListForm $ Just $
		zip testItems [take 2 testItems, take 1 testItems, []])
	-- GroupBool
	, ("/group-bool/empty", renderFormH "forms/group_bool" groupBoolForm Nothing)
	, ("/group-bool/populated", renderFormH "forms/group_bool" groupBoolForm  $ Just $
		zip testItems [False, True, True])
	, ("", serveDirectory "static")
	]

testItems :: [TestItem]
testItems =
	[ (TestItem "foo" "one")
	, (TestItem "bar" "two")
	, (TestItem "buzz" "three")
	]

----------------------------------------------------------------------
-- | Handler for rendering the forms

renderFormH :: ByteString -> (Maybe a -> Form T.Text (Handler App App) a) -> Maybe a -> AppHandler ()
renderFormH template form x = do
	(view, _) <- runForm "form" $ form x
	renderWithSplices template $ digestiveSplicesCustom view

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
--	h <- nestSnaplet "" heist $ heistInit "templates"
	-- ^ default Heist behavior (serves raw templates ahead of configured routes)
	h <- nestSnaplet "" heist $ heistInit "templates"

	addRoutes routes
	return $ App h

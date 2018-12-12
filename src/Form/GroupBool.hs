{-# LANGUAGE OverloadedStrings #-}

module Form.GroupBool
	( groupBoolForm
	) where

import Control.Applicative ((<$>), (<*>))
import Control.Monad.IO.Class (MonadIO)
import Data.Text (Text)
import Text.Digestive
--import Text.Digestive.Heist
import Text.Digestive.Snap (runForm)

import Form.TestItem

import Data.Monoid (Monoid)
import Data.String (IsString)
import Data.List (findIndex, intercalate)
import Data.Maybe (fromMaybe)

----------------------------------------------------------------------

groupBoolForm :: (Monad m, Functor m) => Maybe [(TestItem, Bool)] -> Form Text m [(TestItem, Bool)]
groupBoolForm xs = "group-bool" .: groupBoolForm' snd (\(x, _) -> (x, True)) form (fromMaybe [] xs)
	where
		form x = ( , )
			<$> "item" .: testItemForm (fst <$> x)
			<*> "selected" .: bool (snd <$> x)

-- a generalized, reusable form.  need to move this elsewhere...
groupBoolForm' :: (Monad m, Monoid v, IsString v) => (a -> Bool) -> (a -> a) -> (Maybe a -> Form v m a) -> [a] -> Form v m [a]
groupBoolForm' getBool setTrue f xs = setGroupBool <$> groupForm (if null xs then Nothing else Just (xs', defaultElem))
	where
		--xs' :: [(a, Int)]
		xs' = zip xs [0..]

		defaultElem :: Int
		defaultElem = fromMaybe 0 $ findIndex getBool xs

		--groupForm :: Maybe ([a], Int) -> Form v m ([a], Int)
		groupForm x = ( , )
			<$> "choices" .: listOf f' (fst <$> x)
			<*> "selection" .: stringRead "Not a number" (Just $ maybe 0 snd x)

		--f' :: Maybe (a, Int) -> Form v m (a, Int)
		f' x = ( , )
			<$> f (fst <$> x)
			<*> "elem_index" .: stringRead "Not a number" (Just $ maybe 0 snd x)

		--setGroupBool :: ([(a, Int)], Int) -> [a]
		setGroupBool (ys, idx) =
			case break (\(_, x) -> x == idx) ys of
				(fx, x : lx) -> intercalate [setTrue $ fst x] [map fst fx, map fst lx]
				_ -> map fst ys

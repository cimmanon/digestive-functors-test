module Form.Internal.Common where

import Text.Digestive

editDisabled :: Maybe a -> Form v m b -> Form v m b
editDisabled (Just _) = disable
editDisabled Nothing = id

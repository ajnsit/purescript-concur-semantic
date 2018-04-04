module SemanticUI.ButtonOr where

import Prelude

import Concur.Core (Widget, display)
import Concur.React (HTML)
import Concur.SemanticUI.Common (SemanticUITag)
import Data.Foreign (Foreign)
import Data.Monoid (mempty)
import Data.Options (Option, Options, opt, options, (:=))
import React (ReactClass, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

buttonOr :: forall a. Widget HTML a
buttonOr = display [buttonOrTag mempty []]

buttonOrText :: forall a. String -> Widget HTML a
buttonOrText label = display [buttonOrTag (text := label) []]

-------------------------------------------------------------------------------
-- LOW LEVEL

foreign import buttonOrClass :: ReactClass ButtonOrProps
foreign import data ButtonOrOption :: Type
newtype ButtonOrProps = ButtonOrProps Foreign

buttonOrProps :: Options ButtonOrOption -> ButtonOrProps
buttonOrProps = ButtonOrProps <<< options

buttonOrTag :: SemanticUITag ButtonOrOption
buttonOrTag opts = createElement buttonOrClass (buttonOrProps opts)

-------------------------------------------------------------------------------
-- OPTIONS

as :: Option ButtonOrOption (String)
as = opt "as"

className :: Option ButtonOrOption (String)
className = opt "className"

text :: Option ButtonOrOption (String)
text = opt "text"

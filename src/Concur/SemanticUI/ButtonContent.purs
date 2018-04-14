module Concur.SemanticUI.ButtonContent where

import Prelude

import Concur.Core (Widget, mapView)
import Concur.React (HTML)
import Concur.SemanticUI.Common (SemanticUITag)
import Control.Alt ((<|>))
import Data.Foreign (Foreign)
import Data.Options (Option, Options, opt, options, (:=))
import React (ReactClass, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

buttonContent :: forall a. Widget HTML a -> Widget HTML a -> Widget HTML a
buttonContent visibleContent hiddenContent = visibleEl <|> hiddenEl
  where
    visibleEl = mapView (pure <<< buttonContentTag (visible := true)) visibleContent
    hiddenEl = mapView (pure <<< buttonContentTag (hidden := true)) hiddenContent

-------------------------------------------------------------------------------
-- LOW LEVEL

foreign import buttonContentClass :: ReactClass ButtonContentProps
foreign import data ButtonContentOption :: Type
newtype ButtonContentProps = ButtonContentProps Foreign

buttonContentProps :: Options ButtonContentOption -> ButtonContentProps
buttonContentProps = ButtonContentProps <<< options

buttonContentTag :: SemanticUITag ButtonContentOption
buttonContentTag opts = createElement buttonContentClass (buttonContentProps opts)

-------------------------------------------------------------------------------
-- OPTIONS

as :: Option ButtonContentOption (String)
as = opt "as"

-- children :: Option ButtonContentOption children
-- children = opt "children"

className :: Option ButtonContentOption (String)
className = opt "className"

content :: Option ButtonContentOption (String)
content = opt "content"

hidden :: Option ButtonContentOption (Boolean)
hidden = opt "hidden"

visible :: Option ButtonContentOption (Boolean)
visible = opt "visible"

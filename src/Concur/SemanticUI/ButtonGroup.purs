module SemanticUI.ButtonGroup where

import Prelude

import Concur.Core (Widget, mapView)
import Concur.React (HTML)
import Concur.SemanticUI.Common (Color, Edge, Horiz, SemanticUITag, Size, foreignOpt)
import Data.Foreign (Foreign)
import Data.Monoid (mempty)
import Data.Options (Option, Options, opt, options)
import React (ReactClass, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

buttonGroup :: forall a. Options ButtonGroupOption -> Widget HTML a -> Widget HTML a
buttonGroup opts buts = mapView (pure <<< buttonGroupTag opts) buts

buttonGroup' :: forall a. Widget HTML a -> Widget HTML a
buttonGroup' buts = mapView (pure <<< buttonGroupTag mempty) buts

-------------------------------------------------------------------------------
-- LOW LEVEL

foreign import buttonGroupClass :: ReactClass ButtonGroupProps
foreign import data ButtonGroupOption :: Type
newtype ButtonGroupProps = ButtonGroupProps Foreign

buttonGroupProps :: Options ButtonGroupOption -> ButtonGroupProps
buttonGroupProps = ButtonGroupProps <<< options

buttonGroupTag :: SemanticUITag ButtonGroupOption
buttonGroupTag opts = createElement buttonGroupClass (buttonGroupProps opts)

-------------------------------------------------------------------------------
-- OPTIONS

as :: Option ButtonGroupOption (String)
as = opt "as"

attached :: Option ButtonGroupOption (Edge)
attached = foreignOpt "attached"

basic :: Option ButtonGroupOption (Boolean)
basic = opt "basic"

-- buttons :: Option ButtonGroupOption (buttons)
-- buttons = opt "buttons"

-- children :: Option ButtonGroupOption (children)
-- children = opt "children"

className :: Option ButtonGroupOption (String)
className = opt "className"

color :: Option ButtonGroupOption (Color)
color = foreignOpt "color"

compact :: Option ButtonGroupOption (Boolean)
compact = opt "compact"

content :: Option ButtonGroupOption (String)
content = opt "content"

floated :: Option ButtonGroupOption (Horiz)
floated = foreignOpt "floated"

fluid :: Option ButtonGroupOption (Boolean)
fluid = opt "fluid"

icon :: Option ButtonGroupOption (Boolean)
icon = opt "icon"

inverted :: Option ButtonGroupOption (Boolean)
inverted = opt "inverted"

labeled :: Option ButtonGroupOption (Boolean)
labeled = opt "labeled"

negative :: Option ButtonGroupOption (Boolean)
negative = opt "negative"

positive :: Option ButtonGroupOption (Boolean)
positive = opt "positive"

primary :: Option ButtonGroupOption (Boolean)
primary = opt "primary"

secondary :: Option ButtonGroupOption (Boolean)
secondary = opt "secondary"

size :: Option ButtonGroupOption (Size)
size = foreignOpt "size"

toggle :: Option ButtonGroupOption (Boolean)
toggle = opt "toggle"

vertical :: Option ButtonGroupOption (Boolean)
vertical = opt "vertical"

-- Can be between 1 and 16
widths :: Option ButtonGroupOption (Int)
widths = opt "widths"

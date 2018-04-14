module Concur.SemanticUI.Menu where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML, el)
import Concur.SemanticUI.Common (ChildIcons, Color, Edge, EventHandlerOpt, Horiz, SemanticUITag, Size, Tabular, foreignOpt)
import Data.Foreign (Foreign)
import Data.Options (Option, Options, opt, options)
import React (ReactClass, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

-- Wrap a menu around items
menu :: forall a. Options MenuOption -> Widget HTML a -> Widget HTML a
menu props w = el (menuTag props) w

-------------------------------------------------------------------------------
-- LOW LEVEL

foreign import menuClass :: ReactClass MenuProps
foreign import data MenuOption :: Type
newtype MenuProps = MenuProps Foreign

menuProps :: Options MenuOption -> MenuProps
menuProps = MenuProps <<< options

menuTag :: SemanticUITag MenuOption
menuTag opts = createElement menuClass (menuProps opts)

-------------------------------------------------------------------------------
-- OPTIONS

as :: Option MenuOption (String)
as = opt "as"

activeIndex :: Option MenuOption (Int)
activeIndex = opt "activeIndex"

attached :: Option MenuOption (Horiz)
attached = foreignOpt "attached"

borderless :: Option MenuOption (Boolean)
borderless = opt "borderless"

-- children :: Option MenuOption (Node)
-- children = opt "children"

className :: Option MenuOption (String)
className = opt "className"

color :: Option MenuOption (Color)
color = foreignOpt "color"

compact :: Option MenuOption (Boolean)
compact = opt "compact"

defaultActiveIndex :: Option MenuOption (Int)
defaultActiveIndex = opt "defaultActiveIndex"

fixed :: Option MenuOption (Edge)
fixed = foreignOpt "fixed"

floated :: Option MenuOption (Horiz)
floated = foreignOpt "floated"

fluid :: Option MenuOption (Boolean)
fluid = opt "fluid"

icon :: Option MenuOption (ChildIcons)
icon = foreignOpt "icon"

inverted :: Option MenuOption (Boolean)
inverted = opt "inverted"

-- items :: Option MenuOption (UnknownType)
-- items = foreignOpt "items"

onItemClick :: Option MenuOption (EventHandlerOpt)
onItemClick = opt "onItemClick"

pagination :: Option MenuOption (Boolean)
pagination = opt "pagination"

pointing :: Option MenuOption (Boolean)
pointing = opt "pointing"

secondary :: Option MenuOption (Boolean)
secondary = opt "secondary"

size :: Option MenuOption (Size)
size = foreignOpt "size"

stackable :: Option MenuOption (Boolean)
stackable = opt "stackable"

tabular :: Option MenuOption (Tabular)
tabular = foreignOpt "tabular"

text :: Option MenuOption (Boolean)
text = opt "text"

vertical :: Option MenuOption (Boolean)
vertical = opt "vertical"

-- Can be between 1 and 16
widths :: Option MenuOption (Int)
widths = opt "widths"

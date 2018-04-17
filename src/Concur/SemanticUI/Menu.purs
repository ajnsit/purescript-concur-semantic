module Concur.SemanticUI.Menu where

import Prelude

import Concur.Core (Widget, orr)
import Concur.React (HTML, elp)
import Concur.React.DOM (text)
import Concur.SemanticUI.Common (ChildIcons, Color, Edge, EventHandlerOpt, Horiz, SemanticUITag, Size, Tabular, foreignOpt)
import Concur.SemanticUI.MenuItem (menuItem)
import Concur.SemanticUI.MenuItem as MenuItem
import Data.Either (either)
import Data.Foreign (Foreign)
import Data.Monoid (mempty)
import Data.Options (Option, Options, opt, options, (:=))
import Data.Tuple (Tuple(..))
import React (ReactClass, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

-- A Simple no-frills menu widget
simpleMenu :: forall a. Eq a => Show a => Array (Tuple a String) -> a -> Widget HTML a
simpleMenu = widgetMenu <<< map (map text)

-- Like simpleMenu, but allows arbitrary widgets as menu items
widgetMenu :: forall a. Show a => Eq a => Array (Tuple a (Widget HTML a)) -> a -> Widget HTML a
widgetMenu items activeItem = elp menuTag mempty (orr (map mitem items))
  where
    mitem (Tuple k w) = either (const k) id <$> menuItem (MenuItem.name := (show k) <> MenuItem.active := (activeItem == k)) w

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

textOnly :: Option MenuOption (Boolean)
textOnly = opt "text"

vertical :: Option MenuOption (Boolean)
vertical = opt "vertical"

-- Can be between 1 and 16
widths :: Option MenuOption (Int)
widths = opt "widths"

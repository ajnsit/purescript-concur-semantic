module Concur.SemanticUI.MenuItem where

import Prelude

import Concur.SemanticUI.Common (Color, EventHandlerOpt, Fitted, Horiz, SemanticUITag, foreignOpt)
import Data.Foreign (Foreign)
import Data.Options (Option, Options, opt, options)
import React (ReactClass, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

menuItem :: Options MenuItemOption ->

-------------------------------------------------------------------------------
-- LOW LEVEL

foreign import menuItemClass :: ReactClass MenuItemProps
foreign import data MenuItemOption :: Type
newtype MenuItemProps = MenuItemProps Foreign

menuItemProps :: Options MenuItemOption -> MenuItemProps
menuItemProps = MenuItemProps <<< options

menuItemTag :: SemanticUITag MenuItemOption
menuItemTag opts = createElement menuItemClass (menuItemProps opts)

-------------------------------------------------------------------------------
-- OPTIONS

as :: Option MenuItemOption (String)
as = opt "as"

active :: Option MenuItemOption (Boolean)
active = opt "active"

-- children :: Option MenuItemOption children
-- children = opt "children"

className :: Option MenuItemOption (String)
className = opt "className"

color :: Option MenuItemOption (Color)
color = foreignOpt "color"

-- content :: Option MenuItemOption content
-- content = opt "content"

disabled :: Option MenuItemOption (Boolean)
disabled = opt "disabled"

fitted :: Option MenuItemOption (Fitted)
fitted = foreignOpt "fitted"

header :: Option MenuItemOption (Boolean)
header = opt "header"

-- icon :: Option MenuItemOption icon
-- icon = opt "icon"

index :: Option MenuItemOption (Number)
index = opt "index"

link :: Option MenuItemOption (Boolean)
link = opt "link"

name :: Option MenuItemOption (String)
name = opt "name"

onClick :: Option MenuItemOption (EventHandlerOpt)
onClick = opt "onClick"

position :: Option MenuItemOption Horiz
position = foreignOpt "position"

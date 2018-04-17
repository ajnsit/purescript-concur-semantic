module Concur.SemanticUI.MenuItem where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.SemanticUI.Common (Color, EventHandlerOpt, Fitted, Horiz, SemanticUITag, elSemanticEvent, foreignOpt, mkHandler)
import Control.Monad.IOSync (runIOSync')
import Data.Either (Either, either)
import Data.Foreign (Foreign)
import Data.Monoid (mempty)
import Data.Options (Option, Options, opt, options, (:=))
import React (ReactClass, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

-- Wrap a menuItem around a widget
-- Returns a `Left unit on click events.
-- Or a `Right a` when the inner `Widget HTML a` ends.
menuItem :: forall a. Options MenuItemOption -> Widget HTML a -> Widget HTML (Either Unit a)
menuItem props w = elSemanticEvent (\h -> onClick := (mkHandler (runIOSync' (h unit)))) menuItemTag props w

-- Like a menuItem, but takes no props
menuItem' :: forall a. Widget HTML a -> Widget HTML (Either Unit a)
menuItem' = menuItem mempty

-- Specialised menuItem with only static children
displayMenuItem :: Options MenuItemOption -> (forall a. Widget HTML a) -> Widget HTML Unit
displayMenuItem props d = either id id <$> menuItem props d

-- Like a displayMenuItem, but takes no props
displayMenuItem' :: (forall a. Widget HTML a) -> Widget HTML Unit
displayMenuItem' = displayMenuItem mempty

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

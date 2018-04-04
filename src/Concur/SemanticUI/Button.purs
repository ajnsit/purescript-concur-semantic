module Concur.SemanticUI.Button where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.SemanticUI.Common (Animated, Color, Edge, EventHandlerOpt, Horiz, SemanticUITag, Size, Union2, elSemanticEvent, foreignOpt, mkHandler)
import Control.Monad.IOSync (runIOSync')
import Data.Either (Either, either)
import Data.Foreign (Foreign)
import Data.Monoid (mempty)
import Data.Options (Option, Options, opt, options, (:=))
import React (ReactClass, ReactElement, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

-- Wrap a button around a widget
-- Returns a `Left unit on click events.
-- Or a `Right a` when the inner `Widget HTML a` ends.
button :: forall a. Options ButtonOption -> Widget HTML a -> Widget HTML (Either Unit a)
button props w = elSemanticEvent (\h -> onClick := (mkHandler (runIOSync' (h unit)))) buttonTag props w

-- Like a wrapButton, but takes no props
button' :: forall a. Widget HTML a -> Widget HTML (Either Unit a)
button' = button mempty

-- Specialised button with only static children
displayButton :: Options ButtonOption -> (forall a. Widget HTML a) -> Widget HTML Unit
displayButton props d = either id id <$> button props d

-- Like a displayButton, but takes no props
displayButton' :: (forall a. Widget HTML a) -> Widget HTML Unit
displayButton' = displayButton mempty

-------------------------------------------------------------------------------
-- LOW LEVEL

foreign import buttonClass :: ReactClass ButtonProps

foreign import data ButtonOption :: Type

newtype ButtonProps = ButtonProps Foreign

buttonProps :: Options ButtonOption -> ButtonProps
buttonProps = ButtonProps <<< options

buttonTag :: SemanticUITag ButtonOption
buttonTag opts = createElement buttonClass (buttonProps opts)

-------------------------------------------------------------------------------
-- OPTIONS

as :: Option ButtonOption (String)
as = opt "as"

active :: Option ButtonOption (Boolean)
active = opt "active"

animated :: Option ButtonOption (Union2 Boolean Animated)
animated = foreignOpt "animated"

attached :: Option ButtonOption (Edge)
attached = foreignOpt "attached"

basic :: Option ButtonOption (Boolean)
basic = opt "basic"

-- children :: Option ButtonOption children
-- children = opt "children"

circular :: Option ButtonOption (Boolean)
circular = opt "circular"

className :: Option ButtonOption (String)
className = opt "className"

color :: Option ButtonOption (Color)
color = foreignOpt "color"

compact :: Option ButtonOption (Boolean)
compact = opt "compact"

content :: Option ButtonOption (String)
content = opt "content"

disabled :: Option ButtonOption (Boolean)
disabled = opt "disabled"

floated :: Option ButtonOption (Horiz)
floated = foreignOpt "floated"

fluid :: Option ButtonOption (Boolean)
fluid = opt "fluid"

icon :: Option ButtonOption (Union2 String ReactElement)
icon = foreignOpt "icon"

inverted :: Option ButtonOption (Boolean)
inverted = opt "inverted"

label :: Option ButtonOption (Union2 String ReactElement)
label = foreignOpt "label"

labelPosition :: Option ButtonOption (Horiz)
labelPosition = foreignOpt "labelPosition"

loading :: Option ButtonOption (Boolean)
loading = opt "loading"

negative :: Option ButtonOption (Boolean)
negative = opt "negative"

onClick :: Option ButtonOption (EventHandlerOpt)
onClick = opt "onClick"

positive :: Option ButtonOption (Boolean)
positive = opt "positive"

primary :: Option ButtonOption (Boolean)
primary = opt "primary"

secondary :: Option ButtonOption (Boolean)
secondary = opt "secondary"

size :: Option ButtonOption (Size)
size = foreignOpt "size"

tabIndex :: Option ButtonOption (Int)
tabIndex = opt "tabIndex"

toggle :: Option ButtonOption (Boolean)
toggle = opt "toggle"

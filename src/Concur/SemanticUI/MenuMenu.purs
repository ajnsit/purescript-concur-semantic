module Concur.SemanticUI.MenuMenu where

import Prelude

import Concur.SemanticUI.Common (Horiz, foreignOpt)
import Data.Foreign (Foreign)
import Data.Options (Option, Options, opt, options)
import React (ReactClass, ReactElement, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

-------------------------------------------------------------------------------
-- LOW LEVEL

foreign import menuMenuClass :: ReactClass MenuMenuProps
foreign import data MenuMenuOption :: Type
newtype MenuMenuProps = MenuMenuProps Foreign

menuMenuProps :: Options MenuMenuOption -> MenuMenuProps
menuMenuProps = MenuMenuProps <<< options

menuMenuTag :: Options MenuMenuOption -> Array ReactElement -> ReactElement
menuMenuTag opts = createElement menuMenuClass (menuMenuProps opts)

-------------------------------------------------------------------------------
-- OPTIONS

as :: Option MenuMenuOption (String)
as = opt "as"

-- children :: Option MenuMenuOption children
-- children = opt "children"

className :: Option MenuMenuOption (String)
className = opt "className"

-- content :: Option MenuMenuOption content
-- content = opt "content"

position :: Option MenuMenuOption Horiz
position = foreignOpt "position"

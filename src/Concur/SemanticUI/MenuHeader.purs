module Concur.SemanticUI.MenuHeader where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML, elp)
import Concur.SemanticUI.Common (SemanticUITag)
import Data.Foreign (Foreign)
import Data.Monoid (mempty)
import Data.Options (Option, Options, opt, options)
import React (ReactClass, createElement)

-------------------------------------------------------------------------------
-- HIGH LEVEL

menuHeader :: forall a. Options MenuHeaderOption -> Widget HTML a -> Widget HTML a
menuHeader = elp menuHeaderTag

menuHeader' :: forall a. Widget HTML a -> Widget HTML a
menuHeader' = menuHeader mempty

-------------------------------------------------------------------------------
-- LOW LEVEL

foreign import menuHeaderClass :: ReactClass MenuHeaderProps
foreign import data MenuHeaderOption :: Type
newtype MenuHeaderProps = MenuHeaderProps Foreign

menuHeaderProps :: Options MenuHeaderOption -> MenuHeaderProps
menuHeaderProps = MenuHeaderProps <<< options

menuHeaderTag :: SemanticUITag MenuHeaderOption
menuHeaderTag opts = createElement menuHeaderClass (menuHeaderProps opts)

-------------------------------------------------------------------------------
-- OPTIONS

as :: Option MenuHeaderOption (String)
as = opt "as"

-- children :: Option MenuHeaderOption children
-- children = opt "children"

className :: Option MenuHeaderOption (String)
className = opt "className"

-- content :: Option MenuHeaderOption content
-- content = opt "content"

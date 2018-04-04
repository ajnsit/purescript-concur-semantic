module Main where

import Prelude

import Concur.Core (Widget, orr)
import Concur.React (HTML)
import Concur.React.DOM (text)
import Concur.React.Run (runWidgetInDom)
import Concur.SemanticUI.Button (displayButton, displayButton')
import Concur.SemanticUI.Button as B
import Concur.SemanticUI.Common (Size(..))
import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Monoid (mempty)
import Data.Options ((:=))
import SemanticUI.ButtonGroup (buttonGroup)
import SemanticUI.ButtonOr (buttonOr)

main :: Eff (dom :: DOM) Unit
main = runWidgetInDom "semantic" helloWidget

-- Button demos

helloWidget :: forall a. Widget HTML a
helloWidget = do
  displayButton (B.primary := true) (text "Click me")
  displayButton (B.secondary := true <> B.size := Massive) (text "Hello Sailor!")
  i <- groupButtonWidget
  helloWidget

groupButtonWidget :: Widget HTML Int
groupButtonWidget = buttonGroup mempty $ orr $
  [ displayButton' (text "Cancel") $> 0
  , buttonOr
  , displayButton (B.positive := true) (text "Save") $> 1
  ]

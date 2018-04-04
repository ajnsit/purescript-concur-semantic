module Main where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM (text)
import Concur.React.Run (runWidgetInDom)
import Concur.SemanticUI.Button (displayButton)
import Concur.SemanticUI.Button as B
import Concur.SemanticUI.Common (Size(..))
import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Options ((:=))

main :: Eff (dom :: DOM) Unit
main = runWidgetInDom "semantic" helloWidget

helloWidget :: forall a. Widget HTML a
helloWidget = do
  displayButton (B.primary := true) (text "Click me")
  displayButton (B.secondary := true <> B.size := Massive) (text "Hello Sailor!")
  helloWidget

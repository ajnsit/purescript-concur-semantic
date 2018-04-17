module Main where

import Prelude

import Concur.Core (Widget, orr)
import Concur.React (HTML)
import Concur.React.DOM (div', text)
import Concur.React.Run (runWidgetInDom)
import Concur.SemanticUI.Button (displayButton, displayButton')
import Concur.SemanticUI.Button as B
import Concur.SemanticUI.Common (Size(..))
import Concur.SemanticUI.Menu (simpleMenu, widgetMenu)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (log)
import DOM (DOM)
import Data.Monoid (mempty)
import Data.Options ((:=))
import Data.Tuple (Tuple(..))
import SemanticUI.ButtonGroup (buttonGroup)
import SemanticUI.ButtonOr (buttonOr)

main :: Eff (dom :: DOM) Unit
main = runWidgetInDom "semantic" $ selectedTab "buttons"

selectedTab :: String -> Widget HTML String
selectedTab cur = do
  s <- div'
    [ topMenuWidget cur
    , case cur of
        "buttons" -> helloWidget
        _-> div'
          [ demoSimpleMenuWidget "reviews"
          , demoWidgetMenuWidget "helloworld"
          ]
    ]
  liftEff $ log s
  selectedTab s

topMenuWidget :: String -> Widget HTML String
topMenuWidget = simpleMenu
  [ Tuple "buttons" "Buttons"
  , Tuple "menus" "Menus"
  ]

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

-- Menu demos
demoSimpleMenuWidget :: forall a. String -> Widget HTML a
demoSimpleMenuWidget cur = m cur >>= demoSimpleMenuWidget
  where
    m = simpleMenu
      [ Tuple "reviews" "Reviews"
      , Tuple "editorials" "Editorials"
      , Tuple "upcoming" "Upcoming Events"
      , Tuple "contact" "Contact Us"
      ]

demoWidgetMenuWidget :: forall a. String -> Widget HTML a
demoWidgetMenuWidget cur = m cur >>= demoWidgetMenuWidget
  where
    m = widgetMenu
      [ Tuple "step1" (displayButton' (text "move focus right") $> "step2")
      , Tuple "step2" (text "Static text")
      ]

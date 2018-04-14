module Concur.SemanticUI.Common where

import Prelude

import Concur.Core (Widget, wrapViewEvent)
import Concur.React (HTML)
import Control.Monad.IOSync (IOSync)
import Data.Array (foldMap)
import Data.Either (Either)
import Data.Foreign (Foreign, toForeign)
import Data.Function (applyFlipped)
import Data.Op (Op(..))
import Data.Options (Option, Options(Options))
import Data.Tuple (Tuple(..))
import React (EventHandler, ReactElement, EventHandlerContext, handle)

-------------------------------------------------------------------------------
-- Common types

type SemanticUITag o = Options o -> Array ReactElement -> ReactElement

newtype EventHandlerOpt = EventHandlerOpt (EventHandler Unit)

mkHandler :: forall e p s a. (EventHandlerContext e p s a) -> EventHandlerOpt
mkHandler h = EventHandlerOpt (handle (const h))

-------------------------------------------------------------------------------
-- Wrapper components

-- Wrap an element with an arbitrary eventHandler over a widget
elSemanticEvent :: forall a b o. ((a -> IOSync Unit) -> Options o) -> SemanticUITag o -> Options o -> Widget HTML b -> Widget HTML (Either a b)
elSemanticEvent evt = elSemanticEventMany [evt]

-- Wrap an element with multiple arbitrary eventHandlers over a widget
elSemanticEventMany :: forall a b o. Array ((a -> IOSync Unit) -> Options o) -> SemanticUITag o -> Options o -> Widget HTML b -> Widget HTML (Either a b)
elSemanticEventMany evts e opts w = wrapViewEvent (\h v -> [e (opts <> (foldMap (applyFlipped h) evts)) v]) w

-- Wrap an element with no event handlers
-- elSemantic :: forall o a. SemanticUITag o -> Options o -> Widget HTML a -> Widget HTML a
-- elSemantic e props w = el (e props) w

-------------------------------------------------------------------------------
-- Foreign Opt type class

class ToForeignOpt a where
  toForeignOpt :: a -> Foreign

-- Alternative design
-- class ToForeignOpt o a where
--   toForeignOpt :: String -> a -> Options o

unsafeMkForeignOptions :: forall opt. String -> Foreign -> Options opt
unsafeMkForeignOptions k v = Options [Tuple k v]

mkOpt :: forall o a. (a -> Foreign) -> String -> Option o a
mkOpt f s = Op (unsafeMkForeignOptions s <<< f)

foreignOpt :: forall o a. ToForeignOpt a => String -> Option o a
-- foreignOpt = cmap toForeignOpt <<< opt
foreignOpt = mkOpt toForeignOpt




instance toForeignOptReactElement :: ToForeignOpt ReactElement where
  toForeignOpt = toForeign

instance toForeignOptString :: ToForeignOpt String where
  toForeignOpt = toForeign

instance toForeignOptBoolean :: ToForeignOpt Boolean where
  toForeignOpt = toForeign

instance toForeignOptInt :: ToForeignOpt Int where
  toForeignOpt = toForeign

-------------------------------------------------------------------------------
-- Unions

data Union2 a b = U2a a | U2b b
data Union3 a b c = U3a a | U3b b | U3c c
data Union4 a b c d = U4a a | U4b b | U4c c | U4d d
data Union5 a b c d e = U5a a | U5b b | U5c c | U5d d | U5e e

instance toForeignOptUnion2 :: (ToForeignOpt a, ToForeignOpt b) => ToForeignOpt (Union2 a b) where
  toForeignOpt (U2a a) = toForeignOpt a
  toForeignOpt (U2b b) = toForeignOpt b

instance toForeignOptUnion3 :: (ToForeignOpt a, ToForeignOpt b, ToForeignOpt c) => ToForeignOpt (Union3 a b c) where
  toForeignOpt (U3a a) = toForeignOpt a
  toForeignOpt (U3b b) = toForeignOpt b
  toForeignOpt (U3c c) = toForeignOpt c

instance toForeignOptUnion4 :: (ToForeignOpt a, ToForeignOpt b, ToForeignOpt c, ToForeignOpt d) => ToForeignOpt (Union4 a b c d) where
  toForeignOpt (U4a a) = toForeignOpt a
  toForeignOpt (U4b b) = toForeignOpt b
  toForeignOpt (U4c c) = toForeignOpt c
  toForeignOpt (U4d d) = toForeignOpt d

instance toForeignOptUnion5 :: (ToForeignOpt a, ToForeignOpt b, ToForeignOpt c, ToForeignOpt d, ToForeignOpt e) => ToForeignOpt (Union5 a b c d e) where
  toForeignOpt (U5a a) = toForeignOpt a
  toForeignOpt (U5b b) = toForeignOpt b
  toForeignOpt (U5c c) = toForeignOpt c
  toForeignOpt (U5d d) = toForeignOpt d
  toForeignOpt (U5e e) = toForeignOpt e

-------------------------------------------------------------------------------
-- Custom Data Types

data Edge = LeftEdge | RightEdge | TopEdge | BottomEdge
instance showEdge :: Show Edge where
  show LeftEdge = "left"
  show RightEdge = "right"
  show TopEdge = "top"
  show BottomEdge = "bottom"
instance toForeignOptEdge :: ToForeignOpt Edge where
  toForeignOpt = toForeign <<< show

data Orientation = Horizontal | Vertical
instance showOrientation :: Show Orientation where
  show Horizontal = "horizontal"
  show Vertical = "vertical"
instance toForeignOptOrientation :: ToForeignOpt Orientation where
  toForeignOpt = toForeign <<< show

data Fitted = Horizontally | Vertically
instance showFitted :: Show Fitted where
  show Horizontally = "horizontally"
  show Vertically = "vertically"
instance toForeignOptFitted :: ToForeignOpt Fitted where
  toForeignOpt = toForeign <<< show

data Aligned = LeftAligned | CenterAligned | RightAligned | Justified
instance showAligned :: Show Aligned where
  show LeftAligned = "left"
  show CenterAligned = "center"
  show RightAligned = "right"
  show Justified = "justified"
instance toForeignOptAligned :: ToForeignOpt Aligned where
  toForeignOpt = toForeign <<< show

data Horiz = Left | Right
instance showHoriz :: Show Horiz where
  show Left = "left"
  show Right = "right"
instance toForeignOptHoriz :: ToForeignOpt Horiz where
  toForeignOpt = toForeign <<< show

data Social = Facebook | GooglePlus | Instagram | LinkedIn | Twitter | VK | YouTube
instance showSocial :: Show Social where
  show Facebook = "facebook"
  show GooglePlus = "googlePlus"
  show Instagram = "instagram"
  show LinkedIn = "linkedin"
  show Twitter = "twitter"
  show VK = "vk"
  show YouTube = "youtube"

data Color = Red | Orange | Yellow | Olive | Green | Teal | Blue | Violet | Purple | Pink | Brown | Grey | Black | SocialColor Social
instance showColor :: Show Color where
  show Red = "red"
  show Orange = "orange"
  show Yellow = "yellow"
  show Olive = "olive"
  show Green = "green"
  show Teal = "teal"
  show Blue = "blue"
  show Violet = "violet"
  show Purple = "purple"
  show Pink = "pink"
  show Brown = "brown"
  show Grey = "grey"
  show Black = "black"
  show (SocialColor s) = show s
instance toForeignOptColor :: ToForeignOpt Color where
  toForeignOpt = toForeign <<< show

data Animated = AnimatedVertical | AnimatedFade
instance toForeignOptAnimated :: ToForeignOpt Animated where
  toForeignOpt AnimatedVertical = toForeign "vertical"
  toForeignOpt AnimatedFade = toForeign "fade"

data Size = Mini | Tiny | Small | Medium | Large | Big | Huge | Massive
instance showSize :: Show Size where
  show Mini = "mini"
  show Tiny = "tiny"
  show Small = "small"
  show Medium = "medium"
  show Large = "large"
  show Big = "big"
  show Huge = "huge"
  show Massive = "massive"
instance toForeignOptSize :: ToForeignOpt Size where
  toForeignOpt = toForeign <<< show

data ChildIcons = DisableChildIcons | EnableChildIcons | EnableChildLabels
instance toForeignOptChildIcons :: ToForeignOpt ChildIcons where
  toForeignOpt DisableChildIcons = toForeign false
  toForeignOpt EnableChildIcons = toForeign true
  toForeignOpt EnableChildLabels = toForeign "labeled"

data Tabular = EnableTabular | DisableTabular | EnableTabularRight
instance toForeignOptTabular :: ToForeignOpt Tabular where
  toForeignOpt DisableTabular = toForeign false
  toForeignOpt EnableTabular = toForeign true
  toForeignOpt EnableTabularRight = toForeign "right"

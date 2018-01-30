module Quill.API.Formats
    ( Formats
    , Alignment(..)
    , FontName
    , background
    , color
    , bold
    , font
    , code
    , italic
    , link
    , size
    , strike
    , underline
    , blockquote
    , header
    , indent
    , align
    , codeBlock
    ) where

import Prelude

import Color (Color, toHexString)

import Data.Maybe (Maybe(..))
import Data.Op (Op(..))
import Data.Foreign (toForeign)
import Data.Options (Options(..), Option, opt)
import Data.String.Read (class Read)
import Data.Tuple (Tuple(..))

-- | https://quilljs.com/docs/formats/
data Formats

background :: Option Formats Color
background = optWith toHexString "background"

color :: Option Formats Color
color = optWith toHexString "color"

bold :: Option Formats Boolean
bold = opt "bold"

font :: Option Formats FontName
font = opt "font"

code :: Option Formats Boolean
code = opt "code"

italic :: Option Formats Boolean
italic = opt "italic"

link :: Option Formats Boolean
link = opt "link"

size :: Option Formats Number
size = opt "size"

strike :: Option Formats Boolean
strike = opt "strike"

underline :: Option Formats Boolean
underline = opt "underline"

blockquote :: Option Formats Boolean
blockquote = opt "blockquote"

header :: Option Formats Int
header = opt "header"

indent :: Option Formats Int
indent = opt "indent"

align :: Option Formats Alignment
align = optWith show "align"

codeBlock :: Option Formats Boolean
codeBlock = opt "code-block"

-- | Specify text alignment.
data Alignment
    = Left
    | Center
    | Right
    | Justify

instance showAlignment :: Show Alignment where
    show Left    = "left"
    show Center  = "center"
    show Right   = "right"
    show Justify = "justify"

instance readAlignment :: Read Alignment where
    read "left"    = Just Left
    read "center"  = Just Center
    read "right"   = Just Right
    read "justify" = Just Justify
    read _ = Nothing

-- | E.g. "sans-serif"
type FontName = String

optWith :: forall opt a b . (a -> b) -> String -> Option opt a
optWith f = Op <<< \k v -> Options [Tuple k (toForeign $ f v)]

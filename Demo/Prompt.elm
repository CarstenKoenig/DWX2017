port module Prompt exposing (..)


port showPrompt : String -> Cmd msg


port promptResult : (String -> msg) -> Sub msg

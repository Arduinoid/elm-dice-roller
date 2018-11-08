module Playground exposing (Dude(..), foo)


type Dude
    = Good String
    | Bad String


foo : Dude -> String
foo dude =
    case dude of
        Good name ->
            "It's a good " ++ name

        Bad name ->
            "It's a bad " ++ name

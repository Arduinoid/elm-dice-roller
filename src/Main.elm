module Main exposing (main)

import Browser
import Html exposing (..)
import Http
import Json.Decode as Decode
import Pokedex exposing (..)
import Url.Builder as Url



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { name : String
    , number : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "Pokemon" 0
    , getPokemon 1
    )



-- UPDATE


type Msg
    = Next
    | Prev
    | New (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Next ->
            { model | number = model.number + 1 }
                ( model
                , getPokemon model.number
                )

        Prev ->
            { model | number = model.number - 1 }
                ( model
                , getPokemon model.number
                )

        New result ->
            case result of
                Ok pokemon ->
                    ( { model | name = nameDecoder pokemon }
                    , Cmd.none
                    )

                Err _ ->
                    ( model
                    , Cmd.none
                    )



-- SUBCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getPokemon : Int -> Cmd Msg
getPokemon num =
    Http.send New (Http.get "https://pokeapi.co/api/v2/pokedex/1" (nameDecoder num))


nameDecoder : String -> Result Json.Decode.Error String
nameDecoder json =
    decodeString (field "pokemon_species" (field "pokemon_entries" (field "name" string))) json

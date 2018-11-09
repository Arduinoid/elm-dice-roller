module Main exposing (main)

import Browser exposing (element)
import Browser.Events exposing (onKeyDown)
import Html exposing (Html, button, div, h1, h3, input, label, span, text)
import Html.Attributes exposing (for, id, placeholder, style, type_)
import Html.Events exposing (keyCode, onClick, onInput)
import Json.Decode as D
import Random
import View exposing (..)



-- MODEL


type alias Model =
    { dice : Dice
    , count : Int
    , inputCount : Int
    }


type alias Dice =
    List Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model [ 0 ] 1 1, Cmd.none )



-- MESSAGES


type Msg
    = KeyMsg Int
    | NewNumber Dice
    | UpdateCount
    | GatherInput String



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ id "view" ]
        [ div [] [ h1 [] [ text "Dice Roller" ] ]
        , div []
            [ label [ for "count" ] [ text "count" ]
            , input [ id "count", onInput GatherInput, placeholder "Enter a number..." ] []
            , button [ onClick UpdateCount ] [ text "update / roll" ]
            ]
        , h3 [] [ text "Press \"R\", \"Enter\", or click update to roll the dice" ]
        , div [ id "dice" ] (List.map genDieFace model.dice)
        ]



-- UPDATE


randomNumber : Int -> Cmd Msg
randomNumber count =
    Random.generate NewNumber (Random.list count (Random.int 1 6))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyMsg keycode ->
            case keycode of
                82 ->
                    ( model, randomNumber model.count )

                13 ->
                    ( { model | count = model.inputCount }, randomNumber model.inputCount )

                _ ->
                    ( model, Cmd.none )

        NewNumber numbers ->
            ( { model | dice = numbers }, Cmd.none )

        UpdateCount ->
            ( { model | count = model.inputCount }, randomNumber model.inputCount )

        GatherInput input ->
            let
                val =
                    String.toInt input
            in
            case val of
                Just num ->
                    ( { model | inputCount = num }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )



-- SUBSCRIPTIONS


makeKeyDecoder : D.Decoder Msg
makeKeyDecoder =
    D.map KeyMsg keyCode


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onKeyDown makeKeyDecoder ]



-- MAIN


main =
    element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

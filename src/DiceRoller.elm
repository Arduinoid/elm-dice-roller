module Main exposing (main)

import Browser exposing (element)
import Browser.Events exposing (onClick, onKeyDown)
import Html exposing (Html, br, div, span, text)
import Html.Attributes exposing (style)
import Json.Decode as D
import Random



-- MODEL


type alias Model =
    Dice


type alias Dice =
    List Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( [ 0, 0, 0 ], Cmd.none )



-- MESSAGES


type Msg
    = MouseMsg
    | KeyMsg
    | NewNumber Dice



-- VIEW


dieDot : Char -> Int -> Html Msg
dieDot dot number =
    let
        s =
            String.fromChar dot

        styling =
            [ style "margin" "0 40px" ]
    in
    case number of
        1 ->
            span styling [ text s ]

        _ ->
            span styling [ text " " ]


genRow : List Int -> Html Msg
genRow list =
    List.map (dieDot '*') list
        |> div [ style "width" "360px" ]


oneFace : List (Html Msg)
oneFace =
    [ genRow [ 0, 0, 0 ]
    , genRow [ 0, 1, 0 ]
    , genRow [ 0, 0, 0 ]
    ]


twoFace : List (Html Msg)
twoFace =
    [ genRow [ 1, 0, 0 ]
    , genRow [ 0, 0, 0 ]
    , genRow [ 0, 0, 1 ]
    ]


threeFace : List (Html Msg)
threeFace =
    [ genRow [ 1, 0, 0 ]
    , genRow [ 0, 1, 0 ]
    , genRow [ 0, 0, 1 ]
    ]


fourFace : List (Html Msg)
fourFace =
    [ genRow [ 1, 0, 1 ]
    , genRow [ 0, 0, 0 ]
    , genRow [ 1, 0, 1 ]
    ]


fiveFace : List (Html Msg)
fiveFace =
    [ genRow [ 1, 0, 1 ]
    , genRow [ 0, 1, 0 ]
    , genRow [ 1, 0, 1 ]
    ]


sixFace : List (Html Msg)
sixFace =
    [ genRow [ 1, 0, 1 ]
    , genRow [ 1, 0, 1 ]
    , genRow [ 1, 0, 1 ]
    ]


noneFace : List (Html Msg)
noneFace =
    [ genRow [ 1, 1, 1 ]
    , genRow [ 1, 1, 1 ]
    , genRow [ 1, 1, 1 ]
    ]


chooseDieFace : Int -> List (Html Msg)
chooseDieFace number =
    case number of
        1 ->
            oneFace

        2 ->
            twoFace

        3 ->
            threeFace

        4 ->
            fourFace

        5 ->
            fiveFace

        6 ->
            sixFace

        _ ->
            noneFace


genDie : Int -> Html Msg
genDie number =
    div
        [ style "padding" "20px"
        , style "margin" "10px"
        , style "display" "inline-block"
        , style "border" "solid #ccc 4px"
        , style "border-radius" "8px"
        , style "vertical-align" "top"
        ]
        (chooseDieFace number)


view : Model -> Html Msg
view model =
    div
        [ style "font-family" "sans-serif"
        , style "font-size" "6em"
        , style "padding" "100px"
        , style "text-align" "center"
        ]
        [ div [] [ text "Dice" ], div [] (List.map genDie model) ]



-- UPDATE


randomNumber =
    Random.generate NewNumber (Random.list 3 (Random.int 1 6))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg ->
            ( model, randomNumber )

        KeyMsg ->
            ( model, randomNumber )

        NewNumber numbers ->
            ( numbers, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ onClick (D.succeed MouseMsg)
        , onKeyDown (D.succeed KeyMsg)
        ]



-- MAIN


main =
    element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

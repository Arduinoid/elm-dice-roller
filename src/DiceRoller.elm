module Main exposing (main)

import Browser exposing (element)
import Browser.Events exposing (onKeyDown)
import Html exposing (Html, button, div, input, span, text, h1, h2, h3)
import Html.Attributes exposing (style, type_, placeholder)
import Html.Events exposing (onClick, onInput, keyCode)
import Json.Decode as D
import Random



-- MODEL


type alias Model =
    { dice : Dice
    , count : Int
    , inputCount : Int
    }


type alias Dice =
    List Int


init : () -> ( Model, Cmd Msg )
init _ = ( Model [0] 1 1, Cmd.none)



-- MESSAGES


type Msg
    = KeyMsg Int
    | NewNumber Dice
    | UpdateCount
    | GatherInput String



-- VIEW


oneFace : List (Html Msg)
oneFace =
    [ genDotRow [ 0, 0, 0 ]
    , genDotRow [ 0, 1, 0 ]
    , genDotRow [ 0, 0, 0 ]
    ]


twoFace : List (Html Msg)
twoFace =
    [ genDotRow [ 1, 0, 0 ]
    , genDotRow [ 0, 0, 0 ]
    , genDotRow [ 0, 0, 1 ]
    ]


threeFace : List (Html Msg)
threeFace =
    [ genDotRow [ 1, 0, 0 ]
    , genDotRow [ 0, 1, 0 ]
    , genDotRow [ 0, 0, 1 ]
    ]


fourFace : List (Html Msg)
fourFace =
    [ genDotRow [ 1, 0, 1 ]
    , genDotRow [ 0, 0, 0 ]
    , genDotRow [ 1, 0, 1 ]
    ]


fiveFace : List (Html Msg)
fiveFace =
    [ genDotRow [ 1, 0, 1 ]
    , genDotRow [ 0, 1, 0 ]
    , genDotRow [ 1, 0, 1 ]
    ]


sixFace : List (Html Msg)
sixFace =
    [ genDotRow [ 1, 0, 1 ]
    , genDotRow [ 1, 0, 1 ]
    , genDotRow [ 1, 0, 1 ]
    ]


noneFace : List (Html Msg)
noneFace =
    [ genDotRow [ 1, 1, 1 ]
    , genDotRow [ 1, 1, 1 ]
    , genDotRow [ 1, 1, 1 ]
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


dieDot : Char -> Int -> Html Msg
dieDot dot number =
    let
        s =
            String.fromChar dot

        styling =
            [ style "margin" "0 0.2em"
            , style "font-size" "1.8em"
            , style "font-weight" "bold"
            ]
    in
    case number of
        1 ->
            span styling [ text s ]

        _ ->
            span styling [ text " " ]


genDotRow : List Int -> Html Msg
genDotRow list =
    List.map (dieDot '*') list
        |> div [ style "width" "5em"
               , style "line-height" "0.8"
               ]


genDieFace : Int -> Html Msg
genDieFace number =
    div
        [ style "padding-top" "20px"
        , style "margin" "10px"
        , style "display" "inline-block"
        , style "font-size" "4em"
        , style "border" "solid #ccc 4px"
        , style "border-radius" "8px"
        , style "vertical-align" "top"
        ]
        (chooseDieFace number)


view : Model -> Html Msg
view model =
    div
        [ style "font-family" "sans-serif"
        , style "padding" "100px"
        , style "text-align" "center"
        ]
        [ div [ style "font-size" "3em" ] [ h1 [ ] [ text "Dice" ] ]
        , div [ style "font-size" "3em" ]
            [ h2 [] [text "count"]
            , input [ onInput GatherInput, placeholder "Enter a number..."
                    , style "height" "2em"
                    , style "width" "8em"
                    , style "font-size" "1em"
                    ] []
            , button [ onClick UpdateCount
                     , style "font-size" "1.4em"
                     ] [ text "update / roll" ]
            ]
        , h3 [style "font-size" "2em"] [ text "Press \"R\" or click update to roll the dice" ]
        , div [] (List.map genDieFace model.dice)
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

                _ ->
                    ( model, Cmd.none )

        NewNumber numbers ->
            ( { model | dice = numbers }, Cmd.none )

        UpdateCount ->
            ( { model | count = model.inputCount }, randomNumber model.inputCount )

        GatherInput input ->
            let
                val = String.toInt input
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

module View exposing (chooseDieFace, dieDot, fiveFace, fourFace, genDieFace, genDotRow, noneFace, oneFace, sixFace, threeFace, twoFace)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (style, class)



-- DIE FACES


oneFace : List (Html msg)
oneFace =
    [ genDotRow [ 0, 0, 0 ]
    , genDotRow [ 0, 1, 0 ]
    , genDotRow [ 0, 0, 0 ]
    ]


twoFace : List (Html msg)
twoFace =
    [ genDotRow [ 1, 0, 0 ]
    , genDotRow [ 0, 0, 0 ]
    , genDotRow [ 0, 0, 1 ]
    ]


threeFace : List (Html msg)
threeFace =
    [ genDotRow [ 1, 0, 0 ]
    , genDotRow [ 0, 1, 0 ]
    , genDotRow [ 0, 0, 1 ]
    ]


fourFace : List (Html msg)
fourFace =
    [ genDotRow [ 1, 0, 1 ]
    , genDotRow [ 0, 0, 0 ]
    , genDotRow [ 1, 0, 1 ]
    ]


fiveFace : List (Html msg)
fiveFace =
    [ genDotRow [ 1, 0, 1 ]
    , genDotRow [ 0, 1, 0 ]
    , genDotRow [ 1, 0, 1 ]
    ]


sixFace : List (Html msg)
sixFace =
    [ genDotRow [ 1, 0, 1 ]
    , genDotRow [ 1, 0, 1 ]
    , genDotRow [ 1, 0, 1 ]
    ]


noneFace : List (Html msg)
noneFace =
    [ genDotRow [ 1, 1, 1 ]
    , genDotRow [ 1, 1, 1 ]
    , genDotRow [ 1, 1, 1 ]
    ]


chooseDieFace : Int -> List (Html msg)
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


dieDot : Char -> Int -> Html msg
dieDot char number =
    let
        dot =
            String.fromChar char

        blank =
            " "

        styling =
            class "dot"
    in
    case number of
        1 ->
            span [styling] [ text dot ]

        _ ->
            span [styling] [ text blank ]


genDotRow : List Int -> Html msg
genDotRow list =
    List.map (dieDot '*') list
        |> div
            [ class "dot-row"]


genDieFace : Int -> Html msg
genDieFace number =
    div
        [ class "die-face"]
        (chooseDieFace number)

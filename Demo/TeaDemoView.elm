module TeaDemoView exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (style, src)


main : Html Never
main =
    init
        |> view


type alias Model =
    { augenzahl : Int
    }


init : Model
init =
    Model 5


view : Model -> Html Never
view model =
    viewDice model.augenzahl



-- Bilder der Würfel aus https://commons.wikimedia.org/wiki/File:Dice.png


viewDice : Int -> Html Never
viewDice n =
    let
        diceWidth =
            224

        diceHeight =
            224

        offsetX =
            ((n - 1) % 3) * diceWidth

        offsetY =
            if n > 3 then
                diceHeight
            else
                0

        top =
            toString (-offsetY) ++ "px"

        left =
            toString (-offsetX) ++ "px"
    in
        div
            [ style
                [ ( "width", toString diceWidth ++ "px" )
                , ( "height", toString diceHeight ++ "px" )
                , ( "display", "inline-block" )
                , ( "background-image", "url(Dice.png)" )
                , ( "background-position", left ++ " " ++ top )
                ]
            ]
            []

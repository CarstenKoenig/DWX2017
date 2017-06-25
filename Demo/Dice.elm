module Dice exposing (Model, Msg, init, update, view, random)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style, src)
import Random as Rnd


type alias Model =
    { augenzahl : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 1, Cmd.none )


type Msg
    = AugenzahlAendern Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AugenzahlAendern n ->
            ( { model | augenzahl = n }, Cmd.none )


random : Cmd Msg
random =
    Rnd.generate AugenzahlAendern (Rnd.int 1 6)


view : Model -> Html Msg
view model =
    viewDice model.augenzahl



-- Bilder der Würfel aus https://commons.wikimedia.org/wiki/File:Dice.png


viewDice : Int -> Html Msg
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

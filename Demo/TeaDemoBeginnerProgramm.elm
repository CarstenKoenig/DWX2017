module TeaDemoBeginnerProgramm exposing (..)

import Html exposing (Html, beginnerProgram, div, button, text)
import Html.Attributes exposing (style, src)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    beginnerProgram
        { model = init
        , update = update
        , view = view
        }


type alias Model =
    { augenzahl : Int
    }


init : Model
init =
    Model 1


type Msg
    = AugenzahlAendern Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        AugenzahlAendern n ->
            { model | augenzahl = n }


view : Model -> Html Msg
view model =
    div []
        [ viewDice model.augenzahl
        , viewSwitchButtons
        ]


viewSwitchButtons : Html Msg
viewSwitchButtons =
    div [] (List.map viewSwitchButton (List.range 1 6))


viewSwitchButton : Int -> Html Msg
viewSwitchButton n =
    button
        [ onClick (AugenzahlAendern n)
        , style
            [ ( "font-size", "2em" )
            , ( "width", "50px" )
            ]
        ]
        [ text (toString n) ]



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

module TeaDemoRandom exposing (..)

import Html exposing (Html, program, div, button, text)
import Html.Attributes exposing (style, src)
import Html.Events exposing (onClick)
import Random as Rnd


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


type alias Model =
    { augenzahl : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 1, Cmd.none )


type Msg
    = AugenzahlAendern Int
    | ZufaelligAendern


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AugenzahlAendern n ->
            ( { model | augenzahl = n }, Cmd.none )

        ZufaelligAendern ->
            ( model, zufallszahlErzeugen )


zufallszahlErzeugen : Cmd Msg
zufallszahlErzeugen =
    Rnd.generate AugenzahlAendern (Rnd.int 1 6)


view : Model -> Html Msg
view model =
    div []
        [ div [] [ viewDice model.augenzahl ]
        , viewRndButton
        ]


viewRndButton : Html Msg
viewRndButton =
    button
        [ onClick ZufaelligAendern
        , style
            [ ( "font-size", "2em" )
            , ( "width", "100px" )
            ]
        ]
        [ text "rnd" ]



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

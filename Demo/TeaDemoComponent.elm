module TeaDemoComponent exposing (..)

import Html exposing (Html, program, div, button, text)
import Html.Attributes exposing (style, src)
import Html.Events exposing (onClick)
import Dice


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


type alias Model =
    { dice : Dice.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        ( diceModel, diceInitCmd ) =
            Dice.init
    in
        ( Model diceModel, Cmd.map DiceMsg diceInitCmd )


type Msg
    = DiceMsg Dice.Msg
    | ZufaelligAendern


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DiceMsg diceMsg ->
            let
                ( newDiceModel, diceUpdateCmd ) =
                    Dice.update diceMsg model.dice
            in
                ( { model | dice = newDiceModel }, Cmd.map DiceMsg diceUpdateCmd )

        ZufaelligAendern ->
            ( model, Cmd.map DiceMsg Dice.random )


view : Model -> Html Msg
view model =
    div []
        [ Dice.view model.dice |> Html.map DiceMsg
        , viewRndButton
        ]


viewRndButton : Html Msg
viewRndButton =
    div []
        [ button
            [ onClick ZufaelligAendern
            , style
                [ ( "font-size", "2em" )
                , ( "width", "100px" )
                ]
            ]
            [ text "RND" ]
        ]

module TeaDemoComponentList exposing (..)

import Html exposing (Html, program, div, button, text)
import Html.Attributes exposing (style, src)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import Dice


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


nrDice : Int
nrDice =
    5


type alias Model =
    { dices : Dict Int Dice.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        modelsAndCmds =
            List.repeat nrDice Dice.init

        models =
            modelsAndCmds
                |> List.indexedMap (\i ( model, _ ) -> ( i, model ))
                |> Dict.fromList

        cmds =
            modelsAndCmds
                |> List.indexedMap (\i ( _, cmd ) -> Cmd.map (DiceMsg i) cmd)
    in
        ( Model models
        , Cmd.batch cmds
        )


type Msg
    = DiceMsg Int Dice.Msg
    | ZufaelligAendern


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DiceMsg index diceMsg ->
            case Dict.get index model.dices of
                Nothing ->
                    ( model, Cmd.none )

                Just diceModel ->
                    let
                        ( newDiceModel, diceUpdateCmd ) =
                            Dice.update diceMsg diceModel
                    in
                        ( { model
                            | dices = Dict.insert index newDiceModel model.dices
                          }
                        , Cmd.map (DiceMsg index) diceUpdateCmd
                        )

        ZufaelligAendern ->
            ( model
            , Dict.keys model.dices
                |> List.map (\i -> Cmd.map (DiceMsg i) Dice.random)
                |> Cmd.batch
            )


view : Model -> Html Msg
view model =
    div []
        ((model.dices
            |> Dict.map (\i dice -> Dice.view dice |> Html.map (DiceMsg i))
            |> Dict.values
         )
            ++ [ viewRndButton ]
        )


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

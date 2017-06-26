module TeaDemoPorts exposing (..)

import Html exposing (Html, program, div, button, text, h1)
import Html.Attributes exposing (style, src)
import Html.Events exposing (onClick)
import Prompt


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always (Prompt.promptResult PromptResult)
        }


type alias Model =
    { result : String
    }


init : ( Model, Cmd Msg )
init =
    ( { result = "" }
    , Cmd.none
    )


type Msg
    = ShowPrompt
    | PromptResult String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowPrompt ->
            ( model, Prompt.showPrompt "Name?" )

        PromptResult answer ->
            ( { model | result = answer }, Cmd.none )


view : Model -> Html Msg
view model =
    let
        info =
            if model.result == "" then
                ""
            else
                "Hallo " ++ model.result
    in
        div []
            [ h1 [] [ text info ]
            , button
                [ onClick ShowPrompt
                , style
                    [ ( "font-size", "2em" )
                    , ( "width", "100px" )
                    ]
                ]
                [ text "Name?" ]
            ]

module TeaDemoPorts exposing (..)

import Html exposing (Html, program, div, button, text)
import Html.Attributes exposing (style, src)
import Html.Events exposing (onClick)
import Alert


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}
    , Cmd.none
    )


type Msg
    = ShowAlert


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowAlert ->
            ( model, Alert.show "using Port" )


view : Model -> Html Msg
view model =
    div []
        [ button
            [ onClick ShowAlert
            , style
                [ ( "font-size", "2em" )
                , ( "width", "100px" )
                ]
            ]
            [ text "!!!" ]
        ]

import Html exposing (Html, text, div, h1)
import Html.Attributes as Attributes
import Html.App as App

main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

type alias Model =
    {
    }

type Msg = Something

init : (Model, Cmd x)
init = (Model, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Something ->
            (model, Cmd.none)

view : Model -> Html Msg
view model =
    div [] []

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

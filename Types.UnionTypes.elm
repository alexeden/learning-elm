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

init : (Model, Cmd Msg)
init =
    (tasks, Cmd.none)

tasks : Model
tasks =
    [ Task "Clean the kitchen" True
    , Task "Buy a bed" False
    ]

type alias Model = List Task

type alias Task =
    { description : String
    , complete : Bool
    }

type Visibility = All | Active | Completed

type Msg
    = Show

show : Visibility -> Model -> Model
show vis tasks =
    case vis of
        All ->
            tasks
        Active ->
            tasks
                |> List.filter (\t -> not t.complete)
        Completed ->
            tasks
                |> List.filter (\t -> t.complete)

update : Msg -> Model -> (Model, Cmd Msg)
update msg tasks =
    case msg of
        Show ->
            (tasks, Cmd.none)



view : Model -> Html Msg
view model =
    div
        []
        []

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

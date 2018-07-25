import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Random

main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

-- MODEL
type alias Model =
    { values : (List Int)
    }

init : (Model, Cmd Msg)
init =
    (Model (List.repeat 100 1), Cmd.none)

-- UPDATE
type Msg
    = Roll
    | NewValue (List Int)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewValue (Random.list (List.length model.values) (Random.int 1 6))
            )
        NewValue newValue ->
            ( Model newValue
            , Cmd.none
            )

-- VIEW

view : Model -> Html Msg
view model =
    div []
        (  button [ onClick Roll, style [ ("display", "block") ] ] [ text "Roll the dice" ]
        :: List.map createDice model.values
        )

createDice : Int -> Html Msg
createDice value =
    p
        [ style
            [ ("display", "inline-block")
            , ("width", "100px")
            , ("margin", "1rem")
            , ("line-height", "1rem")
            ]
        ]
        [ text (toString value) ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

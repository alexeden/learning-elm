import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String



main =
    App.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model =
    { counter : Int
    , content : String
    , age : Int
    }

model : Model
model =
    { counter = 0
    , content = ""
    , age = 18
    }


-- UPDATE
type Msg
    = Increment
    | Decrement
    | Reset
    | ChangeContent String

update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeContent newContent ->
            { model | content = newContent }
        Increment ->
            { model | counter = .counter model + 1 }
        Decrement ->
            { model | counter = .counter model - 1 }
        Reset ->
            { model | counter = 0 }

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text <| toString <| model.counter ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Reset ] [ text "Reset" ]
        , input [ onInput ChangeContent, placeholder "Let's reverse it" ] []
        , div [] [ text <| String.reverse <| model.content ]
        , alertMsg ("That's a palindrome!", "Not a palindrome") <| isPalindrome <| model.content
        ]

alertMsg : (String, String) -> Bool -> Html msg
alertMsg (successMsg, errorMsg) good =
    let
        (color, message) =
            if good then
                ("green", successMsg)
            else
                ("red", errorMsg)
    in
        div
            [ style
                [ ("color", color)
                ]
            ]
            [ text message
            ]


isPalindrome : String -> Bool
isPalindrome inputString =
    inputString
        |> String.reverse
        |> (==) inputString

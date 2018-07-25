import Http
import Task
import Json.Decode as Json
import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit, onWithOptions)

main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

-- MODEL
type alias Model =
    { topic : String
    , imgSrc : String
    }

init : (Model, Cmd Msg)
init =
    (Model "cats" "waiting.gif", Cmd.none)

-- UPDATE
type Msg
    = GetNewImage
    | ChangeTopic String
    | FetchSucceed String
    | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetNewImage ->
            (model, getNewImage model.topic)

        ChangeTopic topic ->
            (Model topic model.imgSrc, Cmd.none)

        FetchSucceed newSrc ->
            (Model model.topic newSrc, Cmd.none)

        FetchFail error ->
            (model, Cmd.none)

getNewImage : String -> Cmd Msg
getNewImage topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
        Task.perform FetchFail FetchSucceed (Http.get extractImgSrc url)

extractImgSrc : Json.Decoder String
extractImgSrc =
    Json.at ["data", "image_url"] Json.string


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [   h1 [] [ text model.topic ]
        ,   input
            [ onInput ChangeTopic
            , placeholder model.topic
            ] []
        ,   button [ onClick GetNewImage ] [ text "More please!" ]
        ,   img [ src model.imgSrc ] []
        ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

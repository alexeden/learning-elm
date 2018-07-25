-- nodemon --exec "elm-make --yes --output index.js GithubUserSearch.elm" -e "elm html"
import Http
import Task
import Json.Decode as Json
import Json.Decode exposing ((:=))
import Html exposing (..)
import Html.App as App
import Html.Attributes as Attr
import Html.Events exposing (onClick, onInput)


main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }

type alias Model =
    { name : String
    , avatar_url : Maybe String
    }

type Msg
    = SearchString String
    | FetchSucceed Model
    | FetchFail Http.Error


init : (Model, Cmd x)
init = (Model "" Nothing, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SearchString string ->
            (model, searchUser string)
        FetchSucceed model ->
            (model, Cmd.none)
        FetchFail error ->
            (Model "" Nothing, Cmd.none)


profilePic : Model -> String
profilePic model =
    case model.avatar_url of
        Nothing ->
            "./not-found.jpg"
        Just src ->
            src


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


searchUser : String -> Cmd Msg
searchUser str =
    let
        url =
            "https://api.github.com/users/" ++ str
    in
        Task.perform FetchFail FetchSucceed (Http.get parseResponse url)


{--
Decoder a

Represent an operation that when given JSON data,
returns a value of type "a".

decodeString : Decoder a -> String -> Result String a
tuple1 : (a -> value) -> Decoder a -> Decoder value
object1 : (a -> value) -> Decoder a -> Decoder value

--}

parseResponse : Json.Decoder Model
parseResponse =
    Json.object2 Model
        ("name" := Json.string)
        (Json.maybe ("avatar_url" := Json.string))





view : Model -> Html Msg
view model =
    div
        [ Attr.class "mdl-grid" ]
        [ div
            [ Attr.class "mdl-cell mdl-cell--6-col" ]
            [ div
                []
                [ input
                    [ Attr.class "mdl-textfield__input"
                    , Attr.type' "text"
                    , Attr.id "searchInput"
                    , onInput SearchString
                    ]
                    []
                , label
                    [ Attr.for "searchInput" ]
                    [ text "Search Github users" ]
                ]
            ]
        , div
            [ Attr.class "mdl-cell mdl-cell--6-col" ]
            [ div
                [ Attr.class "mdl-card mdl-shadow--2dp" ]
                [ div
                    [ Attr.class "mdl-card__title"
                    , Attr.style
                        [ ("background", "url('" ++ (profilePic model) ++ "') center / cover")
                        , ("min-height", "200px")
                        ]
                    ]
                    [ h2
                        [ Attr.class "mdl-card__title-text" ]
                        [ text model.name ]
                    ]
                ]
            ]
        ]

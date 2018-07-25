import Html exposing (Html, text, div, h1)
import Html.Attributes as Attributes
import Html.App as App

-- main =
--     App.program
--         { init = init
--         , update = update
--         , subscriptions = subscriptions
--         , view = view
--         }

type alias User =
    { name : String
    , age : Maybe Int
    }


alex : User
alex =
    { name = "Alex"
    , age = Just 25
    }

sam : User
sam =
    { name = "Sam"
    , age = Nothing
    }

canBuyBooze : User -> Bool
canBuyBooze user =
    case user.age of
        Nothing -> False
        Just age ->
            age >= 21

ageOfMinor : User -> Maybe Int
ageOfMinor user =
    case user.age of
        Nothing -> Nothing
        Just age ->
            if (age >= 13) && (age < 18) then
                Just age
            else
                Nothing

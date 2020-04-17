port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (..)
import Random
import FEN

port getParam : (Int -> msg) -> Sub msg
port setParam : Int -> Cmd msg

main = Browser.element { init          = init
                       , update        = update
                       , subscriptions = subscriptions
                       , view          = view
                       }

type alias Model = { position : Int }

init : () -> (Model, Cmd Msg)
init _ = (Model 0 , Cmd.none)

type Msg = Roll | NewPosition Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NewPosition newPosition -> (Model newPosition, setParam newPosition)
    Roll                    -> (model, Random.generate NewPosition (Random.int 0 (FEN.totalFensCount - 1)))

subscriptions : Model -> Sub Msg
subscriptions model = getParam NewPosition

view : Model -> Html Msg
view model =
  div [class "col s12 center-align valign-wrapper"]
    [ h3 [ class "fen"] [ text (Maybe.withDefault "no such FEN" (FEN.fens model.position)) ]
    , div [ class "fixed-action-btn" ] [
        button [ class "btn-floating btn-large blue pulse", onClick Roll ] [
          i [ class "large material-icons" ] [ text "↺" ]
        ]
      ]
    ]

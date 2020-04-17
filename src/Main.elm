import Browser
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (..)
import Random
import FEN

main = Browser.element { init          = init
                       , update        = update
                       , subscriptions = subscriptions
                       , view          = view
                       }

type alias Model = { position : Int }

init : () -> (Model, Cmd Msg)
init _ = (Model 0 , Cmd.none)

type Msg = Roll
         | NewPosition Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll                    -> (model, Random.generate NewPosition (Random.int 0 (FEN.totalFensCount - 1)))
    NewPosition newPosition -> (Model newPosition, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

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

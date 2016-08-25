module View exposing (..)
import Html exposing (..)
import Types exposing (..)

rootView : Model -> Html Msg
rootView model =
  div []
    [ h1 [] [ text "foobar" ] ]

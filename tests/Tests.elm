module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Types exposing (..)

all : Test
all =
    describe "Gwent"
        [
          test "Play card" <|
          \() ->
              Expect.equal (playCard emptyRound Player1 (Card 1 Melee)) 
                { player1 = { value = 1, combatType = Melee } :: []
                , player2 = []
                , round = 1 } 

        , 
        test "String.left" <|
            \() ->
                Expect.equal "a" (String.left 1 "abcdefg")
--        , test "This test should fail" <|
--            \() ->
--                Expect.fail "failed as expected!"
        ]

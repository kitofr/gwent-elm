module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Types exposing (..)

all : Test
all =
    describe "Gwent"
        [
          test "Player1 play card" <|
          \() ->
              Expect.equal (playCard emptyRound Player1 (Card 1 Melee)) 
                { player1 = { value = 1, combatType = Melee } :: []
                , player2 = []
                , round = 1 } 

         ,test "Player2 play card" <|
          \() ->
              Expect.equal (playCard emptyRound Player2 (Card 1 Melee)) 
                { player2 = { value = 1, combatType = Melee } :: []
                , player1 = []
                , round = 1 } 
        ]

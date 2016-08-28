module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Types exposing (..)

all : Test
all =
    describe "Gwent" [
      describe "A round " [
          test "Player1 play card" <|
          \() ->
              Expect.equal (playCard emptyRound Player1 (Card 1 Melee Skellige)) 
                { player1 = { value = 1, combatType = Melee, faction = Skellige } :: []
                , player2 = []
                , round = 1 
                , playerState = (Playing, Playing) } 

         ,test "Player2 play card" <|
          \() ->
              Expect.equal (playCard emptyRound Player2 (Card 1 Melee Skellige)) 
                { player2 = { value = 1, combatType = Melee, faction = Skellige } :: []
                , player1 = []
                , round = 1 
                , playerState = (Playing, Playing) 
                } 
         ,test "Can't play card after a pass" <|
           \() ->
             let round = { emptyRound | playerState = (Passed, Playing) } 
             in
              Expect.equal (playCard round Player1 (Card 1 Melee Skellige))
                round
        ]    
    ]

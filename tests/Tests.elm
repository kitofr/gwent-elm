module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Types exposing (..)

all : Test
all =
    describe "Gwent" [
      describe "A round " [
          test "Player1 play card, becomes Player2s turn" <|
          \() ->
              Expect.equal (playCard (Started emptyRound) Player1 (Card 1 Melee Skellige)) 
                (Started { player1 = { value = 1, combatType = Melee, faction = Skellige } :: []
                  , player2 = []
                  , round = 1 
                  , playerState = (Playing, Playing) 
                  , turn = Player2 } )

         ,test "Player2 play card, becomes Player1s turn" <|
          \() ->
              Expect.equal (playCard (Started emptyRound) Player2 (Card 1 Melee Skellige)) 
                (Started { player2 = { value = 1, combatType = Melee, faction = Skellige } :: []
                  , player1 = []
                  , round = 1 
                  , playerState = (Playing, Playing) 
                  , turn = Player1 } )

         ,test "Player1 pass" <|
           \() ->
              Expect.equal (pass (Started emptyRound) Player1) 
                (Started { player2 = []
                  , player1 = []
                  , round = 1 
                  , playerState = (Passed, Playing) 
                  , turn = Player2 } )

         ,test "Can't play card after a pass" <|
           \() ->
             let roundState = (Finished { emptyRound | playerState = (Passed, Playing) })
             in
              Expect.equal (playCard roundState Player1 (Card 1 Melee Skellige))
                roundState
        ]    
    ]

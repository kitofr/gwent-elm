module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Types exposing (..)

all : Test
all =
    describe "Gwent" [
      describe "A round " [
        describe "Play card" [
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
       ]
       , describe "Passing" [
         test "Player1 pass" <|
           \() ->
              Expect.equal (pass (Started emptyRound) Player1) 
                (Started { player2 = []
                  , player1 = []
                  , round = 1 
                  , playerState = (Passed, Playing) 
                  , turn = Player2 } )

        ,test "Player2 pass" <|
          \() -> 
            Expect.equal (pass (Started emptyRound) Player2) 
              (Started { player2 = []
              , player1 = []
              , round = 1 
              , playerState = (Playing, Passed) 
              , turn = Player1 } )

         ,test "Both passes ends round" <|
           \() ->
             Expect.equal (pass (pass (Started emptyRound) Player1) Player2)
              (Finished { player2 = []
              , player1 = []
              , round = 1 
              , playerState = (Passed, Passed) 
              , turn = Player2 })

      ]
      , describe "Special scenarios" [
         test "Play card after a pass is noop" <|
           \() ->
             let roundState = (Finished { emptyRound | playerState = (Passed, Playing) })
             in
              Expect.equal (playCard roundState Player1 (Card 1 Melee Skellige))
                roundState

         ,test "Passes does not clear played cards" <|
           \() ->
             let turn1 = (playCard (Started emptyRound) Player1 (Card 1 Melee Skellige))
             in 
                Expect.equal (pass turn1 Player2)
                  (Started { player2 = []
                  , player1 = { value = 1, combatType = Melee, faction = Skellige } :: []
                  , round = 1
                  , playerState = (Playing, Passed)
                  , turn = Player1 })
       ]    
       , describe "the score" [
          test "score starts at 0" <|
          \() ->  
            Expect.equal (score emptyRound) (0,0)

         ,test "is equal to the card value total" <|
          \() ->  
            let turn1 = (playCard (Started emptyRound) 
                                  Player1 
                                  (Card 1 Melee Skellige))
                turn2 = (playCard turn1 Player2 (Card 7 Ranged Monsters))
                turn3 = (playCard turn2 Player1 (Card 2 Ranged Skellige))
            in
                Expect.equal (score (getRound turn3)) (3,7)
       ]
    ]
  ]

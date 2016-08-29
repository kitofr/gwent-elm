module Types exposing (..)

type CombatType
  = Melee
  | Ranged
  | Siege

type Faction
  = Nilfgaard
  | NorthenRealms
  | Monsters
  | Scoiatael
  | Skellige

type alias Card = { value: Int, combatType: CombatType, faction: Faction }

type Msg = String

type Player 
  = Player1
  | Player2

-- Turn
type PlayerState
  = Playing
  | Passed

type alias Round = 
  { round: Int
    ,player1: List Card
    ,player2: List Card
    ,playerState: (PlayerState, PlayerState)
    ,turn: Player -- Maybe ?
  } 

type alias Game = { 
  round1: Round
  , round2: Round
  , round3: Round
} 

type RoundState 
  = Started Round
  | Finished Round

type alias Model = {
  game: Game
}

emptyRound : Round
emptyRound = 
  { round = 1
  , player1 = []
  , player2 = []
  , playerState = (Playing, Playing)
  , turn = Player1 }

playCard : RoundState -> Player -> Card -> RoundState
playCard roundState player card =
  case roundState of
    Started round ->
      case round.playerState of
       (Playing, Playing) ->  
         case player of
           Player1 -> (Started { round | player1 = card :: round.player1, turn = Player2 } )
           Player2 -> (Started { round | player2 = card :: round.player2, turn = Player1 } )
       (Playing, Passed) ->
         case player of
           Player1 -> (Started { round | player1 = card :: round.player1, turn = Player1 } )
           Player2 -> (Started round )
       (Passed, Playing) ->
         case player of
           Player1 -> (Started round)
           Player2 -> (Started { round | player2 = card :: round.player2, turn = Player2 })
       (Passed, Passed) ->
         (Finished round)
    _ -> roundState

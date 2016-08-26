module Types exposing (..)

type CombatType
  = Melee
  | Ranged
  | Siege

type alias Card = { value: Int, combatType: CombatType  }

type Msg = String

type Player 
  = Player1
  | Player2

type PlayerState
  = Playing
  | Passed

type alias Round = 
  { round: Int
    ,player1: List Card
    ,player2: List Card
    ,playerState: (PlayerState, PlayerState)
  } 

type alias Game = { 
  round1: Round
  , round2: Round
  , round3: Round
} 

type alias Model = {
  game: Game
}

emptyRound : Round
emptyRound = 
  { round = 1, player1 = [], player2 = [], playerState = (Playing, Playing) }

playCard : Round -> Player -> Card -> Round
playCard round player card =
  case player of
    Player1 -> { round | player1 = card :: round.player1 } 
    Player2 -> { round | player2 = card :: round.player2 }

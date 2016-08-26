module Types exposing (..)

type CombatType
  = Melee
  | Ranged
  | Siege

type alias Card = { value: Int, combatType: CombatType  }

type Msg
  = PlayCard Player Card
  | Pass 

type Player 
  = Player1
  | Player2

type alias Round = 
  { round: Int
    ,player1: List Card
    ,player2: List Card
  } 

type alias Game = { } 

type alias Model = {
  game: Game
}

emptyRound : Round
emptyRound = 
  { round = 1, player1 = [], player2 = [] }

playCard : Round -> Player -> Card -> Round
playCard round player card =
  { round | player1 = card :: round.player1 } 

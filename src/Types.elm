module Types exposing (..)

type CombatType
  = Melee
  | Ranged
  | Siege

type alias Card = { value: Int, combatType: CombatType  }

type Msg
  = PlayCard Player Card
  | Pass 

type Player = Int

type alias Round = 
  { round: Int
    ,player1: List Card
    ,player2: List Card
  } 

type alias Game = { } 

type alias Model = {
  game: Game
}

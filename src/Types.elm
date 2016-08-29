module Types exposing (..)
type Msg = String
type alias Model = Int

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
    ,turn: Player -- Maybe ?
  } 

type RoundState 
  = Started Round
  | Finished Round

emptyRound : Round
emptyRound = 
  { round = 1
  , player1 = []
  , player2 = []
  , playerState = (Playing, Playing)
  , turn = Player1 -- coin toss
  }

pass : RoundState -> Player -> RoundState
pass roundState player =
  case roundState of
    Started round ->
      case round.playerState of
       (Playing, Playing) ->  
         case player of
           Player1 -> (Started { round | playerState = (Passed, Playing), turn = Player2 } )
           Player2 -> (Started { round | playerState = (Playing, Passed), turn = Player1 } )
       (Playing, Passed) ->
         case player of
           Player1 -> (Finished { round | playerState = (Passed, Passed) } )
           Player2 -> roundState 
       (Passed, Playing) ->
         case player of
           Player1 -> roundState
           Player2 -> (Finished { round | playerState = (Passed, Passed)  })
       (Passed, Passed) ->
         (Finished round)
    _ -> roundState

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

getRound : RoundState -> Round
getRound roundState =
  case roundState of
    Started round -> round
    Finished round -> round

score : Round -> (Int, Int)
score round =
  let sum cards = List.map (\x -> x.value) cards |> List.sum
      p1Score = sum round.player1
      p2Score = sum round.player2
  in
      (p1Score,p2Score)

type alias Game = { 
  rounds: (Round, Round, Round)
} 


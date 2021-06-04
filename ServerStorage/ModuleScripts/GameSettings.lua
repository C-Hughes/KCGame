local GameSettings = {}

-- Game Variables
GameSettings.intermissionDuration = 2
GameSettings.matchDuration = 20
GameSettings.minimumPlayers = 2
GameSettings.transitionTime = 5


-- Possible ways that the game can end.
GameSettings.endStates = {
	TimerUp = "TimerUp",
	FoundWinner = "FoundWinner",
	MaxFinished = "MaxPlayersFinished"
}

return GameSettings

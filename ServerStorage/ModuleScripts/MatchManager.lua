local MatchManager = {}

-- Services
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local playerManager = require(moduleScripts:WaitForChild("PlayerManager"))
local SelectGameManager = require(moduleScripts:WaitForChild("SelectGameManager"))
local StartGameManager = require(moduleScripts:WaitForChild("StartGameManager"))
local ResetGameManager = require(moduleScripts:WaitForChild("ResetGameManager"))
local gameSettings = require(moduleScripts:WaitForChild("GameSettings"))
local timer = require(moduleScripts:WaitForChild("Timer"))
local displayManager = require(moduleScripts:WaitForChild("DisplayManager"))


-- Events
local events = ServerStorage:WaitForChild("Events")
local matchStart = events:WaitForChild("MatchStart")
local matchEnd = events:WaitForChild("MatchEnd")

-- Values
local displayValues = ReplicatedStorage:WaitForChild("DisplayValues")
local timeLeft = displayValues:WaitForChild("TimeLeft")

-- Creates a new timer object to be used to keep track of match time.
local myTimer = timer.new()

-- Local Functions
local function stopTimer()
	myTimer:stop()
end

local function timeUp()
	print("Time is up!")
	matchEnd:Fire(gameSettings.endStates.TimerUp)
	--Stop current Game
	StartGameManager.stopCurrentGame()
end

local function startTimer()
	print("Timer started")
	myTimer:start(gameSettings.matchDuration)
	myTimer.finished:Connect(timeUp)
	
	while myTimer:isRunning() do
		-- Adding +1 makes sure the timer display ends at 1 instead of 0.
		timeLeft.Value = (math.floor(myTimer:getTimeLeft() + 1))
		-- By not setting the time for wait, it offers more accurate looping
		wait()
	end
end

-- Module Functions
function MatchManager.prepareGame()
	--Freeze Player
	playerManager.freezePlayers()
	
	--Display Match Loading Screen
	displayManager.gameLoadingGUI(SelectGameManager.gameSelected)
	playerManager.sendPlayersToMatch()

	--Remove Match Loading Screen
	wait(5)
	displayManager.gameLoadingGUI(SelectGameManager.gameSelected)
	
	--Play Match Cut Scene
	displayManager.gameCutScene(SelectGameManager.gameSelected, 8)
	wait(8)
	
	--Start the Countdown
	displayManager.startCountdown()
	--UnFreeze Player
	playerManager.unFreezePlayers()
	
	matchStart:Fire()
	--Start the Selected Game
	StartGameManager.startSelectedGame()
end

function MatchManager.getEndStatus(endState)
	local statusToReturn
	
	if endState == gameSettings.endStates.FoundWinner then
		local winnerName = playerManager.getWinnerName()
		statusToReturn = "Winner is : " .. winnerName
	elseif endState == gameSettings.endStates.MaxFinished then
		statusToReturn = "Maximum Players Finished!"
	elseif endState == gameSettings.endStates.TimerUp then
		statusToReturn = "Time ran out!"
	else
		statusToReturn = "Error found"
	end
	
	return statusToReturn
end

function MatchManager.cleanupMatch()
	print("CLEANUP")
	ResetGameManager.resetSelectedGame()
end

function MatchManager.resetMatch()
	playerManager.resetPlayers()	
end

matchStart.Event:Connect(startTimer)
matchEnd.Event:Connect(stopTimer)

return MatchManager

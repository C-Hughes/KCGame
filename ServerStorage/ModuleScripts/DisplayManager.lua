local DisplayManager = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local selectGameManager = require(moduleScripts:WaitForChild("SelectGameManager"))
local playerManager = require(moduleScripts:WaitForChild("PlayerManager"))

-- Display Values used to update Player GUI
local displayValues = ReplicatedStorage:WaitForChild("DisplayValues")
local status = displayValues:WaitForChild("Status")
local playersLeft = displayValues:WaitForChild("PlayersLeft")
local playerStatus = displayValues:WaitForChild("PlayerStatus")
local timeLeft = displayValues:WaitForChild("TimeLeft")

-- Local Functions
local function updateRoundStatus()
	--status.Value = "Players Left: " .. playersLeft.Value .. " / Time Left: " .. timeLeft.Value
	if selectGameManager.gameWinType == "LastManStanding" then
		playerStatus.Value = "Players Remaining: " .. playersLeft.Value
	else
		playerStatus.Value = "Players Finished: " .. #playerManager.finishedPlayers .. "/" .. playerManager.maxPlayersThatCanFinish
	end
end

-- Module Functions
function DisplayManager.gameLoadingGUI(gameSelection)
	--game.ReplicatedStorage.gameSelection:FireAllClients()
	print("Displaying "..gameSelection.." Loading Screen........")
	--game.ReplicatedStorage[gameSelection]:FireAllClients()
	game.ReplicatedStorage.ToggleLoadingGUI:FireAllClients(gameSelection)
end

function DisplayManager.gameCutScene(gameSelection, timeToWait)
	print("Displaying "..gameSelection.." CutScene........")
	--local gameSelection = gameSelection .. "gameSelection"
	--game.ReplicatedStorage[gameSelection.."CutScene"]:FireAllClients(timeToWait)
	game.ReplicatedStorage.TriggerCutScene:FireAllClients(gameSelection, timeToWait)
	
end

function DisplayManager.updateStatus(newStatus)
	status.Value = newStatus
end

function DisplayManager.hideGameStatusGUI()
	print("hideGameStatusGUI FIRE")
	playerStatus.Value = " "
	timeLeft.Value = 0
end

function DisplayManager.startCountdown()
	
	status.Value = "3"
	wait(1)
	status.Value = "2"
	wait(1)
	status.Value = "1"
	wait(1)
	status.Value = "GO!"
	wait(1)
	status.Value = " "
	
	--[[
	status.Value = "3"
	for size = 5, 100, 5 do
		textLabel.TextSize = size
		textLabel.TextTransparency = size / 200
		wait()
	end
	wait(1)
	status.Value = "2"
	for size = 5, 100, 5 do
		textLabel.TextSize = size
		textLabel.TextTransparency = size / 200
		wait()
	end
	wait(1)
	status.Value = "1"
	-or size = 5, 100, 5 do
		textLabel.TextSize = size
		textLabel.TextTransparency = size / 200
		wait()
	end
	wait(1)
	status.Value = "Go!"
	for size = 5, 100, 5 do
		textLabel.TextSize = size
		textLabel.TextTransparency = size / 200
		wait()
	end
	wait(1)
	]]
end

playersLeft.Changed:Connect(updateRoundStatus)
--timeLeft.Changed:Connect(updateRoundStatus)

return DisplayManager

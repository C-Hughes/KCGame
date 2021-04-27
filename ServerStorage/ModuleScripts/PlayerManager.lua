local PlayerManager = {}

-- Services
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local gameSettings = require(moduleScripts:WaitForChild("GameSettings"))
local SelectGameManager = require(moduleScripts:WaitForChild("SelectGameManager"))


-- Events
local events = ServerStorage:WaitForChild("Events")
local matchEnd = events:WaitForChild("MatchEnd")



-- Map Variables
local lobbySpawn = workspace.StartSpawn
local arenaMap = workspace.Arena
--local spawnLocations = arenaMap.SpawnLocations
local testingSpawner = "CannonBallRunSpawners"
local spawnLocations = workspace[testingSpawner].SpawnLocations




-- Values
local displayValues = ReplicatedStorage:WaitForChild("DisplayValues")
local playersLeft = displayValues:WaitForChild("PlayersLeft")



-- Player Variables
local activePlayers = {}



------------ Local Functions ------------------
local function onPlayerJoin(player)
	player.RespawnLocation = lobbySpawn
end

local function checkPlayerCount()
	if #activePlayers == 1 then
		matchEnd:Fire(gameSettings.endStates.FoundWinner)
	end
end

local function removeActivePlayer(player)
	for playerKey, whichPlayer in pairs(activePlayers) do
		if whichPlayer == player then
			table.remove(activePlayers, playerKey)
			playersLeft.Value = #activePlayers
			checkPlayerCount()
		end
	end
end

local function respawnPlayerInLobby(player)
	player.RespawnLocation = lobbySpawn
	player:LoadCharacter()
end

local function preparePlayer(player, whichSpawn)
	player.RespawnLocation = whichSpawn
	player:LoadCharacter()
	
	local character = player.Character or player.CharacterAdded:Wait()
	
	local humanoid = character:WaitForChild("Humanoid")
	
	humanoid.Died:Connect(function()
		respawnPlayerInLobby(player)
		removeActivePlayer(player)
	end)
end




------------- Module Functions  ------------
function PlayerManager.sendPlayersToMatch()
	print("Sending players to match")
	
	--local arenaSpawns = spawnLocations:GetChildren()
	local arenaSpawns = workspace[SelectGameManager.gameSelectedTPPoint].SpawnLocations:GetChildren()
	
	for playerKey, whichPlayer in pairs(Players:GetPlayers()) do
		table.insert(activePlayers,whichPlayer)	
		local spawnLocation = arenaSpawns[1]
		preparePlayer(whichPlayer, spawnLocation)
		table.remove(arenaSpawns, 1)
	end
	
	playersLeft.Value = #activePlayers
end

function PlayerManager.getWinnerName()
	if activePlayers[1] then
		local winningPlayer = activePlayers[1]
		return winningPlayer.Name
	else
		return "Error: No winning player found"
	end
end

function PlayerManager.resetPlayers()
	for playerKey, whichPlayer in pairs(activePlayers) do
		respawnPlayerInLobby(whichPlayer)
	end
	
	activePlayers = {}
end

function PlayerManager.freezePlayers()
	print("Freezing Players")
	for playerKey, whichPlayer in pairs(Players:GetPlayers()) do
		whichPlayer.Character.Humanoid.WalkSpeed = 0
		whichPlayer.Character.Humanoid.JumpPower = 0
	end
end

function PlayerManager.unFreezePlayers()
	print("UnFreezing Players")
	for playerKey, whichPlayer in pairs(Players:GetPlayers()) do
		whichPlayer.Character.Humanoid.WalkSpeed = 16
		whichPlayer.Character.Humanoid.JumpPower = 50
	end
end
-- Events
Players.PlayerAdded:Connect(onPlayerJoin)

return PlayerManager

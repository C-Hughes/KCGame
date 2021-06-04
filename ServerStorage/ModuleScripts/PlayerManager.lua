local PlayerManager = {}

-- Services
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ds = game:GetService("DataStoreService")

-- Modules
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local gameSettings = require(moduleScripts:WaitForChild("GameSettings"))
local SelectGameManager = require(moduleScripts:WaitForChild("SelectGameManager"))
local coinsODS = ds:GetOrderedDataStore("SaveData")

-- Events
local events = ServerStorage:WaitForChild("Events")
local matchEnd = events:WaitForChild("MatchEnd")


-- Map Variables
local lobbySpawn = workspace.StartSpawn

-- Values
local displayValues = ReplicatedStorage:WaitForChild("DisplayValues")
local playersLeft = displayValues:WaitForChild("PlayersLeft")

-- Player Variables
PlayerManager.activePlayers = {}
PlayerManager.finishedPlayers = {}
PlayerManager.maxPlayersThatCanFinish = 0
PlayerManager.playersWithScores = {}
PlayerManager.playerScores = {}

-- Remote Events
local updateActivePlayersEvent = ReplicatedStorage:WaitForChild("UpdateSpactateGUI")
local showFinalResultsEvent = ReplicatedStorage:WaitForChild("showFinalResults")
local hideFinalResultsEvent = ReplicatedStorage:WaitForChild("hideFinalResults")

------------ Local Functions ------------------
local function onPlayerJoin(player)
	player.RespawnLocation = lobbySpawn
end

local function checkPlayerCount()
	--If Game Finish Type == MaxFinished
	if SelectGameManager.gameWinType == "MaxFinished" then
		print("CheckPlayerCount - MaxFinished")
		--If Game Finish Type == LastManStanding
		if #PlayerManager.finishedPlayers == PlayerManager.maxPlayersThatCanFinish then
			matchEnd:Fire(gameSettings.endStates.MaxFinished)
		end
	else
		print("CheckPlayerCount - LastManStanding")
		--If Game Finish Type == LastManStanding
		if #PlayerManager.activePlayers == 1 then
			matchEnd:Fire(gameSettings.endStates.FoundWinner)
		end
	end
end

local function addPlayerWin(player)
	local stats = player:FindFirstChild("leaderstats")
	local win = stats:FindFirstChild("Wins")
	win.Value = win.Value + 1
	print("1 win added to "..player.Name)
end

local function respawnPlayerInLobby(player)
	player.RespawnLocation = lobbySpawn
	player:LoadCharacter()
end

local function setMaxFinishers()
	PlayerManager.maxPlayersThatCanFinish = math.ceil(#PlayerManager.activePlayers / 2)
end


------------- Module Functions  ------------
function PlayerManager.removeActivePlayer(player)
	for playerKey, whichPlayer in pairs(PlayerManager.activePlayers) do
		if whichPlayer == player then
			table.remove(PlayerManager.activePlayers, playerKey)
			playersLeft.Value = #PlayerManager.activePlayers
			checkPlayerCount()
			--Send active Players to client
			print("Remove Active Player!")
			updateActivePlayersEvent:FireAllClients(PlayerManager.activePlayers)
			print("Updating active player list....")
		end
	end
end

function PlayerManager.addFinishedPlayer(player)
	local alreadyFinished = false
	for playerKey, whichPlayer in pairs(PlayerManager.finishedPlayers) do
		if whichPlayer == player then
			alreadyFinished = true
		end
	end
	if alreadyFinished == false then
		table.insert(PlayerManager.finishedPlayers,player)
		print("Add Finished Player!")
		--print(PlayerManager.finishedPlayers)
		checkPlayerCount()
		--if Finished player == 1, add win to that player
		if #PlayerManager.finishedPlayers == 1 then
			addPlayerWin(player)
		end
	end
end

local function addScoreToPlayers()	
	--Get Total number of players to give score to
	local numFinished = #PlayerManager.finishedPlayers
		
	--Winner get 50 Points
	--Top 20% (0.2) 35 Points
	--Top 50% (0.5) 20 Points
	--Rest of Finished Players 10 Points
	--Any active players get 2 points.
	
	local top20 = math.ceil((numFinished * 0.2) - 1)
	local top50 = math.ceil((numFinished * 0.5) - top20)
	
	local stats = PlayerManager.finishedPlayers[1]:FindFirstChild("leaderstats")
	local score = stats:FindFirstChild("Score")
	score.Value = score.Value + 50
	
	table.insert(PlayerManager.playersWithScores,PlayerManager.finishedPlayers[1])
	table.insert(PlayerManager.playerScores,"50")
	
	--Top 20%
	for i = 1,top20,1  do 
		local stats = PlayerManager.finishedPlayers[i+1]:FindFirstChild("leaderstats")
		local score = stats:FindFirstChild("Score")
		score.Value = score.Value + 35 
		
		table.insert(PlayerManager.playersWithScores,PlayerManager.finishedPlayers[i+1])
		table.insert(PlayerManager.playerScores,"35")
	end
	--Top 50%
	for i = 1,top50,1  do 
		local stats = PlayerManager.finishedPlayers[i+1+top20]:FindFirstChild("leaderstats")
		local score = stats:FindFirstChild("Score")
		score.Value = score.Value + 20 
		
		table.insert(PlayerManager.playersWithScores,PlayerManager.finishedPlayers[i+1+top20])
		table.insert(PlayerManager.playerScores,"20")
	end
	--Rest
	for i = 2+top20+top50,numFinished,1  do 
		local stats = PlayerManager.finishedPlayers[i]:FindFirstChild("leaderstats")
		local score = stats:FindFirstChild("Score")
		score.Value = score.Value + 10 
		
		table.insert(PlayerManager.playersWithScores,PlayerManager.finishedPlayers[i])
		table.insert(PlayerManager.playerScores,"10")
	end	
	
	--Give 2 points to all active players
	for playerKey, whichPlayer in pairs(PlayerManager.activePlayers) do
		local stats = whichPlayer:FindFirstChild("leaderstats")
		local score = stats:FindFirstChild("Score")
		score.Value = score.Value + 2
		
		table.insert(PlayerManager.playersWithScores,whichPlayer)
		table.insert(PlayerManager.playerScores,"2")
	end
end

local function preparePlayer(player, whichSpawn)
	player.RespawnLocation = whichSpawn
	player:LoadCharacter()
	
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	
	humanoid.Died:Connect(function()
		respawnPlayerInLobby(player)
		PlayerManager.removeActivePlayer(player)
	end)
end

function PlayerManager.sendPlayersToMatch()
	print("Sending players to match")
	--Hide the end results gui
	hideFinalResultsEvent:FireAllClients()
	
	--local arenaSpawns = spawnLocations:GetChildren()
	local arenaSpawns = workspace[SelectGameManager.gameSelectedTPPoint].SpawnLocations:GetChildren()
	
	for playerKey, whichPlayer in pairs(Players:GetPlayers()) do
		table.insert(PlayerManager.activePlayers,whichPlayer)	
		local spawnLocation = arenaSpawns[1]
		preparePlayer(whichPlayer, spawnLocation)
		table.remove(arenaSpawns, 1)
	end
	
	--Set number of active players this match
	setMaxFinishers()
	playersLeft.Value = #PlayerManager.activePlayers
	--Fire Spectate GUI Event
	updateActivePlayersEvent:FireAllClients(PlayerManager.activePlayers)
	print("Updating active player list init....")
end

function PlayerManager.getWinnerName()
	if PlayerManager.activePlayers[1] then
		local winningPlayer = PlayerManager.activePlayers[1]
		return winningPlayer.Name
	else
		return "Error: No winning player found"
	end
end

function PlayerManager.playerCrossedFinish(player)
	PlayerManager.makePlayerInvisible(player)
	--Teleport to Finish
	PlayerManager.teleportToFinish(player)
	--Add Player to FinishedPlayer array
	PlayerManager.addFinishedPlayer(player)
	--Remove from ActivePlayers array
	PlayerManager.removeActivePlayer(player)
	--Show spectateGUI
	game.ReplicatedStorage.ShowSpectateGUI:FireClient(player, PlayerManager.activePlayers)
end

function PlayerManager.resetPlayers()
	--Give Players Score
	addScoreToPlayers()
	
	--Put players back into lobby
	for playerKey, whichPlayer in pairs(PlayerManager.finishedPlayers) do
		respawnPlayerInLobby(whichPlayer)
	end
	for playerKey, whichPlayer in pairs(PlayerManager.activePlayers) do
		respawnPlayerInLobby(whichPlayer)
	end
	
	--Show Results Screen when players back in lobby
	showFinalResultsEvent:FireAllClients(PlayerManager.playersWithScores, PlayerManager.playerScores)
	
	PlayerManager.activePlayers = {}
	PlayerManager.finishedPlayers = {}
	PlayerManager.playersWithScores = {}
	PlayerManager.playerScores = {}
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

function PlayerManager.makePlayerInvisible(player)
	if player:FindFirstChild("Humanoid") then
		if player then
			for _, part in ipairs(player:GetDescendants()) do

				-- make sure the part is a base part so that properties exist
				if part:IsA("BasePart") then
					part.Transparency = 1
					part.CanCollide = false
				end
			end
		end
		print("Player Invisible")
	end
end

function PlayerManager.teleportToFinish(player)
	local character = player.Character
	
	--FreezePlayer
	character.Humanoid.WalkSpeed = 0
	character.Humanoid.JumpPower = 0
	
	--TP to FinishedArea
	character:FindFirstChild("HumanoidRootPart").Position = Vector3.new(-59.1, 21.5, 341.45)
	print("Player TP'd to Finish")
end

-- Events
Players.PlayerAdded:Connect(onPlayerJoin)

return PlayerManager

local CastleRunGame = {}

-- Services
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local playerManager = require(moduleScripts:WaitForChild("PlayerManager"))


CastleRunGame.__index = CastleRunGame

--Module Variables
CastleRunGame.clone = game.Workspace.DoorDashGroups:Clone()

function CastleRunGame.new()

	local self = setmetatable({}, CastleRunGame)

	self._finishedEvent = Instance.new("BindableEvent")
	self.finished = self._finishedEvent.Event

	self._running = false

	return self
end


function CastleRunGame.reset()
	local model = game.Workspace.DoorDashGroups
	model:Destroy()
	wait(0.5)
	local lclone = CastleRunGame.clone:Clone()
	lclone.Parent = Workspace
	model = lclone
end

-- Finish Line
game.Workspace.CastleRunFinish.Touched:Connect(function(hit)
	if game.Players:GetPlayerFromCharacter(hit.Parent) then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		
		playerManager.playerCrossedFinish(player)
		--[[
		--Make Invisible
		playerManager.makePlayerInvisible(player)
		--Teleport to Finish
		playerManager.teleportToFinish(player)
		--Add Player to FinishedPlayer array
		playerManager.addFinishedPlayer(player)
		--Remove from ActivePlayers array
		playerManager.removeActivePlayer(player)
		--Show spectateGUI
		game.ReplicatedStorage.ShowSpectateGUI:FireClient(player, playerManager.activePlayers)]]
	end
end)

function CastleRunGame:start()
	self._running = true
end

function CastleRunGame:isRunning()
	return self._running
end

function CastleRunGame:stop()
	self._running = false
end


return CastleRunGame

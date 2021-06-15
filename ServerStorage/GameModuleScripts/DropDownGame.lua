local DropDownGame = {}

-- Services
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local playerManager = require(moduleScripts:WaitForChild("PlayerManager"))


DropDownGame.__index = DropDownGame


function DropDownGame.new()

	local self = setmetatable({}, DropDownGame)

	self._finishedEvent = Instance.new("BindableEvent")
	self.finished = self._finishedEvent.Event

	self._running = false

	return self
end


function DropDownGame.reset()
	local platforms = game.Workspace.DropDownGame.DropDownPlatforms:GetChildren()
	for i, platform in ipairs(platforms) do
		platform.Transparency = 0
		platform.CanCollide = true
	end
	
	local spawners = game.Workspace.DropDownSpawners.SpawnLocations:GetChildren()	
	for i, spawner in ipairs(spawners) do
		spawner.Transparency = 0
		spawner.CanCollide = true
	end
end


function DropDownGame:start()
	self._running = true
	--Set Start Platforms to Invisible/Turn off collisions
	local spawners = game.Workspace.DropDownSpawners.SpawnLocations:GetChildren()	
	for i, spawner in ipairs(spawners) do
		spawner.Transparency = 1
		spawner.CanCollide = false
	end
end

function DropDownGame:isRunning()
	return self._running
end

function DropDownGame:stop()
	self._running = false
end


return DropDownGame

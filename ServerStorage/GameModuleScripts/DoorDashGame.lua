local DoorDashGame = {}

-- Services
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local playerManager = require(moduleScripts:WaitForChild("PlayerManager"))


DoorDashGame.__index = DoorDashGame

--Module Variables
DoorDashGame.clone = game.Workspace.DoorDashGroups:Clone()

function DoorDashGame.new()

	local self = setmetatable({}, DoorDashGame)

	self._finishedEvent = Instance.new("BindableEvent")
	self.finished = self._finishedEvent.Event

	self._running = false

	return self
end


local RandomNumber1 = 0
local RandomNumber2 = 0
local RandomNumber3 = 0

function generateRandomNum(Num, i)
	RandomNumber1 = math.random(1,3)
	
	if Num == 2 or Num == 3 then
		local Generate = true
		while Generate == true do
			RandomNumber2 = math.random(1,i)
			--If RandomNumber2 && RandomNumber1 are not the same, then break
			if RandomNumber2 ~= RandomNumber1 then
				Generate = false
			end
		end
		if Num == 3 then
			local Generate3 = true
			while Generate3 == true do
				RandomNumber3 = math.random(1,7)
				--If RandomNumber3 && RandomNumber1 are not the same, then break
				if RandomNumber3 ~= RandomNumber1 then
					Generate3 = false
				end
			end
		end
	end
end

function setDoors()
	-- loop over the door groups and set some to unAnchored
	local doorGroups = game.Workspace.DoorDashGroups:GetChildren()
	
	for i, doorGroup in ipairs(doorGroups) do
		
		local thisDoorGroup = doorGroup:GetChildren()
		print("DoorGroup "..doorGroup.Name)
		
		if i == 6 then
			--Generate 3 Random Numbers
			generateRandomNum(3, #thisDoorGroup)
		elseif i==7 or i==5 or i==4 or i==3 then
			--Generate 2 Random Numbers
			generateRandomNum(2, #thisDoorGroup)
		else
			--Generate 1 Random Number
			generateRandomNum(1, #thisDoorGroup)
		end
		
		for j, door in ipairs(thisDoorGroup) do

			local doorsDoor = door.Door:GetChildren()
			for k, doorPart in ipairs(doorsDoor) do

				--If it is the first group of doors, unAnchor 5 doors
				if i==7 then
					if(j == RandomNumber1 or j == RandomNumber2)then
						--Skip
					else
						doorPart.Anchored = false
						doorPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						--doorPart.BrickColor = BrickColor.new("Cyan")
					end
				else
					--If it is the 2nd-last door group
					if(j == RandomNumber1)then
						doorPart.Anchored = false
						doorPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						--doorPart.BrickColor = BrickColor.new("Cyan")
					end
					if(j == RandomNumber2 and (i==6 or i==5 or i==4 or i==3))then
						doorPart.Anchored = false
						doorPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						--doorPart.BrickColor = BrickColor.new("Cyan")
					end
					if(j == RandomNumber3 and i==6)then
						doorPart.Anchored = false
						doorPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
						--doorPart.BrickColor = BrickColor.new("Cyan")
					end
				end
			end			
		end	
	end	
end

function DoorDashGame.reset()
	local model = game.Workspace.DoorDashGroups
	model:Destroy()
	wait(0.5)
	local lclone = DoorDashGame.clone:Clone()
	lclone.Parent = Workspace
	model = lclone
end

-- Finish Line
game.Workspace.DoorDashFinish.Touched:Connect(function(hit)
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

function DoorDashGame:start()
	setDoors()
	self._running = true
end

function DoorDashGame:isRunning()
	return self._running
end

function DoorDashGame:stop()
	self._running = false
end


return DoorDashGame

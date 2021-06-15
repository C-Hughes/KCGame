local DuckAndDiveGame = {}

-- Services
local ServerStorage = game:GetService("ServerStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local playerManager = require(moduleScripts:WaitForChild("PlayerManager"))


DuckAndDiveGame.__index = DuckAndDiveGame

--Variables
local Arm1Pos, Arm1Ori
local Arm2Pos, Arm2Ori
running = false

function DuckAndDiveGame.new()

	local self = setmetatable({}, DuckAndDiveGame)

	self._finishedEvent = Instance.new("BindableEvent")
	self.finished = self._finishedEvent.Event

	self._running = false

	return self
end


function DuckAndDiveGame.reset()
	game.Workspace.DuckAndDiveHinge1.HingeConstraint.AngularVelocity = 0
	game.Workspace.DuckAndDiveHinge2.HingeConstraint.AngularVelocity = 0
	wait(1)
	game.Workspace.DuckAndDiveTopArm.Position = Arm1Pos
	game.Workspace.DuckAndDiveBottomArm.Position = Arm2Pos
	game.Workspace.DuckAndDiveTopArm.Orientation = Arm1Ori
	game.Workspace.DuckAndDiveBottomArm.Orientation = Arm2Ori
end


function DuckAndDiveGame:start()
	if not self._running then
		self._running = true
		running = true
		
		--Set Original Arm Positions
		Arm1Pos = game.Workspace.DuckAndDiveTopArm.Position
		Arm1Ori = game.Workspace.DuckAndDiveTopArm.Orientation
		Arm2Pos = game.Workspace.DuckAndDiveBottomArm.Position
		Arm2Ori = game.Workspace.DuckAndDiveBottomArm.Orientation
		
		--Start Spinning
		local hinge1 = game.Workspace.DuckAndDiveHinge1.HingeConstraint
		local hinge2 = game.Workspace.DuckAndDiveHinge2.HingeConstraint
		
		hinge1.AngularVelocity = 0.2
		hinge2.AngularVelocity = -0.1
	
	
		local newDuckAndDiveGameThread = coroutine.wrap(function()
			wait(5)
			for i = 1,20,1 do 
				hinge1.AngularVelocity = hinge1.AngularVelocity + 0.1
				hinge2.AngularVelocity = hinge2.AngularVelocity - 0.1
				wait(1)
			end
			while running do
				hinge1.AngularVelocity = hinge1.AngularVelocity + 0.01
				hinge2.AngularVelocity = hinge2.AngularVelocity - 0.011
				wait(3)
			end
		end)
		newDuckAndDiveGameThread()
	else
		warn("Warning: DUCKANDDIVEGAME could not start again as it is already running.")
	end

end

function DuckAndDiveGame:isRunning()
	return self._running
end

function DuckAndDiveGame:stop()
	self._running = false
	running = false
	wait(1)
	game.Workspace.DuckAndDiveHinge1.HingeConstraint.AngularVelocity = 0
	game.Workspace.DuckAndDiveHinge2.HingeConstraint.AngularVelocity = 0
end


return DuckAndDiveGame

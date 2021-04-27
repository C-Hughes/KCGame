local BallRunGame = {}
BallRunGame.__index = BallRunGame

function BallRunGame.new()
	
	local self = setmetatable({}, BallRunGame)

	self._finishedEvent = Instance.new("BindableEvent")
	self.finished = self._finishedEvent.Event

	self._running = false

	return self
end




local tweenService = game:GetService("TweenService")

local tweeningInformation = TweenInfo.new(
	0.3,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local newProperties = {
	Size = Vector3.new(10,10,10)
}


function createNewBall()

	local ballSpawnPoint = game.Workspace.BallRunBallSpawner

	local part = Instance.new("Part")
	part.Parent = Workspace
	part.Name = "BallRunBall"			
	part.Shape = Enum.PartType.Ball		
	part.Color = Color3.new(1, 1, 1)
	part.Position = ballSpawnPoint.Position
	part.Size = Vector3.new(4,4,4)
	part.Velocity = Vector3.new(0, 0, math.random(-7,7))

	tweenService:Create(part,tweeningInformation,newProperties):Play()
end

--Create despawner when ball falls off track
local DeSpawner = game.Workspace.BallRunBallDespawner

DeSpawner.Touched:Connect(function(hit)
	hit:Destroy()
end)


function BallRunGame:start()
	if not self._running then
		local newBallRunGameThread = coroutine.wrap(function()
			self._running = true
			while self._running do
				createNewBall()
				wait(2)
			end
			local completed = self._running
			self._running = false
			self._finishedEvent:Fire(completed)
		end)
		newBallRunGameThread()
	else
		warn("Warning: NEWBALLRUNGAME could not start again as it is already running.")
	end
end

function BallRunGame:isRunning()
	return self._running
end

function BallRunGame:stop()
	self._running = false
end


return BallRunGame

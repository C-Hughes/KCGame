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
	-- loop over the children and connect touch events
	--local ballBrick = game.Workspace.TestBall
	local ballSpawnPoint = game.Workspace.BallRunBallSpawner

	--tweenService:Create(ballBrick,tweeningInformation,newProperties):Play()

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

_G.startBallRun = function()

	while( _G.stopCurrentGame == false )
	do
		createNewBall()
		wait(2)
	end
	
	return
end

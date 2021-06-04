local TweenService = game:GetService("TweenService")

local camera = game.Workspace.Camera

cutsceneTime = 1

function tween(part1,part2)
	
	local tweenInfo = TweenInfo.new(
		cutsceneTime,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.Out,
		0,
		false,
		0
	)
	
	
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = part1.CFrame
	
	local tween = TweenService:Create(camera, tweenInfo, {CFrame = part2.CFrame})
	tween:Play()
	
	wait(cutsceneTime)
	
	camera.CameraType = Enum.CameraType.Custom
end


game.ReplicatedStorage.TriggerCutScene.OnClientEvent:Connect(function(gameSelection, timeToWait)
	cutsceneTime = timeToWait	
	tween(game.Workspace[gameSelection.."CSCamera1"],game.Workspace[gameSelection.."CSCamera2"])
end)

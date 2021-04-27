local DisplayManager = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Display Values used to update Player GUI
local displayValues = ReplicatedStorage:WaitForChild("DisplayValues")
local status = displayValues:WaitForChild("Status")
local playersLeft = displayValues:WaitForChild("PlayersLeft")
local timeLeft = displayValues:WaitForChild("TimeLeft")

-- Local Functions
local function updateRoundStatus()
	status.Value = "Players Left: " .. playersLeft.Value .. " / Time Left: " .. timeLeft.Value
end

-- Module Functions
function DisplayManager.updateStatus(newStatus)
	status.Value = newStatus
end

function DisplayManager.startCountdown()
	
	status.Value = "5"
	wait(1)
	status.Value = "4"
	wait(1)
	status.Value = "3"
	wait(1)
	status.Value = "2"
	wait(1)
	status.Value = "1"
	wait(1)
	status.Value = "GO!"
	wait(1)
	
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
timeLeft.Changed:Connect(updateRoundStatus)

return DisplayManager

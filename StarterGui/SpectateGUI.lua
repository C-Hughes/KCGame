local ReplicatedStorage = game:GetService("ReplicatedStorage")
local activePlayersEvent = ReplicatedStorage:WaitForChild("UpdateSpactateGUI")
local showGUIEvent = ReplicatedStorage:WaitForChild("ShowSpectateGUI")


local Players = game:GetService("Players")

local gui = script.Parent
local mainFrame = gui.MainFrame
local plrName = mainFrame.PlayerName
local prev = mainFrame.PrevBtn
local nxt = mainFrame.NextBtn

local num = 1
--local currentlySpectating = ""

local playersList = Players:GetPlayers()

local function SetCam(n)
	local p = playersList[n]
	--currentlySpectating = p.Name
	plrName.Text = p.Name
	workspace.CurrentCamera.CameraSubject = p.Character.Humanoid
end

prev.MouseButton1Click:Connect(function()
	if num > 1 then
		num = num - 1
	else
		num = #playersList
	end
	SetCam(num)
end)

nxt.MouseButton1Click:Connect(function()
	if num < #playersList then
		num = num + 1
	else
		num = 1
	end
	SetCam(num)
end)


local function showGUI(activePlayersList)
	script.Parent.Enabled = true
	playersList = activePlayersList
	SetCam(2)
end

--Wait for server to send active Players List
local function onActivePlayersFired(activePlayersList)
	playersList = activePlayersList
end


activePlayersEvent.OnClientEvent:Connect(onActivePlayersFired)
showGUIEvent.OnClientEvent:Connect(showGUI)

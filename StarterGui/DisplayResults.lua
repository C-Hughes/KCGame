local ReplicatedStorage = game:GetService("ReplicatedStorage")
local showFinalResultsEvent = ReplicatedStorage:WaitForChild("showFinalResults")
local hideFinalResultsEvent = ReplicatedStorage:WaitForChild("hideFinalResults")

--Wait for server to send active Players List
local function onShowFinalResults(finishedPlayersList, finishedPlayerScores)
	--Show the Results GUI
	script.Parent.Parent.Parent.Enabled = true
	
	for i, plr in pairs(finishedPlayersList) do

		local template = script.Template:Clone()

		template.Name = plr.Name .. "Leaderboard"
		template.PlrName.Text = plr.Name
		template.Rank.Text = i
		template.Score.Text = finishedPlayerScores[i]
		template.Parent = script.Parent
	end		
	
	wait(10)
	script.Parent.Parent.Parent.Enabled = false
end

local function onHideResultsFired(finishedPlayersList)
	script.Parent.Parent.Parent.Enabled = false
end

showFinalResultsEvent.OnClientEvent:Connect(onShowFinalResults)
hideFinalResultsEvent.OnClientEvent:Connect(onHideResultsFired)

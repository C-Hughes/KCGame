game.Players.PlayerAdded:Connect(function(plr)
	
	local ls = Instance.new("Folder")
	ls.Name = "leaderstats"
	ls.Parent = plr
	
	local coins = Instance.new("IntValue")
	coins.Name = "Score"
	coins.Value = 0
	coins.Parent = ls
	
	local coins = Instance.new("IntValue")
	coins.Name = "Wins"
	coins.Value = 0
	coins.Parent = ls

end)

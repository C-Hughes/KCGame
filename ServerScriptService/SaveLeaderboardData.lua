local ds = game:GetService("DataStoreService"):GetDataStore("SaveData")
game.Players.PlayerAdded:Connect(function(plr)
	wait()
	local plrkey = "id_"..plr.userId
	local save1 = plr.leaderstats.Score
	local save2 = plr.leaderstats.Wins
	
	local GetSaved = ds:GetAsync(plrkey)
	if GetSaved then
		save1.Value = GetSaved[1]
		save2.Value = GetSaved[2]
	else
		local NumberForSaving = {save1.Value, save2.Value}
		ds:GetAsync(plrkey, NumberForSaving)
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	ds:SetAsync("id_"..plr.userId, {plr.leaderstats.Score.Value, plr.leaderstats.Wins.Value})
end)

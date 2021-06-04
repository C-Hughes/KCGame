game.ReplicatedStorage.ToggleLoadingGUI.OnClientEvent:Connect(function(gameSelection)
	--script.Parent.Frame.Visible = not script.Parent.Frame.Visible
	
	script.parent[gameSelection.."LoadingScreen"].Frame.Visible = not script.parent[gameSelection.."LoadingScreen"].Frame.Visible
end)



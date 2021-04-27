-- Services
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local matchManager = require(moduleScripts:WaitForChild("MatchManager"))
local gameSettings = require(moduleScripts:WaitForChild("GameSettings"))
local displayManager = require(moduleScripts:WaitForChild("DisplayManager"))
local SelectGameManager = require(moduleScripts:WaitForChild("SelectGameManager"))

-- Events
local events = ServerStorage:WaitForChild("Events")
local matchEnd = events:WaitForChild("MatchEnd")


_G.startNewLobby = function ()
	while true do
				
		repeat
			displayManager.updateStatus("Waiting for Players...")
			wait(gameSettings.intermissionDuration)
			print("Restarting intermission")
		until Players.NumPlayers >= gameSettings.minimumPlayers

		print("Intermission over")
		--SELECT THE NEXT GAME
		SelectGameManager.selectNextGame()
		wait(gameSettings.transitionTime)
		displayManager.updateStatus("Get ready!")
		
		matchManager.prepareGame()
		local endState = matchEnd.Event:Wait()
		print("Game ended with: " .. endState)
		
		local endStatus = matchManager.getEndStatus(endState)
		displayManager.updateStatus(endStatus)
		
		matchManager.cleanupMatch()
		wait(gameSettings.transitionTime)
		
		matchManager.resetMatch()
	end
end

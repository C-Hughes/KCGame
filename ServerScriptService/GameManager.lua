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


_G.TEST = function ()
	print("STARTING GAME")
	
	while true do
				
		repeat
			displayManager.updateStatus("Waiting for Players...")
			wait(gameSettings.intermissionDuration)
			print("Restarting intermission")
		until Players.NumPlayers >= gameSettings.minimumPlayers

		print("Intermission over")
		--SELECT THE NEXT GAME
		SelectGameManager.selectNextGame()
		displayManager.updateStatus("Next game is... "..SelectGameManager.gameSelected)
		wait(gameSettings.transitionTime)
		displayManager.updateStatus("Get ready!")
		
		matchManager.prepareGame()
		local endState = matchEnd.Event:Wait()
		print("Game ended with: " .. endState)
		
		local endStatus = matchManager.getEndStatus(endState)
		displayManager.updateStatus(endStatus)
		
		displayManager.hideGameStatusGUI() --Clear Match playercount/timer gui
		
		wait(gameSettings.transitionTime)
		matchManager.resetMatch()
		
		matchManager.cleanupMatch()
	end
end

local StartGameManager = {}

-- Services
local ServerStorage = game:GetService("ServerStorage")

-- Modules
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local SelectGameManager = require(moduleScripts:WaitForChild("SelectGameManager"))
local gameModuleScripts = ServerStorage:WaitForChild("GameModuleScripts")
local BallRunGame = require(gameModuleScripts:WaitForChild("BallRunGame"))
local BlockPartyGame = require(gameModuleScripts:WaitForChild("BlockPartyGame"))

-- Events
local events = ServerStorage:WaitForChild("Events")
local ballRunGameStart = events:WaitForChild("BallRunGameStart")
local ballRunGameEnd = events:WaitForChild("BallRunGameEnd")
local blockPartyStart = events:WaitForChild("BlockPartyStart")
local blockPartyEnd = events:WaitForChild("BlockPartyEnd")

-- Creates a new timer object to be used to keep track of match time.
local myBallRunGame = BallRunGame.new()
local myBlockPartyGame = BlockPartyGame.new()

-- Local Functions


------------- Module Functions  ------------
function StartGameManager.startSelectedGame()

	if(SelectGameManager.gameSelected == "BlockParty")
	then
		print("Starting BlockParty" )
		myBlockPartyGame:start()
		
	elseif( SelectGameManager.gameSelected == "CannonBallRun" )
	then   
		print("Starting CannonBallRun" )
		myBallRunGame:start()

	elseif( SelectGameManager.gameSelected == "FallDown" )
	then
		print("Starting FallDown" )


	else
		print("START DEFAULT GAME" )
	end
end


function StartGameManager.stopCurrentGame()
	if(SelectGameManager.gameSelected == "BlockParty")
	then
		myBlockPartyGame:stop()
	elseif( SelectGameManager.gameSelected == "CannonBallRun" )
	then   
		myBallRunGame:stop()
	elseif( SelectGameManager.gameSelected == "FallDown" )
	then

	end
end



--ballRunGameStart.Event:Connect(startBallRunGame)
--ballRunGameEnd.Event:Connect(stopBallRunGame)

return StartGameManager

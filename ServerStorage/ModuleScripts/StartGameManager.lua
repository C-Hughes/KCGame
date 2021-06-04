local StartGameManager = {}

-- Services
local ServerStorage = game:GetService("ServerStorage")

-- Modules
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local SelectGameManager = require(moduleScripts:WaitForChild("SelectGameManager"))
local gameModuleScripts = ServerStorage:WaitForChild("GameModuleScripts")
local BallRunGame = require(gameModuleScripts:WaitForChild("BallRunGame"))
local BlockPartyGame = require(gameModuleScripts:WaitForChild("BlockPartyGame"))
local DoorDashGame = require(gameModuleScripts:WaitForChild("DoorDashGame"))
local CastleRunGame = require(gameModuleScripts:WaitForChild("CastleRunGame"))

-- Events
local events = ServerStorage:WaitForChild("Events")
local ballRunGameStart = events:WaitForChild("BallRunGameStart")
local ballRunGameEnd = events:WaitForChild("BallRunGameEnd")
local blockPartyStart = events:WaitForChild("BlockPartyStart")
local blockPartyEnd = events:WaitForChild("BlockPartyEnd")
local castleRunStart = events:WaitForChild("CastleRunStart")
local castleRunEnd = events:WaitForChild("CastleRunEnd")

-- Creates a new timer object to be used to keep track of match time.
local myBallRunGame = BallRunGame.new()
local myBlockPartyGame = BlockPartyGame.new()
local myDoorDashGame = DoorDashGame.new()
local myCastleRunGame = CastleRunGame.new()

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

	elseif( SelectGameManager.gameSelected == "DizzyHeights" )
	then
		print("Starting DizzyHeights" )

	elseif( SelectGameManager.gameSelected == "DoorDash" )
	then
		print("Starting DoorDash" )
		myDoorDashGame:start()
		
	elseif( SelectGameManager.gameSelected == "CastleRun" )
	then
		print("Starting CastleRun" )
		myCastleRunGame:start()

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
		
	elseif( SelectGameManager.gameSelected == "DizzyHeights" )
	then

	end
end



--ballRunGameStart.Event:Connect(startBallRunGame)
--ballRunGameEnd.Event:Connect(stopBallRunGame)

return StartGameManager

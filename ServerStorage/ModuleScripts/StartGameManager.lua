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
local DropDownGame = require(gameModuleScripts:WaitForChild("DropDownGame"))
local DuckAndDiveGame = require(gameModuleScripts:WaitForChild("DuckAndDiveGame"))

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
local myDropDownGame = DropDownGame.new()
local myDuckAndDiveGame = DuckAndDiveGame.new()

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

	elseif( SelectGameManager.gameSelected == "DropDown" )
	then
		print("Starting DropDown" )
		myDropDownGame:start()

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
		
	elseif( SelectGameManager.gameSelected == "DuckAndDive" )
	then
		print("Starting DuckAndDive" )
		myDuckAndDiveGame:start()

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
	elseif( SelectGameManager.gameSelected == "DropDown" )
	then
		
	elseif( SelectGameManager.gameSelected == "DizzyHeights" )
	then
		
	elseif( SelectGameManager.gameSelected == "CastleRun" )
	then
		myCastleRunGame:stop()
		
	elseif( SelectGameManager.gameSelected == "DuckAndDive" )
	then
		myDuckAndDiveGame:stop()
	end
end


return StartGameManager

local ResetGameManager = {}

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


------------- Module Functions  ------------
function ResetGameManager.resetSelectedGame()

	if(SelectGameManager.gameSelected == "BlockParty")
	then
		print("Reset BlockParty" )


	elseif( SelectGameManager.gameSelected == "CannonBallRun" )
	then   
		print("Reset CannonBallRun" )

	elseif( SelectGameManager.gameSelected == "DropDown" )
	then
		print("Reset DropDownGame" )
		DropDownGame.reset()

	elseif( SelectGameManager.gameSelected == "DizzyHeights" )
	then
		print("Reset DizzyHeights" )

	elseif( SelectGameManager.gameSelected == "DoorDash" )
	then
		print("Reset DoorDash" )
		DoorDashGame.reset()
		
	elseif( SelectGameManager.gameSelected == "CastleRun" )
	then
		print("Reset CastleRun" )
		CastleRunGame.reset()
		
	elseif( SelectGameManager.gameSelected == "DuckAndDive" )
	then
		print("Reset DuckAndDive" )
		DuckAndDiveGame.reset()
	else
		print("Reset DEFAULT GAME" )
	end
end

return ResetGameManager

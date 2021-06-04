local SelectGameManager = {}


-- Services
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local gameSettings = require(moduleScripts:WaitForChild("GameSettings"))

--Variables
SelectGameManager.gameSelected = ""
SelectGameManager.gameSelectedTPPoint = ""
SelectGameManager.gameWinType = ""

--Select Random Game
function SelectGameManager.selectNextGame()

	--local gameSelectionGen = math.random(1,6)
	local gameSelectionGen = 6
	
	if(gameSelectionGen == 1)
	then
		--BlockParty
		print("Next Game is BlockParty" )
		SelectGameManager.gameSelected = "BlockParty"
		SelectGameManager.gameSelectedTPPoint = "BlockPartySpawners"
		SelectGameManager.gameWinType = "LastManStanding"
		gameSettings.matchDuration = 300

	elseif( gameSelectionGen == 2 )
	then   
		--CannonBallRun
		print("Next Game is CannonBallRun" )
		SelectGameManager.gameSelected = "CannonBallRun"
		SelectGameManager.gameSelectedTPPoint = "CannonBallRunSpawners"

	elseif( gameSelectionGen == 3 )
	then
		--FallDown
		print("Next Game is FallDown" )
		SelectGameManager.gameSelected = "FallDown"
		SelectGameManager.gameSelectedTPPoint = "FallDownSpawners"
		SelectGameManager.gameWinType = "LastManStanding"
		gameSettings.matchDuration = 300
		
	elseif( gameSelectionGen == 4 )
	then
		--FallDown
		print("Next Game is DizzyHeights" )
		SelectGameManager.gameSelected = "DizzyHeights"
		SelectGameManager.gameSelectedTPPoint = "DizzyHeightsSpawners"
		gameSettings.matchDuration = 60
		
	elseif( gameSelectionGen == 5 )
	then
		--FallDown
		print("Next Game is DoorDash" )
		SelectGameManager.gameSelected = "DoorDash"
		SelectGameManager.gameSelectedTPPoint = "DoorDashSpawners"
		SelectGameManager.gameWinType = "MaxFinished"
		gameSettings.matchDuration = 120
		
	elseif( gameSelectionGen == 6 )
	then
		--FallDown
		print("Next Game is CastleRun" )
		SelectGameManager.gameSelected = "CastleRun"
		SelectGameManager.gameSelectedTPPoint = "CastleRunSpawners"
		SelectGameManager.gameWinType = "MaxFinished"
		gameSettings.matchDuration = 120

	else
		--DefaultGame
		print("Next Game is DefaultGame" )
		SelectGameManager.gameSelected = "DefaultGame"
		SelectGameManager.gameSelectedTPPoint = "CannonBallRunSpawners"

	end
end


return SelectGameManager

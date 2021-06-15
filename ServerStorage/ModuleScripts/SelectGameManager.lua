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
local PreviousGames = {"DoorDash"}
local selectedMap = ""


local function selectUnique()
	--local gameSelectionGen = math.random(5,6)
	local gameSelectionGen = 7

	if(gameSelectionGen == 1)
	then
		--BlockParty
		print("Next Game is BlockParty" )
		selectedMap = "BlockParty"
		SelectGameManager.gameSelectedTPPoint = "BlockPartySpawners"
		SelectGameManager.gameWinType = "LastManStanding"
		gameSettings.matchDuration = 120

	elseif( gameSelectionGen == 2 )
	then   
		--CannonBallRun
		print("Next Game is CannonBallRun" )
		selectedMap = "CannonBallRun"
		SelectGameManager.gameSelectedTPPoint = "CannonBallRunSpawners"
		SelectGameManager.gameWinType = "MaxFinished"
		gameSettings.matchDuration = 120

	elseif( gameSelectionGen == 3 )
	then
		--FallDown
		print("Next Game is DropDown" )
		selectedMap = "DropDown"
		SelectGameManager.gameSelectedTPPoint = "DropDownSpawners"
		SelectGameManager.gameWinType = "LastManStanding"
		gameSettings.matchDuration = 120

	elseif( gameSelectionGen == 4 )
	then
		--FallDown
		print("Next Game is DizzyHeights" )
		selectedMap = "DizzyHeights"
		SelectGameManager.gameSelectedTPPoint = "DizzyHeightsSpawners"
		gameSettings.matchDuration = 120

	elseif( gameSelectionGen == 5 )
	then
		--FallDown
		print("Next Game is DoorDash" )
		selectedMap = "DoorDash"
		SelectGameManager.gameSelectedTPPoint = "DoorDashSpawners"
		SelectGameManager.gameWinType = "MaxFinished"
		gameSettings.matchDuration = 120

	elseif( gameSelectionGen == 6 )
	then
		--FallDown
		print("Next Game is CastleRun" )
		selectedMap = "CastleRun"
		SelectGameManager.gameSelectedTPPoint = "CastleRunSpawners"
		SelectGameManager.gameWinType = "MaxFinished"
		gameSettings.matchDuration = 120
		
	elseif( gameSelectionGen == 7 )
	then
		--FallDown
		print("Next Game is Duck&Dive" )
		selectedMap = "DuckAndDive"
		SelectGameManager.gameSelectedTPPoint = "DuckAndDiveSpawners"
		SelectGameManager.gameWinType = "LastManStanding"
		gameSettings.matchDuration = 180

	else
		--DefaultGame
		print("Next Game is DefaultGame" )
		SelectGameManager.gameSelected = "DefaultGame"
		SelectGameManager.gameSelectedTPPoint = "CannonBallRunSpawners"

	end
end

--Select Random Game
function SelectGameManager.selectNextGame()
	selectUnique()
	local foundUnique = false
	while foundUnique == false do
		foundUnique = true
		for Map, whichMap in pairs(PreviousGames) do
			if selectedMap == whichMap then
				--foundUnique = false
			end
		end
		
		if foundUnique == true then
			SelectGameManager.gameSelected = selectedMap
			table.insert(PreviousGames,selectedMap)
			if #PreviousGames > 1 then
				table.remove(PreviousGames,1)
			end
		else
			selectUnique()
		end 	
	end
end


return SelectGameManager

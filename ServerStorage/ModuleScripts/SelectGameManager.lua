local SelectGameManager = {}


-- Services
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Module Scripts
local moduleScripts = ServerStorage:WaitForChild("ModuleScripts")
local displayManager = require(moduleScripts:WaitForChild("DisplayManager"))
--local playerManager = require(moduleScripts:WaitForChild("PlayerManager"))

--Variables
SelectGameManager.gameSelected = ""
SelectGameManager.gameSelectedTPPoint = ""

--Select Random Game
function SelectGameManager.selectNextGame()

	local gameSelectionGen = math.random(1,2)
	--local gameSelectionGen = 1
	
	if(gameSelectionGen == 1)
	then
		--BlockParty
		print("Next Game is BlockParty" )
		SelectGameManager.gameSelected = "BlockParty"
		SelectGameManager.gameSelectedTPPoint = "BlockPartySpawners"

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

	else
		--DefaultGame
		print("Next Game is DefaultGame" )
		SelectGameManager.gameSelected = "DefaultGame"
		SelectGameManager.gameSelectedTPPoint = "CannonBallRunSpawners"

	end
	displayManager.updateStatus("Next game is... "..SelectGameManager.gameSelected)
end


return SelectGameManager

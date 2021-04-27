local tweenService = game:GetService("TweenService")

local tweeningInformation = TweenInfo.new(
	2,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local positionA = {Position = game.Workspace["BPTP A"].Position}
local positionB = {Position = game.Workspace["BPTP B"].Position}
local positionC = {Position = game.Workspace["BPTP C"].Position}


	
_G.startBlockParty = function()
	
	-- loop over the children and connect touch events
	local bricks = game.Workspace.BlockPartyObjects:GetChildren()
	for i, brick in ipairs(bricks) do
		
		tweenService:Create(brick,tweeningInformation,positionA):Play()
		wait(2)
		tweenService:Create(brick,tweeningInformation,positionB):Play()
		wait(2)
		tweenService:Create(brick,tweeningInformation,positionC):Play()
		
		if (_G.stopCurrentGame == true) then
			print('breaking')
			break
		end
	end	
	return
end

	
	
	

local BlockPartyGame = {}
BlockPartyGame.__index = BlockPartyGame

function BlockPartyGame.new()

	local self = setmetatable({}, BlockPartyGame)

	self._finishedEvent = Instance.new("BindableEvent")
	self.finished = self._finishedEvent.Event

	self._running = false

	return self
end


local tweenService = game:GetService("TweenService")

local tweeningInformation = TweenInfo.new(
	3,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local positionA = {Position = game.Workspace["BPTP A"].Position}
local positionB = {Position = game.Workspace["BPTP B"].Position}
local positionC = {Position = game.Workspace["BPTP C"].Position}
local positionD = {Position = game.Workspace["BPTP D"].Position}



function BlockPartyGame:start()
	if not self._running then
		local blockPartyThread = coroutine.wrap(function()
			self._running = true
			while self._running do
				
				-- loop over the children and connect touch events
				local bricks = game.Workspace.BlockPartyObjects:GetChildren()
				for i, brick in ipairs(bricks) do

					tweenService:Create(brick,tweeningInformation,positionA):Play()
					wait(3)
					tweenService:Create(brick,tweeningInformation,positionB):Play()
					wait(3)
					tweenService:Create(brick,tweeningInformation,positionC):Play()
					wait(3)
					tweenService:Create(brick,tweeningInformation,positionD):Play()
					
					if(self._running == false) then
						break
					end
				end	
				
				
			end
			local completed = self._running
			self._running = false
			self._finishedEvent:Fire(completed)
		end)
		blockPartyThread()
	else
		warn("Warning: BlockParty could not start again as it is already running.")
	end
end

function BlockPartyGame:isRunning()
	return self._running
end

function BlockPartyGame:stop()
	self._running = false
end


return BlockPartyGame

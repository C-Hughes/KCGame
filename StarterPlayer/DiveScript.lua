--local MAX_JUMPS = 2
local MAX_DIVES = 1
--local TIME_BETWEEN_JUMPS = 0.1

local hrp = script.Parent:WaitForChild("HumanoidRootPart")
local head = script.Parent:WaitForChild("Head")
local humanoid = script.Parent:WaitForChild("Humanoid")
local particle = script:WaitForChild("Particle2")
particle.Parent = nil

--local anim
--if(humanoid.RigType == Enum.HumanoidRigType.R15) then
--	anim = humanoid:LoadAnimation(script:WaitForChild("Roll_R15"))
--else
--	anim = humanoid:LoadAnimation(script:WaitForChild("Roll_R6"))
--end

local canJump = true
local jumpCount = 0

local canDive = true
local diveCount = 0
local totalDives = 0

local function createParticle(cf, t)
	local part = Instance.new("Part")
	part.Size = Vector3.new(4,4,4)
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = 1
	part.CFrame = cf
	part.Parent = game.Workspace
	
	local clone = particle:Clone()
	clone.Enabled = true
	clone.Parent = part
	
	local life = clone.Lifetime
	for i=0, 1.1, 0.1 do
		clone.Lifetime = NumberRange.new(i,i+1)
		wait(t*0.1)
	end
	
	game:GetService("Debris"):AddItem(part, t)
end


local function onTouched(touchingPart, humanoidPart)
	if(humanoid:GetState() == Enum.HumanoidStateType.Flying and touchingPart.CanCollide) then
		humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
	end
end

local function dive()
	if(canDive == true) then
		canDive = false
		humanoid:ChangeState(Enum.HumanoidStateType.Flying)
		hrp.Velocity = hrp.CFrame:vectorToWorldSpace(Vector3.new(0, humanoid.JumpPower/1.5, -humanoid.WalkSpeed*2.5))
		hrp.RotVelocity = hrp.CFrame:vectorToWorldSpace(Vector3.new(-math.rad(135), 0, 0))
		createParticle(hrp.CFrame * CFrame.new(0,-1,-3), .3)
		wait(1)
		canDive = true
	end
end


if (MAX_DIVES > 0) then 
	humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	humanoid.Touched:Connect(onTouched)
	--game:GetService("UserInputService").InputBegan:Connect(onInput())
	
	local UIS = game:GetService("UserInputService")

	UIS.InputBegan:Connect(function(Input, GameProcessedEvent)
		if (GameProcessedEvent or not humanoid or humanoid:GetState() == Enum.HumanoidStateType.Dead) then
			return
		end
		
		if (humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping) then
			if (Input.KeyCode == Enum.KeyCode.LeftShift or Input.KeyCode == Enum.KeyCode.LeftControl) then
				dive()
			end
		end
		
	end)
end



--[[
local function onStateChange(old, new)
	print("HIIIIIIIIIIIII")
	if (new == Enum.HumanoidStateType.Landed or new == Enum.HumanoidStateType.Swimming or new == Enum.HumanoidStateType.Running) then
		canDive = true
		canJump = true
		jumpCount = 0
		diveCount = 0
		anim:Stop()
	elseif (new == Enum.HumanoidStateType.Freefall or new == Enum.HumanoidStateType.Flying) then
		wait(TIME_BETWEEN_JUMPS)
		canJump = true
		canDive = true
	end
end

local function onInput(input, process)
	print("test dive!!!!!")
	if (process or not humanoid or humanoid:GetState() == Enum.HumanoidStateType.Dead) then
		return
	end

	if (input.KeyCode == Enum.KeyCode.LeftShift or Enum.KeyCode.LeftControl) then
		canDive = false
		diveCount = diveCount + 1
		totalDives = totalDives + 1

		anim:Stop()
		humanoid:ChangeState(Enum.HumanoidStateType.Flying)
		hrp.Velocity = hrp.CFrame:vectorToWorldSpace(Vector3.new(0, humanoid.JumpPower, -humanoid.WalkSpeed*3))
		hrp.RotVelocity = hrp.CFrame:vectorToWorldSpace(Vector3.new(-math.rad(135), 0, 0))
		--createParticle(hrp.CFrame * CFrame.new(0,-1,-3), .3)

		local currentDive = totalDives
		wait(0.5)
		if(currentDive == totalDives) then
			hrp.RotVelocity = hrp.CFrame:vectorToWorldSpace(Vector3.new(0,0,0))
		end
	end
end
]]



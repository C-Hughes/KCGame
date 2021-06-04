local humanoid = script.Parent:WaitForChild('Humanoid')
local Players = game:GetService("Players")


local arm = game.Workspace.DoubleArm.SingleSpinner
local arm2 = game.Workspace.JumpPartyTopArm
local arm3 = game.Workspace.JumpPartyBottomArm

function fallDown(hit)
	local b = hit.Parent:FindFirstChild("Humanoid")
	if b ~= nil then
		print("I'm touched!")
	end
	
	b:ChangeState(Enum.HumanoidStateType.FallingDown)
	--wait(0.75)
	--b:ChangeState(Enum.HumanoidStateType.GettingUp)
	for index,joint in pairs(script.Parent:GetDescendants()) do
		if joint:IsA('Motor6D') then
			local socket = Instance.new('BallSocketConstraint')
			local a1 = Instance.new('Attachment')
			local a2 = Instance.new('Attachment')
			a1.Parent = joint.Part0
			a2.Parent = joint.Part1
			socket.Parent = joint.Parent
			socket.Attachment0 = a1
			socket.Attachment1 = a2
			a1.CFrame = joint.C0
			a2.CFrame = joint.C1
			socket.LimitsEnabled = true
			socket.TwistLimitsEnabled = true
			joint:Ragdoll()
		end
	end
	b:ChangeState(Enum.HumanoidStateType.FallingDown)
end

arm.Touched:Connect(function(hit)
	fallDown(hit)
end)

arm2.Touched:Connect(function(hit)
	fallDown(hit)
end)

arm3.Touched:Connect(function(hit)
	fallDown(hit)
end)



--[[

local humanoid = script.Parent:WaitForChild('Humanoid')

humanoid.BreakJointsOnDeath = false



humanoid.Jumping:Connect(function()
	for index,joint in pairs(script.Parent:GetDescendants()) do
		if joint:IsA('Motor6D') then
			local socket = Instance.new('BallSocketConstraint')
			local a1 = Instance.new('Attachment')
			local a2 = Instance.new('Attachment')
			a1.Parent = joint.Part0
			a2.Parent = joint.Part1
			socket.Parent = joint.Parent
			socket.Attachment0 = a1
			socket.Attachment1 = a2
			a1.CFrame = joint.C0
			a2.CFrame = joint.C1
			socket.LimitsEnabled = true
			socket.TwistLimitsEnabled = true
			joint:Destroy()
		end
	end
end)

]]

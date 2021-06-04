local button = script.Parent
local inventoryButton = script.Parent.Parent.InventoryLIGHTBtn
local shopButton = script.Parent.Parent.ShopLIGHTBtn

local shopGUI = button.Parent.Parent.Parent.ShopGUI
local inventoryGUI = button.Parent.Parent.Parent.InventoryGUI
local awardsGUI = button.Parent.Parent.Parent.AwardsGUI


button.MouseButton1Click:Connect(function()
	--Close others GUIs incase already open
	inventoryGUI.Enabled = false
	shopGUI.Enabled = false
	--Deselect All Other Buttons
	inventoryButton.Selected = false
	inventoryButton.Image = "rbxassetid://6896528496"
	shopButton.Selected = false
	shopButton.Image = "rbxassetid://6896527632"


	--Toggle Image & GUI
	awardsGUI.Enabled = not awardsGUI.Enabled
	button.Selected = not button.Selected
	if button.Selected == false then
		button.Image = "rbxassetid://6900880204"
	else
		button.Image = "rbxassetid://6900876040"
	end
end)

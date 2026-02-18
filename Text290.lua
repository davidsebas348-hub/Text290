local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- Esperar personaje
local function getCharacter()
	return player.Character or player.CharacterAdded:Wait()
end

local function getRoot()
	local char = getCharacter()
	return char:WaitForChild("HumanoidRootPart")
end

-- Esperar rutas correctamente
local kit = Workspace:WaitForChild("Kit")
local clientsValue = kit:WaitForChild("Clients")

local TELEPORT_POSITION = Vector3.new(-45, 5, -550)

-- Guardar valor inicial
local lastValue = clientsValue.Value

clientsValue:GetPropertyChangedSignal("Value"):Connect(function()
	local newValue = clientsValue.Value
	
	-- Solo si era 0 y ahora no es 0
	if lastValue == 0 and newValue ~= 0 then
		local root = getRoot()
		root.CFrame = CFrame.new(TELEPORT_POSITION)
	end
	
	lastValue = newValue
end)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- Esperar 1 segundo al ejecutar
task.wait(1)

-- Buscar el prompt "Base" dentro de "LightSwitch"
local function findBasePrompt()
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("UnionOperation") and obj.Name == "Base" then
			local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
			if prompt then
				return prompt, obj
			end
		end
	end
	return nil, nil
end

-- Teleport + activar prompt
local function teleportAndActivate(prompt, part)
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")
	root.CFrame = part.CFrame + Vector3.new(0,3,0)
	task.wait(0.2)
	pcall(function()
		fireproximityprompt(prompt)
	end)
end

-- Ejecutar
local prompt, part = findBasePrompt()
if prompt and part then
	teleportAndActivate(prompt, part)
	print("Se teletransportó y activó el prompt Base.")
else
	warn("No se encontró el prompt Base.")
end

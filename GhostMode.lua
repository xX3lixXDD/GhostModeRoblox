local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "GhostModeGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 110)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -10, 0, 24)
title.Position = UDim2.new(0, 5, 0, 4)
title.BackgroundTransparency = 1
title.Text = "GhostMode by: xX_3lixXDD"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -26, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(180,0,0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 16
closeBtn.Parent = frame

local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 22, 0, 22)
miniBtn.Position = UDim2.new(1, -50, 0, 4)
miniBtn.BackgroundColor3 = Color3.fromRGB(180,0,0)
miniBtn.Text = "-"
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Font = Enum.Font.SourceSansBold
miniBtn.TextSize = 16
miniBtn.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 38)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
toggleBtn.Text = "Enable Ghost Mode"
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextSize = 16
toggleBtn.Parent = frame

local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1, -20, 0, 20)
statusLbl.Position = UDim2.new(0, 10, 0, 82)
statusLbl.BackgroundTransparency = 1
statusLbl.TextColor3 = Color3.fromRGB(220,220,220)
statusLbl.Text = "Status: OFF"
statusLbl.Font = Enum.Font.SourceSans
statusLbl.TextSize = 15
statusLbl.TextXAlignment = Enum.TextXAlignment.Left
statusLbl.Parent = frame

local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://2101148"
clickSound.Volume = 0.8
clickSound.Parent = frame

local function click()
	clickSound:Play()
end

local noclipEnabled = false
local connection

local function setNoclip(state)
	noclipEnabled = state
	statusLbl.Text = "Status: " .. (state and "ON" or "OFF")
	statusLbl.TextColor3 = state and Color3.fromRGB(50,255,50) or Color3.fromRGB(255,80,80)
	toggleBtn.Text = state and "Disable Ghost Mode" or "Enable Ghost Mode"
end

toggleBtn.MouseButton1Click:Connect(function()
	click()
	if not player.Character then return end
	setNoclip(not noclipEnabled)

	if noclipEnabled then
		connection = RunService.Stepped:Connect(function()
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end)
	else
		if connection then connection:Disconnect() end
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end)

local minimized = false
local savedSize = frame.Size

miniBtn.MouseButton1Click:Connect(function()
	click()
	minimized = not minimized
	if minimized then
		for _, c in ipairs(frame:GetChildren()) do
			if c ~= title and c ~= closeBtn and c ~= miniBtn then
				c.Visible = false
			end
		end
		frame.Size = UDim2.new(0, 200, 0, 30)
	else
		for _, c in ipairs(frame:GetChildren()) do
			c.Visible = true
		end
		frame.Size = savedSize
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	click()
	gui:Destroy()
	if connection then connection:Disconnect() end
end)

print("[✅] GhostMode by: xX_3lixXDD loaded successfully.")

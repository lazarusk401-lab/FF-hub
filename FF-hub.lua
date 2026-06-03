-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Main ScreenGui Container
local settingsTab = Instance.new("ScreenGui")
settingsTab.Name = "UniversalSettingsGui"
settingsTab.ResetOnSpawn = false -- Keeps the menu from breaking when you die
settingsTab.Parent = playerGui

-- 2. Main Layout Frame (The Menu Panel)
local tabLayout = Instance.new("Frame")
tabLayout.Name = "TabLayout"
tabLayout.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tabLayout.BorderSizePixel = 0
tabLayout.Size = UDim2.new(0, 320, 0, 240)
tabLayout.Position = UDim2.new(0.5, -160, 0.5, -120) -- Perfectly centered
-- Rounded corners for a modern look
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = tabLayout
tabLayout.Parent = settingsTab

-- Automatically stacks buttons vertically with 10px spacing
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 10)
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = tabLayout

-- Padding around the inside edges of the menu
local uiPadding = Instance.new("UIPadding")
uiPadding.PaddingTop = UDim.new(0, 15)
uiPadding.Parent = tabLayout

-- 3. Menu Title Label
local tabTitle = Instance.new("TextLabel")
tabTitle.Name = "TabTitle"
tabTitle.BackgroundTransparency = 1
tabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
tabTitle.TextSize = 22
tabTitle.Text = "Universal Settings"
tabTitle.Font = Enum.Font.SourceSansBold
tabTitle.Size = UDim2.new(1, 0, 0, 30)
tabTitle.LayoutOrder = 1
tabTitle.Parent = tabLayout

---------------------------------------------------------
-- MENU TOGGLE MECHANIC (Open/Close Menu)
---------------------------------------------------------
local function toggleMenu()
    tabLayout.Visible = not tabLayout.Visible
end

-- Toggles menu when 'M' key is pressed ('Space' would break jumping)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Don't trigger while typing in chat
    if input.KeyCode == Enum.KeyCode.M then 
        toggleMenu() 
    end
end)

---------------------------------------------------------
-- FEATURE 1: WALK SPEED TOGGLE
---------------------------------------------------------
local speedButton = Instance.new("TextButton")
speedButton.Name = "SpeedButton"
speedButton.Size = UDim2.new(0, 280, 0, 45)
speedButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.Text = "WalkSpeed: Default (16)"
speedButton.Font = Enum.Font.SourceSans
speedButton.TextSize = 18
speedButton.LayoutOrder = 2
local btnCorner1 = Instance.new("UICorner")
btnCorner1.CornerRadius = UDim.new(0, 6)
btnCorner1.Parent = speedButton
speedButton.Parent = tabLayout

local speedToggled = false
local speedConnection = nil

local function toggleSpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    speedToggled = not speedToggled
    
    if speedToggled then
        speedButton.Text = "WalkSpeed: Fast (50)"
        speedButton.BackgroundColor3 = Color3.fromRGB(0, 140, 70) -- Green
        
        -- Keeps speed forced to 50 even if the game tries to reset it
        speedConnection = RunService.RenderStepped:Connect(function()
            if character and humanoid then
                humanoid.WalkSpeed = 50
            end
        end)
    else
        speedButton.Text = "WalkSpeed: Default (16)"
        speedButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        if speedConnection then 
            speedConnection:Disconnect() 
            speedConnection = nil
        end
        humanoid.WalkSpeed = 16
    end
end

speedButton.MouseButton1Click:Connect(toggleSpeed)

---------------------------------------------------------
-- FEATURE 2: FREEZE/FLY TOGGLE
---------------------------------------------------------
local freezeButton = Instance.new("TextButton")
freezeButton.Name = "FreezeButton"
freezeButton.Size = UDim2.new(0, 280, 0, 45)
freezeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
freezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeButton.Text = "Freeze Position: OFF"
freezeButton.Font = Enum.Font.SourceSans
freezeButton.TextSize = 18
freezeButton.LayoutOrder = 3
local btnCorner2 = Instance.new("UICorner")
btnCorner2.CornerRadius = UDim.new(0, 6)
btnCorner2.Parent = freezeButton
freezeButton.Parent = tabLayout

local isAnchored = false

local function toggleFreeze()
    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    isAnchored = not isAnchored
    hrp.Anchored = isAnchored
    
    if isAnchored then
        freezeButton.Text = "Freeze Position: ON"
        freezeButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Red
    else
        freezeButton.Text = "Freeze Position: OFF"
        freezeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end

freezeButton.MouseButton1Click:Connect(toggleFreeze)

---------------------------------------------------------
-- FEATURE 3: CHAT NOTIFICATION INFO
---------------------------------------------------------
local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "InfoLabel"
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
infoLabel.TextSize = 14
infoLabel.Text = "Press 'M' to hide/show this menu"
infoLabel.Font = Enum.Font.SourceSansItalic
infoLabel.Size = UDim2.new(1, 0, 0, 25)
infoLabel.LayoutOrder = 4
infoLabel.Parent = tabLayout

-- Let the player know it loaded successfully
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Settings Loaded",
    Text = "Press M to toggle the interface.",
    Duration = 5
})

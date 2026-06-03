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

-- Toggles menu when 'M' key is pressed
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.M then
        toggleMenu()
    end
end)

---------------------------------------------------------
-- FEATURE 1: WALK SPEED TOGGLE
---------------------------------------------------------
local function toggleWalkSpeed()
    local character = player.Character or player.CharacterAdded
    local humanoid = character:WaitForChild("Humanoid")
    
    if not humanoid then return end
    
    -- Toggle value here (true/false)
    local walkSpeedOn = false
    
    -- Update speed
    if walkSpeedOn then
        humanoid.WalkSpeed = 50
        tabLayout:FindFirstChild("WalkSpeedSlider").Value = 1
    else
        humanoid.WalkSpeed = 16
        tabLayout:FindFirstChild("WalkSpeedSlider").Value = 0
    end
    
    -- Update toggle button text and color
    tabLayout:FindFirstChild("WalkSpeedToggle").Text = tostring(walkSpeedOn)
    if walkSpeedOn then
        tabLayout:FindFirstChild("WalkSpeedToggle").BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Red
    else
        tabLayout:FindFirstChild("WalkSpeedToggle").BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end

local walkSpeedSlider = Instance.new("Slider")
walkSpeedSlider.Name = "WalkSpeedSlider"
walkSpeedSlider.Parent = tabLayout
walkSpeedSlider.ValueChanged:Connect(function(value)
    local character = player.Character or player.CharacterAdded
    local humanoid = character:WaitForChild("Humanoid")
    
    if humanoid then
        -- Get old speed value
        local oldSpeedValue = humanoid.WalkSpeed
        
        -- Set new speed value
        humanoid.WalkSpeed = 16 + (value * 34)
        
        -- Update humanoids walk speed to be smooth and not stutter
        RunService.RenderStepped:Connect(function()
            if humanoid then
                humanoid.WalkSpeed = lerp(oldSpeedValue, humanoid.WalkSpeed, 1 / 60)
            end
        end)
    end
end)

local walkSpeedToggle = Instance.new(" Toggle")
walkSpeedToggle.Name = "WalkSpeedToggle"
walkSpeedToggle.Parent = tabLayout
walkSpeedToggle.ValueChanged:Connect(toggleWalkSpeed)

---------------------------------------------------------
-- FEATURE 2: FLY SPEED TOGGLE
---------------------------------------------------------
local function toggleFlySpeed()
    local character = player.Character or player.CharacterAdded
    
    if not character then return end
    
    -- Toggle value here (true/false)
    local flySpeedOn = false
    
    -- Update speed
    if flySpeedOn then
        character:WaitForChild(" humanoidRootPart").CanCollide = false
    else
        character:WaitForChild("humanoidRootPart").CanCollide = true
    end
    
    -- Update toggle button text and color
    tabLayout:FindFirstChild("FlySpeedToggle").Text = tostring(flySpeedOn)
    if flySpeedOn then
        tabLayout:FindFirstChild("FlySpeedToggle").BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Red
    else
        tabLayout:FindFirstChild("FlySpeedToggle").BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end

local flySpeedToggle = Instance.new(" Toggle")
flySpeedToggle.Name = "FlySpeedToggle"
flySpeedToggle.Parent = tabLayout
flySpeedToggle.ValueChanged:Connect(toggleFlySpeed)

---------------------------------------------------------
-- FEATURE 3: MINIMIZE BUTTON
---------------------------------------------------------
local function minimizeSettings()
    settingsTab.Visible = not settingsTab.Visible
end

local minimizeButton = Instance.new("Frame")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 100, 0, 20)
minimizeButton.Position = UDim2.new(1, -10, 0.8, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Parent = tabLayout

local minimizeText = Instance.new("TextLabel")
minimizeText.Name = "MinimizeText"
minimizeText.Text = "+"
minimizeText.Font = Enum.Font.SourceSans
minimizeText.Size = UDim2.new(0, 20, 1, 0)
minimizeText.Parent = minimizeButton

local function onActivate()
    if settingsTab then
        settingsTab:Destroy()
    end
end

minimizeButton.Activated:Connect(onActivate)

-- Initialize the UI
tabLayout:FindFirstChild("WalkSpeedToggle").Value = false
tabLayout:FindFirstChild("FlySpeedToggle").Value = false

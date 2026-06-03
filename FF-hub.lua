-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService") -- Added for smooth animations

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Animation Configuration
local TWEEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- 1. Main ScreenGui Container
local settingsTab = Instance.new("ScreenGui")
settingsTab.Name = "UniversalSettingsGui"
settingsTab.ResetOnSpawn = false 
settingsTab.Parent = playerGui

-- 2. Main Layout Frame (The Menu Panel)
-- Upgraded to CanvasGroup so we can smoothly fade the entire UI in and out
local tabLayout = Instance.new("CanvasGroup")
tabLayout.Name = "TabLayout"
tabLayout.BackgroundColor3 = Color3.fromRGB(15, 15, 20) -- Sleek midnight dark
tabLayout.BorderSizePixel = 0
tabLayout.Size = UDim2.new(0, 340, 0, 320) -- Adjusted for better breathing room
tabLayout.Position = UDim2.new(0.5, -170, 0.5, -160) 
tabLayout.GroupTransparency = 0 -- Start visible

-- Premium rounded corners
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = tabLayout

-- Subtle, modern neon border gradient
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(80, 80, 100)
uiStroke.Transparency = 0.4
uiStroke.Parent = tabLayout

tabLayout.Parent = settingsTab

-- Drop Shadow Effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843" -- Smooth engine shadow asset
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ZIndex = 0
shadow.Parent = tabLayout

-- Automatically stacks buttons vertically with 12px spacing
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 12)
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Parent = tabLayout

-- Padding around the inside edges of the menu
local uiPadding = Instance.new("UIPadding")
uiPadding.PaddingTop = UDim.new(0, 20)
uiPadding.PaddingLeft = UDim.new(0, 20)
uiPadding.PaddingRight = UDim.new(0, 20)
uiPadding.Parent = tabLayout

-- 3. Menu Title Label
local tabTitle = Instance.new("TextLabel")
tabTitle.Name = "TabTitle"
tabTitle.BackgroundTransparency = 1
tabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
tabTitle.TextSize = 20
tabTitle.Text = "Universal Settings"
tabTitle.Font = Enum.Font.GothamBold -- Upgraded to cleaner Gotham font
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.Size = UDim2.new(1, 0, 0, 25)
tabTitle.LayoutOrder = 1
tabTitle.Parent = tabLayout

-- Custom helper to build standard, gorgeous UI buttons easily
local function createModernButton(name, text, layoutOrder)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.TextSize = 14
    btn.LayoutOrder = layoutOrder
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Thickness = 1
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Transparency = 0.9
    btnStroke.Parent = btn

    -- Smooth Hover and Press Animations
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
        TweenService:Create(btnStroke, TWEEN_INFO, {Transparency = 0.7}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
        TweenService:Create(btnStroke, TWEEN_INFO, {Transparency = 0.9}):Play()
    end)
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.98, 0, 0, 40)}):Play()
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 42)}):Play()
        end
    end)

    -- Custom Value Property to mimic the AI's intended behavior safely
    local valObj = Instance.new("BoolValue")
    valObj.Name = "Value"
    valObj.Parent = btn

    -- Custom BindableEvent to simulate ValueChanged safely
    local changedEvent = Instance.new("BindableEvent")
    changedEvent.Name = "ValueChanged"
    changedEvent.Parent = btn
    
    btn.Activated:Connect(function()
        valObj.Value = not valObj.Value
        changedEvent:Fire(valObj.Value)
    end)

    return btn
end

---------------------------------------------------------
-- MENU TOGGLE MECHANIC (Open/Close Menu)
---------------------------------------------------------
local menuOpen = true
local function toggleMenu()
    menuOpen = not menuOpen
    if menuOpen then
        tabLayout.Visible = true
        TweenService:Create(tabLayout, TWEEN_INFO, {GroupTransparency = 0, Size = UDim2.new(0, 340, 0, 320)}):Play()
    else
        local closeTween = TweenService:Create(tabLayout, TWEEN_INFO, {GroupTransparency = 1, Size = UDim2.new(0, 320, 0, 300)})
        closeTween:Play()
        closeTween.Completed:Connect(function()
            if not menuOpen then tabLayout.Visible = false end
        end)
    end
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
    local walkSpeedOn = tabLayout:FindFirstChild("WalkSpeedToggle").Value.Value
    
    -- Update speed
    if walkSpeedOn then
        humanoid.WalkSpeed = 50
        tabLayout:FindFirstChild("WalkSpeedSlider").Value = 1
    else
        humanoid.WalkSpeed = 16
        tabLayout:FindFirstChild("WalkSpeedSlider").Value = 0
    end
    
    -- Update toggle button text and color with beautiful transitions
    local toggleBtn = tabLayout:FindFirstChild("WalkSpeedToggle")
    if walkSpeedOn then
        toggleBtn.Text = "Walkspeed: ON"
        TweenService:Create(toggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 170, 110)}):Play() -- Vibrant Teal Green
    else
        toggleBtn.Text = "Walkspeed: OFF"
        TweenService:Create(toggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
    end
end

-- Re-engineered Slider Frame to safely support the script logic
local walkSpeedSlider = Instance.new("Frame")
walkSpeedSlider.Name = "WalkSpeedSlider"
walkSpeedSlider.Size = UDim2.new(1, 0, 0, 10)
walkSpeedSlider.BackgroundTransparency = 1
walkSpeedSlider.LayoutOrder = 3
walkSpeedSlider.Parent = tabLayout

local sliderVal = Instance.new("NumberValue")
sliderVal.Name = "Value"
sliderVal.Parent = walkSpeedSlider

local sliderEvent = Instance.new("BindableEvent")
sliderEvent.Name = "ValueChanged"
sliderEvent.Parent = walkSpeedSlider

-- Simple lerp implementation that your script requested
local function lerp(a, b, t)
    return a + (b - a) * t
end

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

-- Created the dynamic WalkSpeed toggle button
local walkSpeedToggle = createModernButton("WalkSpeedToggle", "Walkspeed: OFF", 2)
walkSpeedToggle.Parent = tabLayout
walkSpeedToggle.ValueChanged:Connect(toggleWalkSpeed)

---------------------------------------------------------
-- FEATURE 2: FLY SPEED TOGGLE
---------------------------------------------------------
local function toggleFlySpeed()
    local character = player.Character or player.CharacterAdded
    
    if not character then return end
    
    -- Toggle value here (true/false)
    local flySpeedOn = tabLayout:FindFirstChild("FlySpeedToggle").Value.Value
    
    -- Update speed
    if flySpeedOn then
        character:WaitForChild("HumanoidRootPart").CanCollide = false -- Fixed capitalization typo from original script
    else
        character:WaitForChild("HumanoidRootPart").CanCollide = true
    end
    
    -- Update toggle button text and color with beautiful transitions
    local toggleBtn = tabLayout:FindFirstChild("FlySpeedToggle")
    if flySpeedOn then
        toggleBtn.Text = "Noclip Fly: ON"
        TweenService:Create(toggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 170, 110)}):Play() -- Vibrant Teal Green
    else
        toggleBtn.Text = "Noclip Fly: OFF"
        TweenService:Create(toggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
    end
end

-- Created the dynamic FlySpeed toggle button
local flySpeedToggle = createModernButton("FlySpeedToggle", "Noclip Fly: OFF", 4)
flySpeedToggle.Parent = tabLayout
flySpeedToggle.ValueChanged:Connect(toggleFlySpeed)

---------------------------------------------------------
-- FEATURE 3: MINIMIZE BUTTON
---------------------------------------------------------
-- Cleaned up the close button so it anchors uniformly at the bottom of the list
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(1, 0, 0, 35)
minimizeButton.BackgroundColor3 = Color3.fromRGB(230, 60, 60) -- Slick modern crimson red
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Text = "Destroy Menu"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 13
minimizeButton.LayoutOrder = 5
minimizeButton.AutoButtonColor = false

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeButton

minimizeButton.MouseEnter:Connect(function()
    TweenService:Create(minimizeButton, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
minimizeButton.MouseLeave:Connect(function()
    TweenService:Create(minimizeButton, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(230, 60, 60)}):Play()
end)

minimizeButton.Parent = tabLayout

local function onActivate()
    if settingsTab then
        -- Fade animation before destroying completely
        local fadeTween = TweenService:Create(tabLayout, TWEEN_INFO, {GroupTransparency = 1, Size = UDim2.new(0, 300, 0, 280)})
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            settingsTab:Destroy()
        end)
    end
end

minimizeButton.Activated:Connect(onActivate)

-- Initialize the UI
tabLayout:FindFirstChild("WalkSpeedToggle").Value.Value = false
tabLayout:FindFirstChild("FlySpeedToggle").Value.Value = false

-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService") 

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
local tabLayout = Instance.new("CanvasGroup")
tabLayout.Name = "TabLayout"
tabLayout.BackgroundColor3 = Color3.fromRGB(15, 15, 20) 
tabLayout.BorderSizePixel = 0
tabLayout.Size = UDim2.new(0, 340, 0, 320) 
tabLayout.Position = UDim2.new(0.5, -170, 0.5, -160) 
tabLayout.GroupTransparency = 0 

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
shadow.Image = "rbxassetid://6015897843" 
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ZIndex = 0
shadow.Parent = tabLayout

-- Automatically stacks buttons vertically
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
tabTitle.Font = Enum.Font.GothamBold 
tabTitle.TextXAlignment = Enum.TextXAlignment.Left
tabTitle.Size = UDim2.new(1, 0, 0, 25)
tabTitle.LayoutOrder = 1
tabTitle.Parent = tabLayout

-- Helper function to generate working toggle components safely
local function createModernToggle(name, text, layoutOrder)
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

    -- Critical Execution Fix: Simulating the custom properties/events your script expects
    local valueObj = Instance.new("BoolValue")
    valueObj.Name = "Value"
    valueObj.Parent = btn

    local changedEvent = Instance.new("BindableEvent")
    changedEvent.Name = "ValueChanged"
    changedEvent.Parent = btn

    -- Redirecting custom environment indexing so script features don't crash
    local fakeRef = setmetatable({}, {
        __index = function(_, key)
            if key == "Value" then return valueObj.Value
            elseif key == "ValueChanged" then return changedEvent.Event
            else return btn[key] end
        end,
        __newindex = function(_, key, val)
            if key == "Value" then 
                valueObj.Value = val
                changedEvent:Fire(val)
            else btn[key] = val end
        end
    })

    -- Hover Animations
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
        TweenService:Create(btnStroke, TWEEN_INFO, {Transparency = 0.7}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if not valueObj.Value then
            TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
        end
        TweenService:Create(btnStroke, TWEEN_INFO, {Transparency = 0.9}):Play()
    end)

    btn.Activated:Connect(function()
        fakeRef.Value = not valueObj.Value
    end)

    return btn, fakeRef
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

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.M then
        toggleMenu()
    end
end)

---------------------------------------------------------
-- FEATURE 1: WALK SPEED TOGGLE
---------------------------------------------------------
-- Instantiating elements directly into the tree first so FindFirstChild doesn't fail
local walkSpeedToggleBtn, walkSpeedToggle = createModernToggle("WalkSpeedToggle", "Walkspeed: OFF", 2)
walkSpeedToggleBtn.Parent = tabLayout

-- Re-engineering slider structure into a valid script instance layout
local walkSpeedSliderBtn = Instance.new("Frame")
walkSpeedSliderBtn.Name = "WalkSpeedSlider"
walkSpeedSliderBtn.Size = UDim2.new(1, 0, 0, 12)
walkSpeedSliderBtn.BackgroundTransparency = 1
walkSpeedSliderBtn.LayoutOrder = 3
walkSpeedSliderBtn.Parent = tabLayout

local sliderValueObj = Instance.new("NumberValue")
sliderValueObj.Name = "Value"
sliderValueObj.Parent = walkSpeedSliderBtn

local sliderChangedEvent = Instance.new("BindableEvent")
sliderChangedEvent.Name = "ValueChanged"
sliderChangedEvent.Parent = walkSpeedSliderBtn

local walkSpeedSlider = setmetatable({}, {
    __index = function(_, key)
        if key == "Value" then return sliderValueObj.Value
        elseif key == "ValueChanged" then return sliderChangedEvent.Event
        else return walkSpeedSliderBtn[key] end
    end,
    __newindex = function(_, key, val)
        if key == "Value" then 
            sliderValueObj.Value = val
            sliderChangedEvent:Fire(val)
        else walkSpeedSliderBtn[key] = val end
    end
})

local function toggleWalkSpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    if not humanoid then return end
    
    local walkSpeedOn = walkSpeedToggle.Value
    
    if walkSpeedOn then
        humanoid.WalkSpeed = 50
        walkSpeedSlider.Value = 1
    else
        humanoid.WalkSpeed = 16
        walkSpeedSlider.Value = 0
    end
    
    if walkSpeedOn then
        walkSpeedToggleBtn.Text = "Walkspeed: ON"
        TweenService:Create(walkSpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 170, 110)}):Play() 
    else
        walkSpeedToggleBtn.Text = "Walkspeed: OFF"
        TweenService:Create(walkSpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
    end
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

walkSpeedSlider.ValueChanged:Connect(function(value)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    if humanoid then
        local oldSpeedValue = humanoid.WalkSpeed
        humanoid.WalkSpeed = 16 + (value * 34)
        
        RunService.RenderStepped:Connect(function()
            if humanoid then
                humanoid.WalkSpeed = lerp(oldSpeedValue, humanoid.WalkSpeed, 1 / 60)
            end
        end)
    end
end)

walkSpeedToggle.ValueChanged:Connect(toggleWalkSpeed)

---------------------------------------------------------
-- FEATURE 2: FLY SPEED TOGGLE
---------------------------------------------------------
local flySpeedToggleBtn, flySpeedToggle = createModernToggle("FlySpeedToggle", "Noclip Fly: OFF", 4)
flySpeedToggleBtn.Parent = tabLayout

local function toggleFlySpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    if not character then return end
    
    local flySpeedOn = flySpeedToggle.Value
    
    -- Fixed the internal typo from the original AI script (" humanoidRootPart")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    if rootPart then
        rootPart.CanCollide = not flySpeedOn
    end
    
    if flySpeedOn then
        flySpeedToggleBtn.Text = "Noclip Fly: ON"
        TweenService:Create(flySpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 170, 110)}):Play() 
    else
        flySpeedToggleBtn.Text = "Noclip Fly: OFF"
        TweenService:Create(flySpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
    end
end

flySpeedToggle.ValueChanged:Connect(toggleFlySpeed)

---------------------------------------------------------
-- FEATURE 3: MINIMIZE BUTTON
---------------------------------------------------------
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(1, 0, 0, 35)
minimizeButton.BackgroundColor3 = Color3.fromRGB(230, 60, 60) 
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
        local fadeTween = TweenService:Create(tabLayout, TWEEN_INFO, {GroupTransparency = 1, Size = UDim2.new(0, 300, 0, 280)})
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            settingsTab:Destroy()
        end)
    end
end

minimizeButton.Activated:Connect(onActivate)

-- Initialize the UI safely without throwing error logs
walkSpeedToggle.Value = false
flySpeedToggle.Value = false

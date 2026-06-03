-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService") 

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Animation Configuration
local TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- 1. Main ScreenGui Container
local settingsTab = Instance.new("ScreenGui")
settingsTab.Name = "UniversalSettingsGui"
settingsTab.ResetOnSpawn = false 
settingsTab.Parent = playerGui

-- 2. Main Windows Frame (Matches the multi-tab layout style)
local tabLayout = Instance.new("Frame")
tabLayout.Name = "TabLayout"
tabLayout.BackgroundColor3 = Color3.fromRGB(20, 20, 25) 
tabLayout.BorderSizePixel = 0
tabLayout.Size = UDim2.new(0, 480, 0, 320) -- Wider window for the multi-tab layout
tabLayout.Position = UDim2.new(0.5, -240, 0.5, -160) 

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = tabLayout

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(45, 45, 55)
uiStroke.Parent = tabLayout

tabLayout.Parent = settingsTab

-- 3. Top Banner (Branding & Minimize)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
topBar.BorderSizePixel = 0
topBar.Parent = tabLayout

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 8)
topBarCorner.Parent = topBar

-- Hide lower corners of top bar
local topBarLine = Instance.new("Frame")
topBarLine.Size = UDim2.new(1, 0, 0, 5)
topBarLine.Position = UDim2.new(0, 0, 1, -5)
topBarLine.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
topBarLine.BorderSizePixel = 0
topBarLine.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Text = "FF-hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.TextColor3 = Color3.fromRGB(0, 180, 255) -- Vivid blue theme accent
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Size = UDim2.new(0, 100, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = topBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -32, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeButton.TextSize = 14
minimizeButton.AutoButtonColor = false
minimizeButton.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeButton

-- 4. Left Sidebar Layout (Navigation)
local sideBar = Instance.new("Frame")
sideBar.Name = "SideBar"
sideBar.Size = UDim2.new(0, 120, 1, -35)
sideBar.Position = UDim2.new(0, 0, 0, 35)
sideBar.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
sideBar.BorderSizePixel = 0
sideBar.Parent = tabLayout

local sideBarLine = Instance.new("Frame")
sideBarLine.Size = UDim2.new(0, 1, 1, 0)
sideBarLine.Position = UDim2.new(1, -1, 0, 0)
sideBarLine.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
sideBarLine.BorderSizePixel = 0
sideBarLine.Parent = sideBar

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 10)
sidePadding.PaddingLeft = UDim.new(0, 8)
sidePadding.PaddingRight = UDim.new(0, 8)
sidePadding.Parent = sideBar

-- Universal Tab Button
local universalTabBtn = Instance.new("TextButton")
universalTabBtn.Name = "UniversalTabButton"
universalTabBtn.Size = UDim2.new(1, 0, 0, 32)
universalTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
universalTabBtn.Font = Enum.Font.GothamBold
universalTabBtn.Text = "Universal"
universalTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
universalTabBtn.TextSize = 12
universalTabBtn.AutoButtonColor = false
universalTabBtn.Parent = sideBar

local tabBtnCorner = Instance.new("UICorner")
tabBtnCorner.CornerRadius = UDim.new(0, 6)
tabBtnCorner.Parent = universalTabBtn

local tabStroke = Instance.new("UIStroke")
tabStroke.Thickness = 1
tabStroke.Color = Color3.fromRGB(0, 180, 255)
tabStroke.Transparency = 0.5
tabStroke.Parent = universalTabBtn

-- 5. Right Main Content Area
local mainContent = Instance.new("ScrollingFrame")
mainContent.Name = "MainContent"
mainContent.Size = UDim2.new(1, -120, 1, -35)
mainContent.Position = UDim2.new(0, 120, 0, 35)
mainContent.BackgroundTransparency = 1
mainContent.BorderSizePixel = 0
mainContent.ScrollBarThickness = 2
mainContent.ScrollBarImageColor3 = Color3.fromRGB(45, 45, 55)
mainContent.Parent = tabLayout

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 15)
contentPadding.PaddingLeft = UDim.new(0, 15)
contentPadding.PaddingRight = UDim.new(0, 15)
contentPadding.Parent = mainContent

local contentListLayout = Instance.new("UIListLayout")
contentListLayout.Padding = UDim.new(0, 10)
contentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentListLayout.Parent = mainContent

-- Setup Custom Environment Bindings for the scripts
local events = {
    WalkSpeedToggle = Instance.new("BindableEvent"),
    WalkSpeedSlider = Instance.new("BindableEvent"),
    FlySpeedToggle = Instance.new("BindableEvent")
}

-- Custom element creator tailored to the look of the layout image
local function createModernToggle(name, text, layoutOrder)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    container.BorderSizePixel = 0
    container.LayoutOrder = layoutOrder
    
    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = container

    local label = Instance.new("TextLabel")
    label.Text = text
    label.Font = Enum.Font.GothamMedium
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Parent = container

    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 45, 0, 22)
    btn.Position = UDim2.new(1, -57, 0.5, -11)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = container

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 11)
    bCorner.Parent = btn

    local bStroke = Instance.new("UIStroke")
    bStroke.Thickness = 1
    bStroke.Color = Color3.fromRGB(55, 55, 70)
    bStroke.Parent = btn

    local dot = Instance.new("Frame")
    dot.Name = "Dot"
    dot.Size = UDim2.new(0, 16, 0, 16)
    dot.Position = UDim2.new(0, 3, 0.5, -8)
    dot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    dot.BorderSizePixel = 0
    dot.Parent = btn

    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(1, 0)
    dCorner.Parent = dot

    local valueObj = Instance.new("BoolValue")
    valueObj.Name = "Value"
    valueObj.Parent = btn

    -- Fancy sliding switch micro-interactions
    btn.Activated:Connect(function()
        valueObj.Value = not valueObj.Value
        events[name]:Fire(valueObj.Value)
    end)

    return container, btn
end

---------------------------------------------------------
-- MENU TOGGLE MECHANIC (Open/Close Menu)
---------------------------------------------------------
local menuOpen = true
local function toggleMenu()
    menuOpen = not menuOpen
    tabLayout.Visible = menuOpen
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.M then
        toggleMenu()
    end
end)

---------------------------------------------------------
-- FEATURE 1: WALK SPEED TOGGLE
---------------------------------------------------------
local walkSpeedContainer, walkSpeedToggleBtn = createModernToggle("WalkSpeedToggle", "Enable Custom Walkspeed", 2)
walkSpeedContainer.Parent = mainContent

-- Construct a modern mock Slider item layout
local walkSpeedSliderBtn = Instance.new("Frame")
walkSpeedSliderBtn.Name = "WalkSpeedSlider"
walkSpeedSliderBtn.Size = UDim2.new(1, 0, 0, 20)
walkSpeedSliderBtn.BackgroundTransparency = 1
walkSpeedSliderBtn.LayoutOrder = 3
walkSpeedSliderBtn.Parent = mainContent

local sliderValueObj = Instance.new("NumberValue")
sliderValueObj.Name = "Value"
sliderValueObj.Parent = walkSpeedSliderBtn

local walkSpeedToggle = { ValueChanged = events.WalkSpeedToggle.Event }
local walkSpeedSlider = { ValueChanged = events.WalkSpeedSlider.Event }

local toggleMT = setmetatable(walkSpeedToggle, {
    __index = function(t, k) if k == "Value" then return walkSpeedToggleBtn.Value.Value end end,
    __newindex = function(t, k, v) if k == "Value" then walkSpeedToggleBtn.Value.Value = v end end
})
local sliderMT = setmetatable(walkSpeedSlider, {
    __index = function(t, k) if k == "Value" then return sliderValueObj.Value end end,
    __newindex = function(t, k, v) if k == "Value" then sliderValueObj.Value = v events.WalkSpeedSlider:Fire(v) end end
})

local function toggleWalkSpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    if not humanoid then return end
    
    local walkSpeedOn = walkSpeedToggleBtn.Value.Value
    
    if walkSpeedOn then
        humanoid.WalkSpeed = 50
        sliderMT.Value = 1
    else
        humanoid.WalkSpeed = 16
        sliderMT.Value = 0
    end
    
    -- Animate the sleek UI switch node
    if walkSpeedOn then
        TweenService:Create(walkSpeedToggleBtn.Dot, TWEEN_INFO, {Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(walkSpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    else
        TweenService:Create(walkSpeedToggleBtn.Dot, TWEEN_INFO, {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
        TweenService:Create(walkSpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
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
local flySpeedContainer, flySpeedToggleBtn = createModernToggle("FlySpeedToggle", "Noclip Fly Activation", 4)
flySpeedContainer.Parent = mainContent

local flySpeedToggle = { ValueChanged = events.FlySpeedToggle.Event }
local flyMT = setmetatable(flySpeedToggle, {
    __index = function(t, k) if k == "Value" then return flySpeedToggleBtn.Value.Value end end,
    __newindex = function(t, k, v) if k == "Value" then flySpeedToggleBtn.Value.Value = v end end
})

local function toggleFlySpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    if not character then return end
    
    local flySpeedOn = flySpeedToggleBtn.Value.Value
    local rootPart = character:WaitForChild("HumanoidRootPart")
    if rootPart then
        rootPart.CanCollide = not flySpeedOn
    end
    
    -- Animate the sleek UI switch node
    if flySpeedOn then
        TweenService:Create(flySpeedToggleBtn.Dot, TWEEN_INFO, {Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(flySpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    else
        TweenService:Create(flySpeedToggleBtn.Dot, TWEEN_INFO, {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
        TweenService:Create(flySpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
    end
end

flySpeedToggle.ValueChanged:Connect(toggleFlySpeed)

---------------------------------------------------------
-- FEATURE 3: MINIMIZE BUTTON EXECUTION BIND
---------------------------------------------------------
minimizeButton.MouseEnter:Connect(function()
    TweenService:Create(minimizeButton, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(230, 60, 60), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
minimizeButton.MouseLeave:Connect(function()
    TweenService:Create(minimizeButton, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(35, 35, 45), TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
end)

local function onActivate()
    if settingsTab then
        settingsTab:Destroy()
    end
end

minimizeButton.Activated:Connect(onActivate)

-- Initialize values safely 
toggleMT.Value = false
flyMT.Value = false

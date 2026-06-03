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

-- 2. Main Windows Frame
local tabLayout = Instance.new("Frame")
tabLayout.Name = "TabLayout"
tabLayout.BackgroundColor3 = Color3.fromRGB(24, 24, 30) 
tabLayout.BorderSizePixel = 0
tabLayout.Size = UDim2.new(0, 480, 0, 320) 
tabLayout.Position = UDim2.new(0.5, -240, 0.5, -160) 
tabLayout.ClipsDescendants = true 

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = tabLayout

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1
uiStroke.Color = Color3.fromRGB(45, 45, 55)
uiStroke.Parent = tabLayout

tabLayout.Parent = settingsTab

-- 3. Top Banner (Branding, Dragging & Minimize)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
topBar.BorderSizePixel = 0
topBar.Parent = tabLayout

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 8)
topBarCorner.Parent = topBar

local topBarLine = Instance.new("Frame")
topBarLine.Size = UDim2.new(1, 0, 0, 5)
topBarLine.Position = UDim2.new(0, 0, 1, -5)
topBarLine.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
topBarLine.BorderSizePixel = 0
topBarLine.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Text = "FF-hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.TextColor3 = Color3.fromRGB(0, 180, 255) 
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Size = UDim2.new(0, 100, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = topBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -32, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeButton.TextSize = 14
minimizeButton.AutoButtonColor = false
minimizeButton.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeButton

-- 4. Left Sidebar Layout (Navigation Sidebar)
local sideBar = Instance.new("Frame")
sideBar.Name = "SideBar"
sideBar.Size = UDim2.new(0, 120, 1, -35)
sideBar.Position = UDim2.new(0, 0, 0, 35)
sideBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
sideBar.BorderSizePixel = 0
sideBar.Parent = tabLayout

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 10)
sidePadding.PaddingLeft = UDim.new(0, 8)
sidePadding.PaddingRight = UDim.new(0, 8)
sidePadding.Parent = sideBar

local universalTabBtn = Instance.new("TextButton")
universalTabBtn.Name = "UniversalTabButton"
universalTabBtn.Size = UDim2.new(1, 0, 0, 32)
universalTabBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
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

-- 5. Right Content Area Frame
local mainContent = Instance.new("Frame")
mainContent.Name = "MainContent"
mainContent.Size = UDim2.new(1, -120, 1, -35)
mainContent.Position = UDim2.new(0, 120, 0, 35)
mainContent.BackgroundTransparency = 1
mainContent.BorderSizePixel = 0
mainContent.Parent = tabLayout

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 15)
contentPadding.PaddingLeft = UDim.new(0, 15)
contentPadding.PaddingRight = UDim.new(0, 15)
contentPadding.Parent = mainContent

local contentListLayout = Instance.new("UIListLayout")
contentListLayout.Padding = UDim.new(0, 12)
contentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentListLayout.Parent = mainContent

-- 6. Bottom-Right Minimize Circle Button
local quickToggleBtn = Instance.new("TextButton")
quickToggleBtn.Name = "QuickToggleButton"
quickToggleBtn.Size = UDim2.new(0, 50, 0, 50)
quickToggleBtn.Position = UDim2.new(1, -70, 1, -70) 
quickToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
quickToggleBtn.Text = "FF"
quickToggleBtn.Font = Enum.Font.GothamBold
quickToggleBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
quickToggleBtn.TextSize = 16
quickToggleBtn.AutoButtonColor = false
quickToggleBtn.Visible = false 
quickToggleBtn.Parent = settingsTab

local qtCorner = Instance.new("UICorner")
qtCorner.CornerRadius = UDim.new(1, 0) 
qtCorner.Parent = quickToggleBtn

local qtStroke = Instance.new("UIStroke")
qtStroke.Thickness = 1.5
qtStroke.Color = Color3.fromRGB(0, 180, 255)
qtStroke.Parent = quickToggleBtn

---------------------------------------------------------
-- DRAGGING SYSTEM
---------------------------------------------------------
local dragging = false
local dragStart = Vector3.new()
local startPos = UDim2.new()

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = tabLayout.Position
        
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                if connection then connection:Disconnect() end
            end
        end)
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local mousePos = UserInputService:GetMouseLocation()
        local delta = Vector3.new(mousePos.X, mousePos.Y, 0) - dragStart
        tabLayout.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset - 36 + delta.Y)
    end
end)

---------------------------------------------------------
-- FLUID MINIMIZE / RESTORE SYSTEM
---------------------------------------------------------
local menuOpen = true
local originalPosition = tabLayout.Position

local function minimizeToCircle()
    if not menuOpen then return end
    menuOpen = false
    originalPosition = tabLayout.Position 
    
    local targetPos = UDim2.new(1, -70, 1, -70)
    
    local animSize = TweenService:Create(tabLayout, TWEEN_INFO, {Size = UDim2.new(0, 50, 0, 50), Position = targetPos})
    local animFade = TweenService:Create(tabLayout, TWEEN_INFO, {BackgroundTransparency = 1})
    
    animSize:Play()
    animFade:Play()
    
    animSize.Completed:Connect(function()
        tabLayout.Visible = false
        quickToggleBtn.Visible = true
        quickToggleBtn.Size = UDim2.new(0, 10, 0, 10)
        quickToggleBtn.Position = UDim2.new(1, -50, 1, -50)
        TweenService:Create(quickToggleBtn, TWEEN_INFO, {Size = UDim2.new(0, 50, 0, 50), Position = UDim2.new(1, -70, 1, -70)}):Play()
    end)
end

local function restoreFromCircle()
    if menuOpen then return end
    
    quickToggleBtn.Visible = false
    tabLayout.Visible = true
    tabLayout.Size = UDim2.new(0, 50, 0, 50)
    tabLayout.Position = UDim2.new(1, -70, 1, -70)
    
    local animRestore = TweenService:Create(tabLayout, TWEEN_INFO, {Size = UDim2.new(0, 480, 0, 320), Position = originalPosition})
    local animVisible = TweenService:Create(tabLayout, TWEEN_INFO, {BackgroundTransparency = 0})
    
    animRestore:Play()
    animVisible:Play()
    
    animRestore.Completed:Connect(function()
        menuOpen = true
    end)
end

minimizeButton.Activated:Connect(minimizeToCircle)
quickToggleBtn.Activated:Connect(restoreFromCircle)

---------------------------------------------------------
-- TOGGLE & FIXED SLIDER CREATION LOGIC
---------------------------------------------------------
local events = {
    WalkSpeedToggle = Instance.new("BindableEvent"),
    WalkSpeedSlider = Instance.new("BindableEvent"),
    FlySpeedToggle = Instance.new("BindableEvent")
}

local function createModernToggle(name, text, layoutOrder)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
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
    btn.BackgroundColor3 = Color3.fromRGB(48, 48, 60)
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = container

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 11)
    bCorner.Parent = btn

    local bStroke = Instance.new("UIStroke")
    bStroke.Thickness = 1
    bStroke.Color = Color3.fromRGB(65, 65, 80)
    bStroke.Parent = btn

    local dot = Instance.new("Frame")
    dot.Name = "Dot"
    dot.Size = UDim2.new(0, 16, 0, 16)
    dot.Position = UDim2.new(0, 3, 0.5, -8)
    dot.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    dot.BorderSizePixel = 0
    dot.Parent = btn

    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(1, 0)
    dCorner.Parent = dot

    local valueObj = Instance.new("BoolValue")
    valueObj.Name = "Value"
    valueObj.Parent = btn

    btn.Activated:Connect(function()
        valueObj.Value = not valueObj.Value
        events[name]:Fire(valueObj.Value)
    end)

    return container, btn
end

-- Fixed visual slider construction with explicit frame boundaries
local function createModernSlider(name, text, layoutOrder)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, 0, 0, 45)
    container.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
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
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Parent = container

    -- Slider Track Backplate (Fixed position coordinates)
    local sliderTrack = Instance.new("TextButton")
    sliderTrack.Name = name
    sliderTrack.Size = UDim2.new(1, -160, 0, 6)
    sliderTrack.Position = UDim2.new(0, 140, 0.5, -3)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    sliderTrack.Text = ""
    sliderTrack.AutoButtonColor = false
    sliderTrack.Parent = container

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 3)
    trackCorner.Parent = sliderTrack

    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new(0.2, 0, 1, 0) -- Starts at 20% value filled
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = sliderFill

    local sliderKnob = Instance.new("Frame")
    sliderKnob.Name = "Knob"
    sliderKnob.Size = UDim2.new(0, 14, 0, 14)
    sliderKnob.Position = UDim2.new(0.2, -7, 0.5, -7)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.BorderSizePixel = 0
    sliderKnob.Parent = sliderTrack

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = sliderKnob

    local valueObj = Instance.new("NumberValue")
    valueObj.Name = "Value"
    valueObj.Value = 0.2
    valueObj.Parent = sliderTrack

    local sliding = false
    
    local function snapToMouse()
        local mousePos = UserInputService:GetMouseLocation().X
        local trackStart = sliderTrack.AbsolutePosition.X
        local trackWidth = sliderTrack.AbsoluteSize.X
        local percentage = math.clamp((mousePos - trackStart) / trackWidth, 0, 1)
        
        valueObj.Value = percentage
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderKnob.Position = UDim2.new(percentage, -7, 0.5, -7)
        events[name]:Fire(percentage)
    end

    sliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            snapToMouse()
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            snapToMouse()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)

    return container, sliderTrack
end

---------------------------------------------------------
-- FEATURE 1: WALK SPEED BINDINGS
---------------------------------------------------------
local walkSpeedContainer, walkSpeedToggleBtn = createModernToggle("WalkSpeedToggle", "Enable Custom Walkspeed", 2)
walkSpeedContainer.Parent = mainContent

local walkSpeedSliderContainer, walkSpeedSliderBtn = createModernSlider("WalkSpeedSlider", "Speed Value", 3)
walkSpeedSliderContainer.Parent = mainContent

local walkSpeedToggle = { ValueChanged = events.WalkSpeedToggle.Event }
local walkSpeedSlider = { ValueChanged = events.WalkSpeedSlider.Event }

local toggleMT = setmetatable(walkSpeedToggle, {
    __index = function(t, k) if k == "Value" then return walkSpeedToggleBtn.Value.Value end end,
    __newindex = function(t, k, v) if k == "Value" then walkSpeedToggleBtn.Value.Value = v end end
})
local sliderMT = setmetatable(walkSpeedSlider, {
    __index = function(t, k) if k == "Value" then return walkSpeedSliderBtn.Value.Value end end,
    __newindex = function(t, k, v) 
        if k == "Value" then 
            walkSpeedSliderBtn.Value.Value = v 
            walkSpeedSliderBtn.Fill.Size = UDim2.new(v, 0, 1, 0)
            walkSpeedSliderBtn.Knob.Position = UDim2.new(v, -7, 0.5, -7)
            events.WalkSpeedSlider:Fire(v) 
        end 
    end
})

local currentSpeedMultiplier = 32

local function updateWalkSpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    if walkSpeedToggleBtn.Value.Value then
        humanoid.WalkSpeed = currentSpeedMultiplier
    else
        humanoid.WalkSpeed = 16
    end
end

local function toggleWalkSpeed()
    local walkSpeedOn = walkSpeedToggleBtn.Value.Value
    updateWalkSpeed()
    
    if walkSpeedOn then
        TweenService:Create(walkSpeedToggleBtn.Dot, TWEEN_INFO, {Position = UDim2.new(1, -19, 0.5, -8)}):Play()
        TweenService:Create(walkSpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    else
        TweenService:Create(walkSpeedToggleBtn.Dot, TWEEN_INFO, {Position = UDim2.new(0, 3, 0.5, -8)}):Play()
        TweenService:Create(walkSpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(48, 48, 60)}):Play()
    end
end

walkSpeedSlider.ValueChanged:Connect(function(percentage)
    currentSpeedMultiplier = 16 + (percentage * 150) -- Scales up to 166 walkspeed max
    updateWalkSpeed()
end)

walkSpeedToggle.ValueChanged:Connect(toggleWalkSpeed)

-- Keep character speed linked when respawning
player.CharacterAdded:Connect(function()
    task.wait(1)
    updateWalkSpeed()
end)

---------------------------------------------------------
-- FEATURE 2: FLY BINDINGS (Stable Anchor Engine)
---------------------------------------------------------
local flySpeedContainer, flySpeedToggleBtn = createModernToggle("FlySpeedToggle", "Noclip Fly Activation", 4)
flySpeedContainer.Parent = mainContent

local flySpeedToggle = { ValueChanged = events.FlySpeedToggle.Event }
local flyMT = setmetatable(flySpeedToggle, {
    __index = function(t, k) if k == "Value" then return flySpeedToggleBtn.Value.Value end end,
    __newindex = function(t, k, v) if k == "Value" then flySpeedToggleBtn.Value.Value = v end end
})

local bodyPosInstance = nil
local bodyGyroInstance = nil
local flyConnection = nil

local function toggleFlySpeed()
    local character = player.Character or player.CharacterAdded:Wait()
    if not character then return end
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid then return end
    
    local flySpeedOn = flySpeedToggleBtn.Value.Value
    
    if flySpeedOn then
        -- Stable alternative anchor parameters for executor compatibility
        bodyPosInstance = Instance.new("BodyPosition")
        bodyPosInstance.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyPosInstance.Position = rootPart.Position
        bodyPosInstance.Parent = rootPart
        
        bodyGyroInstance = Instance.new("BodyGyro")
        bodyGyroInstance.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bodyGyroInstance.CFrame = rootPart.CFrame
        bodyGyroInstance.Parent = rootPart
        
        flyConnection = RunService.RenderStepped:Connect(function()
            local camera = workspace.CurrentCamera
            local moveDirection = humanoid.MoveDirection
            local upVector = 0
            
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                upVector = 1
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                upVector = -1
            end
            
            -- Lock camera angles into movement trajectory vectors
            bodyGyroInstance.CFrame = camera.CFrame
            bodyPosInstance.Position = bodyPosInstance.Position + (moveDirection * 1.5) + Vector3.new(0, upVector * 1.2, 0)
            
            -- Enforce zero-gravity hovering states smoothly
            rootPart.Velocity = Vector3.new(0, 0, 0)
        end)
        
        TweenService:Create(flySpeedToggleBtn.Dot, TWEEN_INFO, {Position = UDim2.new(1, -19, 0.5, -8)}):Play()
        TweenService:Create(flySpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    else
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if bodyPosInstance then bodyPosInstance:Destroy() bodyPosInstance = nil end
        if bodyGyroInstance then bodyGyroInstance:Destroy() bodyGyroInstance = nil end
        
        TweenService:Create(flySpeedToggleBtn.Dot, TWEEN_INFO, {Position = UDim2.new(0, 3, 0.5, -8)}):Play()
        TweenService:Create(flySpeedToggleBtn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(48, 48, 60)}):Play()
    end
end

flySpeedToggle.ValueChanged:Connect(toggleFlySpeed)

-- Initialize values cleanly
toggleMT.Value = false
flyMT.Value = false
sliderMT.Value = 0.2

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
tabLayout.Size = UDim2.new(0, 480, 0, 350) 
tabLayout.Position = UDim2.new(0.5, -240, 0.5, -175) 
tabLayout.ClipsDescendants = true 

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = tabLayout

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1
uiStroke.Color = Color3.fromRGB(45, 45, 55)
uiStroke.Parent = tabLayout

tabLayout.Parent = settingsTab

-- 3. Top Banner (Dragging & Minimize)
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

-- 4. Left Sidebar Layout
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
contentListLayout.Padding = UDim.new(0, 10)
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
    
    local animRestore = TweenService:Create(tabLayout, TWEEN_INFO, {Size = UDim2.new(0, 480, 0, 350), Position = originalPosition})
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
-- UI ELEMENT GENERATORS
---------------------------------------------------------
local function createModernToggle(name, text, layoutOrder, callback)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, 0, 0, 38)
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

    local active = false
    btn.Activated:Connect(function()
        active = not active
        if active then
            TweenService:Create(dot, TWEEN_INFO, {Position = UDim2.new(1, -19, 0.5, -8)}):Play()
            TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
        else
            TweenService:Create(dot, TWEEN_INFO, {Position = UDim2.new(0, 3, 0.5, -8)}):Play()
            TweenService:Create(btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromRGB(48, 48, 60)}):Play()
        end
        callback(active)
    end)

    container.Parent = mainContent
    return container
end

local function createModernSlider(name, text, layoutOrder, callback)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(1, 0, 0, 38)
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
    sliderFill.Size = UDim2.new(0.2, 0, 1, 0) 
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

    local sliding = false
    
    local function snapToMouse()
        local mousePos = UserInputService:GetMouseLocation().X
        local trackStart = sliderTrack.AbsolutePosition.X
        local trackWidth = sliderTrack.AbsoluteSize.X
        local percentage = math.clamp((mousePos - trackStart) / trackWidth, 0, 1)
        
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderKnob.Position = UDim2.new(percentage, -7, 0.5, -7)
        callback(percentage)
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
-- SPEED MECHANIC
---------------------------------------------------------
local speedEnabled = false
local targetSpeed = 16

createModernToggle("SpeedToggle", "Enable Custom Walkspeed", 1, function(state)
    speedEnabled = state
    local character = player.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = speedEnabled and targetSpeed or 16
    end
end)

createModernSlider("SpeedSlider", "Speed Value", 2, function(percentage)
    targetSpeed = 16 + (percentage * 150)
    local character = player.Character
    if speedEnabled and character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = targetSpeed
    end
end)

---------------------------------------------------------
-- FLY SEPARATE TOGGLE (Modern Engine Fix)
---------------------------------------------------------
local flyEnabled = false
local flyConnection = nil
local linearVelocity = nil
local alignOrientation = nil
local attachment = nil
local animCount = 0

createModernToggle("FlyToggle", "Flight Mode Active", 3, function(state)
    flyEnabled = state
    local character = player.Character
    if not character then return end
    local rootPart = character:WaitForChild("HumanoidRootPart", 2)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not humanoid then return end

    if flyEnabled then
        -- Clean structural generation of modern constraints
        attachment = Instance.new("Attachment")
        attachment.Name = "FlyAttachment"
        attachment.Parent = rootPart

        linearVelocity = Instance.new("LinearVelocity")
        linearVelocity.MaxForce = 50000
        linearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        linearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
        linearVelocity.Attachment0 = attachment
        linearVelocity.Parent = rootPart
        
        alignOrientation = Instance.new("AlignOrientation")
        alignOrientation.MaxTorque = 50000
        alignOrientation.Responsiveness = 25
        alignOrientation.Mode = Enum.OrientationMode.OneAttachment
        alignOrientation.Attachment0 = attachment
        alignOrientation.CFrame = rootPart.CFrame
        alignOrientation.Parent = rootPart

        humanoid.PlatformStand = true -- Blocks falling states cleanly

        flyConnection = RunService.RenderStepped:Connect(function()
            local camera = workspace.CurrentCamera
            local moveDirection = humanoid.MoveDirection
            local upVector = 0
            
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                upVector = 1
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                upVector = -1
            end
            
            animCount = animCount + 0.08
            local floatOffset = math.sin(animCount) * 0.4
            
            alignOrientation.CFrame = camera.CFrame
            linearVelocity.VectorVelocity = (moveDirection * 45) + Vector3.new(0, (upVector * 35) + floatOffset, 0)

            -- Smooth Joint Ticking (R15 & R6 structural validation loops)
            for _, motor in pairs(character:GetDescendants()) do
                if motor:IsA("Motor6D") then
                    if motor.Name:find("LeftHip") or motor.Name:find("Left Thigh") then
                        motor.Transform = CFrame.Angles(0.3, 0, 0)
                    elseif motor.Name:find("RightHip") or motor.Name:find("Right Thigh") then
                        motor.Transform = CFrame.Angles(0.3, 0, 0)
                    elseif motor.Name:find("Shoulder") or motor.Name:find("Arm") then
                        motor.Transform = CFrame.Angles(-0.2, 0, 0)
                    end
                end
            end
        end)
    else
        -- Clean structural cleanup 
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if linearVelocity then linearVelocity:Destroy() linearVelocity = nil end
        if alignOrientation then alignOrientation:Destroy() alignOrientation = nil end
        if attachment then attachment:Destroy() attachment = nil end
        
        if humanoid then humanoid.PlatformStand = false end
        
        for _, motor in pairs(character:GetDescendants()) do
            if motor:IsA("Motor6D") then
                motor.Transform = CFrame.new()
            end
        end
    end
end)

---------------------------------------------------------
-- NOCLIP SEPARATE TOGGLE
---------------------------------------------------------
local noclipEnabled = false
local noclipConnection = nil

createModernToggle("NoclipToggle", "Enable Noclip (No Walls)", 4, function(state)
    noclipEnabled = state
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Structural setup for character spawns
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if speedEnabled and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = targetSpeed
    end
end)

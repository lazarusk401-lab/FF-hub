-- Overall Layout
local layout = Instance.new("Frame")
layout.Name = "Layout"
layout.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
layout.BorderSizePixel = 0

-- Header (Top of Main Panel)
local header = Instance.new("TextLabel")
header.Name = "Header"
header.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
header.BackgroundTransparency = 1
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.Size = UDim2.new(0, 320, 0, 60)
header.Font = Enum.Font.SourceSansBold
header.Text = "FF-HUB"
header.Parent = layout

-- Left Sidebar (Navigation)
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
sidebar.BorderSizePixel = 0
sidebar.Size = UDim2.new(0, 200, 0, 480)
sidebar.Position = UDim2.new(0, 10, 0, 30)
sidebar.Parent = layout

local tabList = Instance.new("Frame")
tabList.Name = "TabList"
tabList.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
tabList.BorderSizePixel = 0
tabList.Size = UDim2.new(0, 150, 1, -10)
tabList.Position = UDim2.new(0, 10, 0, -30)
tabList.Parent = sidebar

local tab = Instance.new("TextLabel")
tab.Name = "Tab"
tab.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
tab.BackgroundTransparency = 1
tab.TextColor3 = Color3.fromRGB(200, 200, 200)
tab.Size = UDim2.new(0, 150, 1, -10)
tab.Font = Enum.Font.SourceSans
tab.Text = "Universal"
tab.Parent = tabList

-- Main Content (Universal Tab)
local content = Instance.new("Frame")
content.Name = "Content"
content.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
content.BackgroundTransparency = 1
content.Size = UDim2.new(0, 320, 0, 480)
content.Position = UDim2.new(0, -190, 0, 60)
content.Parent = layout

local speedControl = Instance.new("Frame")
speedControl.Name = "SpeedControl"
speedControl.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
speedControl.BackgroundTransparency = 1
speedControl.Size = UDim2.new(0, 320, 1, -60)
speedControl.Position = UDim2.new(0, -190, 0, -10)
speedControl.Parent = content

local speedToggle = Instance.new("Frame")
speedToggle.Name = "SpeedToggle"
speedToggle.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
speedToggle.BackgroundTransparency = 1
speedToggle.Size = UDim2.new(0, 100, 1, -20)
speedToggle.Position = UDim2.new(0, -130, 0, -10)
speedToggle.Parent = speedControl

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.Size = UDim2.new(0, 100, 1, -10)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.Text = "Speed"
speedLabel.Parent = speedToggle

local speedSlider = Instance.new("Frame")
speedSlider.Name = "SpeedSlider"
speedSlider.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
speedSlider.BackgroundTransparency = 1
speedSlider.Size = UDim2.new(0, 100, 1, -20)
speedSlider.Position = UDim2.new(0, 130, 0, -10)
speedSlider.Parent = speedControl

local flyControls = Instance.new("Frame")
flyControls.Name = "FlyControls"
flyControls.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
flyControls.BackgroundTransparency = 1
flyControls.Size = UDim2.new(0, 320, 1, -60)
flyControls.Position = UDim2.new(0, -190, 0, -10)
flyControls.Parent = content

local flyToggle = Instance.new("Frame")
flyToggle.Name = "FlyToggle"
flyToggle.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
flyToggle.BackgroundTransparency = 1
flyToggle.Size = UDim2.new(0, 100, 1, -20)
flyToggle.Position = UDim2.new(0, -130, 0, -10)
flyToggle.Parent = flyControls

local flyLabel = Instance.new("TextLabel")
flyLabel.Name = "FlyLabel"
flyLabel.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
flyLabel.BackgroundTransparency = 1
flyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
flyLabel.Size = UDim2.new(0, 100, 1, -10)
flyLabel.Font = Enum.Font.SourceSans
flyLabel.Text = "Fly"
flyLabel.Parent = flyToggle

local flySlider = Instance.new("Frame")
flySlider.Name = "FlySlider"
flySlider.BackgroundColor3 = Color3.fromRGB(30, 50, 70)
flySlider.BackgroundTransparency = 1
flySlider.Size = UDim2.new(0, 100, 1, -20)
flySlider.Position = UDim2.new(0, 130, 0, -10)
flySlider.Parent = flyControls

local animationManager = Instance.new("TweenService")
animationManager.Parent = game:GetService("RunService")

local function createAnimation tween(target, propertyPath, value, easing)
    local tweenInfo = TweenInfo.new(tweenValueTime, tweenType)
    tweenService:Play TweenInfo.new(tweenInfo, tweenTarget, tweenValue, tweenEasing)
end

local tweenManager = Instance.new("TweenService")
tweenManager.Parent = game:GetService("RunService")

local function createHoverAnimation(target, propertyPath, value, easing)
    local tweenInfo = TweenInfo.new(hoverAnimationTime, tweenType)
    tweenService:Play TweenInfo.new(tweenInfo, tweenTarget, tweenValue, tweenEasing)
end

-- Tab switching
local tabClickFunction = function(tab)
    -- Hide active tabs
    for i, v in pairs(tabList:GetChildren()) do
        if v.Name ~= "Active" then
            v:Destroy()
        end
    end
    
    -- Show selected tab
    tab:Destroy()
    local newTab = Instance.new("TextLabel")
    newTab.Name = "Active"
    newTab.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    newTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    newTab.Size = UDim2.new(0, 150, 1, -10)
    newTab.Font = Enum.Font.SourceSans
    newTab.Text = tab.Name
    tabList:InsertChildAt(1, newTab)
end

tabClickFunction(tab)

-- Event listeners
local function onHoverOver()
    createHoverAnimation(speedToggle, "BackgroundTransparency", 0.2, Enum.EasingStyle.Sine)
    createHoverAnimation(flyToggle, "BackgroundTransparency", 0.2, Enum.EasingStyle.Sine)
end

speedToggle.Hovered:Connect(onHoverOver)

local function onHoverOut()
    createHoverAnimation(speedToggle, "BackgroundTransparency", 1, Enum.EasingStyle.Sine)
    createHoverAnimation(flyToggle, "BackgroundTransparency", 1, Enum.EasingStyle.Sine)
end

speedToggle.OutToRest:Connect(onHoverOut)

-- Event listeners for sliders
local function onSliderDrag(eventParameters)
    local slider = eventParameters.Parent
    if slider.Name == "SpeedSlider" then
        createAnimation tween(speedControl, "BackgroundColorTransparency", 0.2, Enum.EasingStyle.Sine)
    elseif slider.Name == "FlySlider" then
        createAnimation tween(flyControls, "BackgroundColorTransparency", 0.2, Enum.EasingStyle.Sine)
    end
    
    local knob = eventParameters.Parent:FindFirstChild("Knob")
    if knob then
        local offset = (eventParameters.Value - slider.MaxValue) / (slider.MinValue - slider.MaxValue) * knob.Size.X
        knob.Position = UDim2.new(0, offset, 0, 0)
    end
end

speedSlider DragStarted:Connect(onSliderDrag)
flySlider DragStarted:Connect(onSliderDrag)

-- Event listeners for toggle
local function onToggle()
    local toggle = eventParameters.Parent
    if toggle.Name == "SpeedToggle" then
        createAnimation tween(speedControl, "BackgroundColorTransparency", 0.2, Enum.EasingStyle.Sine)
        createHoverAnimation(speedToggle, "BackgroundTransparency", 0.2, Enum.EasingStyle.Sine)
        speedSlider.Value = (toggle.Value) * slider.MaxValue / slider.MinValue
    elseif toggle.Name == "FlyToggle" then
        createAnimation tween(flyControls, "BackgroundColorTransparency", 0.2, Enum.EasingStyle.Sine)
        createHoverAnimation(flyToggle, "BackgroundTransparency", 0.2, Enum.EasingStyle.Sine)
        flySlider.Value = (toggle.Value) * slider.MaxValue / slider.MinValue
    end
    
    if toggle.Name == "SpeedToggle" then
        local knob = speedToggle:FindFirstChild("Knob")
        if knob then
            createAnimation tween(knob, "Position", 0.2, Enum.EasingStyle.Sine)
        end
    elseif toggle.Name == "FlyToggle" then
        local knob = flyToggle:FindFirstChild("Knob")
        if knob then
            createAnimation tween(knob, "Position", 0.2, Enum.EasingStyle.Sine)
        end
    end
    
    speedSlider.Value = (toggle.Value) * slider.MaxValue / slider.MinValue
end

speedToggle.Touched:Connect(onToggle)
flyToggle.Touched:Connect(onToggle)

-- Event listeners for slider movement
local function onSliderMoved(eventParameters)
    local slider = eventParameters.Parent
    if slider.Name == "SpeedSlider" then
        createAnimation tween(speedControl, "BackgroundColorTransparency", 0.2, Enum.EasingStyle.Sine)
    elseif slider.Name == "FlySlider" then
        createAnimation tween(flyControls, "BackgroundColorTransparency", 0.2, Enum.EasingStyle.Sine)
    end
    
    local knob = eventParameters.Parent:FindFirstChild("Knob")
    if knob then
        local offset = (eventParameters.Value - slider.MaxValue) / (slider.MinValue - slider.MaxValue) * knob.Size.X
        knob.Position = UDim2.new(0, offset, 0, 0)
    end
end

speedSlider.Moved:Connect(onSliderMoved)
flySlider.Moved:Connect(onSliderMoved)

Note that this script is just a starting point and will require additional modifications to fully function as intended. The code above demonstrates basic concepts such as tweening, hover effects, event listeners, and UI manipulation. However, there are many ways to improve the performance, readability, and maintainability of the code.

The main goal of this script is to create a simple UI layout with speed and fly controls, along with their respective effects. The script also demonstrates basic concepts such as event handling, animation management, and UI manipulation.

Please note that creating interactive UI elements can be complex and may require additional work to ensure proper functionality. Always test your code thoroughly before deploying it in production.

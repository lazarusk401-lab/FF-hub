-- Universal Settings Tab
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local settingsTab = Instance.new("ScreenGui")
settingsTab.Name = "Settings"
settingsTab.Parent = game.Players.LocalPlayer.PlayerGui

local tabLayout = Instance.new("Frame")
tabLayout.Name = "TabLayout"
tabLayout.BackgroundTransparency = 0
tabLayout.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
tabLayout.Size = UDim2.new(0, 300, 0, 100)
tabLayout.Position = UDim2.new(0.5, -150, 1, -40)
tabLayout.zIndexBehavior = Enum.ZIndexBehavior.SortsLast
settingsTab.ChildAdded:Connect(function(child) if child.Name == "Settings" then tabLayout.Enabled = true end )
tabLayout.Parent = settingsTab

local tabTitle = Instance.new("Text")
tabTitle.Name = "TabTitle"
tabTitle.BackgroundTransparency = 0
tabTitle.Color = Color3.fromRGB(100, 100, 100)
tabTitle.FontSize = Enum.FontSize.SizeXxl
tabTitle.Text = "Settings"
tabTitle.Font = Enum.FontSourceArialBold
tabTitle.Parent = tabLayout

local function toggleTab()
    if tabLayout.Enabled then tabLayout.Enabled = false else tabLayout.Enabled = true end
end

settingsTab.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then toggleTab() end )
UserInputService.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.Space then toggleTab() end )

-- Toggle Section
local toggleSection = Instance.new("Frame")
toggleSection.Name = "ToggleSection"
toggleSection.BackgroundTransparency = 0
toggleSection.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
toggleSection.Size = UDim2.new(1, -20, 0, 30)
toggleSection.Position = Udim2.new(0.5, -100, 1, -40)
toggleSection.zIndexBehavior = Enum.ZIndexBehavior.SortsLast
settingsTab:FindFirstChild("ToggleSection") and toggleSection.Enabled = true or toggleSection.Enabled = false
toggleSection.Parent = settingsTab

local function toggleSpeed()
    local speedToggle = Instance.new("BoolProp")
    speedToggle.Name = "speedToggle"
    speedToggle.Value = false
    speedToggle.Parent = toggleSection
    local function onToggled() if speedToggle.Value then RunService.RenderStepped:Connect(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20 end ) else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Enum.HumanoidWalkSpeedNormal end
    speedToggle.OnChanged:Connect(onToggled)
end

toggleSection.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then toggleSpeed() end )
UserInputService.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.Space then toggleSpeed() end )

-- Slider Section
local sliderSection = Instance.new("Frame")
sliderSection.Name = "SliderSection"
sliderSection.BackgroundTransparency = 0
sliderSection.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
sliderSection.Size = UDim2.new(1, -20, 0, 30)
sliderSection.Position = Udim2.new(0.5, -100, 1, -40)
sliderSection.zIndexBehavior = Enum.ZIndexBehavior.SortsLast
settingsTab:FindFirstChild("SliderSection") and sliderSection.Enabled = true or sliderSection.Enabled = false
sliderSection.Parent = settingsTab

local function toggleFly()
    local flyToggle = Instance.new("BoolProp")
    flyToggle.Name = "flyToggle"
    flyToggle.Value = false
    flyToggle.Parent = toggleSection
    local function onToggled() if flyToggle.Value then game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false end else game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true end
    flyToggle.OnChanged:Connect(onToggled)
end

toggleSection.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then toggleFly() end )
UserInputService.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.Space then toggleFly() end )

-- FlySpeed Section
local flySpeedSection = Instance.new("Frame")
flySpeedSection.Name = "FlySpeedSection"
flySpeedSection.BackgroundTransparency = 0
flySpeedSection.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
flySpeedSection.Size = UDim2.new(1, -20, 0, 30)
flySpeedSection.Position = Udim2.new(0.5, -100, 1, -40)
flySpeedSection.zIndexBehavior = Enum.ZIndexBehavior.SortsLast
settingsTab:FindFirstChild("FlySpeedSection") and flySpeedSection.Enabled = true or flySpeedSection.Enabled = false
flySpeedSection.Parent = settingsTab

local function toggleFlySpeed()
    local FlySpeedToggle = Instance.new("Slider")
    FlySpeedToggle.Name = "FlySpeedToggle"
    FlySpeedToggle.MaxValue = 10
    FlySpeedToggle.MinValue = -10
    FlySpeedToggle.Value = 0
    FlySpeedToggle.Parent = flySpeedSection
end

toggleSection.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then toggleFlySpeed() end )
UserInputService.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.Space then toggleFlySpeed() end )

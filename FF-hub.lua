-- Hub Script

-- Settings for the Hub
local settings = {
    BackgroundColor = Color3.new(1, 0, 0),
    MinimizeButtonPosition = Enum.UserInputState.Button1,
    MinimizeButtonIcon = "rbxassetid://",
    HubSize = UDim2.new(0, 300),
    HubSpacing = UDim2.new(0, 10)
}

-- UI Components
local Background = Instance.new("Frame")
Background.Name = "HubBG"
Background.BackgroundColor3 = settings.BackgroundColor
Background.BackgroundTransparency = 0.2
Background.Size = settings.HubSize
Background.Position = UDim2.new(0, 0)
Background.Parent = game.Workspace

local Overlay = Instance.new("ScreenGui")
Overlay.Name = "HubOV"
Overlay.Parent = game.Players.LocalPlayer.PlayerGui
Overlay.ScreenTransparent = true
OverlayBackgroundTransparency = 0.8

local MinimizeButton = Instance.new("Text")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Text = ""
MinimizeButton.Font = EnumFontStyleRegular
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.TextSize = 14
MinimizeButton.TextXAlign = Enum.FontTextEnforcementAlignment.Left
MinimizeButton.TextYScale = Enum.FontTextEnforcementScaling.SCALE100
MinimizeButton.Size = UDim2.new(0, 40, 0, 20)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = Enum.new("Position")
MinimizeButton.Parent = Overlay

local CloseButton = Instance.new("Text")
CloseButton.Name = "Close"
CloseButton.Text = ""
CloseButton.Font = EnumFontStyleRegular
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 14
CloseButton.TextXAlign = Enum.FontTextEnforcementAlignment.Right
CloseButton.TextYScale = Enum.FontTextEnforcementScaling.SCALE100
CloseButton.Size = UDim2.new(0, 40, 0, 20)
CloseButton.BackgroundTransparency = 1
CloseButton.Position = Enum.new("Position")
CloseButton.Parent = Overlay

-- Draggable Variables
local isDragging = false
local offset = UDim2.new(0, 0, 0, 0)

-- Event Listeners
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- Start dragging the Hub
        isDragging = true
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if isDragging then
        -- Update drag offset
        offset = UDim2.new(0, input.Position.X - settings.HubSpacing.X, 0, input.Position.Y - settings.HubSpacing.Y)
        Background.Position = UDim2.new(0, (offset.X + settings.HubSize.X).Value, 0, (offset.Y + settings.HubSize.Y).Value)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        -- Stop dragging the Hub
        isDragging = false
    end
end)

MinimizeButton.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Minus then
        -- Minimize the Hub
        if Overlay:FindFirstChild("Close") then
            CloseButton:Destroy()
        else
            local closeScript = Instance.new("Script")
            closeScript.Parent = overlay
            closeScript.Name = "Close"
            closeScript.Source = [[
                local function OnClick()
                    -- Close the Hub
                    overlay:Destroy()
                end
                game:GetService("RunService").RenderStepped:Connect(OnClick)
            ]]
        end
    end
end)

MinimizeButton.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Minus then
        -- Reset Minimize Button
        local buttonScript = Instance.new("Script")
        buttonScript.Parent = overlay
        buttonScript.Name = "MinimizeButton"
        buttonScript.Source = [[
            local function OnClick()
                -- Show the Minimize Button
                MinimizeButton:Destroy()
                local newButton = Instance.new("Text")
                newButton.Text = ""
                newButton.Font = EnumFontStyleRegular
                newButton.TextColor3 = Color3.new(1, 1, 1)
                newButton.TextSize = 14
                newButton.TextXAlign = Enum.FontTextEnforcementAlignment.Left
                newButton.TextYScale = Enum.FontTextEnforcementScaling.SCALE100
                newButton.Size = UDim2.new(0, 40, 0, 20)
                newButton.BackgroundTransparency = 1
                newButton.Position = Enum.new("Position")
                overlay:WaitForChild("MinimizeButton").Parent = overlay
            end
            game:GetService("RunService").RenderStepped:Connect(OnClick)
        ]]
    end
end)

-- Minimize Button Script
local function OnClick()
    -- Close the Hub
    Overlay:Destroy()
end

overlay:WaitForChild("Close"):GetPropertyChangedSignal("Parent"):Connect(function(parent)
    if parent == nil then
        local closeScript = Instance.new("Script")
        closeScript.Parent = overlay
        closeScript.Name = "Close"
        closeScript.Source = [[
            local function OnClick()
                -- Close the Hub
                overlay:Destroy()
            end
            game:GetService("RunService").RenderStepped:Connect(OnClick)
        ]]
    end
end)

-- Close Button Script
local function OnClick()
    -- Close the Hub
    Overlay:Destroy()
end

overlay:WaitForChild("Close"):GetPropertyChangedSignal("Text"):Connect(function(text)
    if text == "" then
        overlay:WaitForChild("Close").Parent = nil
    end
end)

-- Close Button Script
local function OnClick()
    -- Close the Hub
    Overlay:Destroy()
end

overlay:WaitForChild("MinimizeButton"):GetPropertyChangedSignal("Parent"):Connect(function(parent)
    if parent == nil then
        overlay:WaitForChild("Close").Parent = overlay
    end
end)

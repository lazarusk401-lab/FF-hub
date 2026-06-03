-- Function to create a new toggle button
local function createToggle(name, text, layoutOrder)
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
    btn.Size = UDim2.new(0, 50, 0, 22)
    btn.Position = UDim2.new(1, -57, 0.5, -11)
    btn.BackgroundColor3 = Color3.fromRGB(48, 48, 60)
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = container

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 11)
    bCorner.Parent = btn

    local function toggleHandler()
        print("Toggle clicked!")
    end
    btn.Activated:Connect(toggleHandler)

    container.Parent = mainContent
end

-- Function to create a new slider button
local function createSlider(name, text, layoutOrder)
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

    container.Parent = mainContent
end

-- Create the toggle buttons
createToggle("NoclipToggle", "Enable Noclip (No Walls)", 4)
createToggle("SpeedToggle", "Enable Custom Walkspeed", 1)
createToggle("FlyToggle", "Flight Mode Active", 3)

-- Create the slider button
createSlider("SpeedSlider", "Speed Value", 2, function(percentage)
    local calculatedValue = 16 + (percentage * 150)
    print("Walkspeed Target Configuration:", calculatedValue)
end)

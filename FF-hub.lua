-- main.lua
local walkSpeedModule = require("walk_speed")
local player = {
    id = "player",
    speedMultiplier = 1,
}

-- Main function
function main()
    -- Create UI elements
    local mainContent, toggleBtn, sliderContainer, sliderTrack = createModernUI()

    -- Connect event handlers
    toggleBtn.ValueChanged:Connect(walkSpeedModule.toggleButtonEvent)
    local valueChangedEvent, sliderMT = walkSpeedModule.createSlider()
    sliderMT.ValueChanged:Connect(valueChangedEvent)

    -- Update speed every frame
    while true do
        -- Update player speed
        if player.speedMultiplier > 0 then
            player.id .. "_walk_speed" = "true"
        else
            player.id .. "_walk_speed" = "false"
        end

        -- Apply changes to UI
        toggleBtn.ValueChanged:Connect(function(value)
            if value == true then
                local multiplier = math.floor(sliderMT.Value) * 16 + 32
                if multiplier < 150 then
                    player.speedMultiplier = multiplier / 16
                else
                    player.speedMultiplier = 1
                end

                -- Update slider position
                sliderTrack.Position = math.max(0, math.min(multiplier, 100))
            elseif value == false then
                player.speedMultiplier = 1
            end
        end)

        -- Limit to 60 updates per second
        local sleepTime = 1 / 60
        coroutine.sleep(sleepTime)
    end

    -- Shutdown event handler
    print("Shutting down...")
end

-- createModernUI function
local function createModernUI()
    -- Create modern UI elements (toggle button, slider container, track)
    return {
        toggleBtn = nil,
        sliderContainer = nil,
        sliderTrack = nil,
    }
end

-- walk_speed.lua
local walkSpeedModule = {}

walkSpeedModule.toggleButtonEvent = function(value)
    print("Toggle button value:", value)
end

function walkSpeedModule.createSlider()
    local container, toggleBtn = createModernToggle("WalkSpeedToggle", "Enable Custom Walkspeed")
    container.Parent = game:GetService("RunService").RenderStepped:Wait()

    -- Create slider
    local function updateSlider(value)
        -- Update player speed
        if value > 0 then
            walkSpeedModule.updatePlayerSpeed(value)
        else
            walkSpeedModule.resetPlayerSpeed()
        end

        -- Apply changes to UI
        toggleBtn.ValueChanged:Connect(function(v) return v end)
    end

    local slider = createModernSlider("WalkSpeedSlider", "Speed Value")
    slider.Parent = container

    -- Create a new table for the slider's event handler
    local sliderMT = {
        ValueChanged = function(self, value)
            updateSlider(value)
        end,
    }

    return toggleBtn.ValueChanged, sliderMT
end

function walkSpeedModule.updatePlayerSpeed(newMultiplier)
    print("Updating player speed:", newMultiplier)
    -- Update player speed here
end

function walkSpeedModule.resetPlayerSpeed()
    print("Resetting player speed")
    -- Reset player speed here
end

return walkSpeedModule

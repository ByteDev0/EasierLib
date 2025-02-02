local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalChar = LocalPlayer.Character
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TCS = game:GetService("TextChatService")
local Mouse = LocalPlayer:GetMouse()
local Chat = TCS.ChatInputBarConfiguration.TargetTextChannel
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
ScreenGui.Parent = game:GetService("CoreGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.352856815, 0, 0.6, 0)
Frame.Size = UDim2.new(0, 562, 0, 307)

UIListLayout.Parent = Frame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

local EasierLib = {}

EasierLib.GetPlayers = function()
    return Players:GetPlayers()
end

EasierLib.GetClosestPlayerOnScreen = function()
    local ClosestPlayer
    local ClosestDist = math.huge
    for i,v in EasierLib.GetPlayers() do 
        if v.Character and v.Character:FindFirstChild("Head") and v ~= LocalPlayer then 
            local Vector, onScreen = Camera:WorldToViewportPoint(v.Character:FindFirstChild("Head").Position)
            local Mag = Vector2.new(Vector.X - Mouse.X, Vector.Y - Mouse.Y).Magnitude
            if Mag <= ClosestDist then 
                ClosestDist = Mag 
                ClosestPlayer = v
            end
        end
    end
    return ClosestPlayer
end

SendChatMessage = function(msg)
    return Chat:SendAsync(msg)
end

EasierLib.ChangeValue = function(path, newval)
    path.Value = newval
end

EasierLib.SendWebhook = function(webhooklink, content)
    if type(webhooklink) == "string" and type(content) == "string" then
        local webhook = request({
            Url = tostring(webhooklink),
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                ["content"] = tostring(content)
            })
        })

        warn("webhook succesfully sent!")
    else
        warn("[easier-lib] the link and the webhook content must be a string.")
    end
end

EasierLib.Notification = function(name, content, duration)
    local notif = Instance.new("TextLabel")
    notif.Name = "notification"..tostring(math.random(1,10000000))
    notif.Parent = Frame
    notif.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notif.BackgroundTransparency = 1.000
    notif.BorderColor3 = Color3.fromRGB(0, 0, 0)
    notif.BorderSizePixel = 0
    notif.RichText = true
    notif.Position = UDim2.new(0.322064161, 0, 0.833887041, 0)
    notif.Size = UDim2.new(0, 280, 0, 10)
    notif.Font = Enum.Font.RobotoMono
    notif.Text = "<font color=\"#800080\">" .. name .. "</font> " .. content
    notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif.TextSize = 16.000
    notif.TextStrokeTransparency = 0.000
    notif.TextYAlignment = Enum.TextYAlignment.Bottom
    
    wait(duration)
    notif:Destroy()
end

--[[
    example aimbot with easierlib
    RunService.RenderStepped:Connect(function()
        local Target = EasierLib.GetClosestPlayerOnScreen()
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
    end)
]]

return EasierLib

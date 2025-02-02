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

EasierLib.SendChatMessage = function(msg)
    return Chat:SendAsync(msg)
end

-- example usage: EasierLib.SendChatMessage("real")

EasierLib.ChangeValue = function(path, newval) -- kinda pointless, ran out of ideas :sob:
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

        warn("[easier-lib] webhook succesfully sent!")
    else
        warn("[easier-lib] the link and the webhook content must be a string.")
    end
end

-- dont spam SendWebhook, it may cause crashes.
-- example usage: EasierLib.SendWebhook("https://webhooklink.com", "webhook message")

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

-- example usage: EasierLib.Notification("script-name", "i like kissing boys :3", 5)

EasierLib.CrashGame = function() -- thought it was funny
    while true do print("crashed") end
end

EasierLib.TeleportToPlayer = function(player)
    LocalChar.HumanoidRootPart.CFrame = Players[player].Character.HumanoidRootPart.CFrame
end

-- example usage: EasierLib.TeleportToPlayer("PlayerName")

EasierLib.TeleportToCFrame = function(cframe)
    LocalChar.HumanoidRootPart.CFrame = cframe
end

-- example usage: EasierLib.TeleportToCFrame(CFrame.new(1, 1, 1))

EasierLib.TweenCFrame = function(instance, cframe, duration)	
	local tween = TweenService:Create(instance, TweenInfo.new(duration), {CFrame = cframe})
	tween:Play()
end

-- example usage: EasierLib.TweenCFrame(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, CFrame.new(1, 1, 1), 2)

EasierLib.TweenPos = function(instance, pos, duration)
    local tween = TweenService:Create(instance, TweenInfo.new(duration), {Position = pos})
    tween:Play()
end

EasierLib.SetWalkSpeed = function(speed)
    if LocalChar and LocalChar:FindFirstChild("Humanoid") then
        LocalChar.Humanoid.WalkSpeed = speed
    end
end

-- example usage: EasierLib.SetWalkSpeed(100)

EasierLib.SetJumpPower = function(power)
    if LocalChar and LocalChar:FindFirstChild("Humanoid") then
        LocalChar.Humanoid.JumpPower = power
    end
end

-- example usage: EasierLib.SetJumpPower(100)

EasierLib.TeleportToPart = function(part)
    if part and part:IsA("BasePart") then
        LocalChar.HumanoidRootPart.CFrame = part.CFrame
    else
        warn("[easier-lib] The provided object is not a valid part!")
    end
end

-- example usage: EasierLib.TeleportToPart(workspace.PartName)

EasierLib.CreateESPForPlayer = function(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local espBox = Instance.new("BoxHandleAdornment")
        espBox.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
        espBox.Size = player.Character:GetExtentsSize()
        espBox.Color3 = Color3.fromRGB(255, 0, 0)
        espBox.Transparency = 0.5
        espBox.AlwaysOnTop = true
        espBox.Parent = player.Character

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = ScreenGui
        nameLabel.Text = player.Name
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 14
        nameLabel.Position = UDim2.new(0, 0, 0, -30)
        nameLabel.TextStrokeTransparency = 0.8
        nameLabel.TextYAlignment = Enum.TextYAlignment.Top

        RunService.Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("Head") then
                local headPos = Camera:WorldToViewportPoint(player.Character.Head.Position)
                nameLabel.Position = UDim2.new(0, headPos.X - nameLabel.TextBounds.X / 2, 0, headPos.Y - nameLabel.TextBounds.Y - 10)
            else
                nameLabel:Destroy()
                espBox:Destroy()
            end
        end)
    end
end

-- example usage: EasierLib.CreateESPForPlayer(game.Players.PlayerName)

EasierLib.RemoveESPForPlayer = function(player)
    if player.Character then
        for index, value in next, player.Character:GetChildren() do
            if value:IsA("BoxHandleAdornment") then
                value:Destroy()
            end
        end
    end
end

-- example usage: EasierLib.RemoveESPForPlayer(game.Players.PlayerName)

return EasierLib

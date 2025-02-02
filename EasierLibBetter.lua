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

EasierLib.SpoofValue = function(path, newvalue) -- i hope this works, i dont have an executor that supports hookmetamethod atm :sob:
    local SpoofPath = path
    local old;
    old = hookmetamethod(game, "__index", function(self, val)
        if self == SpoofPath and val == "Value" then
            return newvalue
        end

        return old(self, val)
    end)
end

-- example usage:

EasierLib.SpoofWalkSpeed = function(spoofval) -- i hope this works, i dont have an executor that supports hookmetamethod atm :sob:
    local SpoofPath = LocalChar.Humanoid
    local old;
    old = hookmetamethod(game, "__index", function(self, val)
        if self == SpoofPath and val == "WalkSpeed" then
            return spoofval
        end

        return old(self, val)
    end)
end

-- example usage: EasierLib.SpoofWalkSpeed(16) 
-- this will make the game think that your walk speed is 16, usually used to bypass anti-cheats

EasierLib.HookRemoteArgument = function(path, argtoremote, newargvalue) -- i hope this works, i dont have an executor that supports hookmetamethod atm :sob:
    local RemotePath = path
    local old;
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if self == RemotePath and method == "FireServer" then
            args[argtoremote] = newargvalue
        end

        return old(self, unpack(args))
    end)
end

-- example usage: EasierLib.HookRemoteArg(game:GetService("ReplicatedStorage"), 1, "hooked")
-- english is not my mother language so idrk how to explain this but ill try :pray:
-- this will make it so that whenever a client-sided remote fires the remote will be fired witht the given arguments

return EasierLib

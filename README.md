# EasierLib
An open-sourced library focused on making scripting easier, especially for those who are new in exploiting.

This library is still in beta, I can't really add advanced stuff because I **don't** have a good executor at the moment.

# Documentation
It's actually really simple to use, almost everything takes a single line.

## Easier Lib Basic

Initialize Easier Lib
```
local Easier = loadstring(game:HttpGet("https://raw.githubusercontent.com/laeraz/EasierLib/refs/heads/main/EasierLibBasic.lua"))()
```

Sending Chat Messages
```lua
  EasierLib.SendChatMessage("Chat Message!")
```

Getting the closest player that is visible on the screen. (Not a wall check)
```lua
EasierLib.GetClosestPlayerOnScreen()
```

Sending webhooks 
```
EasierLib.SendWebhook("https://webhooklink.com", "webhook message")
```

Sending notifications (csgo style)
```
EasierLib.Notification("script-name", "notification content", 5)
```

Crashing the game (idk why i added this i thought it would be funny)
```
EasierLib.CrashGame()
```

Teleporting To a Specific Player
```
EasierLib.TeleportToPlayer("playername")
```

Teleporting to a Specific CFrame
```
EasierLib.TeleportToCFrame(CFrame.new(1, 1, 1))
```

Tweening an Instance
```
EasierLib.TweenCFrame(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, CFrame.new(1, 1, 1), 5)
```

## Easier Lib Advanced
Everything above can be also used in this version.
This version may have some bugs also it needs improvements and new features. Can't do it since I don't have a good executor at the moment.
This version is useable only on executors that has hookmetamethod and hookfunction.

Initializing the Advanced version
```
local Easier = loadstring(game:HttpGet("https://raw.githubusercontent.com/laeraz/EasierLib/refs/heads/main/EasierLibBetter.lua"))()
```

Spoofing a Value
```
EasierLib.SpoofValue(game:GetService("Players").LocalPlayer.Currency, math.huge)
```

Hooking a remote to change it's arguments
```
EasierLib.HookRemoteArg(game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Event1"), 1, "hooked")
```

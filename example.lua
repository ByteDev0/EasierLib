-- example simple aimbot made with EasierLib

local EasierLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/laeraz/EasierLib/refs/heads/main/EasierLibBasic.lua"))()
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

RunService.RenderStepped:Connect(function()
  local Target = EasierLib.GetClosestPlayerOnScreen()
  Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
end)

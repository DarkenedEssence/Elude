local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 200)
Frame.Position = UDim2.new(0.5, -200, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 0.6
UIStroke.Transparency = 0.6
UIStroke.Color = Color3.fromRGB(255, 255, 255)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "Interface Prompt"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

local Desc = Instance.new("TextLabel", Frame)
Desc.Size = UDim2.new(1, -20, 0, 80)
Desc.Position = UDim2.new(0, 10, 0, 50)
Desc.BackgroundTransparency = 1
Desc.TextWrapped = true
Desc.TextXAlignment = Enum.TextXAlignment.Left
Desc.TextYAlignment = Enum.TextYAlignment.Top
Desc.Text = "This script is down because of the UI Library changes.\nPlease wait.\n\nIf you want to be notified shortly, join our Discord below."
Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
Desc.Font = Enum.Font.Gotham
Desc.TextSize = 14

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0, 180, 0, 40)
Button.Position = UDim2.new(0.5, -90, 1, -60)
Button.BackgroundColor3 = Color3.fromRGB(85, 85, 255)
Button.Text = "Join Discord"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 16

local BtnCorner = Instance.new("UICorner", Button)
BtnCorner.CornerRadius = UDim.new(0, 8)

Button.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/uCxG4C5PSA")
    Button.Text = "Link Copied!"
    task.wait(1.5)
    Button.Text = "Join Discord"
end)

-- idk. Opened source cuz why not.
-- nvm jk




-- sped shit:
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.IgnoreGuiInset = true

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.new(0, 0, 0)
Background.BackgroundTransparency = 1
Background.Parent = ScreenGui

local Image = Instance.new("ImageLabel")
Image.AnchorPoint = Vector2.new(0.5, 0.5)
Image.Position = UDim2.new(0.5, 0, 0.5, 0)
Image.Size = UDim2.new(0.85, 0, 0.95, 0)
Image.BackgroundTransparency = 1
Image.ImageTransparency = 1
Image.Image = "rbxassetid://92984486581873"
Image.ZIndex = 0
Image.Parent = ScreenGui

local TextContainer = Instance.new("Frame")
TextContainer.AnchorPoint = Vector2.new(0.5, 0.5)
TextContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
TextContainer.BackgroundTransparency = 1
TextContainer.Size = UDim2.new(0, 500, 0, 150)
TextContainer.ZIndex = 2
TextContainer.Parent = ScreenGui

local Gradient = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 0, 120))
}

local letters = {"E", "L", "U", "D", "E"}
local letterLabels = {}

for i, char in ipairs(letters) do
	local lbl = Instance.new("TextLabel")
	lbl.AnchorPoint = Vector2.new(0.5, 0.5)
	lbl.Position = UDim2.new((i - 1) / (#letters - 1), 0, 0.5, 0)
	lbl.Size = UDim2.new(0, 100, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = char
	lbl.TextScaled = true
	lbl.Font = Enum.Font.GothamBlack
	lbl.TextColor3 = Color3.new(1, 1, 1)
	lbl.TextTransparency = 1
	lbl.ZIndex = 2
	lbl.Parent = TextContainer

	local grad = Instance.new("UIGradient", lbl)
	grad.Color = Gradient
	grad.Rotation = 90

	table.insert(letterLabels, lbl)
end

TweenService:Create(Background, TweenInfo.new(0.7), {BackgroundTransparency = 0.3}):Play()
task.wait(0.8)

for _, lbl in ipairs(letterLabels) do
	local tween = TweenService:Create(lbl, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextTransparency = 0})
	tween:Play()
	task.wait(0.6)
end

TweenService:Create(Image, TweenInfo.new(1), {ImageTransparency = 0}):Play()

task.wait(2)
TweenService:Create(Background, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
for _, lbl in ipairs(letterLabels) do
	TweenService:Create(lbl, TweenInfo.new(1), {TextTransparency = 1}):Play()
end
TweenService:Create(Image, TweenInfo.new(1), {ImageTransparency = 1}):Play()
task.wait(1.2)
ScreenGui:Destroy()
wait(1)
function notify(desc)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Interface Prompt",
        Text = desc,
        Icon = "rbxassetid://128667616483044",
        Duration = 5
    })
end
function sped()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Name = "ScriptWarningUI"
screenGui.Parent = playerGui

local container = Instance.new("Frame")
container.Size = UDim2.new(0, 500, 0, 250)
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.new(0.5, 0, 0.35, 0)
container.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
container.BorderSizePixel = 0
container.Parent = screenGui
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 14)
local stroke = Instance.new("UIStroke", container)
stroke.Transparency = 0.75
stroke.Thickness = 1

local title = Instance.new("TextLabel", container)
title.Size = UDim2.new(1, -32, 0, 48)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SCRIPT WARNING"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(240, 240, 240)

local dividerTop = Instance.new("Frame", container)
dividerTop.Size = UDim2.new(1, -32, 0, 1)
dividerTop.Position = UDim2.new(0, 16, 0, 44)
dividerTop.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
dividerTop.BorderSizePixel = 0

local body = Instance.new("TextLabel", container)
body.Size = UDim2.new(1, -32, 0, 70)
body.Position = UDim2.new(0, 16, 0, 54)
body.BackgroundTransparency = 1
body.TextWrapped = true
body.RichText = true
body.TextYAlignment = Enum.TextYAlignment.Top
body.Font = Enum.Font.Gotham
body.TextSize = 16
body.TextColor3 = Color3.fromRGB(220, 220, 220)
body.Text = "If the script doesn't load please use a <font color='rgb(255,60,60)'><b>VPN</b></font>, as Roblox is blocking WIND ui for non VPN users. Use any type of VPN!"

local note = Instance.new("TextLabel", container)
note.Size = UDim2.new(1, -32, 0, 44)
note.Position = UDim2.new(0, 16, 0, 126)
note.BackgroundTransparency = 1
note.TextWrapped = true
note.RichText = true
note.TextYAlignment = Enum.TextYAlignment.Top
note.Font = Enum.Font.Gotham
note.TextSize = 15
note.TextColor3 = Color3.fromRGB(255, 70, 70)
note.Text = "<b>Note:</b> The reason this doesn’t load is because of Roblox’s anti-cheat system blocking certain GUIs. To combat this, use a VPN."

local dividerBottom = Instance.new("Frame", container)
dividerBottom.Size = UDim2.new(1, -32, 0, 1)
dividerBottom.Position = UDim2.new(0, 16, 0, 180)
dividerBottom.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
dividerBottom.BorderSizePixel = 0

local joinBtn = Instance.new("TextButton", container)
joinBtn.Size = UDim2.new(0, 180, 0, 36)
joinBtn.Position = UDim2.new(0, 20, 0, 195)
joinBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 38)
joinBtn.BorderSizePixel = 0
joinBtn.Text = "Join Discord for help"
joinBtn.Font = Enum.Font.GothamBold
joinBtn.TextSize = 16
joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", joinBtn).CornerRadius = UDim.new(0, 8)
local joinStroke = Instance.new("UIStroke", joinBtn)
joinStroke.Transparency = 0.85
joinStroke.Thickness = 1

local closeBtn = Instance.new("TextButton", container)
closeBtn.Size = UDim2.new(0, 120, 0, 36)
closeBtn.Position = UDim2.new(1, -140, 0, 195)
closeBtn.AnchorPoint = Vector2.new(0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(56, 120, 230)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "Close"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
local closeStroke = Instance.new("UIStroke", closeBtn)
closeStroke.Transparency = 0.85
closeStroke.Thickness = 1

container.BackgroundTransparency = 1
container.Position = UDim2.new(0.5, 0, 0.35, -30)
local openTween = TweenService:Create(container, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(0.5, 0, 0.35, 0)})
openTween:Play()

local function close()
	local t = TweenService:Create(container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.35, -30)})
	t:Play()
	t.Completed:Wait()
	screenGui:Destroy()
end

closeBtn.MouseButton1Click:Connect(close)

joinBtn.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/uCxG4C5PSA")
	StarterGui:SetCore("SendNotification", {
		Title = "Discord Copied",
		Text = "Invite link copied to clipboard!",
		Icon = "rbxassetid://128667616483044",
		Duration = 4
	})
end)
end
notify("Executed successfully!")
function fuck()
if game.PlaceId == 79546208627805 then
notify("Do not execute in lobby!")
elseif game.PlaceId == 126509999114328 then
loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkenedEssence/Elude/refs/heads/main/Games/Tttghhhhhhh.lua"))()
else
notify("This game is unsupported")
end
end
fuck()

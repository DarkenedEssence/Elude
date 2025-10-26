-- opened source because some people dont check and are dumb enough
-- yes you can skid ts.
-- we do not care abt the key system

--bruhh

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local KEY_RAW_URL = "https://glot.io/snippets/hce7fcytlx/raw/main.lua"
local CONFIG_FILE = "keysystem_config.txt"
local DISCORD_LINK = "https://discord.gg/uCxG4C5PSA"

local function notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 5,
    })
end

local function saveKey(key)
    if writefile then
        writefile(CONFIG_FILE, key)
    end
end

local function loadKey()
    if isfile and isfile(CONFIG_FILE) then
        return readfile(CONFIG_FILE)
    end
    return nil
end

local function runScript()
    if game.PlaceId == 79546208627805 then
notify("no lobby bruh", "Do not execute in lobby!")
elseif game.PlaceId == 126509999114328 then
loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkenedEssence/Elude/refs/heads/main/Games/Tttghhhhhhh.lua"))()
else
notify("not supported", "This game is unsupported")
end
end

local s = Instance.new("ScreenGui")
s.Name = "KeySystemUI"
s.IgnoreGuiInset = true
s.ResetOnSpawn = false
s.Parent = gethui()

local f = Instance.new("Frame", s)
f.Size = UDim2.new(0, 380, 0, 280)
f.Position = UDim2.new(0.5, -190, 1, 250)
f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
f.BackgroundTransparency = 1
f.ClipsDescendants = true
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 50)
t.BackgroundTransparency = 1
t.Text = "🔑 Key Verification"
t.Font = Enum.Font.GothamBold
t.TextSize = 24
t.TextColor3 = Color3.fromRGB(54, 57, 63)

local b = Instance.new("TextBox", f)
b.Size = UDim2.new(0.88, 0, 0, 42)
b.Position = UDim2.new(0.06, 0, 0.35, 0)
b.PlaceholderText = "Enter your key..."
b.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
b.TextColor3 = Color3.fromRGB(0, 0, 0)
b.Font = Enum.Font.Gotham
b.TextSize = 18
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)

local sb = Instance.new("TextButton", f)
sb.Size = UDim2.new(0.88, 0, 0, 40)
sb.Position = UDim2.new(0.06, 0, 0.65, 0)
sb.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
sb.Text = "Submit Key"
sb.TextColor3 = Color3.fromRGB(255, 255, 255)
sb.Font = Enum.Font.GothamBold
sb.TextSize = 18
Instance.new("UICorner", sb).CornerRadius = UDim.new(0, 10)

local jd = Instance.new("TextButton", f)
jd.Size = UDim2.new(0.88, 0, 0, 40)
jd.Position = UDim2.new(0.06, 0, 0.82, 0)
jd.BackgroundColor3 = Color3.fromRGB(26, 115, 232)
jd.Text = "Join Discord for Key"
jd.TextColor3 = Color3.fromRGB(255, 255, 255)
jd.Font = Enum.Font.GothamBold
jd.TextSize = 18
Instance.new("UICorner", jd).CornerRadius = UDim.new(0, 10)

for i = 1, 10 do
    f.BackgroundTransparency = 1 - (i / 10)
    task.wait(0.03)
end
f.Position = UDim2.new(0.5, -190, 0.5, -140)

local savedKey = loadKey()
if savedKey then
    notify("✅ Key Loaded", "Running script automatically.")
    runScript()
    s:Destroy()
end

jd.MouseButton1Click:Connect(function()
    setclipboard(DISCORD_LINK)
    notify("📋 Copied", "Discord invite link copied to clipboard!")
end)

sb.MouseButton1Click:Connect(function()
    local enteredKey = b.Text
    if enteredKey == "" then
        notify("⚠️ Empty Key", "Please enter your key.")
        return
    end

    local success, rawData = pcall(function()
        return game:HttpGet(KEY_RAW_URL)
    end)

    if not success or not rawData then
        notify("🚫 Request Failed", "Could not fetch key data.")
        return
    end

    if string.find(rawData, enteredKey, 1, true) then
        notify("✅ Key Valid", "Loading script...")
        saveKey(enteredKey)
        runScript()
        for i = 1, 10 do
            f.BackgroundTransparency = i / 10
            task.wait(0.03)
        end
        f:TweenPosition(UDim2.new(0.5, -190, 1, 250), "In", "Quart", 0.6, true)
        task.delay(0.6, function() s:Destroy() end)
    else
        notify("❌ Invalid Key", "Please get a valid key from Discord.")
        if isfile and isfile(CONFIG_FILE) and writefile then
            delfile(CONFIG_FILE)
        end
    end
end)

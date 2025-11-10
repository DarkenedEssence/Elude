local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function Create(class, props)
    local obj = Instance.new(class)
    if props then
        for k, v in pairs(props) do
            if k ~= "Parent" then
                pcall(function() obj[k] = v end)
            end
        end
        if props.Parent then
            obj.Parent = props.Parent
        end
    end
    return obj
end

local function Round(n) return math.floor(n + 0.5) end

local Library = {}
Library.__index = Library

function CreateLibrary(settings)
    local self = setmetatable({}, Library)
    self.Settings = settings or {}
    self.ScreenGui = Create("ScreenGui", { Name = (settings and settings.Name) or "QuantumUI", ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ResetOnSpawn = false, Parent = game:GetService("CoreGui") })
    local Win = Create("Frame", { Parent = self.ScreenGui, Size = UDim2.new(0, 720, 0, 420), Position = UDim2.new(0.5, -360, 0.5, -210), BackgroundColor3 = Color3.fromRGB(18,18,28), BorderSizePixel = 0 })
    local UICorner = Create("UICorner", { Parent = Win, CornerRadius = UDim.new(0, 12) })
    local TopBar = Create("Frame", { Parent = Win, Size = UDim2.new(1,0,0,56), BackgroundColor3 = Color3.fromRGB(22,22,34), BorderSizePixel = 0, Position = UDim2.new(0,0,0,0) })
    Create("UICorner", { Parent = TopBar, CornerRadius = UDim.new(0,12) })
    local Title = Create("TextLabel", { Parent = TopBar, Size = UDim2.new(0.7,0,1,0), BackgroundTransparency = 1, Text = settings.Name or "Title", Font = Enum.Font.GothamBold, TextSize = 18, TextColor3 = Color3.fromRGB(245,245,245), TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.new(0,18,0,0) })
    local Subtitle = Create("TextLabel", { Parent = TopBar, Size = UDim2.new(0.3,-18,1,0), BackgroundTransparency = 1, Text = settings.Subtitle or "", Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Color3.fromRGB(170,170,190), TextXAlignment = Enum.TextXAlignment.Right, Position = UDim2.new(0.3,0,0,0) })
    local Body = Create("Frame", { Parent = Win, Size = UDim2.new(1,0,1,-56), Position = UDim2.new(0,0,0,56), BackgroundTransparency = 1 })
    local TabsHolder = Create("Frame", { Parent = Body, Size = UDim2.new(0,180,1,0), BackgroundColor3 = Color3.fromRGB(14,14,22), BorderSizePixel = 0 })
    Create("UICorner", { Parent = TabsHolder, CornerRadius = UDim.new(0,10) })
    local PagesHolder = Create("Frame", { Parent = Body, Size = UDim2.new(1,-200,1,0), Position = UDim2.new(0,200,0,0), BackgroundTransparency = 1 })
    local TabsUIList = Create("UIListLayout", { Parent = TabsHolder, Padding = UDim.new(0,8) })
    TabsUIList.SortOrder = Enum.SortOrder.LayoutOrder
    local Pages = {}
    local function createPage(name)
        local page = Create("Frame", { Parent = PagesHolder, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Visible = false })
        Pages[name] = page
        return page
    end

    self._tabs = {}
    self._sections = {}

    function self:CreateTab(opt)
        local tabName = opt.Name or "Tab"
        local icon = opt.Icon or ""
        local Button = Create("TextButton", { Parent = TabsHolder, Text = tabName, Size = UDim2.new(1,-24,0,44), BackgroundColor3 = Color3.fromRGB(18,18,26), BorderSizePixel = 0, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(220,220,255) })
        Create("UICorner", { Parent = Button, CornerRadius = UDim.new(0,8) })
        local Page = createPage(tabName)
        local TabObj = { Button = Button, Page = Page, Sections = {} }
        table.insert(self._tabs, TabObj)
        Button.MouseButton1Click:Connect(function()
            for _, t in pairs(self._tabs) do
                t.Page.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(18,18,26)
            end
            Page.Visible = true
            Button.BackgroundColor3 = Color3.fromRGB(40,28,70)
        end)
        if #self._tabs == 1 then
            Button:CaptureFocus()
            Button.BackgroundColor3 = Color3.fromRGB(40,28,70)
            Page.Visible = true
        end
        function TabObj:Section(sectionOpt)
            local secName = (sectionOpt and sectionOpt.Name) or "Section"
            local SectionFrame = Create("Frame", { Parent = Page, Size = UDim2.new(0.48,0,0,0), BackgroundTransparency = 1 })
            local Layout = Create("UIListLayout", { Parent = SectionFrame, Padding = UDim.new(0,8) })
            Layout.SortOrder = Enum.SortOrder.LayoutOrder
            table.insert(self.Sections, SectionFrame)
            local SectionObj = { Frame = SectionFrame, Elements = {} }
            return SectionObj
        end
        function TabObj:CreateSection(name)
            return TabObj:Section({ Name = name })
        end
        return TabObj
    end

    function Library:CreateTab(opt) return self:CreateTab(opt) end

    local function makeLabel(title, desc, parent)
        local holder = Create("Frame", { Parent = parent, Size = UDim2.new(1,0,0,56), BackgroundColor3 = Color3.fromRGB(18,18,26), BorderSizePixel = 0 })
        Create("UICorner", { Parent = holder, CornerRadius = UDim.new(0,8) })
        local ttl = Create("TextLabel", { Parent = holder, Text = title or "", Font = Enum.Font.GothamBold, TextSize = 14, BackgroundTransparency = 1, Position = UDim2.new(0,12,0,6), Size = UDim2.new(1,-24,0,20), TextColor3 = Color3.fromRGB(240,240,255), TextXAlignment = Enum.TextXAlignment.Left })
        local dsc = Create("TextLabel", { Parent = holder, Text = desc or "", Font = Enum.Font.Gotham, TextSize = 12, BackgroundTransparency = 1, Position = UDim2.new(0,12,0,28), Size = UDim2.new(1,-24,0,20), TextColor3 = Color3.fromRGB(160,160,180), TextXAlignment = Enum.TextXAlignment.Left })
        return { Holder = holder, SetTitle = function(v) ttl.Text = v end, SetDesc = function(v) dsc.Text = v end }
    end

    local function makeButton(name, callback, parent)
        local btn = Create("TextButton", { Parent = parent, Text = name or "Button", Size = UDim2.new(1,0,0,40), BackgroundColor3 = Color3.fromRGB(38,38,48), BorderSizePixel = 0, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(245,245,255) })
        Create("UICorner", { Parent = btn, CornerRadius = UDim.new(0,8) })
        btn.MouseButton1Click:Connect(function() pcall(callback) end)
        return btn
    end

    local function makeToggle(name, default, callback, parent)
        local holder = Create("Frame", { Parent = parent, Size = UDim2.new(1,0,0,40), BackgroundColor3 = Color3.fromRGB(18,18,26), BorderSizePixel = 0 })
        Create("UICorner", { Parent = holder, CornerRadius = UDim.new(0,8) })
        local label = Create("TextLabel", { Parent = holder, Text = name or "Toggle", Font = Enum.Font.Gotham, TextSize = 14, BackgroundTransparency = 1, Position = UDim2.new(0,12,0,0), Size = UDim2.new(0.8,0,1,0), TextColor3 = Color3.fromRGB(230,230,250), TextXAlignment = Enum.TextXAlignment.Left })
        local switch = Create("TextButton", { Parent = holder, Size = UDim2.new(0,36,0,20), Position = UDim2.new(1,-48,0,10), BackgroundColor3 = Color3.fromRGB(60,60,70), Text = "", AutoButtonColor = false })
        Create("UICorner", { Parent = switch, CornerRadius = UDim.new(0,10) })
        local knob = Create("Frame", { Parent = switch, Size = UDim2.new(0,16,0,16), Position = UDim2.new(0,2,0,2), BackgroundColor3 = Color3.fromRGB(230,230,255) })
        Create("UICorner", { Parent = knob, CornerRadius = UDim.new(1,0) })
        local state = default and true or false
        local function update(b)
            state = b
            if state then
                TweenService:Create(switch, TweenInfo.new(0.18), { BackgroundColor3 = Color3.fromRGB(90,50,200) }):Play()
                TweenService:Create(knob, TweenInfo.new(0.18), { Position = UDim2.new(1,-18,0,2) }):Play()
            else
                TweenService:Create(switch, TweenInfo.new(0.18), { BackgroundColor3 = Color3.fromRGB(60,60,70) }):Play()
                TweenService:Create(knob, TweenInfo.new(0.18), { Position = UDim2.new(0,2,0,2) }):Play()
            end
            pcall(callback, state)
        end
        switch.MouseButton1Click:Connect(function() update(not state) end)
        update(state)
        return { Holder = holder, Set = update, Get = function() return state end }
    end

    local function makeSlider(name, min, max, default, callback, parent)
        local holder = Create("Frame", { Parent = parent, Size = UDim2.new(1,0,0,52), BackgroundColor3 = Color3.fromRGB(18,18,26) })
        Create("UICorner", { Parent = holder, CornerRadius = UDim.new(0,8) })
        local label = Create("TextLabel", { Parent = holder, Text = name or "Slider", Font = Enum.Font.Gotham, TextSize = 14, BackgroundTransparency = 1, Position = UDim2.new(0,12,0,6), Size = UDim2.new(0.6,0,0,18), TextColor3 = Color3.fromRGB(235,235,255), TextXAlignment = Enum.TextXAlignment.Left })
        local valLabel = Create("TextLabel", { Parent = holder, Text = tostring(default or min), Font = Enum.Font.Gotham, TextSize = 12, BackgroundTransparency = 1, Position = UDim2.new(1,-76,0,8), Size = UDim2.new(0,64,0,16), TextColor3 = Color3.fromRGB(170,170,190), TextXAlignment = Enum.TextXAlignment.Right })
        local track = Create("Frame", { Parent = holder, BackgroundColor3 = Color3.fromRGB(38,38,48), Size = UDim2.new(1,-24,0,12), Position = UDim2.new(0,12,0,30), BorderSizePixel = 0 })
        Create("UICorner", { Parent = track, CornerRadius = UDim.new(0,6) })
        local fill = Create("Frame", { Parent = track, BackgroundColor3 = Color3.fromRGB(90,50,200), Size = UDim2.new(0,0,1,0), BorderSizePixel = 0 })
        Create("UICorner", { Parent = fill, CornerRadius = UDim.new(0,6) })
        local knob = Create("Frame", { Parent = track, Size = UDim2.new(0,16,0,16), Position = UDim2.new(0,0,-2,0), BackgroundColor3 = Color3.fromRGB(240,240,255) })
        Create("UICorner", { Parent = knob, CornerRadius = UDim.new(1,0) })
        local dragging = false
        local minv = min or 0
        local maxv = max or 100
        local value = default or minv
        local function setValue(v)
            v = math.clamp(math.floor((v or value) + 0.5), minv, maxv)
            value = v
            local ratio = (value - minv) / (maxv - minv)
            fill.Size = UDim2.new(ratio, 0, 1, 0)
            knob.Position = UDim2.new(ratio, -8, -0.166, 0)
            valLabel.Text = tostring(value)
            pcall(callback, value)
        end
        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                local absPos = track.AbsolutePosition.X
                local width = track.AbsoluteSize.X
                local x = math.clamp((UserInputService:GetMouseLocation().X - absPos) / width, 0, 1)
                setValue(minv + x * (maxv - minv))
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local absPos = track.AbsolutePosition.X
                local width = track.AbsoluteSize.X
                local x = math.clamp((UserInputService:GetMouseLocation().X - absPos) / width, 0, 1)
                setValue(minv + x * (maxv - minv))
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
        end)
        setValue(value)
        return { Holder = holder, Set = setValue, Get = function() return value end }
    end

    local function makeDropdown(name, options, default, callback, parent)
        local holder = Create("Frame", { Parent = parent, Size = UDim2.new(1,0,0,46), BackgroundColor3 = Color3.fromRGB(18,18,26) })
        Create("UICorner", { Parent = holder, CornerRadius = UDim.new(0,8) })
        local label = Create("TextLabel", { Parent = holder, Text = name or "Dropdown", Font = Enum.Font.Gotham, TextSize = 14, BackgroundTransparency = 1, Position = UDim2.new(0,12,0,6), Size = UDim2.new(0.6,0,0,18), TextColor3 = Color3.fromRGB(235,235,255), TextXAlignment = Enum.TextXAlignment.Left })
        local selected = Create("TextButton", { Parent = holder, Text = default or (options and options[1]) or "", Font = Enum.Font.Gotham, TextSize = 13, Position = UDim2.new(0,12,0,26), Size = UDim2.new(1,-24,0,16), BackgroundColor3 = Color3.fromRGB(32,32,40), BorderSizePixel = 0, AutoButtonColor = false })
        Create("UICorner", { Parent = selected, CornerRadius = UDim.new(0,6) })
        local list = Create("Frame", { Parent = holder, Size = UDim2.new(1,-24,0,0), Position = UDim2.new(0,12,0,46), BackgroundColor3 = Color3.fromRGB(24,24,30), BorderSizePixel = 0, ClipsDescendants = true })
        Create("UICorner", { Parent = list, CornerRadius = UDim.new(0,6) })
        local layout = Create("UIListLayout", { Parent = list, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0,4) })
        local open = false
        local current = default or (options and options[1]) or ""
        local entries = {}
        local function rebuild(opts)
            for _,v in pairs(entries) do if v and v:FindFirstAncestor(list) then v:Destroy() end end
            entries = {}
            for i,opt in ipairs(opts or {}) do
                local btn = Create("TextButton", { Parent = list, Text = opt, Font = Enum.Font.Gotham, TextSize = 13, Size = UDim2.new(1,0,0,28), BackgroundColor3 = Color3.fromRGB(28,28,36), BorderSizePixel = 0 })
                Create("UICorner", { Parent = btn, CornerRadius = UDim.new(0,6) })
                btn.MouseButton1Click:Connect(function()
                    current = opt
                    selected.Text = current
                    pcall(callback, current)
                    open = false
                    TweenService:Create(list, TweenInfo.new(0.18), { Size = UDim2.new(1,-24,0,0) }):Play()
                end)
                table.insert(entries, btn)
            end
            local total = #opts * 32
            if open then
                TweenService:Create(list, TweenInfo.new(0.18), { Size = UDim2.new(1,-24,0, math.clamp(total, 0, 180)) }):Play()
            end
        end
        selected.MouseButton1Click:Connect(function()
            open = not open
            if open then
                rebuild(options)
            end
            local total = #options * 32
            TweenService:Create(list, TweenInfo.new(0.18), { Size = UDim2.new(1,-24,0, open and math.clamp(total, 0, 180) or 0) }):Play()
        end)
        rebuild(options)
        selected.Text = current
        return { Holder = holder, Set = function(v) current = v; selected.Text = v; pcall(callback, v) end, RefreshValues = function(vals) options = vals; rebuild(vals) end, Get = function() return current end }
    end

    local function makeInput(name, default, callback, parent)
        local holder = Create("Frame", { Parent = parent, Size = UDim2.new(1,0,0,46), BackgroundColor3 = Color3.fromRGB(18,18,26) })
        Create("UICorner", { Parent = holder, CornerRadius = UDim.new(0,8) })
        local label = Create("TextLabel", { Parent = holder, Text = name or "Input", Font = Enum.Font.Gotham, TextSize = 14, BackgroundTransparency = 1, Position = UDim2.new(0,12,0,6), Size = UDim2.new(0.6,0,0,18), TextColor3 = Color3.fromRGB(235,235,255), TextXAlignment = Enum.TextXAlignment.Left })
        local box = Create("TextBox", { Parent = holder, Text = default or "", Font = Enum.Font.Gotham, TextSize = 13, Position = UDim2.new(0,12,0,26), Size = UDim2.new(1,-24,0,16), BackgroundColor3 = Color3.fromRGB(32,32,40), ClearTextOnFocus = false })
        Create("UICorner", { Parent = box, CornerRadius = UDim.new(0,6) })
        box.FocusLost:Connect(function(enter)
            pcall(callback, box.Text)
        end)
        return { Holder = holder, Set = function(v) box.Text = v end, Get = function() return box.Text end }
    end

    function Library:InitTabHelpers(tabObj)
        tabObj.Section = function(self, opts)
            local sec = Create("Frame", { Parent = tabObj.Page, Size = UDim2.new(0.48,0,0,0), BackgroundTransparency = 1 })
            local ui = Create("UIListLayout", { Parent = sec, Padding = UDim.new(0,8), SortOrder = Enum.SortOrder.LayoutOrder })
            sec.LayoutOrder = #tabObj.Page:GetChildren()
            local SectionAPI = {}
            function SectionAPI:CreateLabel(tbl)
                local l = makeLabel(tbl.Title or "", tbl.Desc or "", sec)
                table.insert(self.Elements, l)
                return l
            end
            function SectionAPI:CreateButton(tbl)
                local b = makeButton(tbl.Name or "Button", tbl.Callback or function() end, sec)
                table.insert(self.Elements, b)
                return b
            end
            function SectionAPI:CreateToggle(tbl)
                local t = makeToggle(tbl.Name or "Toggle", tbl.Default, tbl.Callback or function() end, sec)
                table.insert(self.Elements, t)
                return t
            end
            function SectionAPI:CreateSlider(tbl)
                local s = makeSlider(tbl.Name or "Slider", tbl.Min or 0, tbl.Max or 100, tbl.Default or tbl.Value or 0, tbl.Callback or function() end, sec)
                table.insert(self.Elements, s)
                return s
            end
            function SectionAPI:CreateDropdown(tbl)
                local d = makeDropdown(tbl.Name or "Dropdown", tbl.Value or {}, tbl.Default or (tbl.Value and tbl.Value[1]) or "", tbl.Callback or function() end, sec)
                table.insert(self.Elements, d)
                return d
            end
            function SectionAPI:CreateInput(tbl)
                local i = makeInput(tbl.Name or "Input", tbl.Default or "", tbl.Callback or function() end, sec)
                table.insert(self.Elements, i)
                return i
            end
            function SectionAPI:RefreshValues(name, vals)
                for _,v in pairs(sec:GetChildren()) do
                    if v:IsA("Frame") or v:IsA("TextButton") then end
                end
            end
            return SectionAPI
        end
    end

    for _, t in pairs(self._tabs) do
        self:InitTabHelpers(t)
    end

    local API = {}
    function API:CreateTab(tbl)
        local t = self:CreateTab(tbl)
        self:InitTabHelpers(t)
        return t
    end

    setmetatable(API, { __index = function(_, k) return Library[k] end })
    return API
end

return CreateLibrary

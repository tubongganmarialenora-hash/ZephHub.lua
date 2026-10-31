
--==================================================
-- ZEPH HUB V2
-- PART 1: CORE INTERFACE
-- COMPLETE UPDATED VERSION
-- CLIENT SIDE
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- SETTINGS
--==================================================

local Purple = Color3.fromRGB(145, 65, 255)
local White = Color3.fromRGB(245, 245, 255)
local Gray = Color3.fromRGB(170, 170, 185)

local HubSize = UDim2.new(0.792, 0, 0, 297)

local Tabs = {
    "Local Player",
    "Movement",
    "Camera",
    "Graphics",
    "World",
    "Visuals",
    "Performance",
    "Utilities",
    "ESP & Highlights",
    "Teleports",
    "Animations",
    "Interface",
    "Environment",
    "Information",
    "Customization"
}

--==================================================
-- GUI SETUP
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZephHubV2"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = PlayerGui

local function Create(class, properties, parent)
    local object = Instance.new(class)

    for property, value in pairs(properties) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function Corner(parent, radius)
    Create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, parent)
end

local function Stroke(parent, color, thickness, transparency)
    return Create("UIStroke", {
        Color = color,
        Thickness = thickness,
        Transparency = transparency or 0
    }, parent)
end

local function Tween(object, duration, properties)
    local animation = TweenService:Create(
        object,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        properties
    )

    animation:Play()
    return animation
end

--==================================================
-- LOADING SCREEN
--==================================================

local Loading = Create("Frame", {
    Name = "LoadingScreen",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(5, 4, 10),
    BorderSizePixel = 0
}, ScreenGui)

local LoadingTitle = Create("TextLabel", {
    Size = UDim2.fromOffset(300, 65),
    Position = UDim2.new(0.5, -150, 0.42, -32),
    BackgroundTransparency = 1,
    Text = "ZEPH HUB",
    TextColor3 = White,
    TextSize = 35,
    Font = Enum.Font.GothamBlack
}, Loading)

local LoadingSubtitle = Create("TextLabel", {
    Size = UDim2.fromOffset(300, 25),
    Position = UDim2.new(0.5, -150, 0.42, 30),
    BackgroundTransparency = 1,
    Text = "VERSION 2.0",
    TextColor3 = Purple,
    TextSize = 12,
    Font = Enum.Font.GothamBold
}, Loading)

local BarBackground = Create("Frame", {
    Size = UDim2.fromOffset(260, 7),
    Position = UDim2.new(0.5, -130, 0.56, 0),
    BackgroundColor3 = Color3.fromRGB(35, 25, 45),
    BorderSizePixel = 0
}, Loading)

Corner(BarBackground, 10)

local Bar = Create("Frame", {
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = Purple,
    BorderSizePixel = 0
}, BarBackground)

Corner(Bar, 10)

local Percentage = Create("TextLabel", {
    Size = UDim2.fromOffset(200, 25),
    Position = UDim2.new(0.5, -100, 0.59, 0),
    BackgroundTransparency = 1,
    Text = "Loading... 0%",
    TextColor3 = Gray,
    TextSize = 12,
    Font = Enum.Font.Gotham
}, Loading)

--==================================================
-- MAIN HUB
--==================================================

local Main = Create("Frame", {
    Name = "MainHub",
    Size = HubSize,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(15, 12, 22),
    BackgroundTransparency = 0.10,
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 2
}, ScreenGui)

Corner(Main, 15)

Stroke(Main, Purple, 2, 0.1)

-- Glow frame

local Glow = Create("Frame", {
    Name = "Glow",
    Size = UDim2.new(1, 12, 1, 12),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    ZIndex = 1
}, Main)

Corner(Glow, 18)
Stroke(Glow, Purple, 5, 0.65)

--==================================================
-- TOP BAR
--==================================================

local TopBar = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 39),
    BackgroundColor3 = Color3.fromRGB(30, 20, 42),
    BackgroundTransparency = 0.10,
    BorderSizePixel = 0,
    ZIndex = 3
}, Main)

Corner(TopBar, 15)

local Title = Create("TextLabel", {
    Size = UDim2.new(0, 220, 1, 0),
    Position = UDim2.fromOffset(12, 0),
    BackgroundTransparency = 1,
    Text = "⚡ ZEPH HUB V2",
    TextColor3 = White,
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, TopBar)

local Minimize = Create("TextButton", {
    Size = UDim2.fromOffset(32, 27),
    Position = UDim2.new(1, -39, 0, 6),
    BackgroundColor3 = Purple,
    Text = "—",
    TextColor3 = White,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    ZIndex = 4
}, TopBar)

Corner(Minimize, 8)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Create("ScrollingFrame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 125, 1, -51),
    Position = UDim2.fromOffset(7, 44),
    BackgroundColor3 = Color3.fromRGB(20, 15, 30),
    BackgroundTransparency = 0.10,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Purple,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ZIndex = 3
}, Main)

Corner(Sidebar, 9)

Create("UIListLayout", {
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Sidebar)

Create("UIPadding", {
    PaddingTop = UDim.new(0, 6),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5)
}, Sidebar)

--==================================================
-- CONTENT PANEL
--==================================================

local Content = Create("Frame", {
    Name = "Content",
    Size = UDim2.new(1, -139, 1, -51),
    Position = UDim2.fromOffset(132, 44),
    BackgroundColor3 = Color3.fromRGB(20, 15, 30),
    BackgroundTransparency = 0.10,
    BorderSizePixel = 0,
    ZIndex = 3
}, Main)

Corner(Content, 10)

local TabTitle = Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 30),
    Position = UDim2.fromOffset(10, 5),
    BackgroundTransparency = 1,
    Text = "LOCAL PLAYER",
    TextColor3 = Purple,
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, Content)

local Description = Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 24),
    Position = UDim2.fromOffset(10, 34),
    BackgroundTransparency = 1,
    Text = "Choose a tab to view its features.",
    TextColor3 = Gray,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4
}, Content)

local FeaturePlaceholder = Create("TextLabel", {
    Size = UDim2.new(1, -20, 0, 70),
    Position = UDim2.fromOffset(10, 85),
    BackgroundTransparency = 1,
    Text = "FEATURES WILL APPEAR HERE",
    TextColor3 = Color3.fromRGB(110, 90, 130),
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    ZIndex = 4
}, Content)

--==================================================
-- TAB SYSTEM
--==================================================

local SelectedTab = "Local Player"
local TabButtons = {}

local function SelectTab(tabName)
    SelectedTab = tabName

    TabTitle.Text = string.upper(tabName)
    Description.Text = "Features for " .. tabName
    FeaturePlaceholder.Text = "WAITING FOR FEATURE MODULE"

    for name, button in pairs(TabButtons) do
        if name == tabName then
            Tween(button, 0.15, {
                BackgroundColor3 = Purple,
                BackgroundTransparency = 0
            })

            button.TextColor3 = White
        else
            Tween(button, 0.15, {
                BackgroundColor3 = Color3.fromRGB(35, 25, 45),
                BackgroundTransparency = 0.10
            })

            button.TextColor3 = Gray
        end
    end
end

for index, tabName in ipairs(Tabs) do
    local Button = Create("TextButton", {
        Name = tabName:gsub("[^%w]", ""),
        Size = UDim2.new(1, -4, 0, 28),
        BackgroundColor3 = Color3.fromRGB(35, 25, 45),
        BackgroundTransparency = 0.10,
        BorderSizePixel = 0,
        Text = tabName,
        TextColor3 = Gray,
        TextSize = 9,
        Font = Enum.Font.GothamSemibold,
        LayoutOrder = index,
        AutoButtonColor = false,
        ZIndex = 4
    }, Sidebar)

    Corner(Button, 6)

    TabButtons[tabName] = Button

    Button.Activated:Connect(function()
        SelectTab(tabName)
    end)
end

SelectTab("Local Player")

--==================================================
-- DRAGGING SYSTEM
--==================================================

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

--==================================================
-- RESTORE BUTTON
--==================================================

local Restore = Create("TextButton", {
    Name = "RestoreButton",
    Size = UDim2.fromOffset(45, 45),
    Position = UDim2.new(0, 18, 0.7, 0),
    BackgroundColor3 = Color3.fromRGB(25, 15, 40),
    BackgroundTransparency = 0.10,
    BorderSizePixel = 0,
    Text = "Z",
    TextColor3 = White,
    TextSize = 22,
    Font = Enum.Font.GothamBlack,
    Visible = false,
    AutoButtonColor = false,
    ZIndex = 10
}, ScreenGui)

Corner(Restore, 13)
Stroke(Restore, Purple, 2, 0.05)

--==================================================
-- MINIMIZE AND RESTORE LOGIC
--==================================================

local minimized = false
local animating = false

Minimize.Activated:Connect(function()
    if minimized or animating then
        return
    end

    animating = true
    minimized = true

    local animation = Tween(Main, 0.22, {
        Size = UDim2.new(0.792, 0, 0, 0)
    })

    animation.Completed:Wait()

    Main.Visible = false
    Main.Size = HubSize

    Restore.Visible = true
    Restore.BackgroundTransparency = 1
    Restore.TextTransparency = 1

    Tween(Restore, 0.2, {
        BackgroundTransparency = 0.10,
        TextTransparency = 0
    })

    animating = false
end)

Restore.Activated:Connect(function()
    if not minimized or animating then
        return
    end

    animating = true
    minimized = false

    Tween(Restore, 0.15, {
        BackgroundTransparency = 1,
        TextTransparency = 1
    })

    task.wait(0.15)

    Restore.Visible = false
    Main.Visible = true
    Main.Size = UDim2.new(0.792, 0, 0, 0)

    local animation = Tween(Main, 0.3, {
        Size = HubSize
    })

    animation.Completed:Wait()

    animating = false
end)

--==================================================
-- LOADING ANIMATION
--==================================================

for i = 0, 100 do
    Bar.Size = UDim2.new(i / 100, 0, 1, 0)
    Percentage.Text = "Loading... " .. i .. "%"

    task.wait(0.018)
end

Tween(Loading, 0.35, {
    BackgroundTransparency = 1
})

Tween(LoadingTitle, 0.25, {
    TextTransparency = 1
})

Tween(LoadingSubtitle, 0.25, {
    TextTransparency = 1
})

Tween(BarBackground, 0.25, {
    BackgroundTransparency = 1
})

Tween(Bar, 0.25, {
    BackgroundTransparency = 1
})

Tween(Percentage, 0.25, {
    TextTransparency = 1
})

task.wait(0.4)

Loading:Destroy()

Main.Visible = true
Main.Size = UDim2.new(0.792, 0, 0, 0)

Tween(Main, 0.4, {
    Size = HubSize
})

print("================================")
print("ZEPH HUB V2")
print("PART 1 SUCCESSFULLY LOADED")
print("15 TABS INITIALIZED")
print("READY FOR PART 2 AND PART 3")
print("================================")


--==================================================
-- ZEPH HUB V2
-- PART 2: 104-FEATURE ENGINE
-- CLIENT-SIDE LOCAL SCRIPT
-- Requires Part 1
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Hub = PlayerGui:WaitForChild("ZephHubV2")
local Main = Hub:WaitForChild("MainHub")
local Content = Main:WaitForChild("Content")
local TabTitle = Content:WaitForChild("TabTitle")
local Description = Content:WaitForChild("Description")
local Placeholder = Content:WaitForChild("TextLabel")

local Purple = Color3.fromRGB(145, 65, 255)
local White = Color3.fromRGB(245, 245, 255)
local Gray = Color3.fromRGB(170, 170, 185)

--==================================================
-- CHARACTER REFERENCES
--==================================================

local function Character()
    return Player.Character
end

local function Humanoid()
    local char = Character()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function Root()
    local char = Character()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function Camera()
    return Workspace.CurrentCamera
end

--==================================================
-- ORIGINAL SETTINGS
--==================================================

local Original = {
    WalkSpeed = 16,
    JumpPower = 50,
    Gravity = Workspace.Gravity,
    FOV = 70,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    Shadows = Lighting.GlobalShadows,
    MinZoom = Player.CameraMinZoomDistance,
    MaxZoom = Player.CameraMaxZoomDistance
}

local h = Humanoid()

if h then
    Original.WalkSpeed = h.WalkSpeed
    Original.JumpPower = h.JumpPower
end

if Camera() then
    Original.FOV = Camera().FieldOfView
end

--==================================================
-- FEATURE UI
--==================================================

Placeholder.Visible = false

local OldList = Content:FindFirstChild("FeatureList")
if OldList then
    OldList:Destroy()
end

local FeatureList = Instance.new("ScrollingFrame")
FeatureList.Name = "FeatureList"
FeatureList.Size = UDim2.new(1, -16, 1, -74)
FeatureList.Position = UDim2.fromOffset(8, 68)
FeatureList.BackgroundTransparency = 1
FeatureList.BorderSizePixel = 0
FeatureList.ScrollBarThickness = 3
FeatureList.ScrollBarImageColor3 = Purple
FeatureList.AutomaticCanvasSize = Enum.AutomaticSize.Y
FeatureList.CanvasSize = UDim2.new(0, 0, 0, 0)
FeatureList.Parent = Content

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 6)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = FeatureList

local Padding = Instance.new("UIPadding")
Padding.PaddingBottom = UDim.new(0, 8)
Padding.Parent = FeatureList

--==================================================
-- MONITOR DISPLAY
--==================================================

local Monitor = Instance.new("TextLabel")
Monitor.Name = "ZephMonitor"
Monitor.Size = UDim2.new(0, 150, 0, 35)
Monitor.Position = UDim2.new(1, -155, 0, 3)
Monitor.BackgroundTransparency = 1
Monitor.TextColor3 = Purple
Monitor.TextSize = 10
Monitor.Font = Enum.Font.GothamBold
Monitor.TextXAlignment = Enum.TextXAlignment.Right
Monitor.Text = ""
Monitor.Parent = Content

local MonitorModes = {}

local function GetPing()
    local success, result = pcall(function()
        return Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
    end)

    if success then
        return result
    end

    return "Unavailable"
end

local fps = 0
local frames = 0
local elapsed = 0

RunService.RenderStepped:Connect(function(dt)
    frames += 1
    elapsed += dt

    if elapsed >= 1 then
        fps = frames
        frames = 0
        elapsed = 0

        local values = {}

        if MonitorModes.FPS then
            table.insert(values, "FPS: " .. fps)
        end

        if MonitorModes.Ping then
            table.insert(values, "PING: " .. GetPing())
        end

        if MonitorModes.Memory then
            local success, memory = pcall(function()
                return Stats:GetTotalMemoryUsageMb()
            end)

            if success then
                table.insert(values, "MEM: " .. math.floor(memory) .. " MB")
            end
        end

        if MonitorModes.Coordinates or MonitorModes.Position then
            local root = Root()

            if root then
                local p = root.Position
                table.insert(values,
                    string.format("XYZ: %d, %d, %d",
                    p.X, p.Y, p.Z)
                )
            end
        end

        if MonitorModes.Health then
            local humanoid = Humanoid()

            if humanoid then
                table.insert(values,
                    "HP: " .. math.floor(humanoid.Health)
                )
            end
        end

        if MonitorModes.Speed then
            local humanoid = Humanoid()

            if humanoid then
                table.insert(values,
                    "SPEED: " .. math.floor(humanoid.WalkSpeed)
                )
            end
        end

        if MonitorModes.Username then
            table.insert(values, Player.Name)
        end

        if MonitorModes.DisplayName then
            table.insert(values, Player.DisplayName)
        end

        if MonitorModes.UserId then
            table.insert(values, "ID: " .. Player.UserId)
        end

        if MonitorModes.AccountAge then
            table.insert(values, "AGE: " .. Player.AccountAge .. " days")
        end

        if MonitorModes.PlaceId then
            table.insert(values, "PLACE: " .. game.PlaceId)
        end

        if MonitorModes.PlayerCount then
            table.insert(values,
                "PLAYERS: " .. #Players:GetPlayers()
            )
        end

        if MonitorModes.Clock then
            table.insert(values,
                "TIME: " .. os.date("%H:%M:%S")
            )
        end

        Monitor.Text = table.concat(values, "  |  ")
    end
end)

--==================================================
-- EFFECTS
--==================================================

local function GetEffect(className, name)
    local effect = Lighting:FindFirstChild(name)

    if not effect then
        effect = Instance.new(className)
        effect.Name = name
        effect.Parent = Lighting
    end

    return effect
end

local Blur = GetEffect("BlurEffect", "ZephBlur")
local Bloom = GetEffect("BloomEffect", "ZephBloom")
local SunRays = GetEffect("SunRaysEffect", "ZephSunRays")
local ColorCorrection = GetEffect(
    "ColorCorrectionEffect",
    "ZephColorCorrection"
)

local Atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")

if not Atmosphere then
    Atmosphere = Instance.new("Atmosphere")
    Atmosphere.Name = "ZephAtmosphere"
    Atmosphere.Parent = Lighting
end

--==================================================
-- VISUAL HELPERS
--==================================================

local SavedTransparency = {}

local function SetPartsVisible(container, visible)
    if not container then return end

    for _, object in ipairs(container:GetDescendants()) do
        if object:IsA("BasePart") then
            if SavedTransparency[object] == nil then
                SavedTransparency[object] =
                    object.LocalTransparencyModifier
            end

            object.LocalTransparencyModifier =
                visible and SavedTransparency[object] or 1
        end
    end
end

local function SetClassEnabled(className, enabled)
    for _, object in ipairs(Workspace:GetDescendants()) do
        if object.ClassName == className then
            if object:IsA("ParticleEmitter")
                or object:IsA("Trail")
                or object:IsA("Beam")
                or object:IsA("Fire")
                or object:IsA("Smoke")
                or object:IsA("Decal")
                or object:IsA("Texture") then

                if object:GetAttribute("ZephOriginalEnabled") == nil then
                    object:SetAttribute(
                        "ZephOriginalEnabled",
                        object.Enabled
                    )
                end

                object.Enabled = enabled and
                    object:GetAttribute("ZephOriginalEnabled") or false
            end
        end
    end
end

local SelfHighlight

local function HighlightSelf(enabled)
    if enabled then
        if SelfHighlight then return end

        local char = Character()
        if not char then return end

        SelfHighlight = Instance.new("Highlight")
        SelfHighlight.Name = "ZephSelfHighlight"
        SelfHighlight.FillColor = Purple
        SelfHighlight.OutlineColor = White
        SelfHighlight.FillTransparency = 0.65
        SelfHighlight.Parent = char
    else
        if SelfHighlight then
            SelfHighlight:Destroy()
            SelfHighlight = nil
        end
    end
end

local LocalLight

local function LocalGlow(enabled)
    local root = Root()
    if not root then return end

    if enabled then
        if not LocalLight then
            LocalLight = Instance.new("PointLight")
            LocalLight.Name = "ZephLocalGlow"
            LocalLight.Color = Purple
            LocalLight.Range = 15
            LocalLight.Brightness = 2
            LocalLight.Parent = root
        end
    elseif LocalLight then
        LocalLight:Destroy()
        LocalLight = nil
    end
end

--==================================================
-- TOGGLE ACTIONS
--==================================================

local ToggleActions = {}

ToggleActions.HideAccessories = function(v)
    local char = Character()
    if not char then return end

    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Accessory") then
            for _, part in ipairs(item:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = v and 1 or 0
                end
            end
        end
    end
end

ToggleActions.SelfHighlight = HighlightSelf

ToggleActions.HealthMonitor = function(v)
    MonitorModes.Health = v
end

ToggleActions.Coordinates = function(v)
    MonitorModes.Coordinates = v
end

ToggleActions.HideCharacter = function(v)
    SetPartsVisible(Character(), not v)
end

ToggleActions.HideName = function(v)
    local humanoid = Humanoid()
    if humanoid then
        humanoid.DisplayDistanceType = v
            and Enum.HumanoidDisplayDistanceType.None
            or Enum.HumanoidDisplayDistanceType.Viewer
    end
end

ToggleActions.AutoRotate = function(v)
    local humanoid = Humanoid()
    if humanoid then
        humanoid.AutoRotate = v
    end
end

ToggleActions.HideTools = function(v)
    local char = Character()
    if not char then return end

    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Tool") then
            for _, part in ipairs(item:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = v and 1 or 0
                end
            end
        end
    end
end

ToggleActions.LocalGlow = LocalGlow

ToggleActions.Position = function(v)
    MonitorModes.Position = v
end

ToggleActions.Sprint = function(v)
    local humanoid = Humanoid()
    if humanoid then
        humanoid.WalkSpeed = v and 28 or Original.WalkSpeed
    end
end

ToggleActions.LowGravity = function(v)
    Workspace.Gravity = v and 100 or Original.Gravity
end

ToggleActions.HighJump = function(v)
    local humanoid = Humanoid()
    if humanoid then
        humanoid.JumpPower = v and 100 or Original.JumpPower
    end
end

ToggleActions.FirstPerson = function(v)
    Player.CameraMode = v
        and Enum.CameraMode.LockFirstPerson
        or Enum.CameraMode.Classic
end

ToggleActions.CameraShake = function(v)
    local camera = Camera()
    if camera then
        camera.FieldOfView = v and 80 or Original.FOV
    end
end

ToggleActions.Shadows = function(v)
    Lighting.GlobalShadows = v
end

ToggleActions.Blur = function(v)
    Blur.Enabled = v
    Blur.Size = 12
end

ToggleActions.Bloom = function(v)
    Bloom.Enabled = v
    Bloom.Intensity = 1
end

ToggleActions.SunRays = function(v)
    SunRays.Enabled = v
end

ToggleActions.Fog = function(v)
    Lighting.FogEnd = v and 150 or 100000
end

ToggleActions.Atmosphere = function(v)
    Atmosphere.Enabled = v
end

ToggleActions.HideParticles = function(v)
    SetClassEnabled("ParticleEmitter", not v)
end

ToggleActions.HideTrails = function(v)
    SetClassEnabled("Trail", not v)
end

ToggleActions.HideBeams = function(v)
    SetClassEnabled("Beam", not v)
end

ToggleActions.HideDecals = function(v)
    SetClassEnabled("Decal", not v)
end

ToggleActions.HideTextures = function(v)
    SetClassEnabled("Texture", not v)
end

ToggleActions.ShowHealthBar = function(v)
    MonitorModes.Health = v
end

ToggleActions.ShowPlayerNames = function(v)
    MonitorModes.DisplayName = v
end

ToggleActions.HideSmoke = function(v)
    SetClassEnabled("Smoke", not v)
end

ToggleActions.HideFire = function(v)
    SetClassEnabled("Fire", not v)
end

ToggleActions.PostEffects = function(v)
    for _, effect in ipairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = not v
        end
    end
end

ToggleActions.ReduceShadows = function(v)
    Lighting.GlobalShadows = not v
end

ToggleActions.FPS = function(v)
    MonitorModes.FPS = v
end

ToggleActions.Ping = function(v)
    MonitorModes.Ping = v
end

ToggleActions.Memory = function(v)
    MonitorModes.Memory = v
end

ToggleActions.PlayerCount = function(v)
    MonitorModes.PlayerCount = v
end

--==================================================
-- SLIDER ACTIONS
--==================================================

local SliderActions = {}

SliderActions.WalkSpeed = function(v)
    local humanoid = Humanoid()
    if humanoid then
        humanoid.WalkSpeed = v
    end
end

SliderActions.JumpPower = function(v)
    local humanoid = Humanoid()
    if humanoid then
        humanoid.JumpPower = v
    end
end

SliderActions.HipHeight = function(v)
    local humanoid = Humanoid()
    if humanoid then
        humanoid.HipHeight = v
    end
end

SliderActions.Gravity = function(v)
    Workspace.Gravity = v
end

SliderActions.FOV = function(v)
    local camera = Camera()
    if camera then
        camera.FieldOfView = v
    end
end

SliderActions.MinZoom = function(v)
    Player.CameraMinZoomDistance = v
end

SliderActions.MaxZoom = function(v)
    Player.CameraMaxZoomDistance = math.max(
        v,
        Player.CameraMinZoomDistance
    )
end

SliderActions.OffsetX = function(v)
    local humanoid = Humanoid()
    if humanoid then
        local offset = humanoid.CameraOffset
        humanoid.CameraOffset = Vector3.new(v, offset.Y, offset.Z)
    end
end

SliderActions.OffsetY = function(v)
    local humanoid = Humanoid()
    if humanoid then
        local offset = humanoid.CameraOffset
        humanoid.CameraOffset = Vector3.new(offset.X, v, offset.Z)
    end
end

SliderActions.Brightness = function(v)
    Lighting.Brightness = v
end

SliderActions.ClockTime = function(v)
    Lighting.ClockTime = v
end

SliderActions.Saturation = function(v)
    ColorCorrection.Saturation = v
end

SliderActions.Contrast = function(v)
    ColorCorrection.Contrast = v
end

SliderActions.Exposure = function(v)
    Lighting.ExposureCompensation = v
end

SliderActions.Density = function(v)
    Atmosphere.Density = v
end

SliderActions.FogDistance = function(v)
    Lighting.FogEnd = v
end

SliderActions.FogStart = function(v)
    Lighting.FogStart = v
end

SliderActions.Haze = function(v)
    Atmosphere.Haze = v
end

SliderActions.Glare = function(v)
    Atmosphere.Glare = v
end

SliderActions.Ambient = function(v)
    Lighting.EnvironmentDiffuseScale = v
end

--==================================================
-- BUTTON ACTIONS
--==================================================

local ButtonActions = {}

ButtonActions.Sit = function()
    local humanoid = Humanoid()
    if humanoid then
        humanoid.Sit = true
    end
end

ButtonActions.Jump = function()
    local humanoid = Humanoid()
    if humanoid then
        humanoid.Jump = true
    end
end

ButtonActions.ResetCharacter = function()
    local humanoid = Humanoid()
    if humanoid then
        humanoid.Health = 0
    end
end

ButtonActions.Dash = function()
    local root = Root()
    local humanoid = Humanoid()

    if root and humanoid then
        local direction = humanoid.MoveDirection

        if direction.Magnitude > 0 then
            root.AssemblyLinearVelocity =
                direction.Unit * 65 +
                Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
        end
    end
end

ButtonActions.ResetSpeed = function()
    local humanoid = Humanoid()
    if humanoid then
        humanoid.WalkSpeed = Original.WalkSpeed
    end
end

ButtonActions.ResetJump = function()
    local humanoid = Humanoid()
    if humanoid then
        humanoid.JumpPower = Original.JumpPower
    end
end

ButtonActions.ResetMovement = function()
    local humanoid = Humanoid()
    if humanoid then
        humanoid.WalkSpeed = Original.WalkSpeed
        humanoid.JumpPower = Original.JumpPower
        humanoid.HipHeight = 0
    end

    Workspace.Gravity = Original.Gravity
end

ButtonActions.ResetCamera = function()
    local camera = Camera()
    if camera then
        camera.FieldOfView = Original.FOV
        camera.CameraType = Enum.CameraType.Custom
    end

    local humanoid = Humanoid()
    if humanoid then
        humanoid.CameraOffset = Vector3.zero
    end
end

ButtonActions.ZoomIn = function()
    Player.CameraMaxZoomDistance = 5
end

ButtonActions.ZoomOut = function()
    Player.CameraMaxZoomDistance = 30
end

ButtonActions.ClassicCamera = function()
    Player.CameraMode = Enum.CameraMode.Classic
end

ButtonActions.FollowCamera = function()
    local camera = Camera()
    local humanoid = Humanoid()

    if camera and humanoid then
        camera.CameraType = Enum.CameraType.Custom
        camera.CameraSubject = humanoid
    end
end

ButtonActions.ResetFOV = function()
    local camera = Camera()
    if camera then
        camera.FieldOfView = Original.FOV
    end
end

ButtonActions.Day = function()
    Lighting.ClockTime = 14
end

ButtonActions.Night = function()
    Lighting.ClockTime = 0
end

ButtonActions.Sunrise = function()
    Lighting.ClockTime = 6
end

ButtonActions.Sunset = function()
    Lighting.ClockTime = 18
end

ButtonActions.DayAmbient = function()
    Lighting.Ambient = Color3.fromRGB(150, 150, 150)
    Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
end

ButtonActions.NightAmbient = function()
    Lighting.Ambient = Color3.fromRGB(35, 35, 65)
    Lighting.OutdoorAmbient = Color3.fromRGB(25, 25, 45)
end

ButtonActions.ResetGraphics = function()
    Lighting.Brightness = Original.Brightness
    Lighting.ClockTime = Original.ClockTime
    Lighting.GlobalShadows = Original.Shadows
    Lighting.FogStart = Original.FogStart
    Lighting.FogEnd = Original.FogEnd
    Blur.Enabled = false
    Bloom.Enabled = false
    SunRays.Enabled = false
    ColorCorrection.Enabled = false
    Atmosphere.Density = 0.3
end

ButtonActions.ResetVisuals = function()
    SetPartsVisible(Character(), true)
    HighlightSelf(false)
    LocalGlow(false)

    SetClassEnabled("ParticleEmitter", true)
    SetClassEnabled("Trail", true)
    SetClassEnabled("Beam", true)
    SetClassEnabled("Decal", true)
    SetClassEnabled("Texture", true)
    SetClassEnabled("Smoke", true)
    SetClassEnabled("Fire", true)
end

ButtonActions.TeleportSpawn = function()
    local root = Root()
    if not root then return end

    local spawn = Workspace:FindFirstChildWhichIsA("SpawnLocation", true)

    if spawn then
        root.CFrame = spawn.CFrame + Vector3.new(0, 4, 0)
    end
end

ButtonActions.ResetZoom = function()
    Player.CameraMinZoomDistance = Original.MinZoom
    Player.CameraMaxZoomDistance = Original.MaxZoom
end

ButtonActions.ShowClock = function()
    MonitorModes.Clock = not MonitorModes.Clock
end

ButtonActions.ResetGravity = function()
    Workspace.Gravity = Original.Gravity
end

ButtonActions.ResetName = function()
    MonitorModes.Username = false
    MonitorModes.DisplayName = false
    MonitorModes.UserId = false
end

--==================================================
-- FEATURE DEFINITIONS
--==================================================

local function T(name, description, action)
    return {
        name = name,
        description = description,
        kind = "toggle",
        action = action
    }
end

local function S(name, description, action, min, max, default)
    return {
        name = name,
        description = description,
        kind = "slider",
        action = action,
        min = min,
        max = max,
        default = default
    }
end

local function B(name, description, action)
    return {
        name = name,
        description = description,
        kind = "button",
        action = action
    }
end

local Features = {

--==================================================
-- TAB 1: LOCAL PLAYER
--==================================================

["Local Player"] = {
    T("Hide Accessories", "Locally hide your accessories.", "HideAccessories"),
    T("Self Highlight", "Add a purple highlight to yourself.", "SelfHighlight"),
    T("Health Monitor", "Display your current health.", "HealthMonitor"),
    T("Coordinate Monitor", "Display your coordinates.", "Coordinates"),
    T("Hide Character", "Locally hide your character.", "HideCharacter"),
    T("Hide Nameplate", "Hide your local nameplate.", "HideName"),
    T("Auto Rotate", "Control character auto rotation.", "AutoRotate"),
    T("Hide Tools", "Locally hide equipped tools.", "HideTools"),
    T("Local Glow", "Add a purple light to your character.", "LocalGlow"),
    T("Position Monitor", "Display your position.", "Position"),
    B("Sit Down", "Make your character sit.", "Sit"),
    B("Jump", "Make your character jump.", "Jump"),
    B("Reset Character", "Reset your character.", "ResetCharacter")
},

--==================================================
-- TAB 2: MOVEMENT
--==================================================

["Movement"] = {
    S("WalkSpeed", "Change your local movement speed.", "WalkSpeed", 0, 100, 16),
    S("JumpPower", "Change your jump power.", "JumpPower", 0, 150, 50),
    S("Hip Height", "Adjust your humanoid hip height.", "HipHeight", -2, 10, 0),
    T("Sprint", "Set your local speed to 28.", "Sprint"),
    T("Low Gravity", "Set local gravity to 100.", "LowGravity"),
    T("High Jump", "Set jump power to 100.", "HighJump"),
    T("Auto Rotate", "Toggle character rotation.", "AutoRotate"),
    B("Dash", "Dash in your current movement direction.", "Dash"),
    B("Sit", "Sit down.", "Sit"),
    B("Jump", "Jump once.", "Jump"),
    B("Reset Speed", "Restore original walking speed.", "ResetSpeed"),
    B("Reset Jump", "Restore original jump power.", "ResetJump"),
    B("Reset Movement", "Restore movement settings.", "ResetMovement")
},

--==================================================
-- TAB 3: CAMERA
--==================================================

["Camera"] = {
    S("Field Of View", "Adjust camera FOV.", "FOV", 40, 120, 70),
    S("Minimum Zoom", "Adjust minimum camera zoom.", "MinZoom", 0.5, 20, 0.5),
    S("Maximum Zoom", "Adjust maximum camera zoom.", "MaxZoom", 5, 100, 30),
    S("Camera Offset X", "Adjust horizontal camera offset.", "OffsetX", -5, 5, 0),
    S("Camera Offset Y", "Adjust vertical camera offset.", "OffsetY", -5, 5, 0),
    T("First Person", "Lock camera into first person.", "FirstPerson"),
    T("Camera FOV Effect", "Toggle an alternate camera FOV.", "CameraShake"),
    B("Reset Camera", "Restore camera type and offset.", "ResetCamera"),
    B("Zoom In", "Set maximum zoom to 5.", "ZoomIn"),
    B("Zoom Out", "Set maximum zoom to 30.", "ZoomOut"),
    B("Classic Camera", "Use classic camera mode.", "ClassicCamera"),
    B("Follow Camera", "Follow your humanoid.", "FollowCamera"),
    B("Reset FOV", "Restore original FOV.", "ResetFOV")
},

--==================================================
-- TAB 4: GRAPHICS
--==================================================

["Graphics"] = {
    S("Brightness", "Change local lighting brightness.", "Brightness", 0, 10, 2),
    S("Clock Time", "Change local time of day.", "ClockTime", 0, 24, 14),
    T("Global Shadows", "Toggle local global shadows.", "Shadows"),
    T("Blur Effect", "Enable a local blur effect.", "Blur"),
    T("Bloom Effect", "Enable a local bloom effect.", "Bloom"),
    T("Sun Rays", "Enable local sun rays.", "SunRays"),
    S("Saturation", "Change color saturation.", "Saturation", -1, 1, 0),
    S("Contrast", "Change color contrast.", "Contrast", -1, 1, 0),
    S("Exposure", "Change exposure compensation.", "Exposure", -3, 3, 0),
    S("Atmosphere Density", "Adjust atmosphere density.", "Density", 0, 1, 0.3),
    S("Fog Distance", "Adjust fog ending distance.", "FogDistance", 50, 100000, 1000),
    S("Fog Start", "Adjust fog starting distance.", "FogStart", 0, 1000, 0),
    B("Restore Graphics", "Restore basic lighting settings.", "ResetGraphics")
},

--==================================================
-- TAB 5: WORLD
--==================================================

["World"] = {
    B("Daytime", "Set the time to afternoon.", "Day"),
    B("Nighttime", "Set the time to midnight.", "Night"),
    B("Sunrise", "Set the time to sunrise.", "Sunrise"),
    B("Sunset", "Set the time to sunset.", "Sunset"),
    T("Fog", "Toggle local fog.", "Fog"),
    T("Atmosphere", "Toggle local atmosphere.", "Atmosphere"),
    S("Haze", "Adjust atmosphere haze.", "Haze", 0, 10, 0),
    S("Glare", "Adjust atmosphere glare.", "Glare", 0, 10, 0),
    S("Ambient Scale", "Adjust environmental diffuse scale.", "Ambient", 0, 1, 0.5),
    B("Day Ambient", "Apply a brighter ambient preset.", "DayAmbient"),
    B("Night Ambient", "Apply a darker ambient preset.", "NightAmbient"),
    B("Reset World Gravity", "Restore original gravity.", "ResetGravity"),
    B("Reset Graphics", "Restore basic lighting settings.", "ResetGraphics")
},

--==================================================
-- TAB 6: VISUALS
--==================================================

["Visuals"] = {
    T("Hide Particles", "Hide particle emitters locally.", "HideParticles"),
    T("Hide Trails", "Hide trail effects locally.", "HideTrails"),
    T("Hide Beams", "Hide beam effects locally.", "HideBeams"),
    T("Hide Decals", "Hide decals locally.", "HideDecals"),
    T("Hide Textures", "Hide textures locally.", "HideTextures"),
    T("Self Highlight", "Highlight your character.", "SelfHighlight"),
    T("Health Display", "Show your health monitor.", "ShowHealthBar"),
    T("Name Display", "Show your display name in monitor.", "ShowPlayerNames"),
    T("Hide Accessories", "Hide your accessories locally.", "HideAccessories"),
    T("Hide Tools", "Hide equipped tools locally.", "HideTools"),
    T("Hide Smoke", "Hide smoke effects locally.", "HideSmoke"),
    T("Hide Fire", "Hide fire effects locally.", "HideFire"),
    B("Restore Visuals", "Restore local visual changes.", "ResetVisuals")
},

--==================================================
-- TAB 7: PERFORMANCE
--==================================================

["Performance"] = {
    T("FPS Counter", "Display your approximate FPS.", "FPS"),
    T("Ping Checker", "Display network ping.", "Ping"),
    T("Memory Monitor", "Display client memory usage.", "Memory"),
    T("Disable Particles", "Disable particle effects locally.", "HideParticles"),
    T("Disable Trails", "Disable trails locally.", "HideTrails"),
    T("Disable Beams", "Disable beams locally.", "HideBeams"),
    T("Disable Post Effects", "Disable local post-processing.", "PostEffects"),
    B("Low Graphics", "Apply a simple low-effects preset.", "ResetGraphics"),
    T("Hide Decals", "Hide decals locally.", "HideDecals"),
    T("Hide Textures", "Hide textures locally.", "HideTextures"),
    T("Reduce Shadows", "Turn off global shadows locally.", "ReduceShadows"),
    B("Restore Performance", "Restore basic visual settings.", "ResetVisuals"),
    T("Player Counter", "Display the current player count.", "PlayerCount")
},

--==================================================
-- TAB 8: UTILITIES
--==================================================

["Utilities"] = {
    T("Coordinates", "Display your current position.", "Coordinates"),
    B("Teleport To Spawn", "Move to a SpawnLocation locally.", "TeleportSpawn"),
    B("Reset Character", "Reset your character.", "ResetCharacter"),
    B("Sit", "Sit down.", "Sit"),
    B("Jump", "Jump once.", "Jump"),
    B("Username Display", "Toggle username display.", "ShowClock"),
    B("Display Name", "Toggle display name display.", "ShowClock"),
    B("User ID", "Display your user ID.", "ShowClock"),
    B("Account Age", "Display account age.", "ShowClock"),
    B("Place ID", "Display the current place ID.", "ShowClock"),
    T("Server Player Count", "Display current player count.", "PlayerCount"),
    T("Health Information", "Display current health.", "HealthMonitor"),
    T("WalkSpeed Information", "Display current WalkSpeed.", "Position")
}

}

--==================================================
-- FEATURE COUNT CHECK
--==================================================

local totalFeatures = 0

for tabName, list in pairs(Features) do
    print(tabName .. ": " .. #list .. " features")
    totalFeatures += #list
end

print("ZEPH PART 2 FEATURE COUNT:", totalFeatures)

--==================================================
-- FEATURE UI BUILDERS
--==================================================

local function CreateCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object
end

local function CreateButton(parent, text, width)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, width, 0, 27)
    button.BackgroundColor3 = Purple
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = White
    button.TextSize = 10
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = true
    button.Parent = parent

    CreateCorner(button, 7)

    return button
end

local function ClearFeatures()
    for _, object in ipairs(FeatureList:GetChildren()) do
        if object ~= ListLayout and object ~= Padding then
            object:Destroy()
        end
    end
end

local function CreateFeatureRow(feature, index)
    local Row = Instance.new("Frame")
    Row.Name = "Feature_" .. index
    Row.Size = UDim2.new(1, -5, 0, 53)
    Row.BackgroundColor3 = Color3.fromRGB(29, 22, 40)
    Row.BackgroundTransparency = 0.05
    Row.BorderSizePixel = 0
    Row.LayoutOrder = index
    Row.Parent = FeatureList

    CreateCorner(Row, 8)

    local Name = Instance.new("TextLabel")
    Name.Size = UDim2.new(1, -125, 0, 22)
    Name.Position = UDim2.fromOffset(9, 4)
    Name.BackgroundTransparency = 1
    Name.Text = feature.name
    Name.TextColor3 = White
    Name.TextSize = 11
    Name.Font = Enum.Font.GothamBold
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.Parent = Row

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -125, 0, 18)
    Desc.Position = UDim2.fromOffset(9, 27)
    Desc.BackgroundTransparency = 1
    Desc.Text = feature.description
    Desc.TextColor3 = Gray
    Desc.TextSize = 8
    Desc.Font = Enum.Font.Gotham
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextTruncate = Enum.TextTruncate.AtEnd
    Desc.Parent = Row

    if feature.kind == "toggle" then
        local enabled = false

        local button = CreateButton(Row, "OFF", 65)
        button.Position = UDim2.new(1, -73, 0.5, -13)
        button.BackgroundColor3 = Color3.fromRGB(150, 45, 55)

        button.Activated:Connect(function()
            enabled = not enabled

            local action = ToggleActions[feature.action]

            if action then
                local success, err = pcall(action, enabled)

                if not success then
                    warn("Zeph toggle error:", err)
                    enabled = not enabled
                    return
                end
            end

            button.Text = enabled and "ON" or "OFF"
            button.BackgroundColor3 = enabled
                and Color3.fromRGB(40, 170, 95)
                or Color3.fromRGB(150, 45, 55)
        end)

    elseif feature.kind == "slider" then
        local input = Instance.new("TextBox")
        input.Size = UDim2.fromOffset(52, 27)
        input.Position = UDim2.new(1, -112, 0.5, -13)
        input.BackgroundColor3 = Color3.fromRGB(40, 30, 55)
        input.TextColor3 = White
        input.PlaceholderColor3 = Gray
        input.Text = tostring(feature.default)
        input.PlaceholderText = "Value"
        input.TextSize = 10
        input.Font = Enum.Font.GothamBold
        input.ClearTextOnFocus = false
        input.Parent = Row

        CreateCorner(input, 6)

        local apply = CreateButton(Row, "SET", 42)
        apply.Position = UDim2.new(1, -51, 0.5, -13)

        local function ApplyValue()
            local value = tonumber(input.Text)

            if not value then
                input.Text = tostring(feature.default)
                return
            end

            value = math.clamp(value, feature.min, feature.max)
            input.Text = tostring(value)

            local action = SliderActions[feature.action]

            if action then
                local success, err = pcall(action, value)

                if not success then
                    warn("Zeph slider error:", err)
                end
            end
        end

        apply.Activated:Connect(ApplyValue)

        input.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                ApplyValue()
            end
        end)

    elseif feature.kind == "button" then
        local button = CreateButton(Row, "EXECUTE", 65)
        button.Position = UDim2.new(1, -73, 0.5, -13)

        button.Activated:Connect(function()
            local action = ButtonActions[feature.action]

            if action then
                local success, err = pcall(action)

                if not success then
                    warn("Zeph button error:", err)
                end
            else
                warn("Missing action:", feature.action)
            end

            TweenService:Create(
                button,
                TweenInfo.new(0.12),
                {BackgroundColor3 = Color3.fromRGB(95, 50, 160)}
            ):Play()

            task.delay(0.15, function()
                if button.Parent then
                    button.BackgroundColor3 = Purple
                end
            end)
        end)
    end
end

--==================================================
-- TAB RENDERING
--==================================================

local function RenderTab(tabName)
    local featureData = Features[tabName]

    if not featureData then return end

    ClearFeatures()

    TabTitle.Text = string.upper(tabName)
    Description.Text = #featureData .. " available features"

    for index, feature in ipairs(featureData) do
        CreateFeatureRow(feature, index)
    end

    FeatureList.CanvasPosition = Vector2.zero

    print("ZEPH: Loaded tab:", tabName)
end

--==================================================
-- CONNECT PART 1 TABS
--==================================================

local Sidebar = Main:WaitForChild("Sidebar")

for _, tabName in ipairs({
    "Local Player",
    "Movement",
    "Camera",
    "Graphics",
    "World",
    "Visuals",
    "Performance",
    "Utilities"
}) do

    local buttonName = tabName:gsub("[^%w]", "")
    local button = Sidebar:FindFirstChild(buttonName)

    if button then
        button.Activated:Connect(function()
            RenderTab(tabName)
        end)
    else
        warn("Zeph: Missing tab button:", tabName)
    end
end

--==================================================
-- INITIALIZATION
--==================================================

RenderTab("Local Player")

print("================================")
print("ZEPH HUB V2 - PART 2")
print("FEATURE ENGINE INITIALIZED")
print("104 FEATURE SLOTS DEFINED")
print("8 FEATURE TABS CONNECTED")
print("================================")


--========================================================
-- ZEPH HUB V2 - PART 3
-- FINAL 7 TABS / 70 FEATURES
--========================================================

local P3_Players = game:GetService("Players")
local P3_Lighting = game:GetService("Lighting")
local P3_StarterGui = game:GetService("StarterGui")

local P3_Player = P3_Players.LocalPlayer
local P3_PlayerGui = P3_Player:WaitForChild("PlayerGui")
local P3_Hub = P3_PlayerGui:WaitForChild("ZephHubV2")
local P3_Main = P3_Hub:WaitForChild("MainHub")
local P3_Content = P3_Main:WaitForChild("Content")
local P3_Sidebar = P3_Main:WaitForChild("Sidebar")

local P3_Title = P3_Content:WaitForChild("TabTitle")
local P3_Description = P3_Content:WaitForChild("Description")

local P3_Purple = Color3.fromRGB(160, 75, 255)
local P3_White = Color3.fromRGB(245, 245, 255)
local P3_Dark = Color3.fromRGB(30, 25, 40)

--========================================================
-- FEATURE LIST
--========================================================

local P3_List = P3_Content:FindFirstChild("FeatureList")

if not P3_List then
    P3_List = Instance.new("ScrollingFrame")
    P3_List.Name = "FeatureList"
    P3_List.Size = UDim2.new(1, -10, 1, -75)
    P3_List.Position = UDim2.new(0, 5, 0, 70)
    P3_List.BackgroundTransparency = 1
    P3_List.BorderSizePixel = 0
    P3_List.ScrollBarThickness = 3
    P3_List.Parent = P3_Content
end

P3_List:ClearAllChildren()
P3_List.AutomaticCanvasSize = Enum.AutomaticSize.Y
P3_List.CanvasSize = UDim2.new(0, 0, 0, 0)

local P3_Layout = Instance.new("UIListLayout")
P3_Layout.Padding = UDim.new(0, 7)
P3_Layout.SortOrder = Enum.SortOrder.LayoutOrder
P3_Layout.Parent = P3_List

local P3_Padding = Instance.new("UIPadding")
P3_Padding.PaddingTop = UDim.new(0, 5)
P3_Padding.PaddingBottom = UDim.new(0, 8)
P3_Padding.PaddingLeft = UDim.new(0, 3)
P3_Padding.PaddingRight = UDim.new(0, 5)
P3_Padding.Parent = P3_List

--========================================================
-- GENERAL HELPERS
--========================================================

local function P3_Status(Message)
    P3_Description.Text = tostring(Message)
end

local function P3_Character()
    return P3_Player.Character
end

local function P3_Humanoid()
    local Character = P3_Character()
    return Character and Character:FindFirstChildOfClass("Humanoid")
end

local function P3_Root()
    local Character = P3_Character()
    return Character and Character:FindFirstChild("HumanoidRootPart")
end

local function P3_Teleport(Position)
    local Root = P3_Root()

    if Root then
        Root.CFrame = CFrame.new(Position)
    else
        P3_Status("Your character is not ready.")
    end
end

local function P3_Notify(Message)
    pcall(function()
        P3_StarterGui:SetCore("SendNotification", {
            Title = "ZEPH HUB V2",
            Text = Message,
            Duration = 3
        })
    end)
end

--========================================================
-- ORIGINAL SETTINGS
--========================================================

local P3_Original = {
    Brightness = P3_Lighting.Brightness,
    ClockTime = P3_Lighting.ClockTime,
    FogEnd = P3_Lighting.FogEnd,
    FogStart = P3_Lighting.FogStart,
    Ambient = P3_Lighting.Ambient,
    OutdoorAmbient = P3_Lighting.OutdoorAmbient,
    Transparency = P3_Main.BackgroundTransparency,
    Size = P3_Main.Size
}

local P3_SavedPosition = nil
local P3_Highlights = {}
local P3_NameTags = {}
local P3_Toggles = {}
local P3_Accent = P3_Purple

--========================================================
-- ESP FUNCTIONS
--========================================================

local function P3_ClearHighlights()
    for Object, Highlight in pairs(P3_Highlights) do
        if Highlight then
            Highlight:Destroy()
        end

        P3_Highlights[Object] = nil
    end
end

local function P3_AddHighlight(Object)
    local Character

    if Object:IsA("Player") then
        Character = Object.Character
    else
        Character = Object
    end

    if not Character then return end

    local Existing = Character:FindFirstChild("ZephHighlight")

    if Existing then
        Existing:Destroy()
    end

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ZephHighlight"
    Highlight.FillColor = P3_Accent
    Highlight.OutlineColor = P3_White
    Highlight.FillTransparency = 0.55
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Character

    P3_Highlights[Object] = Highlight
end

local function P3_ClearNames()
    for Object, Billboard in pairs(P3_NameTags) do
        if Billboard then
            Billboard:Destroy()
        end

        P3_NameTags[Object] = nil
    end
end

local function P3_AddNameTag(Target)
    if Target == P3_Player then return end

    local Character = Target.Character
    local Head = Character and Character:FindFirstChild("Head")

    if not Head then return end
    if Head:FindFirstChild("ZephNameTag") then return end

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "ZephNameTag"
    Billboard.Size = UDim2.new(0, 150, 0, 30)
    Billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Adornee = Head
    Billboard.Parent = Head

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.BackgroundTransparency = 1
    Text.Text = Target.DisplayName
    Text.TextColor3 = P3_White
    Text.TextStrokeTransparency = 0.2
    Text.TextScaled = true
    Text.Font = Enum.Font.GothamBold
    Text.Parent = Billboard

    P3_NameTags[Target] = Billboard
end

--========================================================
-- ENVIRONMENT FUNCTIONS
--========================================================

local function P3_ResetEnvironment()
    P3_Lighting.Brightness = P3_Original.Brightness
    P3_Lighting.ClockTime = P3_Original.ClockTime
    P3_Lighting.FogEnd = P3_Original.FogEnd
    P3_Lighting.FogStart = P3_Original.FogStart
    P3_Lighting.Ambient = P3_Original.Ambient
    P3_Lighting.OutdoorAmbient = P3_Original.OutdoorAmbient

    for _, Effect in ipairs(P3_Lighting:GetChildren()) do
        if Effect.Name:match("^Zeph") then
            Effect:Destroy()
        end
    end

    P3_Status("Original environment restored.")
end

local function P3_ToggleEffect(Name, ClassName, Enabled)
    local Effect = P3_Lighting:FindFirstChild(Name)

    if Enabled then
        if not Effect then
            Effect = Instance.new(ClassName)
            Effect.Name = Name
            Effect.Parent = P3_Lighting
        end
    elseif Effect then
        Effect:Destroy()
    end
end

--========================================================
-- ACTIONS
--========================================================

local P3_Actions = {}

-- TAB 9: ESP & HIGHLIGHTS

P3_Actions.PlayerESP = function(Value)
    if Value then
        for _, Target in ipairs(P3_Players:GetPlayers()) do
            if Target ~= P3_Player then
                P3_AddHighlight(Target)
            end
        end

        P3_Status("Player highlights enabled.")
    else
        P3_ClearHighlights()
        P3_Status("Player highlights disabled.")
    end
end

P3_Actions.NPCESP = function(Value)
    for _, Object in ipairs(workspace:GetDescendants()) do
        if Object:IsA("Humanoid") then
            local Model = Object.Parent

            if Model and not P3_Players:GetPlayerFromCharacter(Model) then
                if Value then
                    P3_AddHighlight(Model)
                elseif P3_Highlights[Model] then
                    P3_Highlights[Model]:Destroy()
                    P3_Highlights[Model] = nil
                end
            end
        end
    end

    P3_Status(Value and "NPC highlights enabled." or "NPC highlights disabled.")
end

P3_Actions.NameTags = function(Value)
    if Value then
        for _, Target in ipairs(P3_Players:GetPlayers()) do
            P3_AddNameTag(Target)
        end
    else
        P3_ClearNames()
    end
end

P3_Actions.TeamColors = function(Value)
    for Target, Highlight in pairs(P3_Highlights) do
        if Target:IsA("Player") and Highlight then
            if Value and Target.Team then
                Highlight.FillColor = Target.Team.TeamColor.Color
            else
                Highlight.FillColor = P3_Accent
            end
        end
    end

    P3_Status("Team color setting updated.")
end

P3_Actions.WallHighlights = function(Value)
    for _, Highlight in pairs(P3_Highlights) do
        if Highlight then
            Highlight.DepthMode = Value
                and Enum.HighlightDepthMode.AlwaysOnTop
                or Enum.HighlightDepthMode.Occluded
        end
    end

    P3_Status("Highlight visibility updated.")
end

P3_Actions.SelfHighlight = function(Value)
    local Character = P3_Character()
    if not Character then return end

    local Existing = Character:FindFirstChild("ZephSelfHighlight")

    if Value and not Existing then
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "ZephSelfHighlight"
        Highlight.FillColor = P3_Accent
        Highlight.OutlineColor = P3_White
        Highlight.Parent = Character
    elseif not Value and Existing then
        Existing:Destroy()
    end
end

P3_Actions.ClearESP = function()
    P3_ClearHighlights()
    P3_ClearNames()
    P3_Status("ESP objects cleared.")
end

P3_Actions.RefreshESP = function()
    P3_ClearHighlights()

    for _, Target in ipairs(P3_Players:GetPlayers()) do
        if Target ~= P3_Player then
            P3_AddHighlight(Target)
        end
    end

    P3_Status("Player highlights refreshed.")
end

P3_Actions.ESPCount = function()
    P3_Status("Other players: " .. tostring(#P3_Players:GetPlayers() - 1))
end

P3_Actions.HighlightColor = function()
    for _, Highlight in pairs(P3_Highlights) do
        if Highlight then
            Highlight.FillColor = P3_Accent
        end
    end

    P3_Status("Highlight color refreshed.")
end

-- TAB 10: TELEPORTS

P3_Actions.SpawnTeleport = function()
    local Spawn = workspace:FindFirstChildWhichIsA("SpawnLocation", true)

    if Spawn then
        P3_Teleport(Spawn.Position + Vector3.new(0, 5, 0))
        P3_Status("Moved to spawn.")
    else
        P3_Status("No SpawnLocation was found.")
    end
end

P3_Actions.SavePosition = function()
    local Root = P3_Root()

    if Root then
        P3_SavedPosition = Root.Position
        P3_Status("Position saved.")
    end
end

P3_Actions.ReturnPosition = function()
    if P3_SavedPosition then
        P3_Teleport(P3_SavedPosition)
        P3_Status("Returned to saved position.")
    else
        P3_Status("Save a position first.")
    end
end

P3_Actions.ForwardTeleport = function()
    local Root = P3_Root()

    if Root then
        Root.CFrame = Root.CFrame + Root.CFrame.LookVector * 20
        P3_Status("Moved forward.")
    end
end

P3_Actions.UpTeleport = function()
    local Root = P3_Root()

    if Root then
        Root.CFrame = Root.CFrame + Vector3.new(0, 20, 0)
        P3_Status("Moved upward.")
    end
end

P3_Actions.DownTeleport = function()
    local Root = P3_Root()

    if Root then
        Root.CFrame = Root.CFrame - Vector3.new(0, 10, 0)
        P3_Status("Moved downward.")
    end
end

P3_Actions.CoordinateTeleport = function(X, Y, Z)
    X = tonumber(X)
    Y = tonumber(Y)
    Z = tonumber(Z)

    if X and Y and Z then
        P3_Teleport(Vector3.new(X, Y, Z))
        P3_Status("Coordinate teleport requested.")
    else
        P3_Status("Enter valid X, Y and Z values.")
    end
end

P3_Actions.PlayerTeleport = function(Name)
    if not Name or Name == "" then
        P3_Status("Enter a player name.")
        return
    end

    for _, Target in ipairs(P3_Players:GetPlayers()) do
        if Target ~= P3_Player and Target.Name:lower():sub(1, #Name) == Name:lower() then
            local TargetRoot = Target.Character
                and Target.Character:FindFirstChild("HumanoidRootPart")

            if TargetRoot then
                P3_Teleport(TargetRoot.Position + Vector3.new(0, 3, 0))
                P3_Status("Moved to " .. Target.Name .. ".")
                return
            end
        end
    end

    P3_Status("Player not found.")
end

P3_Actions.ShowCoordinates = function()
    local Root = P3_Root()

    if Root then
        local Position = Root.Position

        P3_Status(string.format(
            "X: %.1f | Y: %.1f | Z: %.1f",
            Position.X,
            Position.Y,
            Position.Z
        ))
    end
end

P3_Actions.ResetPosition = function()
    P3_SavedPosition = nil
    P3_Status("Saved position cleared.")
end

-- TAB 11: ANIMATIONS

P3_Actions.StopAnimations = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        for _, Track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
            Track:Stop()
        end

        P3_Status("Animations stopped.")
    end
end

P3_Actions.Sit = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        Humanoid.Sit = true
    end
end

P3_Actions.Stand = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        Humanoid.Sit = false
        Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end

P3_Actions.Jump = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        Humanoid.Jump = true
    end
end

P3_Actions.ResetMovement = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
        Humanoid.JumpHeight = 7.2
        P3_Status("Movement values reset.")
    end
end

P3_Actions.Wave = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        pcall(function()
            Humanoid:PlayEmote("wave")
        end)
    end
end

P3_Actions.Cheer = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        pcall(function()
            Humanoid:PlayEmote("cheer")
        end)
    end
end

P3_Actions.Dance = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        pcall(function()
            Humanoid:PlayEmote("dance")
        end)
    end
end

P3_Actions.FaceForward = function()
    local Root = P3_Root()

    if Root then
        local Position = Root.Position
        Root.CFrame = CFrame.lookAt(
            Position,
            Position + Vector3.new(0, 0, -1)
        )
    end
end

P3_Actions.PlatformStand = function(Value)
    local Humanoid = P3_Humanoid()

    if Humanoid then
        Humanoid.PlatformStand = Value
    end
end

-- TAB 12: INTERFACE

P3_Actions.HideOtherGuis = function(Value)
    for _, Gui in ipairs(P3_PlayerGui:GetChildren()) do
        if Gui:IsA("ScreenGui") and Gui ~= P3_Hub then
            Gui.Enabled = not Value
        end
    end

    P3_Status(Value and "Other GUIs hidden." or "Other GUIs restored.")
end

P3_Actions.CompactMode = function(Value)
    P3_Main.Size = Value
        and UDim2.new(0.72, 0, 0, 260)
        or P3_Original.Size
end

P3_Actions.HideSidebar = function(Value)
    P3_Sidebar.Visible = not Value
end

P3_Actions.HideDescription = function(Value)
    P3_Description.Visible = not Value
end

P3_Actions.ToggleHub = function()
    P3_Main.Visible = not P3_Main.Visible
end

P3_Actions.ResetInterface = function()
    P3_Main.Size = P3_Original.Size
    P3_Main.Visible = true
    P3_Sidebar.Visible = true
    P3_Title.Visible = true
    P3_Description.Visible = true
    P3_List.Visible = true
    P3_Status("Interface reset.")
end

P3_Actions.RefreshInterface = function()
    P3_Title.Text = "ZEPH HUB V2"
    P3_Status("Interface refreshed.")
end

P3_Actions.HideTitle = function(Value)
    P3_Title.Visible = not Value
end

P3_Actions.HideFeatureList = function(Value)
    P3_List.Visible = not Value
end

P3_Actions.CycleTransparency = function()
    if P3_Main.BackgroundTransparency >= 0.3 then
        P3_Main.BackgroundTransparency = 0.1
    else
        P3_Main.BackgroundTransparency = 0.3
    end
end

-- TAB 13: ENVIRONMENT

P3_Actions.Day = function()
    P3_Lighting.ClockTime = 14
    P3_Status("Daytime enabled.")
end

P3_Actions.Night = function()
    P3_Lighting.ClockTime = 0
    P3_Status("Nighttime enabled.")
end

P3_Actions.Fog = function(Value)
    P3_Lighting.FogEnd = Value and 100 or P3_Original.FogEnd
    P3_Lighting.FogStart = 0
end

P3_Actions.Brightness = function(Value)
    P3_Lighting.Brightness = Value and 3 or P3_Original.Brightness
end

P3_Actions.Ambient = function(Value)
    P3_Lighting.Ambient = Value
        and Color3.fromRGB(130, 110, 180)
        or P3_Original.Ambient
end

P3_Actions.Atmosphere = function(Value)
    local Atmosphere = P3_Lighting:FindFirstChildOfClass("Atmosphere")

    if Atmosphere then
        Atmosphere.Enabled = Value
    else
        P3_Status("No Atmosphere object found.")
    end
end

P3_Actions.Bloom = function(Value)
    P3_ToggleEffect("ZephBloom", "BloomEffect", Value)

    local Effect = P3_Lighting:FindFirstChild("ZephBloom")

    if Effect then
        Effect.Intensity = 0.5
        Effect.Size = 24
    end
end

P3_Actions.ColorCorrection = function(Value)
    P3_ToggleEffect("ZephColor", "ColorCorrectionEffect", Value)

    local Effect = P3_Lighting:FindFirstChild("ZephColor")

    if Effect then
        Effect.Saturation = 0.25
        Effect.Contrast = 0.1
    end
end

P3_Actions.ResetEnvironment = function()
    P3_ResetEnvironment()
end

P3_Actions.OutdoorAmbient = function(Value)
    P3_Lighting.OutdoorAmbient = Value
        and Color3.fromRGB(120, 100, 170)
        or P3_Original.OutdoorAmbient
end

-- TAB 14: INFORMATION

P3_Actions.PlayerName = function()
    P3_Status("Username: " .. P3_Player.Name)
end

P3_Actions.DisplayName = function()
    P3_Status("Display name: " .. P3_Player.DisplayName)
end

P3_Actions.UserID = function()
    P3_Status("User ID: " .. P3_Player.UserId)
end

P3_Actions.AccountAge = function()
    P3_Status("Account age: " .. P3_Player.AccountAge .. " days")
end

P3_Actions.PlaceID = function()
    P3_Status("Place ID: " .. game.PlaceId)
end

P3_Actions.JobID = function()
    P3_Status("Server ID: " .. game.JobId)
end

P3_Actions.PlayerCount = function()
    P3_Status("Players in server: " .. #P3_Players:GetPlayers())
end

P3_Actions.HealthInfo = function()
    local Humanoid = P3_Humanoid()

    if Humanoid then
        P3_Status(
            "Health: " .. math.floor(Humanoid.Health)
            .. " / " .. math.floor(Humanoid.MaxHealth)
        )
    end
end

P3_Actions.PositionInfo = function()
    local Root = P3_Root()

    if Root then
        local Position = Root.Position

        P3_Status(string.format(
            "Position: %.1f, %.1f, %.1f",
            Position.X,
            Position.Y,
            Position.Z
        ))
    end
end

P3_Actions.PingInfo = function()
    local Success, Result = pcall(function()
        return game:GetService("Stats")
            .Network.ServerStatsItem["Data Ping"]:GetValueString()
    end)

    P3_Status("Ping: " .. (Success and Result or "Unavailable"))
end

-- TAB 15: CUSTOMIZATION

local P3_Colors = {
    Color3.fromRGB(160, 75, 255),
    Color3.fromRGB(50, 150, 255),
    Color3.fromRGB(255, 80, 180),
    Color3.fromRGB(50, 220, 170),
    Color3.fromRGB(255, 170, 50)
}

local P3_ColorIndex = 1

local function P3_ChangeAccent(Color)
    P3_Accent = Color

    for _, Object in ipairs(P3_Hub:GetDescendants()) do
        if Object:IsA("UIStroke") then
            Object.Color = Color
        elseif Object:IsA("ScrollingFrame") then
            Object.ScrollBarImageColor3 = Color
        end
    end

    for _, Highlight in pairs(P3_Highlights) do
        if Highlight then
            Highlight.FillColor = Color
        end
    end

    P3_Status("Accent color changed.")
end

P3_Actions.NextAccent = function()
    P3_ColorIndex += 1

    if P3_ColorIndex > #P3_Colors then
        P3_ColorIndex = 1
    end

    P3_ChangeAccent(P3_Colors[P3_ColorIndex])
end

P3_Actions.PurpleTheme = function()
    P3_ChangeAccent(Color3.fromRGB(160, 75, 255))
end

P3_Actions.BlueTheme = function()
    P3_ChangeAccent(Color3.fromRGB(50, 150, 255))
end

P3_Actions.PinkTheme = function()
    P3_ChangeAccent(Color3.fromRGB(255, 80, 180))
end

P3_Actions.GreenTheme = function()
    P3_ChangeAccent(Color3.fromRGB(50, 220, 170))
end

P3_Actions.OrangeTheme = function()
    P3_ChangeAccent(Color3.fromRGB(255, 170, 50))
end

P3_Actions.MoreOpaque = function()
    P3_Main.BackgroundTransparency = math.max(
        0,
        P3_Main.BackgroundTransparency - 0.1
    )
end

P3_Actions.MoreTransparent = function()
    P3_Main.BackgroundTransparency = math.min(
        0.7,
        P3_Main.BackgroundTransparency + 0.1
    )
end

P3_Actions.GlowToggle = function(Value)
    for _, Object in ipairs(P3_Main:GetDescendants()) do
        if Object:IsA("UIStroke") then
            Object.Enabled = Value
        end
    end
end

P3_Actions.ResetTheme = function()
    P3_ChangeAccent(Color3.fromRGB(160, 75, 255))
    P3_Main.BackgroundTransparency = P3_Original.Transparency
    P3_Main.Size = P3_Original.Size
    P3_Status("Default theme restored.")
end

--========================================================
-- 70 FEATURES
--========================================================

local P3_Tabs = {
    ["ESP & Highlights"] = {
        {"Player ESP", "Toggle", "PlayerESP"},
        {"NPC Highlights", "Toggle", "NPCESP"},
        {"Name Tags", "Toggle", "NameTags"},
        {"Team Colors", "Toggle", "TeamColors"},
        {"Highlight Through Walls", "Toggle", "WallHighlights"},
        {"Highlight Yourself", "Toggle", "SelfHighlight"},
        {"Clear ESP", "Button", "ClearESP"},
        {"Refresh ESP", "Button", "RefreshESP"},
        {"Player Count", "Button", "ESPCount"},
        {"Refresh Highlight Color", "Button", "HighlightColor"}
    },

    ["Teleports"] = {
        {"Teleport to Spawn", "Button", "SpawnTeleport"},
        {"Save Current Position", "Button", "SavePosition"},
        {"Return to Saved Position", "Button", "ReturnPosition"},
        {"Move Forward 20 Studs", "Button", "ForwardTeleport"},
        {"Move Up 20 Studs", "Button", "UpTeleport"},
        {"Move Down 10 Studs", "Button", "DownTeleport"},
        {"Coordinate Teleporter", "Coordinates", "CoordinateTeleport"},
        {"Player Name Teleporter", "TextInput", "PlayerTeleport"},
        {"Show Coordinates", "Button", "ShowCoordinates"},
        {"Clear Saved Position", "Button", "ResetPosition"}
    },

    ["Animations"] = {
        {"Stop All Animations", "Button", "StopAnimations"},
        {"Sit", "Button", "Sit"},
        {"Stand Up", "Button", "Stand"},
        {"Jump", "Button", "Jump"},
        {"Reset Movement", "Button", "ResetMovement"},
        {"Wave Emote", "Button", "Wave"},
        {"Cheer Emote", "Button", "Cheer"},
        {"Dance Emote", "Button", "Dance"},
        {"Face Forward", "Button", "FaceForward"},
        {"Platform Stand", "Toggle", "PlatformStand"}
    },

    ["Interface"] = {
        {"Hide Other GUIs", "Toggle", "HideOtherGuis"},
        {"Compact Mode", "Toggle", "CompactMode"},
        {"Hide Sidebar", "Toggle", "HideSidebar"},
        {"Hide Description", "Toggle", "HideDescription"},
        {"Show / Hide Hub", "Button", "ToggleHub"},
        {"Reset Interface", "Button", "ResetInterface"},
        {"Refresh Interface", "Button", "RefreshInterface"},
        {"Hide Hub Title", "Toggle", "HideTitle"},
        {"Hide Feature List", "Toggle", "HideFeatureList"},
        {"Cycle Transparency", "Button", "CycleTransparency"}
    },

    ["Environment"] = {
        {"Daytime", "Button", "Day"},
        {"Nighttime", "Button", "Night"},
        {"Fog", "Toggle", "Fog"},
        {"Extra Brightness", "Toggle", "Brightness"},
        {"Purple Ambient", "Toggle", "Ambient"},
        {"Atmosphere", "Toggle", "Atmosphere"},
        {"Bloom Effect", "Toggle", "Bloom"},
        {"Color Correction", "Toggle", "ColorCorrection"},
        {"Reset Environment", "Button", "ResetEnvironment"},
        {"Outdoor Ambient", "Toggle", "OutdoorAmbient"}
    },

    ["Information"] = {
        {"Username", "Button", "PlayerName"},
        {"Display Name", "Button", "DisplayName"},
        {"User ID", "Button", "UserID"},
        {"Account Age", "Button", "AccountAge"},
        {"Place ID", "Button", "PlaceID"},
        {"Server ID", "Button", "JobID"},
        {"Player Count", "Button", "PlayerCount"},
        {"Health Information", "Button", "HealthInfo"},
        {"Position Information", "Button", "PositionInfo"},
        {"Ping Information", "Button", "PingInfo"}
    },

    ["Customization"] = {
        {"Next Accent Color", "Button", "NextAccent"},
        {"Purple Theme", "Button", "PurpleTheme"},
        {"Blue Theme", "Button", "BlueTheme"},
        {"Pink Theme", "Button", "PinkTheme"},
        {"Green Theme", "Button", "GreenTheme"},
        {"Orange Theme", "Button", "OrangeTheme"},
        {"More Opaque", "Button", "MoreOpaque"},
        {"More Transparent", "Button", "MoreTransparent"},
        {"Toggle Glow", "Toggle", "GlowToggle"},
        {"Reset Theme", "Button", "ResetTheme"}
    }
}

--========================================================
-- FEATURE UI CREATION
--========================================================

local function P3_CreateRow(Name)
    local Row = Instance.new("Frame")
    Row.Name = "ZephFeatureRow"
    Row.Size = UDim2.new(1, -5, 0, 42)
    Row.BackgroundColor3 = P3_Dark
    Row.BackgroundTransparency = 0.08
    Row.BorderSizePixel = 0
    Row.Parent = P3_List

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Row

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = P3_Accent
    Stroke.Transparency = 0.65
    Stroke.Thickness = 1
    Stroke.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Name = "FeatureName"
    Label.Size = UDim2.new(0.57, -5, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Name
    Label.TextColor3 = P3_White
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamMedium
    Label.Parent = Row

    return Row, Label
end

local function P3_CreateButton(Row, Text, Callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 105, 0, 28)
    Button.Position = UDim2.new(1, -112, 0.5, -14)
    Button.BackgroundColor3 = P3_Accent
    Button.BorderSizePixel = 0
    Button.Text = Text
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = true
    Button.Parent = Row

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(Callback)

    return Button
end

local function P3_CreateInput(Row, Placeholder)
    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(0, 105, 0, 28)
    Input.Position = UDim2.new(1, -112, 0.5, -14)
    Input.BackgroundColor3 = Color3.fromRGB(45, 38, 58)
    Input.BorderSizePixel = 0
    Input.PlaceholderText = Placeholder
    Input.PlaceholderColor3 = Color3.fromRGB(180, 170, 195)
    Input.Text = ""
    Input.TextColor3 = P3_White
    Input.TextSize = 11
    Input.Font = Enum.Font.Gotham
    Input.ClearTextOnFocus = false
    Input.Parent = Row

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Input

    return Input
end

local function P3_CreateToggle(Row, Name, Action)
    local Enabled = P3_Toggles[Name] == true

    local Button = P3_CreateButton(
        Row,
        Enabled and "ON" or "OFF",
        function()
            Enabled = not Enabled
            P3_Toggles[Name] = Enabled
            Button.Text = Enabled and "ON" or "OFF"

            if Action then
                local Success, ErrorMessage = pcall(Action, Enabled)

                if not Success then
                    warn("[ZEPH HUB] " .. tostring(ErrorMessage))
                    P3_Status("This feature could not run.")
                end
            end
        end
    )

    Button.BackgroundColor3 = Enabled
        and Color3.fromRGB(45, 170, 100)
        or Color3.fromRGB(100, 65, 125)

    return Button
end

--========================================================
-- TAB RENDERING
--========================================================

local function P3_RenderTab(TabName)
    local Features = P3_Tabs[TabName]

    if not Features then return end

    P3_Title.Text = TabName
    P3_Description.Text = "ZEPH HUB V2  |  " .. #Features .. " FEATURES"

    P3_List:ClearAllChildren()

    local NewLayout = Instance.new("UIListLayout")
    NewLayout.Padding = UDim.new(0, 7)
    NewLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NewLayout.Parent = P3_List

    local NewPadding = Instance.new("UIPadding")
    NewPadding.PaddingTop = UDim.new(0, 5)
    NewPadding.PaddingBottom = UDim.new(0, 8)
    NewPadding.PaddingLeft = UDim.new(0, 3)
    NewPadding.PaddingRight = UDim.new(0, 5)
    NewPadding.Parent = P3_List

    for _, Feature in ipairs(Features) do
        local Name = Feature[1]
        local Type = Feature[2]
        local ActionName = Feature[3]

        local Row = P3_CreateRow(Name)
        local Action = P3_Actions[ActionName]

        if Type == "Button" then
            P3_CreateButton(Row, "EXECUTE", function()
                if Action then
                    local Success, ErrorMessage = pcall(Action)

                    if not Success then
                        warn("[ZEPH HUB] " .. tostring(ErrorMessage))
                        P3_Status("Feature error. Check Output.")
                    end
                end
            end)

        elseif Type == "Toggle" then
            P3_CreateToggle(Row, Name, Action)

        elseif Type == "Coordinates" then
            local X = P3_CreateInput(Row, "X")
            X.Size = UDim2.new(0, 35, 0, 28)
            X.Position = UDim2.new(1, -145, 0.5, -14)

            local Y = P3_CreateInput(Row, "Y")
            Y.Size = UDim2.new(0, 35, 0, 28)
            Y.Position = UDim2.new(1, -105, 0.5, -14)

            local Z = P3_CreateInput(Row, "Z")
            Z.Size = UDim2.new(0, 35, 0, 28)
            Z.Position = UDim2.new(1, -65, 0.5, -14)

            P3_CreateButton(Row, "GO", function()
                if Action then
                    Action(X.Text, Y.Text, Z.Text)
                end
            end)

        elseif Type == "TextInput" then
            local Input = P3_CreateInput(Row, "Player name")
            Input.Size = UDim2.new(0, 105, 0, 28)

            P3_CreateButton(Row, "GO", function()
                if Action then
                    Action(Input.Text)
                end
            end)
        end
    end

    P3_Status("Loaded " .. TabName .. ".")
end

--========================================================
-- CONNECT THE LAST 7 SIDEBAR BUTTONS
--========================================================

local P3_Connected = {}

for _, Object in ipairs(P3_Sidebar:GetDescendants()) do
    if Object:IsA("TextButton") then
        local TabName = Object.Text

        if P3_Tabs[TabName] and not P3_Connected[Object] then
            P3_Connected[Object] = true

            Object.MouseButton1Click:Connect(function()
                P3_RenderTab(TabName)
            end)
        end
    end
end

--========================================================
-- FINISHED
--========================================================

print("================================")
print("ZEPH HUB V2 - PART 3 LOADED")
print("7 NEW TABS CONNECTED")
print("70 NEW FEATURE SLOTS CREATED")
print("15 TOTAL TABS")
print("174 TOTAL FEATURE SLOTS")
print("================================")

P3_Notify("Part 3 loaded successfully!")

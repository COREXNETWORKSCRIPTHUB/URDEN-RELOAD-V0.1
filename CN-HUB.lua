local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ParentGui = (gethui and gethui()) or CoreGui
if ParentGui:FindFirstChild("CorexHubGui") then
	ParentGui.CorexHubGui:Destroy()
end
if PlayerGui:FindFirstChild("CorexHubGui") then
	PlayerGui.CorexHubGui:Destroy()
end
if ParentGui:FindFirstChild("CorexAimEspOverlay") then
	ParentGui.CorexAimEspOverlay:Destroy()
end

local Theme = {
	Bg = Color3.fromRGB(11, 13, 18),
	Bg2 = Color3.fromRGB(16, 19, 26),
	Bg3 = Color3.fromRGB(22, 26, 35),
	Accent = Color3.fromRGB(0, 175, 255),
	Text = Color3.fromRGB(242, 246, 255),
	TextDim = Color3.fromRGB(145, 158, 180),
	Stroke = Color3.fromRGB(0, 175, 255),
	Danger = Color3.fromRGB(255, 75, 90),
	Green = Color3.fromRGB(50, 220, 120)
}

local Connections = {}
local function Track(conn)
	table.insert(Connections, conn)
	return conn
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CorexHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = ParentGui

local OverlayGui = Instance.new("ScreenGui")
OverlayGui.Name = "CorexAimEspOverlay"
OverlayGui.ResetOnSpawn = false
OverlayGui.IgnoreGuiInset = true
OverlayGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
OverlayGui.Parent = ParentGui

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(0, 276, 0, 122)
LoadingFrame.Position = UDim2.new(0.5, -138, 0.5, -61)
LoadingFrame.BackgroundColor3 = Theme.Bg
LoadingFrame.BorderSizePixel = 0
LoadingFrame.ZIndex = 20
LoadingFrame.Parent = ScreenGui

Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 10)
local LoadStroke = Instance.new("UIStroke", LoadingFrame)
LoadStroke.Color = Theme.Stroke
LoadStroke.Thickness = 1.5
LoadStroke.Transparency = 0.2

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 22)
LoadTitle.Position = UDim2.new(0, 0, 0, 12)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "COREX NETWORK SCRIPT HUB"
LoadTitle.Font = Enum.Font.GothamBlack
LoadTitle.TextSize = 13
LoadTitle.TextColor3 = Theme.Accent
LoadTitle.ZIndex = 21
LoadTitle.Parent = LoadingFrame

local LoadSub = Instance.new("TextLabel")
LoadSub.Size = UDim2.new(1, 0, 0, 14)
LoadSub.Position = UDim2.new(0, 0, 0, 33)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "CN-HUB  •  URBAN RELOAD"
LoadSub.Font = Enum.Font.GothamBold
LoadSub.TextSize = 10
LoadSub.TextColor3 = Theme.TextDim
LoadSub.ZIndex = 21
LoadSub.Parent = LoadingFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -56, 0, 15)
StatusLabel.Position = UDim2.new(0, 16, 0, 60)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "กำลังโหลด..."
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextSize = 11
StatusLabel.TextColor3 = Theme.Text
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.ZIndex = 21
StatusLabel.Parent = LoadingFrame

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(0, 42, 0, 15)
PercentLabel.Position = UDim2.new(1, -58, 0, 60)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextSize = 11
PercentLabel.TextColor3 = Theme.Accent
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
PercentLabel.ZIndex = 21
PercentLabel.Parent = LoadingFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(1, -32, 0, 6)
BarBg.Position = UDim2.new(0, 16, 0, 86)
BarBg.BackgroundColor3 = Theme.Bg3
BarBg.BorderSizePixel = 0
BarBg.ZIndex = 21
BarBg.Parent = LoadingFrame
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Theme.Accent
BarFill.BorderSizePixel = 0
BarFill.ZIndex = 22
BarFill.Parent = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 470, 0, 290)
Main.Position = UDim2.new(0.5, -235, 0.5, -145)
Main.BackgroundColor3 = Theme.Bg
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Visible = false
Main.ZIndex = 2
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Theme.Stroke
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = Theme.Bg2
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 4
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local TopFix = Instance.new("Frame")
TopFix.Size = UDim2.new(1, 0, 0, 12)
TopFix.Position = UDim2.new(0, 0, 1, -12)
TopFix.BackgroundColor3 = Theme.Bg2
TopFix.BorderSizePixel = 0
TopFix.ZIndex = 3
TopFix.Parent = TopBar

local HubTitle = Instance.new("TextLabel")
HubTitle.Size = UDim2.new(1, -96, 1, 0)
HubTitle.Position = UDim2.new(0, 12, 0, 0)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "COREX NETWORK SCRIPT HUB"
HubTitle.Font = Enum.Font.GothamBold
HubTitle.TextSize = 12
HubTitle.TextColor3 = Theme.Accent
HubTitle.TextXAlignment = Enum.TextXAlignment.Left
HubTitle.ZIndex = 5
HubTitle.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -13)
CloseBtn.BackgroundColor3 = Theme.Bg3
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.TextColor3 = Theme.Danger
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 5
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 7)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -62, 0.5, -13)
MinBtn.BackgroundColor3 = Theme.Bg3
MinBtn.Text = "−"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.TextColor3 = Theme.Text
MinBtn.AutoButtonColor = false
MinBtn.ZIndex = 5
MinBtn.Parent = TopBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 7)

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 124, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = Theme.Bg2
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 3
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local SideFix = Instance.new("Frame")
SideFix.Size = UDim2.new(0, 12, 1, 0)
SideFix.Position = UDim2.new(1, -12, 0, 0)
SideFix.BackgroundColor3 = Theme.Bg2
SideFix.BorderSizePixel = 0
SideFix.ZIndex = 3
SideFix.Parent = Sidebar

local TabList = Instance.new("Frame")
TabList.Size = UDim2.new(1, -10, 1, -14)
TabList.Position = UDim2.new(0, 5, 0, 8)
TabList.BackgroundTransparency = 1
TabList.ZIndex = 4
TabList.Parent = Sidebar

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 6)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabList

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -134, 1, -46)
ContentArea.Position = UDim2.new(0, 129, 0, 42)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 3
ContentArea.Parent = Main

local MiniContainer = Instance.new("Frame")
MiniContainer.Name = "MiniContainer"
MiniContainer.Size = UDim2.new(0, 48, 0, 48)
MiniContainer.Position = UDim2.new(1, -64, 0.5, -24)
MiniContainer.BackgroundTransparency = 1
MiniContainer.Visible = false
MiniContainer.ZIndex = 15
MiniContainer.Parent = ScreenGui

local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 46, 0, 46)
MiniBtn.Position = UDim2.new(0, 1, 0, 1)
MiniBtn.BackgroundColor3 = Theme.Bg
MiniBtn.Text = "CN"
MiniBtn.Font = Enum.Font.GothamBlack
MiniBtn.TextSize = 15
MiniBtn.TextColor3 = Theme.Accent
MiniBtn.AutoButtonColor = false
MiniBtn.ZIndex = 16
MiniBtn.Parent = MiniContainer
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)

local MiniStroke = Instance.new("UIStroke", MiniBtn)
MiniStroke.Color = Theme.Stroke
MiniStroke.Thickness = 1.8
MiniStroke.Transparency = 0.15

local function MakeDraggable(frame, handle)
	local dragging, dragInput, dragStart, startPos
	Track(handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			Track(input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end))
		end
	end))
	Track(handle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end))
	Track(UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end))
end

MakeDraggable(Main, TopBar)
MakeDraggable(LoadingFrame, LoadingFrame)
MakeDraggable(MiniContainer, MiniBtn)

local Backup = {
	Saved = false,
	GlobalShadows = nil,
	LightingChildren = {},
	PartMaterials = {},
	PartReflectance = {},
	PartCastShadow = {},
	Decals = {},
	TerrainDecoration = nil
}

local function SaveOriginalWorld()
	if Backup.Saved then return end
	Backup.Saved = true
	Backup.GlobalShadows = Lighting.GlobalShadows
	local terrain = workspace:FindFirstChildOfClass("Terrain")
	if terrain then
		pcall(function()
			Backup.TerrainDecoration = terrain.Decoration
		end)
	end
	for _, obj in ipairs(Lighting:GetChildren()) do
		if obj:IsA("PostEffect") or obj:IsA("Atmosphere") or obj:IsA("Sky") then
			table.insert(Backup.LightingChildren, {
				Obj = obj,
				Enabled = obj:IsA("PostEffect") and obj.Enabled or nil
			})
		end
	end
end

local function ApplyClayMode(enabled)
	SaveOriginalWorld()
	if enabled then
		pcall(function() Lighting.GlobalShadows = false end)
		for _, item in ipairs(Backup.LightingChildren) do
			if item.Obj and item.Obj.Parent and item.Enabled ~= nil then
				pcall(function() item.Obj.Enabled = false end)
			end
		end
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				if Backup.PartMaterials[obj] == nil then
					Backup.PartMaterials[obj] = obj.Material
					Backup.PartReflectance[obj] = obj.Reflectance
					Backup.PartCastShadow[obj] = obj.CastShadow
				end
				pcall(function()
					obj.Material = Enum.Material.SmoothPlastic
					obj.Reflectance = 0
					obj.CastShadow = false
				end)
			elseif obj:IsA("Decal") or obj:IsA("Texture") then
				if Backup.Decals[obj] == nil then
					Backup.Decals[obj] = obj.Transparency
				end
				pcall(function() obj.Transparency = 1 end)
			elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
				pcall(function() obj.Enabled = false end)
			end
		end
	else
		pcall(function()
			if Backup.GlobalShadows ~= nil then
				Lighting.GlobalShadows = Backup.GlobalShadows
			end
		end)
		for _, item in ipairs(Backup.LightingChildren) do
			if item.Obj and item.Obj.Parent and item.Enabled ~= nil then
				pcall(function() item.Obj.Enabled = item.Enabled end)
			end
		end
		for part, mat in pairs(Backup.PartMaterials) do
			if part and part.Parent then
				pcall(function()
					part.Material = mat
					part.Reflectance = Backup.PartReflectance[part] or 0
					part.CastShadow = Backup.PartCastShadow[part]
				end)
			end
		end
		for dec, trans in pairs(Backup.Decals) do
			if dec and dec.Parent then
				pcall(function() dec.Transparency = trans end)
			end
		end
	end
end

local function ApplyBoostFps(enabled)
	SaveOriginalWorld()
	local terrain = workspace:FindFirstChildOfClass("Terrain")
	if enabled then
		pcall(function()
			Lighting.GlobalShadows = false
			if terrain then
				terrain.WaterWaveSize = 0
				terrain.WaterWaveSpeed = 0
				terrain.WaterReflectance = 0
				terrain.WaterTransparency = 1
				pcall(function() terrain.Decoration = false end)
			end
		end)
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				pcall(function() obj.CastShadow = false end)
			elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
				pcall(function() obj.Enabled = false end)
			end
		end
	else
		pcall(function()
			if Backup.GlobalShadows ~= nil then
				Lighting.GlobalShadows = Backup.GlobalShadows
			end
			if terrain and Backup.TerrainDecoration ~= nil then
				pcall(function() terrain.Decoration = Backup.TerrainDecoration end)
			end
		end)
	end
end

local function ApplyFullClayMode(enabled)
	ApplyClayMode(enabled)
	ApplyBoostFps(enabled)
	if enabled then
		pcall(function()
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		end)
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				pcall(function()
					obj.Material = Enum.Material.Plastic
					obj.Reflectance = 0
					obj.CastShadow = false
				end)
			elseif obj:IsA("SpecialMesh") then
				pcall(function() obj.TextureId = "" end)
			elseif obj:IsA("MeshPart") then
				pcall(function() obj.TextureID = "" end)
			elseif obj:IsA("Decal") or obj:IsA("Texture") then
				pcall(function() obj.Transparency = 1 end)
			end
		end
	else
		pcall(function()
			settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
		end)
	end
end

local State = {
	AimbotEnabled = false,
	AimPullLevel = 50,
	AimRange = 250,
	NoWallLock = true,
	AimCfgOpen = false,
	EspEnabled = false,
	EspCfgOpen = false,
	EspBox = false,
	EspLine = false,
	EspChams = false,
	EspHp = false,
	LockedTargetPart = nil
}

local function GetCharParts(plr)
	local char = plr and plr.Character
	if not char then return nil, nil, nil end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	return char, hum, hrp
end

local function GetBodyTargetPart(char)
	if not char then return nil end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum and hum.RigType == Enum.HumanoidRigType.R15 then
		return char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart")
	end
	return char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
end

local function HasClearLineOfSight(originPos, targetPart)
	if not targetPart or not targetPart.Parent then
		return false
	end
	local direction = targetPart.Position - originPos
	local distance = direction.Magnitude
	if distance <= 0.1 then
		return true
	end

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local ignoreList = {}
	if LocalPlayer.Character then
		table.insert(ignoreList, LocalPlayer.Character)
	end
	local cam = workspace.CurrentCamera
	if cam then
		table.insert(ignoreList, cam)
	end
	params.FilterDescendantsInstances = ignoreList
	params.IgnoreWater = true

	local result = workspace:Raycast(originPos, direction, params)
	if not result or not result.Instance then
		return true
	end

	return result.Instance:IsDescendantOf(targetPart.Parent)
end

local function IsTargetValid(part)
	if not part or not part:IsA("BasePart") or not part.Parent then
		return false
	end
	local char = part.Parent
	local hum = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp or hum.Health <= 0 then
		return false
	end

	local _, _, myHrp = GetCharParts(LocalPlayer)
	if not myHrp then
		return false
	end

	local dist = (part.Position - myHrp.Position).Magnitude
	if dist > State.AimRange then
		return false
	end

	if State.NoWallLock then
		local cam = workspace.CurrentCamera
		local originPos = cam and cam.CFrame.Position or myHrp.Position
		if not HasClearLineOfSight(originPos, part) then
			return false
		end
	end

	return true
end

local EspVisuals = {}

local function DestroyEspForPlayer(plr)
	local data = EspVisuals[plr]
	if data then
		if data.Box then data.Box:Destroy() end
		if data.HpBg then data.HpBg:Destroy() end
		if data.Line then data.Line:Destroy() end
		EspVisuals[plr] = nil
	end
	local char = plr and plr.Character
	if char then
		for _, desc in ipairs(char:GetDescendants()) do
			if desc.Name == "Corex_ChamsAdorn" then
				desc:Destroy()
			end
		end
	end
end

local function ClearAllEsp()
	for plr in pairs(EspVisuals) do
		DestroyEspForPlayer(plr)
	end
	for _, plr in ipairs(Players:GetPlayers()) do
		DestroyEspForPlayer(plr)
	end
end

local function EnsureEsp2d(plr)
	if EspVisuals[plr] then
		return EspVisuals[plr]
	end

	local box = Instance.new("Frame")
	box.Name = "Corex_Box"
	box.BackgroundTransparency = 1
	box.BorderSizePixel = 0
	box.Visible = false
	box.ZIndex = 10
	box.Parent = OverlayGui

	local boxStroke = Instance.new("UIStroke", box)
	boxStroke.Color = Theme.Accent
	boxStroke.Thickness = 1.5
	boxStroke.Transparency = 0.05

	local hpBg = Instance.new("Frame")
	hpBg.Name = "Corex_HpBg"
	hpBg.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
	hpBg.BorderSizePixel = 0
	hpBg.Visible = false
	hpBg.ZIndex = 10
	hpBg.Parent = OverlayGui

	local hpFill = Instance.new("Frame")
	hpFill.Name = "Fill"
	hpFill.Size = UDim2.new(1, 0, 1, 0)
	hpFill.Position = UDim2.new(0, 0, 0, 0)
	hpFill.BackgroundColor3 = Theme.Green
	hpFill.BorderSizePixel = 0
	hpFill.ZIndex = 11
	hpFill.Parent = hpBg

	local line = Instance.new("Frame")
	line.Name = "Corex_TopLine"
	line.BackgroundColor3 = Theme.Accent
	line.BorderSizePixel = 0
	line.AnchorPoint = Vector2.new(0.5, 0.5)
	line.Visible = false
	line.ZIndex = 9
	line.Parent = OverlayGui

	local data = {
		Box = box,
		HpBg = hpBg,
		HpFill = hpFill,
		Line = line
	}
	EspVisuals[plr] = data
	return data
end

local function UpdateEsp()
	local cam = workspace.CurrentCamera
	if not cam then return end

	if not State.EspEnabled then
		ClearAllEsp()
		return
	end

	local viewport = cam.ViewportSize
	local topCenter = Vector2.new(viewport.X * 0.5, 0)

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local char, hum, hrp = GetCharParts(plr)
			if char and hum and hrp and hum.Health > 0 then
				for _, part in ipairs(char:GetDescendants()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
						local adorn = part:FindFirstChild("Corex_ChamsAdorn")
						if State.EspChams then
							if not adorn then
								adorn = Instance.new("BoxHandleAdornment")
								adorn.Name = "Corex_ChamsAdorn"
								adorn.Adornee = part
								adorn.Size = part.Size + Vector3.new(0.06, 0.06, 0.06)
								adorn.Color3 = Theme.Accent
								adorn.Transparency = 0.42
								adorn.AlwaysOnTop = true
								adorn.ZIndex = 5
								adorn.Parent = part
							end
						elseif adorn then
							adorn:Destroy()
						end
					end
				end

				local need2d = State.EspBox or State.EspLine or State.EspHp
				local vis = EnsureEsp2d(plr)
				local rootScreen, onScreen = cam:WorldToViewportPoint(hrp.Position)
				local topScreen = cam:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3.1, 0))
				local botScreen = cam:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.2, 0))

				if need2d and onScreen and rootScreen.Z > 0 then
					local boxHeight = math.clamp(math.abs(topScreen.Y - botScreen.Y), 18, 500)
					local boxWidth = math.clamp(boxHeight * 0.62, 12, 320)
					local centerX = rootScreen.X
					local centerY = (topScreen.Y + botScreen.Y) * 0.5

					if State.EspBox then
						vis.Box.Visible = true
						vis.Box.Size = UDim2.new(0, boxWidth, 0, boxHeight)
						vis.Box.Position = UDim2.new(0, centerX - boxWidth * 0.5, 0, centerY - boxHeight * 0.5)
					else
						vis.Box.Visible = false
					end

					if State.EspHp then
						local ratio = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
						vis.HpBg.Visible = true
						vis.HpBg.Size = UDim2.new(0, 5, 0, boxHeight)
						vis.HpBg.Position = UDim2.new(0, centerX - boxWidth * 0.5 - 8, 0, centerY - boxHeight * 0.5)
						vis.HpFill.Size = UDim2.new(1, 0, ratio, 0)
						vis.HpFill.Position = UDim2.new(0, 0, 1 - ratio, 0)
						vis.HpFill.BackgroundColor3 = ratio > 0.5 and Theme.Green or (ratio > 0.25 and Color3.fromRGB(255, 195, 40) or Theme.Danger)
					else
						vis.HpBg.Visible = false
					end

					if State.EspLine then
						local targetPt = Vector2.new(centerX, topScreen.Y)
						local delta = targetPt - topCenter
						local dist2d = delta.Magnitude
						if dist2d > 1 then
							vis.Line.Visible = true
							vis.Line.Size = UDim2.new(0, 1.5, 0, dist2d)
							vis.Line.Position = UDim2.new(0, (topCenter.X + targetPt.X) * 0.5, 0, (topCenter.Y + targetPt.Y) * 0.5)
							vis.Line.Rotation = math.deg(math.atan2(delta.Y, delta.X)) - 90
						else
							vis.Line.Visible = false
						end
					else
						vis.Line.Visible = false
					end
				else
					vis.Box.Visible = false
					vis.HpBg.Visible = false
					vis.Line.Visible = false
				end
			else
				DestroyEspForPlayer(plr)
			end
		end
	end

	for plr in pairs(EspVisuals) do
		if not plr.Parent then
			DestroyEspForPlayer(plr)
		end
	end
end

local function FindClosestBodyTarget()
	local cam = workspace.CurrentCamera
	if not cam then return nil end

	local _, _, myHrp = GetCharParts(LocalPlayer)
	if not myHrp then return nil end

	local screenCenter = Vector2.new(cam.ViewportSize.X * 0.5, cam.ViewportSize.Y * 0.5)
	local bestPart = nil
	local bestScore = math.huge

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			local char, hum, hrp = GetCharParts(plr)
			if char and hum and hrp and hum.Health > 0 then
				local bodyPart = GetBodyTargetPart(char)
				if bodyPart then
					local worldDist = (bodyPart.Position - myHrp.Position).Magnitude
					if worldDist <= State.AimRange then
						local visibleOk = (not State.NoWallLock) or HasClearLineOfSight(cam.CFrame.Position, bodyPart)
						if visibleOk then
							local screenPos, onScreen = cam:WorldToViewportPoint(bodyPart.Position)
							if onScreen and screenPos.Z > 0 then
								local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
								local score = screenDist + (worldDist * 0.35)
								if score < bestScore then
									bestScore = score
									bestPart = bodyPart
								end
							end
						end
					end
				end
			end
		end
	end

	return bestPart
end

local function UpdateAimbot(dt)
	if not State.AimbotEnabled then
		State.LockedTargetPart = nil
		return
	end

	local cam = workspace.CurrentCamera
	if not cam then return end

	if not IsTargetValid(State.LockedTargetPart) then
		State.LockedTargetPart = FindClosestBodyTarget()
	else
		local char = State.LockedTargetPart.Parent
		local refreshedBody = GetBodyTargetPart(char)
		if refreshedBody and IsTargetValid(refreshedBody) then
			State.LockedTargetPart = refreshedBody
		else
			State.LockedTargetPart = FindClosestBodyTarget()
		end
	end

	local targetPart = State.LockedTargetPart
	if not targetPart then return end

	local screenPos, onScreen = cam:WorldToViewportPoint(targetPart.Position)
	if not onScreen or screenPos.Z <= 0 then
		State.LockedTargetPart = FindClosestBodyTarget()
		targetPart = State.LockedTargetPart
		if not targetPart then return end
	end

	local levelFactor = math.clamp(State.AimPullLevel / 100, 0.01, 1)
	local lockAlpha = math.clamp(0.18 + (levelFactor * 0.82) * math.min(dt * 60, 1.5), 0.15, 1)
	local currentCf = cam.CFrame
	local desiredCf = CFrame.lookAt(currentCf.Position, targetPart.Position)
	cam.CFrame = (lockAlpha >= 0.98) and desiredCf or currentCf:Lerp(desiredCf, lockAlpha)
end

local Tabs = {}
local FirstTab = true

local function CreateTab(name, order)
	local btn = Instance.new("TextButton")
	btn.Name = name .. "Tab"
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.LayoutOrder = order or 1
	btn.BackgroundColor3 = FirstTab and Theme.Accent or Theme.Bg3
	btn.Text = "  " .. name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.TextColor3 = FirstTab and Color3.new(1, 1, 1) or Theme.TextDim
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.AutoButtonColor = false
	btn.ZIndex = 5
	btn.Parent = TabList
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)

	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = Theme.Accent
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Visible = FirstTab
	page.ZIndex = 4
	page.Parent = ContentArea

	local layout = Instance.new("UIListLayout", page)
	layout.Padding = UDim.new(0, 6)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	local pad = Instance.new("UIPadding", page)
	pad.PaddingRight = UDim.new(0, 4)
	pad.PaddingBottom = UDim.new(0, 8)

	table.insert(Tabs, {Name = name, Button = btn, Page = page})
	FirstTab = false

	Track(btn.MouseButton1Click:Connect(function()
		for _, t in ipairs(Tabs) do
			t.Page.Visible = false
			TweenService:Create(t.Button, TweenInfo.new(0.16), {
				BackgroundColor3 = Theme.Bg3,
				TextColor3 = Theme.TextDim
			}):Play()
		end
		page.Visible = true
		TweenService:Create(btn, TweenInfo.new(0.16), {
			BackgroundColor3 = Theme.Accent,
			TextColor3 = Color3.new(1, 1, 1)
		}):Play()
	end))

	return page
end

local HomePage = CreateTab("หน้าหลัก", 1)
local ClayPage = CreateTab("โหมดดินน้ำมัน", 2)
local AimbotPage = CreateTab("aimbot", 3)

local function AddInfoCard(parent, titleText, bodyText, order, height)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, height or 46)
	card.LayoutOrder = order or 1
	card.BackgroundColor3 = Theme.Bg3
	card.BorderSizePixel = 0
	card.ZIndex = 5
	card.Parent = parent
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 7)

	local stroke = Instance.new("UIStroke", card)
	stroke.Color = Theme.Stroke
	stroke.Thickness = 1
	stroke.Transparency = 0.72

	local tLbl = Instance.new("TextLabel")
	tLbl.Size = UDim2.new(1, -16, 0, 17)
	tLbl.Position = UDim2.new(0, 8, 0, 5)
	tLbl.BackgroundTransparency = 1
	tLbl.Text = titleText
	tLbl.Font = Enum.Font.GothamBold
	tLbl.TextSize = 11
	tLbl.TextColor3 = Theme.Accent
	tLbl.TextXAlignment = Enum.TextXAlignment.Left
	tLbl.ZIndex = 6
	tLbl.Parent = card

	local bLbl = Instance.new("TextLabel")
	bLbl.Size = UDim2.new(1, -16, 1, -22)
	bLbl.Position = UDim2.new(0, 8, 0, 20)
	bLbl.BackgroundTransparency = 1
	bLbl.Text = bodyText
	bLbl.Font = Enum.Font.GothamMedium
	bLbl.TextSize = 11
	bLbl.TextColor3 = Theme.Text
	bLbl.TextWrapped = true
	bLbl.TextXAlignment = Enum.TextXAlignment.Left
	bLbl.TextYAlignment = Enum.TextYAlignment.Top
	bLbl.ZIndex = 6
	bLbl.Parent = card
end

local function AddSwitchRow(parent, labelPrefix, initialState, order, onChange)
	local active = initialState or false

	local row = Instance.new("TextButton")
	row.Size = UDim2.new(1, 0, 0, 31)
	row.LayoutOrder = order or 1
	row.BackgroundColor3 = Theme.Bg3
	row.Text = ""
	row.AutoButtonColor = false
	row.ZIndex = 5
	row.Parent = parent
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

	local stroke = Instance.new("UIStroke", row)
	stroke.Color = Theme.Stroke
	stroke.Thickness = 1
	stroke.Transparency = 0.78

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -14, 1, 0)
	lbl.Position = UDim2.new(0, 10, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = labelPrefix .. ":" .. (active and "ON" or "OFF")
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 11
	lbl.TextColor3 = active and Theme.Accent or Theme.Text
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 6
	lbl.Parent = row

	Track(row.MouseButton1Click:Connect(function()
		active = not active
		lbl.Text = labelPrefix .. ":" .. (active and "ON" or "OFF")
		lbl.TextColor3 = active and Theme.Accent or Theme.Text
		if onChange then
			task.spawn(onChange, active)
		end
	end))
end

local function AddSeparator(parent, order)
	local line = Instance.new("Frame")
	line.Size = UDim2.new(1, 0, 0, 1)
	line.LayoutOrder = order or 1
	line.BackgroundColor3 = Theme.Stroke
	line.BackgroundTransparency = 0.6
	line.BorderSizePixel = 0
	line.ZIndex = 5
	line.Parent = parent
end

local function AddSlider(parent, titleText, minVal, maxVal, defaultVal, order, onValue)
	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(1, 0, 0, 48)
	holder.LayoutOrder = order or 1
	holder.BackgroundColor3 = Theme.Bg3
	holder.BorderSizePixel = 0
	holder.ZIndex = 6
	holder.Parent = parent
	Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 7)

	local stroke = Instance.new("UIStroke", holder)
	stroke.Color = Theme.Stroke
	stroke.Thickness = 1
	stroke.Transparency = 0.78

	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size = UDim2.new(1, -16, 0, 18)
	titleLbl.Position = UDim2.new(0, 10, 0, 4)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text = titleText .. " (" .. tostring(minVal) .. "-" .. tostring(maxVal) .. "): " .. tostring(defaultVal)
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.TextSize = 11
	titleLbl.TextColor3 = Theme.Text
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.ZIndex = 7
	titleLbl.Parent = holder

	local track = Instance.new("Frame")
	track.Size = UDim2.new(1, -20, 0, 8)
	track.Position = UDim2.new(0, 10, 0, 31)
	track.BackgroundColor3 = Theme.Bg2
	track.BorderSizePixel = 0
	track.ZIndex = 7
	track.Parent = holder
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

	local initNorm = math.clamp((defaultVal - minVal) / math.max(maxVal - minVal, 1), 0, 1)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(initNorm, 0, 1, 0)
	fill.BackgroundColor3 = Theme.Accent
	fill.BorderSizePixel = 0
	fill.ZIndex = 8
	fill.Parent = track
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 14, 0, 14)
	knob.Position = UDim2.new(initNorm, -7, 0.5, -7)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.BorderSizePixel = 0
	knob.ZIndex = 9
	knob.Parent = track
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local function ApplyAlpha(alpha)
		alpha = math.clamp(alpha, 0, 1)
		local rawVal = minVal + alpha * (maxVal - minVal)
		local val = math.clamp(math.floor(rawVal + 0.5), minVal, maxVal)
		local norm = (val - minVal) / math.max(maxVal - minVal, 1)
		fill.Size = UDim2.new(norm, 0, 1, 0)
		knob.Position = UDim2.new(norm, -7, 0.5, -7)
		titleLbl.Text = titleText .. " (" .. tostring(minVal) .. "-" .. tostring(maxVal) .. "): " .. tostring(val)
		if onValue then
			onValue(val)
		end
	end

	local sliding = false
	Track(track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			sliding = true
			local absPos = track.AbsolutePosition.X
			local absSize = math.max(track.AbsoluteSize.X, 1)
			ApplyAlpha((input.Position.X - absPos) / absSize)
		end
	end))

	Track(UserInputService.InputChanged:Connect(function(input)
		if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local absPos = track.AbsolutePosition.X
			local absSize = math.max(track.AbsoluteSize.X, 1)
			ApplyAlpha((input.Position.X - absPos) / absSize)
		end
	end))

	Track(UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			sliding = false
		end
	end))
end

AddInfoCard(HomePage, "ยินดีต้อนรับ", "ยินดีต้อนรับสู่สคริป COREX NETWORK SCRIPT HUB", 1, 44)
AddInfoCard(HomePage, "ผู้สร้าง", "CN-HUB", 2, 42)
AddInfoCard(HomePage, "แมพที่รองรับ", "สคริปนี้สร้างมาโดยแมพ URBAN RELOAD", 3, 44)
AddInfoCard(HomePage, "การทำงาน", "ฟังชั่นทั้งหมดไม่ได้โกงแต่ช่วยให้เล่นลื่นขึ้นอย่างมาก", 4, 52)

AddSwitchRow(ClayPage, "ถาพดินน้ำมัน", false, 1, function(val)
	ApplyClayMode(val)
end)

AddSwitchRow(ClayPage, "เพิ่ม fps ", false, 2, function(val)
	ApplyBoostFps(val)
end)

AddSwitchRow(ClayPage, "ถาพดินน้ำมันเพิ่มเต็ม", false, 3, function(val)
	ApplyFullClayMode(val)
end)

AddSwitchRow(AimbotPage, "AIMBOT", false, 1, function(val)
	State.AimbotEnabled = val
	if not val then
		State.LockedTargetPart = nil
	end
end)

AddSwitchRow(AimbotPage, "ESP", false, 2, function(val)
	State.EspEnabled = val
	UpdateEsp()
end)

AddSeparator(AimbotPage, 3)

local AimCfgBtn = Instance.new("TextButton")
AimCfgBtn.Size = UDim2.new(1, 0, 0, 30)
AimCfgBtn.LayoutOrder = 4
AimCfgBtn.BackgroundColor3 = Theme.Bg3
AimCfgBtn.Text = "  การตั้งค่า AIMBOT"
AimCfgBtn.Font = Enum.Font.GothamBold
AimCfgBtn.TextSize = 11
AimCfgBtn.TextColor3 = Theme.Accent
AimCfgBtn.TextXAlignment = Enum.TextXAlignment.Left
AimCfgBtn.AutoButtonColor = false
AimCfgBtn.ZIndex = 5
AimCfgBtn.Parent = AimbotPage
Instance.new("UICorner", AimCfgBtn).CornerRadius = UDim.new(0, 7)

local AimCfgBox = Instance.new("Frame")
AimCfgBox.Size = UDim2.new(1, 0, 0, 146)
AimCfgBox.LayoutOrder = 5
AimCfgBox.BackgroundColor3 = Theme.Bg2
AimCfgBox.BorderSizePixel = 0
AimCfgBox.Visible = false
AimCfgBox.ZIndex = 5
AimCfgBox.Parent = AimbotPage
Instance.new("UICorner", AimCfgBox).CornerRadius = UDim.new(0, 7)

local AimCfgLayout = Instance.new("UIListLayout", AimCfgBox)
AimCfgLayout.Padding = UDim.new(0, 4)
AimCfgLayout.SortOrder = Enum.SortOrder.LayoutOrder

local AimCfgPad = Instance.new("UIPadding", AimCfgBox)
AimCfgPad.PaddingTop = UDim.new(0, 4)
AimCfgPad.PaddingBottom = UDim.new(0, 4)
AimCfgPad.PaddingLeft = UDim.new(0, 4)
AimCfgPad.PaddingRight = UDim.new(0, 4)

Track(AimCfgBtn.MouseButton1Click:Connect(function()
	State.AimCfgOpen = not State.AimCfgOpen
	AimCfgBox.Visible = State.AimCfgOpen
end))

AddSlider(AimCfgBox, "ระดับการดูด", 1, 100, 50, 1, function(val)
	State.AimPullLevel = val
end)

AddSlider(AimCfgBox, "ระยะล็อก", 10, 1000, 250, 2, function(val)
	State.AimRange = val
end)

AddSwitchRow(AimCfgBox, "ล็อกไม่ทะลุ", true, 3, function(val)
	State.NoWallLock = val
end)

local EspCfgBtn = Instance.new("TextButton")
EspCfgBtn.Size = UDim2.new(1, 0, 0, 30)
EspCfgBtn.LayoutOrder = 6
EspCfgBtn.BackgroundColor3 = Theme.Bg3
EspCfgBtn.Text = "  การตั้งค่า ESP"
EspCfgBtn.Font = Enum.Font.GothamBold
EspCfgBtn.TextSize = 11
EspCfgBtn.TextColor3 = Theme.Accent
EspCfgBtn.TextXAlignment = Enum.TextXAlignment.Left
EspCfgBtn.AutoButtonColor = false
EspCfgBtn.ZIndex = 5
EspCfgBtn.Parent = AimbotPage
Instance.new("UICorner", EspCfgBtn).CornerRadius = UDim.new(0, 7)

local EspCfgBox = Instance.new("Frame")
EspCfgBox.Size = UDim2.new(1, 0, 0, 148)
EspCfgBox.LayoutOrder = 7
EspCfgBox.BackgroundColor3 = Theme.Bg2
EspCfgBox.BorderSizePixel = 0
EspCfgBox.Visible = false
EspCfgBox.ZIndex = 5
EspCfgBox.Parent = AimbotPage
Instance.new("UICorner", EspCfgBox).CornerRadius = UDim.new(0, 7)

local EspCfgLayout = Instance.new("UIListLayout", EspCfgBox)
EspCfgLayout.Padding = UDim.new(0, 4)
EspCfgLayout.SortOrder = Enum.SortOrder.LayoutOrder

local EspCfgPad = Instance.new("UIPadding", EspCfgBox)
EspCfgPad.PaddingTop = UDim.new(0, 4)
EspCfgPad.PaddingBottom = UDim.new(0, 4)
EspCfgPad.PaddingLeft = UDim.new(0, 4)
EspCfgPad.PaddingRight = UDim.new(0, 4)

Track(EspCfgBtn.MouseButton1Click:Connect(function()
	State.EspCfgOpen = not State.EspCfgOpen
	EspCfgBox.Visible = State.EspCfgOpen
end))

AddSwitchRow(EspCfgBox, "ESP BOX", false, 1, function(val)
	State.EspBox = val
	UpdateEsp()
end)

AddSwitchRow(EspCfgBox, "ESP เส้น", false, 2, function(val)
	State.EspLine = val
	UpdateEsp()
end)

AddSwitchRow(EspCfgBox, "ESP ขี้กาง", false, 3, function(val)
	State.EspChams = val
	UpdateEsp()
end)

AddSwitchRow(EspCfgBox, "ESP เลือด", false, 4, function(val)
	State.EspHp = val
	UpdateEsp()
end)

Track(RunService.RenderStepped:Connect(function(dt)
	UpdateAimbot(dt)
	UpdateEsp()
end))

Track(Players.PlayerRemoving:Connect(function(plr)
	DestroyEspForPlayer(plr)
end))

local function SetMinimized(minimized)
	Main.Visible = not minimized
	MiniContainer.Visible = minimized
end

Track(MinBtn.MouseButton1Click:Connect(function()
	SetMinimized(true)
end))

Track(MiniBtn.MouseButton1Click:Connect(function()
	SetMinimized(false)
end))

Track(UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.RightControl and Main.Parent then
		if MiniContainer.Visible then
			SetMinimized(false)
		else
			SetMinimized(Main.Visible)
		end
	end
end))

Track(CloseBtn.MouseButton1Click:Connect(function()
	State.LockedTargetPart = nil
	for _, conn in ipairs(Connections) do
		if conn.Connected then
			conn:Disconnect()
		end
	end
	ClearAllEsp()
	ScreenGui:Destroy()
	OverlayGui:Destroy()
end))

task.spawn(function()
	local progress = 0
	local duration = 1.2
	local conn
	conn = Track(RunService.Heartbeat:Connect(function(dt)
		if not LoadingFrame or not LoadingFrame.Parent then
			if conn.Connected then conn:Disconnect() end
			return
		end

		progress = math.clamp(progress + (dt / duration) * 100, 0, 100)
		local pct = math.floor(progress)
		BarFill.Size = UDim2.new(progress / 100, 0, 1, 0)
		PercentLabel.Text = tostring(pct) .. "%"

		if pct < 40 then
			StatusLabel.Text = "กำลังโหลด..."
		elseif pct < 80 then
			StatusLabel.Text = "เตรียมระบบ..."
		else
			StatusLabel.Text = "เสร็จสิ้น!"
		end

		if progress >= 100 then
			if conn.Connected then conn:Disconnect() end
			task.delay(0.15, function()
				if LoadingFrame and LoadingFrame.Parent then
					LoadingFrame:Destroy()
				end
				if Main and Main.Parent then
					Main.Visible = true
				end
			end)
		end
	end))
end)
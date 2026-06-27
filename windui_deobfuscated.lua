-- =============================================================================
-- [1. SOURCE: MASTER WINDOW LIBRARY WITH ALL MODERN UI ELEMENTS]
-- =============================================================================
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local PremiumLib = {}
PremiumLib.__index = PremiumLib

local COLORS = {
	Background = Color3.fromRGB(14, 14, 18),
	Secondary = Color3.fromRGB(30, 30, 38), 
	Sidebar = Color3.fromRGB(20, 20, 26),    
	Border = Color3.fromRGB(45, 45, 55),    
	Accent = Color3.fromRGB(255, 255, 255),  
	Text = Color3.fromRGB(250, 250, 255),
	TextMuted = Color3.fromRGB(130, 130, 140),
	CloseHover = Color3.fromRGB(240, 70, 70),
	ButtonBg = Color3.fromRGB(22, 22, 28),
	ToggleBg = Color3.fromRGB(18, 18, 22),
	FocusBorder = Color3.fromRGB(100, 100, 120)
}

-- Sürükleme Fonksiyonu
local function makeDraggable(frame, dragHandle)
	local dragging, dragInput, dragStart, startPos
	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	dragHandle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- Geometrik Üçgen Oluşturucu
local function createPerfectTriangle(parent, size, position, rotation)
	local triangleFrame = Instance.new("Frame")
	triangleFrame.Size = size
	triangleFrame.Position = position
	triangleFrame.BackgroundColor3 = COLORS.Secondary
	triangleFrame.BorderSizePixel = 0
	triangleFrame.ZIndex = 102
	triangleFrame.Parent = parent

	local gradient = Instance.new("UIGradient")
	gradient.Rotation = rotation
	gradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.499, 0),
		NumberSequenceKeypoint.new(0.5, 1),
		NumberSequenceKeypoint.new(1, 1)
	})
	gradient.Parent = triangleFrame
	return triangleFrame
end

function PremiumLib.CreateWindow(hubName, LoadingText, LoadingDescription)
	local self = setmetatable({}, PremiumLib)
	self.Tabs = {}
	self.ActiveTab = nil
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "PremiumHub_" .. hubName
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	
	----------------------------------------------------------------
	-- LOADING CONTAINER
	----------------------------------------------------------------
	local LoadingContainer = Instance.new("Frame")
	LoadingContainer.Size = UDim2.new(0, 500, 0, 250)
	LoadingContainer.Position = UDim2.new(0.5, -250, 0.5, -125)
	LoadingContainer.BackgroundTransparency = 1
	LoadingContainer.ZIndex = 100
	LoadingContainer.Parent = ScreenGui
	
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, 0, 0, 30)
	TitleLabel.Position = UDim2.new(0, 0, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = LoadingText:upper()
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 28
	TitleLabel.TextColor3 = COLORS.Text
	TitleLabel.ZIndex = 101
	TitleLabel.Parent = LoadingContainer
	
	local DescLabel = Instance.new("TextLabel")
	DescLabel.Size = UDim2.new(1, 0, 0, 20)
	DescLabel.Position = UDim2.new(0, 0, 0, 35)
	DescLabel.BackgroundTransparency = 1
	DescLabel.Text = LoadingDescription or "Loading..."
	DescLabel.Font = Enum.Font.Gotham
	DescLabel.TextSize = 13
	DescLabel.TextColor3 = COLORS.TextMuted
	DescLabel.ZIndex = 101
	DescLabel.Parent = LoadingContainer

	----------------------------------------------------------------
	-- GEOMETRİK MATRİS GRUBU
	----------------------------------------------------------------
	local GeometryGroup = Instance.new("Frame")
	GeometryGroup.Size = UDim2.new(0, 100, 0, 100)
	GeometryGroup.Position = UDim2.new(0.5, -50, 0, 100)
	GeometryGroup.BackgroundTransparency = 1
	GeometryGroup.ZIndex = 101
	GeometryGroup.Parent = LoadingContainer

	local triangleSize = UDim2.new(0, 100, 0, 100)
	local LeftTriangle = createPerfectTriangle(GeometryGroup, triangleSize, UDim2.new(0, -120, 0, 0), 45)
	local RightTriangle = createPerfectTriangle(GeometryGroup, triangleSize, UDim2.new(0, 120, 0, 0), -135)

	local CornerBorders = {}
	local borderConfigs = {
		{Size = UDim2.new(0, 2, 0, 0), Pos = UDim2.new(0, -2, 0, -2), Target = UDim2.new(0, 2, 0, 30)},
		{Size = UDim2.new(0, 0, 0, 2), Pos = UDim2.new(0, -2, 0, -2), Target = UDim2.new(0, 30, 0, 2)},
		{Size = UDim2.new(0, 2, 0, 0), Pos = UDim2.new(1, 0, 0, -2), Target = UDim2.new(0, 2, 0, 30)},
		{Size = UDim2.new(0, 0, 0, 2), Pos = UDim2.new(1, -30, 0, -2), Target = UDim2.new(0, 30, 0, 2)},
		{Size = UDim2.new(0, 2, 0, 0), Pos = UDim2.new(1, 0, 1, -30), Target = UDim2.new(0, 2, 0, 30)},
		{Size = UDim2.new(0, 0, 0, 2), Pos = UDim2.new(1, -30, 1, 0), Target = UDim2.new(0, 30, 0, 2)},
		{Size = UDim2.new(0, 2, 0, 0), Pos = UDim2.new(0, -2, 1, -30), Target = UDim2.new(0, 2, 0, 30)},
		{Size = UDim2.new(0, 0, 0, 2), Pos = UDim2.new(0, -2, 1, 0), Target = UDim2.new(0, 30, 0, 2)}
	}
	for i, cfg in ipairs(borderConfigs) do
		local border = Instance.new("Frame")
		border.Size = cfg.Size
		border.Position = cfg.Pos
		border.BackgroundColor3 = COLORS.Accent
		border.BorderSizePixel = 0
		border.ZIndex = 105
		border.Parent = GeometryGroup
		CornerBorders[i] = {Frame = border, TargetSize = cfg.Target}
	end

	local function createSplitBar(rotation)
		local barGroup = Instance.new("Frame")
		barGroup.Size = UDim2.new(0, 140, 0, 2)
		barGroup.Position = UDim2.new(0.5, -70, 0.5, -1)
		barGroup.BackgroundTransparency = 1
		barGroup.Rotation = rotation
		barGroup.ZIndex = 103
		barGroup.Parent = GeometryGroup

		local leftPart = Instance.new("Frame")
		leftPart.Size = UDim2.new(0, 0, 1, 0)
		leftPart.Position = UDim2.new(0.5, 0, 0, 0)
		leftPart.BackgroundColor3 = COLORS.Accent
		leftPart.BorderSizePixel = 0
		leftPart.ZIndex = 104
		leftPart.Parent = barGroup

		local rightPart = Instance.new("Frame")
		rightPart.Size = UDim2.new(0, 0, 1, 0)
		rightPart.Position = UDim2.new(0.5, 0, 0, 0)
		rightPart.BackgroundColor3 = COLORS.Accent
		rightPart.BorderSizePixel = 0
		rightPart.ZIndex = 104
		rightPart.Parent = barGroup
		
		return {Group = barGroup, Left = leftPart, Right = rightPart}
	end

	local Bar1 = createSplitBar(-45)
	local Bar2 = createSplitBar(45)

	----------------------------------------------------------------
	-- MAIN WINDOW STRUCTURE
	----------------------------------------------------------------
	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, 560, 0, 360)
	MainFrame.Position = UDim2.new(0.5, -280, 0.5, -180)
	MainFrame.BackgroundColor3 = COLORS.Background
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.BackgroundTransparency = 1
	MainFrame.Visible = false
	MainFrame.Parent = ScreenGui
	Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

	local WindowBorder = Instance.new("UIStroke")
	WindowBorder.Color = COLORS.Border
	WindowBorder.Thickness = 1.2
	WindowBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	WindowBorder.Parent = MainFrame
	
	-- Top Bar
	local TopBarFrame = Instance.new("Frame")
	TopBarFrame.Size = UDim2.new(1, 0, 0, 45)
	TopBarFrame.BackgroundTransparency = 1
	TopBarFrame.Parent = MainFrame
	makeDraggable(MainFrame, TopBarFrame)
	
	local WindowTitle = Instance.new("TextLabel")
	WindowTitle.Size = UDim2.new(1, -100, 1, 0)
	WindowTitle.Position = UDim2.new(0, 15, 0, 0)
	WindowTitle.BackgroundTransparency = 1
	WindowTitle.Text = hubName
	WindowTitle.Font = Enum.Font.GothamBold
	WindowTitle.TextSize = 16
	WindowTitle.TextColor3 = COLORS.Text
	WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
	WindowTitle.Parent = TopBarFrame

	-- Content Container
	local ContentContainer = Instance.new("Frame")
	ContentContainer.Size = UDim2.new(1, 0, 1, -45)
	ContentContainer.Position = UDim2.new(0, 0, 0, 45)
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.Parent = MainFrame

	----------------------------------------------------------------
	-- SIDEBAR & SMART SCROLL
	----------------------------------------------------------------
	local Sidebar = Instance.new("Frame")
	Sidebar.Size = UDim2.new(0, 150, 1, 0)
	Sidebar.BackgroundColor3 = COLORS.Sidebar
	Sidebar.BorderSizePixel = 0
	Sidebar.Parent = ContentContainer

	local SidebarLine = Instance.new("Frame")
	SidebarLine.Size = UDim2.new(0, 1, 1, 0)
	SidebarLine.Position = UDim2.new(1, -1, 0, 0)
	SidebarLine.BackgroundColor3 = COLORS.Border
	SidebarLine.BorderSizePixel = 0
	SidebarLine.Parent = Sidebar

	local TabButtonList = Instance.new("ScrollingFrame")
	TabButtonList.Size = UDim2.new(1, -5, 1, -10)
	TabButtonList.Position = UDim2.new(0, 0, 0, 5)
	TabButtonList.BackgroundTransparency = 1
	TabButtonList.BorderSizePixel = 0
	TabButtonList.ScrollBarThickness = 2
	TabButtonList.ScrollBarImageColor3 = COLORS.Border
	TabButtonList.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabButtonList.ScrollingDirection = Enum.ScrollingDirection.Y
	TabButtonList.Parent = Sidebar

	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.Padding = UDim.new(0, 5)
	TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabListLayout.Parent = TabButtonList

	TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		local contentHeight = TabListLayout.AbsoluteContentSize.Y
		TabButtonList.CanvasSize = UDim2.new(0, 0, 0, contentHeight + 10)
		if contentHeight <= TabButtonList.AbsoluteSize.Y then
			TabButtonList.ScrollBarThickness = 0
		else
			TabButtonList.ScrollBarThickness = 2
		end
	end)

	-- Sağ İçerik Sayfaları Alanı
	local TabPagesContainer = Instance.new("Frame")
	TabPagesContainer.Size = UDim2.new(1, -150, 1, 0)
	TabPagesContainer.Position = UDim2.new(0, 150, 0, 0)
	TabPagesContainer.BackgroundTransparency = 1
	TabPagesContainer.Parent = ContentContainer

	----------------------------------------------------------------
	-- WINDOW CONTROLS
	----------------------------------------------------------------
	local ButtonContainer = Instance.new("Frame")
	ButtonContainer.Size = UDim2.new(0, 70, 1, 0)
	ButtonContainer.Position = UDim2.new(1, -75, 0, 0)
	ButtonContainer.BackgroundTransparency = 1
	ButtonContainer.Parent = TopBarFrame

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = ButtonContainer

	local function createTopButton(text, layoutOrder)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 26, 0, 26)
		btn.BackgroundTransparency = 1
		btn.Text = text
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 14
		btn.TextColor3 = COLORS.TextMuted
		btn.LayoutOrder = layoutOrder
		btn.AutoButtonColor = false
		btn.Parent = ButtonContainer
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
		return btn
	end

	local MinimizeBtn = createTopButton("-", 1)
	local CloseBtn = createTopButton("×", 2)
	CloseBtn.TextSize = 18

	CloseBtn.MouseEnter:Connect(function()
		TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8, BackgroundColor3 = COLORS.CloseHover, TextColor3 = COLORS.Accent}):Play()
	end)
	CloseBtn.MouseLeave:Connect(function()
		TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = COLORS.TextMuted}):Play()
	end)

	MinimizeBtn.MouseEnter:Connect(function()
		TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8, BackgroundColor3 = COLORS.Secondary, TextColor3 = COLORS.Accent}):Play()
	end)
	MinimizeBtn.MouseLeave:Connect(function()
		TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = COLORS.TextMuted}):Play()
	end)

	CloseBtn.MouseButton1Click:Connect(function()
		local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 500, 0, 0), BackgroundTransparency = 1})
		closeTween:Play()
		closeTween.Completed:Connect(function() ScreenGui:Destroy() end)
	end)

	local isMinimized = false
	MinimizeBtn.MouseButton1Click:Connect(function()
		isMinimized = not isMinimized
		if isMinimized then
			ContentContainer.Visible = false
			TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 560, 0, 45)}):Play()
		else
			TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 560, 0, 360)}):Play()
			task.wait(0.2)
			ContentContainer.Visible = true
		end
	end)

	----------------------------------------------------------------
	-- TAB ENGINE & COMPONENT CREATORS
	----------------------------------------------------------------
	function self:CreateTab(tabName)
		local tabData = {}
		
		-- Sol Sekme Butonu
		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(0, 135, 0, 34)
		TabButton.BackgroundTransparency = 1
		TabButton.Text = "   " .. tabName
		TabButton.Font = Enum.Font.GothamMedium
		TabButton.TextSize = 13
		TabButton.TextColor3 = COLORS.TextMuted
		TabButton.TextXAlignment = Enum.TextXAlignment.Left
		TabButton.AutoButtonColor = false
		TabButton.Parent = TabButtonList
		Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 6)

		local Indicator = Instance.new("Frame")
		Indicator.Size = UDim2.new(0, 3, 0, 0)
		Indicator.Position = UDim2.new(0, 0, 0.5, 0)
		Indicator.BackgroundColor3 = COLORS.Accent
		Indicator.BorderSizePixel = 0
		Indicator.Parent = TabButton

		-- Sağ Sayfa Alanı
		local Page = Instance.new("ScrollingFrame")
		Page.Size = UDim2.new(1, -20, 1, -20)
		Page.Position = UDim2.new(0, 10, 0, 10)
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.ScrollBarThickness = 3
		Page.ScrollBarImageColor3 = COLORS.Border
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.ScrollingDirection = Enum.ScrollingDirection.Y
		Page.Visible = false
		Page.Parent = TabPagesContainer

		local PageLayout = Instance.new("UIListLayout")
		PageLayout.Padding = UDim.new(0, 6)
		PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		PageLayout.Parent = Page

		PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			local pageHeight = PageLayout.AbsoluteContentSize.Y
			Page.CanvasSize = UDim2.new(0, 0, 0, pageHeight + 10)
			if pageHeight <= Page.AbsoluteSize.Y then
				Page.ScrollBarThickness = 0
			else
				Page.ScrollBarThickness = 3
			end
		end)

		tabData.Button = TabButton
		tabData.Page = Page
		tabData.Indicator = Indicator

		local function selectThisTab()
			if self.ActiveTab == tabData then return end
			if self.ActiveTab then
				local prev = self.ActiveTab
				TweenService:Create(prev.Button, TweenInfo.new(0.2), {TextColor3 = COLORS.TextMuted, BackgroundTransparency = 1}):Play()
				TweenService:Create(prev.Indicator, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 0), Position = UDim2.new(0, 0, 0.5, 0)}):Play()
				local fadeOut = TweenService:Create(prev.Page, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 10, 0, 20)})
				fadeOut:Play()
				fadeOut.Completed:Connect(function() prev.Page.Visible = false end)
			end

			self.ActiveTab = tabData
			TabButton.BackgroundTransparency = 0.92
			TabButton.BackgroundColor3 = COLORS.Accent
			TweenService:Create(TabButton, TweenInfo.new(0.25), {TextColor3 = COLORS.Text}):Play()
			TweenService:Create(Indicator, TweenInfo.new(0.25, Enum.EasingStyle.Back), {Size = UDim2.new(0, 3, 0, 18), Position = UDim2.new(0, 0, 0.5, -9)}):Play()
			
			Page.Position = UDim2.new(0, 10, 0, 0)
			Page.Visible = true
			TweenService:Create(Page, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Position = UDim2.new(0, 10, 0, 10)}):Play()
		end

		TabButton.MouseButton1Click:Connect(selectThisTab)

		if #self.Tabs == 0 then
			task.spawn(function()
				repeat task.wait() until MainFrame.Visible == true
				selectThisTab()
			end)
		end

		table.insert(self.Tabs, tabData)
		
		------------------------------------------------------------
		-- ELEMENT 1: BORDERLI BUTTON
		------------------------------------------------------------
		function tabData:CreateButton(btnText, callback)
			local Button = Instance.new("TextButton")
			Button.Size = UDim2.new(1, -10, 0, 38)
			Button.BackgroundColor3 = COLORS.ButtonBg
			Button.BorderSizePixel = 0
			Button.Text = btnText
			Button.Font = Enum.Font.GothamMedium
			Button.TextSize = 14
			Button.TextColor3 = COLORS.Text
			Button.AutoButtonColor = false
			Button.Parent = Page
			
			Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
			
			local BtnBorder = Instance.new("UIStroke")
			BtnBorder.Color = COLORS.Border
			BtnBorder.Thickness = 1
			BtnBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			BtnBorder.Parent = Button

			Button.MouseEnter:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.Secondary}):Play()
				TweenService:Create(BtnBorder, TweenInfo.new(0.2), {Color = Color3.fromRGB(80, 80, 95)}):Play()
			end)
			Button.MouseLeave:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.ButtonBg}):Play()
				TweenService:Create(BtnBorder, TweenInfo.new(0.2), {Color = COLORS.Border}):Play()
			end)
			Button.MouseButton1Down:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.05), {Size = UDim2.new(1, -16, 0, 36)}):Play()
			end)
			Button.MouseButton1Up:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(1, -10, 0, 38)}):Play()
				if callback then callback() end
			end)
			
			return Button
		end

		------------------------------------------------------------
		-- ELEMENT 2: ANIMATED TOGGLE
		------------------------------------------------------------
		function tabData:CreateToggle(toggleText, defaultState, callback)
			local toggleData = {State = defaultState or false}
			
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Size = UDim2.new(1, -10, 0, 42)
			ToggleFrame.BackgroundColor3 = COLORS.ButtonBg
			ToggleFrame.BorderSizePixel = 0
			ToggleFrame.Parent = Page
			Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 8)

			local ToggleBorder = Instance.new("UIStroke")
			ToggleBorder.Color = COLORS.Border
			ToggleBorder.Thickness = 1
			ToggleBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			ToggleBorder.Parent = ToggleFrame

			local ToggleLabel = Instance.new("TextLabel")
			ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
			ToggleLabel.Position = UDim2.new(0, 14, 0, 0)
			ToggleLabel.BackgroundTransparency = 1
			ToggleLabel.Text = toggleText
			ToggleLabel.Font = Enum.Font.GothamMedium
			ToggleLabel.TextSize = 14
			ToggleLabel.TextColor3 = COLORS.Text
			ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			ToggleLabel.Parent = ToggleFrame

			local SwitchTrack = Instance.new("TextButton")
			SwitchTrack.Size = UDim2.new(0, 38, 0, 20)
			SwitchTrack.Position = UDim2.new(1, -52, 0.5, -10)
			SwitchTrack.BackgroundColor3 = COLORS.ToggleBg
			SwitchTrack.BorderSizePixel = 0
			SwitchTrack.Text = ""
			SwitchTrack.AutoButtonColor = false
			SwitchTrack.Parent = ToggleFrame
			Instance.new("UICorner", SwitchTrack).CornerRadius = UDim.new(1, 0)

			local TrackBorder = Instance.new("UIStroke")
			TrackBorder.Color = COLORS.Border
			TrackBorder.Thickness = 1
			TrackBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			TrackBorder.Parent = SwitchTrack

			local Circle = Instance.new("Frame")
			Circle.Size = UDim2.new(0, 14, 0, 14)
			Circle.Position = toggleData.State and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
			Circle.BackgroundColor3 = toggleData.State and COLORS.Background or COLORS.TextMuted
			Circle.BorderSizePixel = 0
			Circle.Parent = SwitchTrack
			Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

			if toggleData.State then
				SwitchTrack.BackgroundColor3 = COLORS.Accent
				TrackBorder.Color = COLORS.Accent
			end

			local function updateToggle()
				local targetPos = toggleData.State and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
				local targetTrackColor = toggleData.State and COLORS.Accent or COLORS.ToggleBg
				local targetCircleColor = toggleData.State and COLORS.Background or COLORS.TextMuted
				local targetBorderColor = toggleData.State and COLORS.Accent or COLORS.Border

				TweenService:Create(Circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetPos, BackgroundColor3 = targetCircleColor}):Play()
				TweenService:Create(SwitchTrack, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = targetTrackColor}):Play()
				TweenService:Create(TrackBorder, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Color = targetBorderColor}):Play()
				if callback then callback(toggleData.State) end
			end

			SwitchTrack.MouseButton1Click:Connect(function()
				toggleData.State = not toggleData.State
				updateToggle()
			end)
			
			ToggleFrame.MouseEnter:Connect(function() TweenService:Create(ToggleBorder, TweenInfo.new(0.2), {Color = Color3.fromRGB(80, 80, 95)}):Play() end)
			ToggleFrame.MouseLeave:Connect(function() TweenService:Create(ToggleBorder, TweenInfo.new(0.2), {Color = COLORS.Border}):Play() end)

			return toggleData
		end

		------------------------------------------------------------
		-- ELEMENT 3: TEXTBOX (GİRİŞ ALANI)
		------------------------------------------------------------
		function tabData:CreateTextBox(placeholder, callback)
			local TextBoxFrame = Instance.new("Frame")
			TextBoxFrame.Size = UDim2.new(1, -10, 0, 42)
			TextBoxFrame.BackgroundColor3 = COLORS.ButtonBg
			TextBoxFrame.BorderSizePixel = 0
			TextBoxFrame.Parent = Page
			Instance.new("UICorner", TextBoxFrame).CornerRadius = UDim.new(0, 8)

			local TBBorder = Instance.new("UIStroke")
			TBBorder.Color = COLORS.Border
			TBBorder.Thickness = 1
			TBBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			TBBorder.Parent = TextBoxFrame

			local ActualTextBox = Instance.new("TextBox")
			ActualTextBox.Size = UDim2.new(1, -20, 1, 0)
			ActualTextBox.Position = UDim2.new(0, 10, 0, 0)
			ActualTextBox.BackgroundTransparency = 1
			ActualTextBox.Font = Enum.Font.GothamMedium
			ActualTextBox.TextSize = 13
			ActualTextBox.TextColor3 = COLORS.Text
			ActualTextBox.PlaceholderText = placeholder or "Enter text..."
			ActualTextBox.PlaceholderColor3 = COLORS.TextMuted
			ActualTextBox.TextXAlignment = Enum.TextXAlignment.Left
			ActualTextBox.ClearTextOnFocus = false
			ActualTextBox.Parent = TextBoxFrame

			-- TextBox Özel Odaklanma Efektleri
			ActualTextBox.Focused:Connect(function()
				TweenService:Create(TBBorder, TweenInfo.new(0.25), {Color = COLORS.FocusBorder, Thickness = 1.2}):Play()
			end)
			ActualTextBox.FocusLost:Connect(function(enterPressed)
				TweenService:Create(TBBorder, TweenInfo.new(0.25), {Color = COLORS.Border, Thickness = 1}):Play()
				if enterPressed and callback then
					callback(ActualTextBox.Text)
				end
			end)

			return TextBoxFrame
		end

		------------------------------------------------------------
		-- ELEMENT 4: PARAGRAPH (BİLGİLENDİRME METNİ)
		------------------------------------------------------------
		function tabData:CreateParagraph(title, content)
			local ParagraphFrame = Instance.new("Frame")
			ParagraphFrame.Size = UDim2.new(1, -10, 0, 60) -- Otomatik boyutlandırma altta ayarlandı
			ParagraphFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24) -- Hafif daha koyu estetik
			ParagraphFrame.BorderSizePixel = 0
			ParagraphFrame.Parent = Page
			Instance.new("UICorner", ParagraphFrame).CornerRadius = UDim.new(0, 8)

			local PBorder = Instance.new("UIStroke")
			PBorder.Color = COLORS.Border
			PBorder.Thickness = 0.8
			PBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			PBorder.Parent = ParagraphFrame

			local PTitle = Instance.new("TextLabel")
			PTitle.Size = UDim2.new(1, -20, 0, 22)
			PTitle.Position = UDim2.new(0, 12, 0, 6)
			PTitle.BackgroundTransparency = 1
			PTitle.Text = title
			PTitle.Font = Enum.Font.GothamBold
			PTitle.TextSize = 13
			PTitle.TextColor3 = COLORS.Text
			PTitle.TextXAlignment = Enum.TextXAlignment.Left
			PTitle.Parent = ParagraphFrame

			local PContent = Instance.new("TextLabel")
			PContent.Size = UDim2.new(1, -24, 0, 0)
			PContent.Position = UDim2.new(0, 12, 0, 26)
			PContent.BackgroundTransparency = 1
			PContent.Text = content
			PContent.Font = Enum.Font.Gotham
			PContent.TextSize = 12
			PContent.TextColor3 = COLORS.TextMuted
			PContent.TextXAlignment = Enum.TextXAlignment.Left
			PContent.TextYAlignment = Enum.TextYAlignment.Top
			PContent.TextWrapped = true
			PContent.Parent = ParagraphFrame

			-- Metin uzunluğuna göre kutunun boyunu otomatik uzatır
			local function dynamicResize()
				local textHeight = PContent.TextBounds.Y
				PContent.Size = UDim2.new(1, -24, 0, textHeight)
				ParagraphFrame.Size = UDim2.new(1, -10, 0, textHeight + 36)
			end
			
			task.spawn(dynamicResize)
			PContent:GetPropertyChangedSignal("Text"):Connect(dynamicResize)

			return ParagraphFrame
		end

		return tabData
	end

	----------------------------------------------------------------
	-- INTRO ANIMATION DISPATCHER
	----------------------------------------------------------------
	task.spawn(function()
		local tweenInfoQuick = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local tweenInfoSlow = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tweenInfoCorner = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

		TweenService:Create(LeftTriangle, tweenInfoQuick, {Position = UDim2.new(0, 0, 0, 0)}):Play()
		TweenService:Create(RightTriangle, tweenInfoQuick, {Position = UDim2.new(0, 0, 0, 0)}):Play()
		task.wait(0.8)
		
		for i = 1, #CornerBorders do
			TweenService:Create(CornerBorders[i].Frame, tweenInfoCorner, {Size = CornerBorders[i].TargetSize}):Play()
			task.wait(0.15)
		end
		task.wait(0.2)
		
		TweenService:Create(Bar1.Left, tweenInfoSlow, {Size = UDim2.new(0.5, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}):Play()
		TweenService:Create(Bar1.Right, tweenInfoSlow, {Size = UDim2.new(0.5, 0, 1, 0), Position = UDim2.new(0.5, 0, 0, 0)}):Play()
		task.wait(0.6)
		
		TweenService:Create(Bar2.Left, tweenInfoSlow, {Size = UDim2.new(0.5, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}):Play()
		TweenService:Create(Bar2.Right, tweenInfoSlow, {Size = UDim2.new(0.5, 0, 1, 0), Position = UDim2.new(0.5, 0, 0, 0)}):Play()
		task.wait(1.0)

		local splitTweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
		TweenService:Create(Bar1.Left, splitTweenInfo, {Position = UDim2.new(-0.2, 0, 0, 0), BackgroundTransparency = 1}):Play()
		TweenService:Create(Bar1.Right, splitTweenInfo, {Position = UDim2.new(0.7, 0, 0, 0), BackgroundTransparency = 1}):Play()
		TweenService:Create(Bar2.Left, splitTweenInfo, {Position = UDim2.new(-0.2, 0, 0, 0), BackgroundTransparency = 1}):Play()
		TweenService:Create(Bar2.Right, splitTweenInfo, {Position = UDim2.new(0.7, 0, 0, 0), BackgroundTransparency = 1}):Play()
		task.wait(0.6)

		local spinInfo = TweenInfo.new(0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		TweenService:Create(GeometryGroup, spinInfo, {Rotation = 45}):Play()
		task.wait(1.0)
		
		local fadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad)
		TweenService:Create(TitleLabel, fadeInfo, {TextTransparency = 1}):Play()
		TweenService:Create(DescLabel, fadeInfo, {TextTransparency = 1}):Play()
		TweenService:Create(LeftTriangle, fadeInfo, {BackgroundTransparency = 1}):Play()
		TweenService:Create(RightTriangle, fadeInfo, {BackgroundTransparency = 1}):Play()
		for _, border in ipairs(CornerBorders) do TweenService:Create(border.Frame, fadeInfo, {BackgroundTransparency = 1}):Play() end
		task.wait(0.4)
		LoadingContainer.Visible = false
		
		MainFrame.Visible = true
		MainFrame.Size = UDim2.new(0, 530, 0, 330)
		MainFrame.Position = UDim2.new(0.5, -265, 0.5, -165)
		
		TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 560, 0, 360),
			Position = UDim2.new(0.5, -280, 0.5, -180),
			BackgroundTransparency = 0
		}):Play()
	end)

	return self
end


return PremiumLib
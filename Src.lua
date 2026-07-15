local lib = {
	Default = {},
	Themes = {
		Dark = {
			Background1 = Color3.fromRGB(48, 48, 48),
			Background2 = Color3.fromRGB(64, 64, 64),
			Background3 = Color3.fromRGB(82, 82, 82),
			Background4 = Color3.fromRGB(24, 24, 24),
			Background5 = Color3.fromRGB(102, 102, 102),
			Stroke1 = Color3.fromRGB(82, 82, 82),
			Stroke2 = Color3.fromRGB(102, 102, 102),
			Stroke3 = Color3.fromRGB(64, 64, 64),
			TextOff = Color3.fromRGB(202, 202, 202),
			TextOn = Color3.fromRGB(255, 255, 255),
			CornerRadius = UDim.new(0, 6)
		}
	},
	Theme = nil
}

lib.Theme = lib.Themes.Dark
local uis = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local defaultTween = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local fastTween = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function lib:tween(object, goal, callback, info)
	local tween = TweenService:Create(object, info or defaultTween, goal)
	if callback then tween.Completed:Connect(callback) end
	tween:Play()
	return tween
end

local function MakeDraggable(frame)
    if not frame then return end
    
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)
end

function lib:new(name: string, draggable: boolean, keybind: Enum.KeyCode?, theme: string?)
	local GUI = {}
	GUI.Tabs = {}
	
	theme = theme or "Dark"
	self.Theme = self.Themes[theme] or self.Themes.Dark

	local Preview = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Topbar = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
	local UIPadding = Instance.new("UIPadding")
	local Search = Instance.new("TextBox")
	local Close = Instance.new("ImageButton")
	local Exit = Instance.new("ImageButton")
	local Line = Instance.new("Frame")
	local Navigation = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local Line_2 = Instance.new("Frame")
	local ButtonHolder = Instance.new("ScrollingFrame")
	local UIPadding_2 = Instance.new("UIPadding")
	local UIListLayout = Instance.new("UIListLayout")
	local TabHolder = Instance.new("Frame")
	local Tabs = Instance.new("Folder")
	local Label = Instance.new("TextButton")
	local UIPadding_5 = Instance.new("UIPadding")
	local UICorner_6 = Instance.new("UICorner")
	local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
	local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
	local Toggle = Instance.new("TextButton")
	local UIPadding_6 = Instance.new("UIPadding")
	local UICorner_7 = Instance.new("UICorner")
	local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
	local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
	local CheckMark = Instance.new("Frame")
	local UICorner_8 = Instance.new("UICorner")
	local Icon_3 = Instance.new("ImageLabel")
	local Dropdown = Instance.new("Frame")
	local UICorner_9 = Instance.new("UICorner")
	local Text = Instance.new("TextLabel")
	local UIPadding_7 = Instance.new("UIPadding")
	local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
	local Icon_4 = Instance.new("ImageLabel")
	local Items = Instance.new("ScrollingFrame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local UIPadding_8 = Instance.new("UIPadding")
	local Option = Instance.new("TextButton")
	local UICorner_10 = Instance.new("UICorner")
	local UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
	local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")
	local Icon_5 = Instance.new("ImageLabel")
	local UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint")
	local Slider = Instance.new("Frame")
	local UICorner_11 = Instance.new("UICorner")
	local Text_2 = Instance.new("TextLabel")
	local UIPadding_9 = Instance.new("UIPadding")
	local UITextSizeConstraint_8 = Instance.new("UITextSizeConstraint")
	local Value = Instance.new("TextLabel")
	local UIPadding_10 = Instance.new("UIPadding")
	local UITextSizeConstraint_9 = Instance.new("UITextSizeConstraint")
	local Sliderback = Instance.new("Frame")
	local UICorner_12 = Instance.new("UICorner")
	local Draggable = Instance.new("Frame")
	local UICorner_13 = Instance.new("UICorner")
	local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint")
	
	local UIStroke = Instance.new("UIStroke")
	
	
	-- Main
	do
		Preview.Name = "Preview"
		Preview.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
		Preview.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		Preview.ResetOnSpawn = false

		Main.Name = "Main"
		Main.Parent = Preview
		Main.AnchorPoint = Vector2.new(0.5, 0.5)
		Main.BackgroundColor3 = self.Theme.Background1
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 0
		Main.Position = UDim2.new(0.5, 0, 0.5, 0)
		Main.Size = UDim2.new(0.427655011, 0, 0.4540295, 0)

		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = Main
		
		UIStroke.Parent = Main
		UIStroke.Color = self.Theme.Stroke1
		UIStroke.Thickness = 3.000
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

		Topbar.Name = "Topbar"
		Topbar.Parent = Main
		Topbar.BackgroundColor3 = self.Theme.Background2
		Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Topbar.BorderSizePixel = 0
		Topbar.Size = UDim2.new(1, 0, 0.137500003, 0)

		UICorner_2.CornerRadius = UDim.new(0, 6)
		UICorner_2.Parent = Topbar

		Title.Name = "Title"
		Title.Parent = Topbar
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Size = UDim2.new(0.333333343, 0, 0.854545474, 0)
		Title.Font = Enum.Font.Ubuntu
		Title.Text = name;
		Title.TextColor3 = self.Theme.TextOn
		Title.TextScaled = true
		Title.TextSize = 14.000
		Title.TextWrapped = true
		Title.TextXAlignment = Enum.TextXAlignment.Left

		UITextSizeConstraint.Parent = Title
		UITextSizeConstraint.MaxTextSize = 14

		UIPadding.Parent = Title
		UIPadding.PaddingLeft = UDim.new(0, 26)

		Search.Name = "Search"
		Search.Parent = Topbar
		Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Search.BackgroundTransparency = 1.000
		Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Search.BorderSizePixel = 0
		Search.Position = UDim2.new(0.333333343, 0, 0, 0)
		Search.Size = UDim2.new(0.333333343, 0, 0.909090936, 0)
		Search.Font = Enum.Font.SourceSans
		Search.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
		Search.PlaceholderText = "Search Here"
		Search.Text = ""
		Search.TextColor3 = Color3.fromRGB(0, 0, 0)
		Search.TextSize = 14.000

		Close.Name = "Close"
		Close.Parent = Topbar
		Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Close.BackgroundTransparency = 1.000
		Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Close.BorderSizePixel = 0
		Close.Position = UDim2.new(0.681666672, 0, 0.127272725, 0)
		Close.Size = UDim2.new(0.0666666701, 0, 0.727272749, 0)
		Close.Image = "rbxassetid://10734896206"
		Close.ImageColor3 = Color3.fromRGB(140, 140, 140)

		Close.MouseButton1Click:Connect(function()
			Preview:Destory
		end)

		Exit.Name = "Exit"
		Exit.Parent = Topbar
		Exit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Exit.BackgroundTransparency = 1.000
		Exit.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Exit.BorderSizePixel = 0
		Exit.Position = UDim2.new(0.796666682, 0, 0.127272725, 0)
		Exit.Size = UDim2.new(0.0666666701, 0, 0.727272749, 0)
		Exit.Image = "rbxassetid://10747384394"
		Exit.ImageColor3 = Color3.fromRGB(140, 140, 140)

		Line.Name = "Line"
		Line.Parent = Topbar
		Line.AnchorPoint = Vector2.new(0, 1)
		Line.BackgroundColor3 = self.Theme.Background3
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, 0, 1, 0)
		Line.Size = UDim2.new(1, 0, 0, 1)

		if draggable then
			MakeDraggable(Main)
		end

		if keybind then
        	uis.InputBegan:Connect(function(input, gameProcessed)
            	if gameProcessed then return end

            	if input.KeyCode == keybind then
               		Main.Visible = not Main.Visible
            	end
        	end)
    	end

		
	end
	
	do
		Navigation.Name = "Navigation"
		Navigation.Parent = Main
		Navigation.BackgroundColor3 = self.Theme.Background2
		Navigation.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Navigation.BorderSizePixel = 0
		Navigation.Position = UDim2.new(0, 0, 0.140000001, 0)
		Navigation.Size = UDim2.new(0.216666669, 0, 0.860000014, 0)

		UICorner_3.CornerRadius = UDim.new(0, 0)
		UICorner_3.Parent = Navigation

		Line_2.Name = "Line"
		Line_2.Parent = Navigation
		Line_2.AnchorPoint = Vector2.new(1, 0)
		Line_2.BackgroundColor3 = self.Theme.Background3
		Line_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line_2.BorderSizePixel = 0
		Line_2.Position = UDim2.new(1, 0, 0, 0)
		Line_2.Size = UDim2.new(0, 1, 1, 0)

		ButtonHolder.Name = "ButtonHolder"
		ButtonHolder.Parent = Navigation
		ButtonHolder.Active = true
		ButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonHolder.BackgroundTransparency = 1.000
		ButtonHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonHolder.BorderSizePixel = 0
		ButtonHolder.Size = UDim2.new(0.992307663, 0, 1, 0)
		ButtonHolder.ScrollBarThickness = 0

		UIPadding_2.Parent = ButtonHolder
		UIPadding_2.PaddingBottom = UDim.new(0, 12)
		UIPadding_2.PaddingLeft = UDim.new(0, 12)
		UIPadding_2.PaddingRight = UDim.new(0, 12)
		UIPadding_2.PaddingTop = UDim.new(0, 12)

		UIListLayout.Parent = ButtonHolder
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 12)
	end
	

	TabHolder.Name = "TabHolder"
	TabHolder.Parent = Main
	TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabHolder.BackgroundTransparency = 1.000
	TabHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabHolder.BorderSizePixel = 0
	TabHolder.Position = UDim2.new(0.218333334, 0, 0.140000001, 0)
	TabHolder.Size = UDim2.new(0.783333361, 0, 0.860000014, 0)

	Tabs.Name = "Tabs"
	Tabs.Parent = TabHolder
	
	function GUI:CreateTab(text: string)
		if not text or typeof(text) ~= "string" then
			text = "Tab"
		end

		local Tab = {
			Hover = false,
			Active = false,
			Button = nil,
			Frame = nil
		}

		local Button = Instance.new("TextButton")
		Button.Name = "Tab_" .. text:gsub("%s+", "_")
		Button.Parent = ButtonHolder
		Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundTransparency = 0.900
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(1, 0, 0.0436046496, 0)
		Button.Font = Enum.Font.Ubuntu
		Button.Text = text
		Button.TextColor3 = lib.Theme.TextOff
		Button.TextScaled = true
		Button.TextWrapped = true

		Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

		local Icon = Instance.new("ImageLabel")
		Icon.Name = "Icon"
		Icon.Parent = Button
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundTransparency = 1
		Icon.Position = UDim2.new(0.038, 0, 0.5, 0)
		Icon.Size = UDim2.new(0.171, 0, 0.622, 0)
		Icon.Image = "rbxassetid://10723407389"
		Icon.ImageColor3 = Color3.fromRGB(140, 140, 140)

		Instance.new("UITextSizeConstraint", Button).MaxTextSize = 14

		local Aspect = Instance.new("UIAspectRatioConstraint", Button)
		Aspect.AspectRatio = 3.627
		Aspect.AspectType = Enum.AspectType.ScaleWithParentSize

		local TabFrame = Instance.new("ScrollingFrame")
		TabFrame.Name = "Tab_" .. text:gsub("%s+", "_")
		TabFrame.Parent = Tabs
		TabFrame.Active = true
		TabFrame.BackgroundTransparency = 1
		TabFrame.Size = UDim2.new(1, 0, 1, 0)
		TabFrame.CanvasPosition = Vector2.new(0, 0)
		TabFrame.ScrollBarThickness = 0
		TabFrame.Visible = false

		local Padding = Instance.new("UIPadding", TabFrame)
		Padding.PaddingTop = UDim.new(0, 12)
		Padding.PaddingBottom = UDim.new(0, 12)
		Padding.PaddingLeft = UDim.new(0, 12)
		Padding.PaddingRight = UDim.new(0, 12)

		local ListLayout = Instance.new("UIListLayout", TabFrame)
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Padding = UDim.new(0, 12)

		Tab.Button = Button
		Tab.Frame = TabFrame

		local function Activate()
			for _, v in ipairs(Tabs:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end

			for _, v in ipairs(ButtonHolder:GetChildren()) do
				if v:IsA("TextButton") then
					lib:tween(v, {TextColor3 = lib.Theme.TextOff})
					local icon = v:FindFirstChild("Icon")
					if icon then
						lib:tween(icon, {ImageColor3 = Color3.fromRGB(140, 140, 140)})
					end
				end
			end

			TabFrame.Visible = true
			Tab.Active = true
			lib:tween(Button, {TextColor3 = lib.Theme.TextOn})
			lib:tween(Icon, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
		end

		Button.MouseEnter:Connect(function()
			Tab.Hover = true
			if not Tab.Active then
				lib:tween(Button, {TextColor3 = lib.Theme.TextOn})
				lib:tween(Icon, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
			end
		end)

		Button.MouseLeave:Connect(function()
			Tab.Hover = false
			if not Tab.Active then
				lib:tween(Button, {TextColor3 = lib.Theme.TextOff})
				lib:tween(Icon, {ImageColor3 = Color3.fromRGB(140, 140, 140)})
			end
		end)

		Button.MouseButton1Click:Connect(Activate)

		if #ButtonHolder:GetChildren() == 1 then
			Activate()
		end
		
		function Tab:Button(text, callback)
			local ButtonData = {
				Hover = false,
				Mousedown = false,
				Button = nil
			}

			local Button = Instance.new("TextButton")
			Button.Name = "Button"
			Button.Parent = self.Frame
			Button.BackgroundColor3 = lib.Theme.Background4
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(1, 0, 0, 45)
			Button.Font = Enum.Font.Ubuntu
			Button.Text = text
			Button.TextColor3 = Color3.fromRGB(202, 202, 202)
			Button.TextScaled = true
			Button.TextSize = 14
			Button.TextWrapped = true
			Button.TextXAlignment = Enum.TextXAlignment.Left

			Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

			local Padding = Instance.new("UIPadding", Button)
			Padding.PaddingLeft = UDim.new(0, 12)

			Instance.new("UITextSizeConstraint", Button).MaxTextSize = 14

			local Aspect = Instance.new("UIAspectRatioConstraint", Button)
			Aspect.AspectRatio = 9.911
			Aspect.AspectType = Enum.AspectType.ScaleWithParentSize

			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.Parent = Button
			Icon.AnchorPoint = Vector2.new(1, 0.5)
			Icon.BackgroundTransparency = 1
			Icon.Position = UDim2.new(0.973, 0, 0.5, 0)
			Icon.Size = UDim2.new(0.0448, 0, 0.4444, 0)
			Icon.Image = "rbxassetid://10734898476"
			Icon.ImageColor3 = Color3.fromRGB(140, 140, 140)

			local Stroke = Instance.new("UIStroke", Button)
			Stroke.Color = lib.Theme.Stroke3
			Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			ButtonData.Button = Button

			Button.MouseEnter:Connect(function()
				ButtonData.Hover = true
				lib:tween(Button, {BackgroundColor3 = lib.Theme.Background2})
				lib:tween(Icon, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				lib:tween(Stroke, {Color = lib.Theme.Stroke1})
			end)

			Button.MouseLeave:Connect(function()
				ButtonData.Hover = false
				if not ButtonData.Mousedown then
					lib:tween(Button, {BackgroundColor3 = lib.Theme.Background4})
					lib:tween(Icon, {ImageColor3 = Color3.fromRGB(140, 140, 140)})
					lib:tween(Stroke, {Color = lib.Theme.Stroke3})
				end
			end)

			Button.MouseButton1Down:Connect(function()
				ButtonData.Mousedown = true
				lib:tween(Button, {BackgroundColor3 = lib.Theme.Background1})
			end)

			Button.MouseButton1Up:Connect(function()
				ButtonData.Mousedown = false
				lib:tween(Button, {BackgroundColor3 = lib.Theme.Background2})
			end)

			Button.MouseButton1Click:Connect(function()
				if callback then
					callback()
				end
			end)

			return ButtonData
		end
		
		function Tab:Label(text)
			local Label = Instance.new("TextButton")
			local UIPadding_5 = Instance.new("UIPadding")
			local UICorner_6 = Instance.new("UICorner")
			local UIStroke_4 = Instance.new("UIStroke")
			local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
			local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
			

			Label.Name = "Label"
			Label.Parent = TabFrame
			Label.BackgroundColor3 = lib.Theme.Background4
			Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Label.BorderSizePixel = 0
			Label.Size = UDim2.new(1, 0, 0, 45)
			Label.Font = Enum.Font.Ubuntu
			Label.Text = text;
			Label.TextColor3 = lib.Theme.TextOff
			Label.TextScaled = true
			Label.TextSize = 14.000
			Label.TextWrapped = true
			Label.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_5.Parent = Label
			UIPadding_5.PaddingLeft = UDim.new(0, 12)

			UICorner_6.CornerRadius = UDim.new(0, 6)
			UICorner_6.Parent = Label

			UIStroke_4.Parent = Label
			UIStroke_4.Color = lib.Theme.Stroke3
			UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			UIAspectRatioConstraint_3.Parent = Label
			UIAspectRatioConstraint_3.AspectRatio = 9.911
			UIAspectRatioConstraint_3.AspectType = Enum.AspectType.ScaleWithParentSize

			UITextSizeConstraint_4.Parent = Label
			UITextSizeConstraint_4.MaxTextSize = 14
		end
		
		function Tab:Toggle(text, callback)
			local ToggleData = {
				Hover = false,
				State = false
			}
			
			local Toggle = Instance.new("TextButton")
			local UIPadding_6 = Instance.new("UIPadding")
			local UICorner_7 = Instance.new("UICorner")
			local UIStroke_5 = Instance.new("UIStroke")
			local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
			local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
			local CheckMark = Instance.new("Frame")
			local UICorner_8 = Instance.new("UICorner")
			local UIStroke_6 = Instance.new("UIStroke")
			local Icon_3 = Instance.new("ImageLabel")
			
			Toggle.Name = "Toggle"
			Toggle.Parent = TabFrame
			Toggle.BackgroundColor3 = lib.Theme.Background4
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(1, 0, 0, 45)
			Toggle.Font = Enum.Font.Ubuntu
			Toggle.Text = text;
			Toggle.TextColor3 = Color3.fromRGB(202, 202, 202)
			Toggle.TextScaled = true
			Toggle.TextSize = 14.000
			Toggle.TextWrapped = true
			Toggle.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_6.Parent = Toggle
			UIPadding_6.PaddingLeft = UDim.new(0, 12)

			UICorner_7.CornerRadius = UDim.new(0, 6)
			UICorner_7.Parent = Toggle

			UIStroke_5.Parent = Toggle
			UIStroke_5.Color = lib.Theme.Stroke3
			UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			UIAspectRatioConstraint_4.Parent = Toggle
			UIAspectRatioConstraint_4.AspectRatio = 9.911
			UIAspectRatioConstraint_4.AspectType = Enum.AspectType.ScaleWithParentSize

			UITextSizeConstraint_5.Parent = Toggle
			UITextSizeConstraint_5.MaxTextSize = 14

			CheckMark.Name = "CheckMark"
			CheckMark.Parent = Toggle
			CheckMark.AnchorPoint = Vector2.new(1, 0.5)
			CheckMark.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
			CheckMark.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CheckMark.BorderSizePixel = 0
			CheckMark.Position = UDim2.new(0.973094165, 0, 0.5, 0)
			CheckMark.Size = UDim2.new(0.0436365083, 0, 0.444444448, 0)

			UICorner_8.CornerRadius = UDim.new(0, 6)
			UICorner_8.Parent = CheckMark

			UIStroke_6.Parent = CheckMark
			UIStroke_6.Color = Color3.fromRGB(82, 82, 82)
			UIStroke_6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			Icon_3.Name = "Icon"
			Icon_3.Parent = CheckMark
			Icon_3.AnchorPoint = Vector2.new(1, 0.5)
			Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon_3.BackgroundTransparency = 1.000
			Icon_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon_3.BorderSizePixel = 0
			Icon_3.Position = UDim2.new(0.973094165, 0, 0.5, 0)
			Icon_3.Size = UDim2.new(1, 0, 1, 0)
			Icon_3.Image = "rbxassetid://10709790644"
			Icon_3.ImageTransparency = 1.000
			
			Toggle.MouseEnter:Connect(function()
				ToggleData.Hover = true
				lib:tween(Toggle, {BackgroundColor3 = lib.Theme.Background2})
				lib:tween(UIStroke_5, {Color = lib.Theme.Stroke1})
			end)
			
			Toggle.MouseLeave:Connect(function()
				ToggleData.Hover = false
				if not ToggleData.Mousedown then
					lib:tween(Toggle, {BackgroundColor3 = lib.Theme.Background4})
					lib:tween(UIStroke_5, {Color = lib.Theme.Stroke3})
				end
			end)
			
			Toggle.MouseButton1Click:Connect(function()
				ToggleData.State = not ToggleData.State

				if callback then
					callback(ToggleData.State)
				end

				if ToggleData.State then
					lib:tween(CheckMark, {BackgroundColor3 = Color3.fromRGB(0, 255, 0)})
					lib:tween(UIStroke_6, {Color = Color3.fromRGB(80, 173, 71)})
					lib:tween(Icon_3, {ImageTransparency = 0})
				else
					lib:tween(CheckMark, {BackgroundColor3 = Color3.fromRGB(64, 64, 64)})
					lib:tween(UIStroke_6, {Color = Color3.fromRGB(82, 82, 82)})
					lib:tween(Icon_3, {ImageTransparency = 1})
				end
			end)

			
			return ToggleData
		end
		
		function Tab:Dropdown(text, options, callback)
			local DropdownData = {
				Hover = false,
				ItemHover = false,
				Open = false,
				Options = {},
				Selected = {}
			}
			
			local Dropdown = Instance.new("Frame")
			local UIStroke_7 = Instance.new("UIStroke")
			local UICorner_9 = Instance.new("UICorner")
			local Text = Instance.new("TextLabel")
			local UIPadding_7 = Instance.new("UIPadding")
			local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
			local Icon_4 = Instance.new("ImageLabel")
			local Items = Instance.new("ScrollingFrame")
			local UIListLayout_3 = Instance.new("UIListLayout")
			local UIPadding_8 = Instance.new("UIPadding")
			
			Dropdown.Name = "Dropdown"
			Dropdown.Parent = TabFrame
			Dropdown.BackgroundColor3 = lib.Theme.Background4
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Size = UDim2.new(1, 0, 0, 45)
			
			local Header = Instance.new("Frame")

			Header.Name = "Header"
			Header.Parent = Dropdown
			Header.BackgroundColor3 = lib.Theme.Background4
			Header.BorderSizePixel = 0
			Header.Size = UDim2.new(1,0,0,45)

			UIStroke_7.Parent = Header
			UIStroke_7.Color = lib.Theme.Stroke3
			UIStroke_7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			UICorner_9.CornerRadius = UDim.new(0, 6)
			UICorner_9.Parent = Header

			Text.Name = "Text"
			Text.Parent = Header
			Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Text.BackgroundTransparency = 1.000
			Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Text.BorderSizePixel = 0
			Text.Size = UDim2.new(1, 0, 1, 0)
			Text.Position = UDim2.new(0, 0, 0, 0)
			Text.Font = Enum.Font.Ubuntu
			Text.Text = text;
			Text.TextColor3 = lib.Theme.TextOff
			Text.TextScaled = true
			Text.TextSize = 14.000
			Text.TextWrapped = true
			Text.TextXAlignment = Enum.TextXAlignment.Left
			
			UIPadding_7.Parent = Text
			UIPadding_7.PaddingLeft = UDim.new(0, 10)
			UIPadding_7.PaddingTop = UDim.new(0, 0)

			UITextSizeConstraint_6.Parent = Text
			UITextSizeConstraint_6.MaxTextSize = 14

			Icon_4.Name = "Icon"
			Icon_4.Parent = Header
			Icon_4.AnchorPoint = Vector2.new(1, 0.5)
			Icon_4.Position = UDim2.new(1, -15, 0.5, 0)
			Icon_4.Size = UDim2.fromOffset(18, 18)
			Icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon_4.BackgroundTransparency = 1.000
			Icon_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon_4.BorderSizePixel = 0
			Icon_4.Image = "rbxassetid://10734944115"
			Icon_4.ImageColor3 = Color3.fromRGB(140, 140, 140)

			Items.Name = "Items"
			Items.Parent = Dropdown
			Items.Active = true
			Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Items.BackgroundTransparency = 1.000
			Items.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Items.BorderSizePixel = 0
			Items.Position = UDim2.new(0, 0, 0, 45)
			Items.Size = UDim2.new(1, 0, 0, 0)
			Items.Visible = false
			Items.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
			Items.ScrollBarThickness = 0

			UIListLayout_3.Parent = Items
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Padding = UDim.new(0, 12)

			UIPadding_8.Parent = Items
			UIPadding_8.PaddingBottom = UDim.new(0, 12)
			UIPadding_8.PaddingLeft = UDim.new(0, 12)
			UIPadding_8.PaddingRight = UDim.new(0, 12)
			UIPadding_8.PaddingTop = UDim.new(0, 12)
			
			function DropdownData:Add(id, value)	
				DropdownData.Options[id] = value
				local Option = Instance.new("TextButton")
				local UICorner_10 = Instance.new("UICorner")
				local UIStroke_8 = Instance.new("UIStroke")
				local UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
				local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")
				local Icon_5 = Instance.new("ImageLabel")
				local UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint")

				Option.Name = id
				Option.Parent = Items
				Option.BackgroundColor3 = lib.Theme.Background3
				Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Option.BorderSizePixel = 0
				Option.Size = UDim2.new(1, 0, 0, 24)
				Option.Font = Enum.Font.SourceSans
				Option.Text = value
				Option.TextColor3 = lib.Theme.TextOff
				Option.TextScaled = true
				Option.TextSize = 14.000
				Option.TextWrapped = true

				UICorner_10.CornerRadius = UDim.new(0, 6)
				UICorner_10.Parent = Option

				UIStroke_8.Parent = Option
				UIStroke_8.Color = lib.Theme.Stroke2
				UIStroke_8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				UITextSizeConstraint_7.Parent = Option
				UITextSizeConstraint_7.MaxTextSize = 14

				UIAspectRatioConstraint_5.Parent = Option
				UIAspectRatioConstraint_5.AspectRatio = 17.583
				UIAspectRatioConstraint_5.AspectType = Enum.AspectType.ScaleWithParentSize

				Icon_5.Name = "Icon"
				Icon_5.Parent = Option
				Icon_5.AnchorPoint = Vector2.new(1, 0.5)
				Icon_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon_5.BackgroundTransparency = 1.000
				Icon_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon_5.BorderSizePixel = 0
				Icon_5.Position = UDim2.new(1, -6, 0.5, 0)
				Icon_5.Size = UDim2.new(0, 18, 0, 18)
				Icon_5.Image = "rbxassetid://10709790644"
				Icon_5.ImageColor3 = Color3.fromRGB(140, 140, 140)
				Icon_5.ImageTransparency = 1.000

				Option.MouseEnter:Connect(function()
					DropdownData.ItemHover = true
					lib:tween(Option, {BackgroundColor3 = lib.Theme.Background2})
					lib:tween(Icon_5, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
					lib:tween(UIStroke_8, {Color = lib.Theme.Stroke1})	
				end)

				Option.MouseLeave:Connect(function()
					DropdownData.ItemHover = false

					if not DropdownData.ItemHover then
						lib:tween(Option, {BackgroundColor3 = lib.Theme.Background3})
						lib:tween(Icon_5, {ImageColor3 = Color3.fromRGB(140, 140, 140)})
						lib:tween(UIStroke_8, {Color = lib.Theme.Stroke2})
					end
				end)
				
				Option.MouseButton1Click:Connect(function(input, gpe)
					if gpe then return end
					
					if DropdownData.Selected[id] then
						DropdownData.Selected[id] = nil
						lib:tween(Icon_5, {ImageTransparency = 1})
					else
						DropdownData.Selected[id] = value
						lib:tween(Icon_5, {ImageTransparency = 0})
					end

					if callback then
						callback(table.clone(DropdownData.Selected))
					end

					DropdownData.Open = false


					if callback then
						callback(id, value)
					end
				end)
				
				Items.CanvasSize = UDim2.fromOffset(0, UIListLayout_3.AbsoluteContentSize.Y)
			end
			
			Header.InputBegan:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
					return
				end

				DropdownData.Open = not DropdownData.Open

				if DropdownData.Open then
					Items.Visible = true

					local Height = math.min(UIListLayout_3.AbsoluteContentSize.Y + 24, 140)

					lib:tween(Dropdown, {Size = UDim2.new(1, 0, 0, 45 + Height)})
					lib:tween(Items, {Size = UDim2.new(1, 0, 0, Height)})
					lib:tween(Icon_4, {Rotation = 180})
				else
					lib:tween(Dropdown, {Size = UDim2.new(1, 0, 0, 45)})
					lib:tween(Items, {Size = UDim2.new(1, 0, 0, 0)})
					lib:tween(Icon_4, {Rotation = 0})

					task.delay(0.2, function()
						if not DropdownData.Open then
							Items.Visible = false
						end
					end)
				end
			end)
			
			UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Items.CanvasSize = UDim2.fromOffset(0, UIListLayout_3.AbsoluteContentSize.Y)

				if DropdownData.Open then
					local Height = math.min(UIListLayout_3.AbsoluteContentSize.Y + 24, 140)

					lib:tween(Dropdown, {Size = UDim2.new(1, 0, 0, 45 + Height)})
					lib:tween(Items, {Size = UDim2.new(1, 0, 0, Height)})
				end
			end)

			
			function DropdownData:Remove(id)
				local Option = Items:FindFirstChild(id)

				if Option then
					Option:Destroy()
				end

				Items.CanvasSize = UDim2.fromOffset(0, UIListLayout_3.AbsoluteContentSize.Y)
			end
			
			function DropdownData:Clear()
				for _, v in ipairs(Items:GetChildren()) do
					if v:IsA("TextButton") then
						v:Destroy()
					end
				end

				Items.CanvasSize = UDim2.fromOffset(0, UIListLayout_3.AbsoluteContentSize.Y)
			end
			
			function DropdownData:Refresh(options)
				self:Clear()

				for id, value in pairs(options) do
					self:Add(id, value)
				end
			end
			
			function DropdownData:Set(id, state)
				local Option = Items:FindFirstChild(id)

				if not Option then
					return
				end

				local Icon = Option:FindFirstChild("Icon")

				if state then
					DropdownData.Selected[id] = DropdownData.Options[id]

					if Icon then
						lib:tween(Icon, {ImageTransparency = 0})
					end
				else
					DropdownData.Selected[id] = nil

					if Icon then
						lib:tween(Icon, {ImageTransparency = 1})
					end
				end

				if callback then
					callback(table.clone(DropdownData.Selected))
				end
			end
			
			function DropdownData:Setcallback()
				
			end
			
			if options then
				for id, value in pairs(options) do
					DropdownData:Add(id, value)
				end
			end
			
			return DropdownData
		end
		
		function Tab:Slider(text, min, default, max, callback)
			local SliderData = {}
			
			local Slider = Instance.new("Frame")
			local UIStroke_9 = Instance.new("UIStroke")
			local UICorner_11 = Instance.new("UICorner")
			local Text_2 = Instance.new("TextLabel")
			local UIPadding_9 = Instance.new("UIPadding")
			local UITextSizeConstraint_8 = Instance.new("UITextSizeConstraint")
			local Value = Instance.new("TextLabel")
			local UIPadding_10 = Instance.new("UIPadding")
			local UITextSizeConstraint_9 = Instance.new("UITextSizeConstraint")
			local Sliderback = Instance.new("Frame")
			local UICorner_12 = Instance.new("UICorner")
			local UIStroke_10 = Instance.new("UIStroke")
			local Draggable = Instance.new("Frame")
			local UICorner_13 = Instance.new("UICorner")
			local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint")

			Slider.Name = "Slider"
			Slider.Parent = TabFrame
			Slider.BackgroundColor3 = lib.Theme.Background4
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(1, 0, 0, 102)

			UIStroke_9.Parent = Slider
			UIStroke_9.Color = lib.Theme.Stroke3
			UIStroke_9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			UICorner_11.CornerRadius = UDim.new(0, 6)
			UICorner_11.Parent = Slider

			Text_2.Name = "Text"
			Text_2.Parent = Slider
			Text_2.BackgroundTransparency = 1
			Text_2.Size = UDim2.new(1, 0, 0.196078435, 0)
			Text_2.Font = Enum.Font.Ubuntu
			Text_2.Text = text
			Text_2.TextColor3 = lib.Theme.TextOff
			Text_2.TextScaled = true
			Text_2.TextWrapped = true
			Text_2.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_9.Parent = Text_2
			UIPadding_9.PaddingLeft = UDim.new(0, 26)
			UIPadding_9.PaddingTop = UDim.new(0, 6)

			UITextSizeConstraint_8.Parent = Text_2
			UITextSizeConstraint_8.MaxTextSize = 14

			Value.Name = "Value"
			Value.Parent = Slider
			Value.BackgroundTransparency = 1
			Value.Position = UDim2.new(0.858744323, 0, 0, 0)
			Value.Size = UDim2.new(0.141255602, 0, 0.196078435, 0)
			Value.Font = Enum.Font.Ubuntu
			Value.TextColor3 = lib.Theme.TextOff
			Value.TextScaled = true
			Value.TextWrapped = true
			Value.TextXAlignment = Enum.TextXAlignment.Right

			UIPadding_10.Parent = Value
			UIPadding_10.PaddingRight = UDim.new(0, 26)
			UIPadding_10.PaddingTop = UDim.new(0, 6)

			UITextSizeConstraint_9.Parent = Value
			UITextSizeConstraint_9.MaxTextSize = 14

			Sliderback.Name = "Sliderback"
			Sliderback.Parent = Slider
			Sliderback.BackgroundColor3 = lib.Theme.Background3
			Sliderback.BorderSizePixel = 0
			Sliderback.Position = UDim2.new(0.0336322859, 0, 0.578431368, 0)
			Sliderback.Size = UDim2.new(0.932735384, 0, 0.0392156877, 0)

			UICorner_12.CornerRadius = UDim.new(0, 6)
			UICorner_12.Parent = Sliderback

			UIStroke_10.Parent = Sliderback
			UIStroke_10.Color = lib.Theme.Stroke3
			UIStroke_10.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			Draggable.Name = "Draggable"
			Draggable.Parent = Sliderback
			Draggable.BackgroundColor3 = lib.Theme.Background1
			Draggable.BorderSizePixel = 0

			UICorner_13.CornerRadius = UDim.new(0, 6)
			UICorner_13.Parent = Draggable

			UIAspectRatioConstraint_7.Parent = Slider
			UIAspectRatioConstraint_7.AspectRatio = 4.373
			UIAspectRatioConstraint_7.AspectType = Enum.AspectType.ScaleWithParentSize

			
			local Dragging = false
			local CurrentValue = math.clamp(default or min, min, max)
			local Percent = (CurrentValue - min) / (max - min)

			Draggable.Size = UDim2.new(Percent, 0, 1, 0)
			Value.Text = tostring(CurrentValue)

			local function Update()
				local MouseX = uis:GetMouseLocation().X
				local Percent = math.clamp((MouseX - Sliderback.AbsolutePosition.X) / Sliderback.AbsoluteSize.X, 0, 1)
				local Number = math.floor(min + ((max - min) * Percent) + 0.5)

				CurrentValue = Number

				Draggable.Size = UDim2.new(Percent, 0, 1, 0)
				Value.Text = tostring(Number)

				if callback then
					callback(Number)
				end
			end

			Sliderback.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = true
					Update()
				end
			end)

			Draggable.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = true
				end
			end)

			uis.InputChanged:Connect(function(input)
				if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					Update()
				end
			end)

			uis.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = false
				end
			end)

			function SliderData:Set(value)
				value = math.clamp(value, min, max)

				CurrentValue = value

				local Percent = (value - min) / (max - min)

				Draggable.Size = UDim2.new(Percent, 0, 1, 0)
				Value.Text = tostring(value)

				if callback then
					callback(value)
				end
			end

			function SliderData:Get()
				return CurrentValue
			end

			return SliderData
		end
		
		return Tab
	end

	Search:GetPropertyChangedSignal("Text"):Connect(function()
        local search = Search.Text:lower()

        for _, tab in ipairs(Tabs:GetChildren()) do
            if tab:IsA("ScrollingFrame") then
                for _, control in ipairs(tab:GetChildren()) do
                    if control:IsA("GuiObject") then
                        local visible = search == ""

                        if not visible then
                            for _, obj in ipairs(control:GetDescendants()) do
                                if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                                    if string.find(obj.Text:lower(), search, 1, true) then
                                        visible = true
                                        break
                                    end
                                elseif obj:IsA("TextBox") then
                                    if string.find(obj.Text:lower(), search, 1, true)
                                    or string.find(obj.PlaceholderText:lower(), search, 1, true) then
                                        visible = true
                                        break
                                    end
                                end
                            end
                        end

                        control.Visible = visible
                    end
                end
            end
        end
    end)
	
	return GUI
end

function lib:Notify(title, text, duration)
	duration = duration or 3.5

	local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	local Holder = PlayerGui:FindFirstChild("NotificationHolder")
	if not Holder then
		Holder = Instance.new("ScreenGui")
		Holder.Name = "NotificationHolder"
		Holder.ResetOnSpawn = false
		Holder.Parent = PlayerGui
	end

	local Notification = Instance.new("Frame")
	Notification.Name = "Notification"
	Notification.BackgroundColor3 = lib.Theme.Background4
	Notification.BorderSizePixel = 0
	Notification.Size = UDim2.new(0, 340, 0, 82)
	Notification.Position = UDim2.new(1, 380, 1, -24)
	Notification.AnchorPoint = Vector2.new(1, 1)
	Notification.Parent = Holder

	-- Corner
	Instance.new("UICorner", Notification).CornerRadius = UDim.new(0, 14)

	-- Stroke
	local UIStroke = Instance.new("UIStroke", Notification)
	UIStroke.Color = lib.Theme.Stroke3
	UIStroke.Thickness = 1.5
	UIStroke.Transparency = 0.25

	-- Title
	local Title = Instance.new("TextLabel")
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 16, 0, 12)
	Title.Size = UDim2.new(1, -32, 0, 20)
	Title.Font = Enum.Font.Ubuntu
	Title.Text = title
	Title.TextColor3 = lib.Theme.TextOn
	Title.TextSize = 16
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Notification

	-- Description
	local Description = Instance.new("TextLabel")
	Description.BackgroundTransparency = 1
	Description.Position = UDim2.new(0, 16, 0, 35)
	Description.Size = UDim2.new(1, -32, 1, -54)
	Description.Font = Enum.Font.Ubuntu
	Description.Text = text
	Description.TextColor3 = lib.Theme.TextOff
	Description.TextSize = 14
	Description.TextWrapped = true
	Description.TextXAlignment = Enum.TextXAlignment.Left
	Description.TextYAlignment = Enum.TextYAlignment.Top
	Description.Parent = Notification

	-- Progress Bar (modern line)
	local ProgressBar = Instance.new("Frame")
	ProgressBar.Name = "Progress"
	ProgressBar.BackgroundColor3 = lib.Theme.TextOn or Color3.fromRGB(255, 255, 255)
	ProgressBar.BorderSizePixel = 0
	ProgressBar.Size = UDim2.new(1, 0, 0, 3)
	ProgressBar.Position = UDim2.new(0, 0, 1, -3)
	ProgressBar.Parent = Notification

	local ProgressCorner = Instance.new("UICorner", ProgressBar)
	ProgressCorner.CornerRadius = UDim.new(0, 3)

	-- Auto height adjustment
	task.defer(function()
		if Description.Parent then
			local textHeight = Description.TextBounds.Y
			local newHeight = 35 + textHeight + 28
			Notification.Size = UDim2.new(0, 340, 0, math.clamp(newHeight, 82, 170))
		end
	end)

	-- Slide In
	lib:tween(Notification, {
		Position = UDim2.new(1, -12, 1, -24)
	})

	-- Progress Bar Animation
	local progressTween = lib:tween(ProgressBar, {
		Size = UDim2.new(0, 0, 0, 3)
	}, nil, TweenInfo.new(duration, Enum.EasingStyle.Linear))

	-- Slide Out + Destroy
	task.delay(duration, function()
		if not Notification or not Notification.Parent then return end

		lib:tween(Notification, {
			Position = UDim2.new(1, 380, 1, -24)
		}, function()
			Notification:Destroy()
		end)
	end)
end

lib:Notify("Success", "UI Library loaded successfully! else debug in print to check if bypass :3", 10)

return lib

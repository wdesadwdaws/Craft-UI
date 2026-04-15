-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local coreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local GuiService = game:GetService("GuiService")

-- Vars
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local viewport = workspace.CurrentCamera.ViewportSize
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local Daily = {}

function Daily:tween(object, goal, callback)
	local tween = TweenService:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

local Icons = {
	TabIcon = {
		Home = "rbxassetid://119322639372153",
	},
	TopBarExitIcon = {
		Exit = "rbxassetid://95439249159068",
	},
	ButtonIcon = {
		Cusor = "rbxassetid://111250893869573",
	},
	DropdownIcon = {
		Down = "rbxassetid://97639853041688",
	},
	ToggleIcon = {
		Toggle = "rbxassetid://130999423149396",
	},
	WarningIcon = {
		Warning = "rbxassetid://117238936381225",
	},
	InfoIcon = {
		Info = "rbxassetid://78014970513086",
	},
	LabelIcon = {
		Label = "rbxassetid://106063415470342",
	},
	MinimiseIcon = {
		Minimise = "rbxassetid://121714782477610"
	},
	NotificationIcon = {
		Notificaton = nil
	},
	DefaultIcon = {
		Home = "rbxassetid://119322639372153",
		Exit = "rbxassetid://95439249159068",
		Cusor = "rbxassetid://111250893869573",
		Toggle = "rbxassetid://130999423149396",
		Down = "rbxassetid://97639853041688",
		Info = "rbxassetid://78014970513086",
		Label = "rbxassetid://106063415470342",
		Warning = "rbxassetid://117238936381225",
		Minimise = "rbxassetid://121714782477610",
		Notificaton = nil,
	}
}

local Sounds = {
	Notify = {
		Notify1 = "6026984224"
	},
	Default = {
		Notify1 = "6026984224"
	}
}



function Daily:validate(defaults, options)	
	for i, v in pairs(defaults) do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end




function Daily:Init(options)
	options = Daily:validate({
		Title = "Daily UI",
		Icon = Icons.DefaultIcon.Exit
	}, options or  {})

	local GUI = {
		CurrentTab = nil,
		ClosedState = false,
	}

	local Open = {}

	-- Main	
	do
		-- StarterGui.CraftExitUI
		Open["1"] = Instance.new("ScreenGui", RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui") or coreGui);
		Open["1"]["IgnoreGuiInset"] = true;
		Open["1"].Enabled = false
		Open["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
		Open["1"]["Name"] = options.Title .. "ExitUI";

		-- StarterGui.CraftExitUI.Main
		Open["2"] = Instance.new("Frame", Open["1"])
		Open["2"].Active = true
		Open["2"].BorderSizePixel = 0
		Open["2"].BackgroundColor3 = Color3.fromRGB(27, 27, 27)
		Open["2"].AnchorPoint = Vector2.new(0.5, 0)
		Open["2"].Size = UDim2.new(0, 36, 0, 36)
		Open["2"].Position = UDim2.new(0.5, 0, 0, 20)
		Open["2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
		Open["2"].Name = "Main"
		Open["2"].ClipsDescendants = true

		Open["2"].InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Open["2"].Visible = false
				GUI["2"].Visible = true
			end
		end)
		-- StarterGui.CraftExitUI.Main.UICorner
		Open["3"] = Instance.new("UICorner", Open["2"]);



		-- StarterGui.CraftExitUI.Main.UIStroke
		Open["4"] = Instance.new("UIStroke", Open["2"]);
		Open["4"]["Color"] = Color3.fromRGB(82, 82, 82);
		Open["4"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


		-- StarterGui.CraftExitUI.Main.UIGradient
		Open["5"] = Instance.new("UIGradient", Open["2"]);
		Open["5"]["Rotation"] = 90;
		Open["5"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0),NumberSequenceKeypoint.new(0.341, 0.244),NumberSequenceKeypoint.new(1.000, 1),NumberSequenceKeypoint.new(1.000, 0)};
		Open["5"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(52, 52, 52)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 255, 255))};


		-- StarterGui.CraftExitUI.Main.Title
		Open["6"] = Instance.new("TextLabel", Open["2"]);
		Open["6"]["BorderSizePixel"] = 0;
		Open["6"]["TextSize"] = 14;
		Open["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		Open["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Open["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Open["6"]["BackgroundTransparency"] = 1;
		Open["6"]["Size"] = UDim2.new(0, 200, 0, 50);
		Open["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Open["6"]["Text"] = [[Click To Open]];
		Open["6"]["Name"] = [[Title]];
		Open["6"]["Position"] = UDim2.new(-2.27778, 0, -1.91667, 0);

		-- StarterGui.CraftGui
		GUI["1"] = Instance.new("ScreenGui", RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui") or coreGui);
		GUI["1"]["IgnoreGuiInset"] = true;
		GUI["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
		GUI["1"]["Name"] = options.Title;

		-- StarterGui.CraftGui.Main
		GUI["2"] = Instance.new("Frame", GUI["1"]);
		GUI["2"]["BorderSizePixel"] = 0;
		GUI["2"]["BackgroundColor3"] = Color3.fromRGB(49, 49, 49);
		GUI["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["2"]["Size"] = UDim2.new(0, 400, 0, 300);
		GUI["2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
		GUI["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["2"]["Name"] = [[Main]];

		local dragging = false
		local dragInput
		local dragStart
		local startPos
		local moved = false
		local clickThreshold = 5

		local function updateDrag(input, frame)
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end

		GUI["2"].InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragStart = input.Position
				startPos = GUI["2"].Position
				moved = false
				dragging = false
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
						dragInput = nil
						dragStart = nil
						startPos = nil
						moved = false
					end
				end)
			end
		end)

		GUI["2"].InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if not dragStart then return end

				local delta = (input.Position - dragStart).Magnitude
				if delta > clickThreshold then
					dragging = true
					dragInput = input
					moved = true
				end
			end
		end)

		uis.InputChanged:Connect(function(input)
			if dragging and input == dragInput then
				updateDrag(input, GUI["2"])
			end
		end)
		-- StarterGui.Daily UI.Main.UIGradient
		local MainGradient = Instance.new("UIGradient", GUI["2"]);
		MainGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0.3),NumberSequenceKeypoint.new(1.000, 0.3)};
		MainGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(54, 54, 54)),ColorSequenceKeypoint.new(0.567, Color3.fromRGB(158, 159, 161)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(161, 163, 163))};




		-- StarterGui.CraftGui.Main.UICorner
		GUI["3"] = Instance.new("UICorner", GUI["2"]);
		GUI["3"]["CornerRadius"] = UDim.new(0, 6);


		-- StarterGui.CraftGui.Main.DropShadowHolder
		GUI["4"] = Instance.new("Frame", GUI["2"]);
		GUI["4"]["ZIndex"] = 0;
		GUI["4"]["BorderSizePixel"] = 0;
		GUI["4"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["4"]["Name"] = [[DropShadowHolder]];
		GUI["4"]["BackgroundTransparency"] = 1;


		-- StarterGui.CraftGui.Main.DropShadowHolder.DropShadow
		GUI["5"] = Instance.new("ImageLabel", GUI["4"]);
		GUI["5"]["ZIndex"] = 0;
		GUI["5"]["BorderSizePixel"] = 0;
		GUI["5"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		GUI["5"]["ScaleType"] = Enum.ScaleType.Slice;
		GUI["5"]["ImageTransparency"] = 0.5;
		GUI["5"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["5"]["Image"] = [[rbxassetid://6014261993]];
		GUI["5"]["Size"] = UDim2.new(1, 47, 1, 47);
		GUI["5"]["BackgroundTransparency"] = 1;
		GUI["5"]["Name"] = [[DropShadow]];
		GUI["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


		-- StarterGui.CraftGui.Main.TopBar
		GUI["6"] = Instance.new("Frame", GUI["2"]);
		GUI["6"]["BorderSizePixel"] = 0;
		GUI["6"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
		GUI["6"]["Size"] = UDim2.new(1, 0, 0, 30);
		GUI["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["6"]["Name"] = [[TopBar]];


		-- StarterGui.CraftGui.Main.TopBar.UICorner
		GUI["7"] = Instance.new("UICorner", GUI["6"]);
		GUI["7"]["CornerRadius"] = UDim.new(0, 4);


		-- StarterGui.CraftGui.Main.TopBar.Hide
		GUI["8"] = Instance.new("Frame", GUI["6"]);
		GUI["8"]["BorderSizePixel"] = 0;
		GUI["8"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
		GUI["8"]["AnchorPoint"] = Vector2.new(0, 1);
		GUI["8"]["Size"] = UDim2.new(1, 0, 0.5, 0);
		GUI["8"]["Position"] = UDim2.new(0, 0, 1, 0);
		GUI["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["8"]["Name"] = [[Hide]];


		-- StarterGui.CraftGui.Main.TopBar.Title
		GUI["9"] = Instance.new("TextLabel", GUI["6"]);
		GUI["9"]["BorderSizePixel"] = 0;
		GUI["9"]["TextSize"] = 14;
		GUI["9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["9"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
		GUI["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		GUI["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["9"]["BackgroundTransparency"] = 1;
		GUI["9"]["Size"] = UDim2.new(0.5, 0, 1, 0);
		GUI["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["9"]["Text"] = options.Title;
		GUI["9"]["Name"] = [[Title]];


		-- StarterGui.CraftGui.Main.TopBar.Title.UIPadding
		GUI["a"] = Instance.new("UIPadding", GUI["9"]);
		GUI["a"]["PaddingTop"] = UDim.new(0, 1);
		GUI["a"]["PaddingLeft"] = UDim.new(0, 8);


		-- StarterGui.CraftGui.Main.TopBar.Exit
		GUI["b"] = Instance.new("ImageLabel", GUI["6"]);
		GUI["b"]["BorderSizePixel"] = 0;
		GUI["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["b"]["AnchorPoint"] = Vector2.new(1, 0.5);
		GUI["b"]["Image"] = options.Icon
		GUI["b"]["Size"] = UDim2.new(0, 18, 0, 18);
		GUI["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["b"]["BackgroundTransparency"] = 1;
		GUI["b"]["Name"] = [[Exit]];
		GUI["b"]["Position"] = UDim2.new(1, -6, 0.5, 0);

		local Minimise = Instance.new("ImageLabel", GUI["6"])
		Minimise.AnchorPoint = Vector2.new(1, 0.5)
		Minimise.BackgroundTransparency = 1
		Minimise.Size = UDim2.new(0, 18, 0, 18)
		Minimise.Position = UDim2.new(1, -35, 0.5, 0)
		Minimise.Image = Icons.DefaultIcon.Minimise
		Minimise.BorderSizePixel = 0
		Minimise.Name = "Minimise"
		Minimise.BorderColor3 = Color3.fromRGB(0, 0, 0)


		GUI["b"].InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				GUI["1"].Enabled = false
			end
		end)

		Minimise.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				GUI["2"].Visible = false
				Open["2"].Visible = true
				Open["1"].Enabled = true
			end
		end)

		-- StarterGui.CraftGui.Main.TopBar.Line
		GUI["c"] = Instance.new("Frame", GUI["6"]);
		GUI["c"]["BorderSizePixel"] = 0;
		GUI["c"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		GUI["c"]["AnchorPoint"] = Vector2.new(0, 1);
		GUI["c"]["Size"] = UDim2.new(1, 0, 0, 1);
		GUI["c"]["Position"] = UDim2.new(0, 0, 1, 0);
		GUI["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["c"]["Name"] = [[Line]];

		-- StarterGui.CraftGui.Main.ConentContainer
		GUI["1b"] = Instance.new("Frame", GUI["2"]);
		GUI["1b"]["BorderSizePixel"] = 0;
		GUI["1b"]["BackgroundColor3"] = Color3.fromRGB(55, 55, 55);
		GUI["1b"]["AnchorPoint"] = Vector2.new(1, 0);
		GUI["1b"]["Size"] = UDim2.new(1, -133, 1, -42);
		GUI["1b"]["Position"] = UDim2.new(1, -6,0, 36);
		GUI["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["1b"]["Name"] = [[ConentContainer]];
		GUI["1b"]["BackgroundTransparency"] = 1;
	end

	function GUI:Destroy()
		GUI["1"]:Destroy()
	end

	-- Nav
	do
		-- StarterGui.CraftGui.Main.Navigation
		GUI["d"] = Instance.new("Frame", GUI["2"]);
		GUI["d"]["BorderSizePixel"] = 0;
		GUI["d"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["d"]["Size"] = UDim2.new(0, 120, 1, -30);
		GUI["d"]["Position"] = UDim2.new(0, 0, 0, 30);
		GUI["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["d"]["Name"] = [[Navigation]];


		-- StarterGui.CraftGui.Main.Navigation.UICorner
		GUI["e"] = Instance.new("UICorner", GUI["d"]);
		GUI["e"]["CornerRadius"] = UDim.new(0, 6);


		-- StarterGui.CraftGui.Main.Navigation.Hide1
		GUI["f"] = Instance.new("Frame", GUI["d"]);
		GUI["f"]["BorderSizePixel"] = 0;
		GUI["f"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["f"]["Size"] = UDim2.new(1, 0, 0, 20);
		GUI["f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["f"]["Name"] = [[Hide1]];


		-- StarterGui.CraftGui.Main.Navigation.Hide2
		GUI["10"] = Instance.new("Frame", GUI["d"]);
		GUI["10"]["BorderSizePixel"] = 0;
		GUI["10"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["10"]["AnchorPoint"] = Vector2.new(1, 0);
		GUI["10"]["Size"] = UDim2.new(0, 20, 1, 0);
		GUI["10"]["Position"] = UDim2.new(1, 0, 0, 0);
		GUI["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["10"]["Name"] = [[Hide2]];


		-- StarterGui.CraftGui.Main.Navigation.ButtonHolder
		GUI["11"] = Instance.new("Frame", GUI["d"]);
		GUI["11"]["BorderSizePixel"] = 0;
		GUI["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["11"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["11"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["11"]["Name"] = [[ButtonHolder]];
		GUI["11"]["BackgroundTransparency"] = 1;


		-- StarterGui.CraftGui.Main.Navigation.ButtonHolder.UIPadding
		GUI["12"] = Instance.new("UIPadding", GUI["11"]);
		GUI["12"]["PaddingTop"] = UDim.new(0, 8);
		GUI["12"]["PaddingBottom"] = UDim.new(0, 8);


		-- StarterGui.CraftGui.Main.Navigation.ButtonHolder.UIListLayout
		GUI["13"] = Instance.new("UIListLayout", GUI["11"]);
		GUI["13"]["Padding"] = UDim.new(0, 1);
		GUI["13"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


		-- StarterGui.CraftGui.Main.Navigation.Line
		GUI["1a"] = Instance.new("Frame", GUI["d"]);
		GUI["1a"]["BorderSizePixel"] = 0;
		GUI["1a"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		GUI["1a"]["Size"] = UDim2.new(0, 1, 1, 0);
		GUI["1a"]["Position"] = UDim2.new(1, 0, 0, 0);
		GUI["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["1a"]["Name"] = [[Line]]
	end



	function GUI:CreateTab(options)
		options = Daily:validate({
			Text = "Daily Tab",
			Icon = Icons.DefaultIcon.Home
		}, options or  {})

		local Tab = {
			Hover = false,
			Active = false
		}

		-- Render
		do
			-- StarterGui.CraftGui.Main.Navigation.ButtonHolder.Inactive
			Tab["17"] = Instance.new("TextLabel", GUI["11"]);
			Tab["17"]["BorderSizePixel"] = 0;
			Tab["17"]["TextSize"] = 12;
			Tab["17"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			Tab["17"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["17"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Tab["17"]["TextColor3"] = Color3.fromRGB(200, 200, 200);
			Tab["17"]["BackgroundTransparency"] = 1;
			Tab["17"]["Size"] = UDim2.new(1, 0, 0, 24);
			Tab["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["17"]["Text"] = options.Text;
			Tab["17"]["Name"] = options.Text;


			-- StarterGui.CraftGui.Main.Navigation.ButtonHolder.Inactive.UIPadding
			Tab["18"] = Instance.new("UIPadding", Tab["17"]);
			Tab["18"]["PaddingLeft"] = UDim.new(0, 28);


			-- StarterGui.CraftGui.Main.Navigation.ButtonHolder.Inactive.Icon
			Tab["19"] = Instance.new("ImageLabel", Tab["17"]);
			Tab["19"]["BorderSizePixel"] = 0;
			Tab["19"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["19"]["ImageColor3"] = Color3.fromRGB(200, 200, 200);
			Tab["19"]["AnchorPoint"] = Vector2.new(0, 0.5);
			Tab["19"]["Image"] = options.Icon;
			Tab["19"]["Size"] = UDim2.new(0, 20, 0, 20);
			Tab["19"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["19"]["BackgroundTransparency"] = 1;
			Tab["19"]["Name"] = [[Icon]];
			Tab["19"]["Position"] = UDim2.new(0, -24, 0.5, 0);

			-- StarterGui.CraftGui.Main.ConentContainer.HomeTab
			Tab["1c"] = Instance.new("ScrollingFrame", GUI["1b"]);
			Tab["1c"]["BorderSizePixel"] = 0;
			Tab["1c"]["CanvasPosition"] = Vector2.new(0, 0);
			Tab["1c"]["Name"] = options.Text .. "Tab";
			Tab["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["1c"]["Selectable"] = false;
			Tab["1c"]["Size"] = UDim2.new(1, 0, 1, 0);
			Tab["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Tab["1c"]["ScrollBarThickness"] = 0;
			Tab["1c"]["BackgroundTransparency"] = 1;
			Tab["1c"]["Visible"] = false;

			-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.UIPadding
			Tab["23"] = Instance.new("UIPadding", Tab["1c"]);
			Tab["23"]["PaddingTop"] = UDim.new(0, 1);
			Tab["23"]["PaddingRight"] = UDim.new(0, 1);
			Tab["23"]["PaddingLeft"] = UDim.new(0, 1);
			Tab["23"]["PaddingBottom"] = UDim.new(0, 1);


			-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.UIListLayout
			Tab["24"] = Instance.new("UIListLayout", Tab["1c"]);
			Tab["24"]["Padding"] = UDim.new(0, 6);
			Tab["24"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		end


		-- Methods
		function Tab:Activate()
			if not Tab.Active then
				if GUI.CurrentTab ~= nil then
					GUI.CurrentTab:Deactivate()
				end
				Tab.Active = true
				Daily:tween(Tab["17"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
				Daily:tween(Tab["19"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				Daily:tween(Tab["17"], {BackgroundTransparency = .8})
				Tab["1c"].Visible = true				
				GUI.CurrentTab = Tab
			end
		end

		function Tab:Deactivate()
			if Tab.Active then
				Tab.Active = false
				Tab.Hover = false
				Daily:tween(Tab["17"], {TextColor3 = Color3.fromRGB(200, 200, 200)})
				Daily:tween(Tab["19"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
				Daily:tween(Tab["17"], {BackgroundTransparency = 1})
				Tab["1c"].Visible = false
			end
		end


		-- Logic
		do
			Tab["17"].MouseEnter:Connect(function()
				Tab.Hover = true

				if not Tab.Active then
					Daily:tween(Tab["17"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
					Daily:tween(Tab["19"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				end
			end)

			Tab["17"].MouseLeave:Connect(function()
				Tab.Hover = false

				if not Tab.Active then
					Daily:tween(Tab["17"], {TextColor3 = Color3.fromRGB(200, 200, 200)})
					Daily:tween(Tab["19"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
				end
			end)

			uis.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				if Tab.Hover then
					Tab:Activate()
				end
			end
		end)

			if GUI.CurrentTab == nil then
				Tab:Activate()
			end
		end

		function Tab:Button(options)
			options = Daily:validate({
				Text = "Daily Button",
				Icon = Icons.DefaultIcon.Cusor,
				callback = function() end
			}, options or  {})

			local Button = {
				Hover = false,
				MouseDown = false
			}

			-- Render
			do
				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Button
				Button["1d"] = Instance.new("Frame", Tab["1c"]);
				Button["1d"]["BorderSizePixel"] = 0;
				Button["1d"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				Button["1d"]["Size"] = UDim2.new(1, 0, 0, 32);
				Button["1d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Button["1d"]["Name"] = options.Text;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Button.UICorner
				Button["1e"] = Instance.new("UICorner", Button["1d"]);
				Button["1e"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Button.UIStroke
				Button["1f"] = Instance.new("UIStroke", Button["1d"]);
				Button["1f"]["Color"] = Color3.fromRGB(82, 82, 82);
				Button["1f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Button.Title
				Button["20"] = Instance.new("TextLabel", Button["1d"]);
				Button["20"]["TextWrapped"] = true;
				Button["20"]["BorderSizePixel"] = 0;
				Button["20"]["TextSize"] = 14;
				Button["20"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Button["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Button["20"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Button["20"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Button["20"]["BackgroundTransparency"] = 1;
				Button["20"]["Size"] = UDim2.new(1, -20, 1, 0);
				Button["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Button["20"]["Text"] = options.Text;
				Button["20"]["Name"] = [[Title]];


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Button.UIPadding
				Button["21"] = Instance.new("UIPadding", Button["1d"]);
				Button["21"]["PaddingTop"] = UDim.new(0, 6);
				Button["21"]["PaddingRight"] = UDim.new(0, 6);
				Button["21"]["PaddingLeft"] = UDim.new(0, 6);
				Button["21"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Button.Icon
				Button["22"] = Instance.new("ImageLabel", Button["1d"]);
				Button["22"]["BorderSizePixel"] = 0;
				Button["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Button["22"]["AnchorPoint"] = Vector2.new(1, 0);
				Button["22"]["Image"] = options.Icon;
				Button["22"]["Size"] = UDim2.new(0, 20, 0, 20);
				Button["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Button["22"]["BackgroundTransparency"] = 1;
				Button["22"]["Name"] = [[Icon]];
				Button["22"]["Position"] = UDim2.new(1, 0, 0, 0);
			end

			-- Methods
			function Button:SetText(text)
				options.Text = text
				Button["20"].Text = text
			end

			function Button:SetCallback(fn)
				options.callback = fn
			end

			-- Logic
			do
				Button["1d"].MouseEnter:Connect(function()
					Button.Hover = true

					Daily:tween(Button["1f"], {Color = Color3.fromRGB(102, 102, 102)})
				end)

				Button["1d"].MouseLeave:Connect(function()
					Button.Hover = false

					if not Button.MouseDown then
						Daily:tween(Button["1f"], {Color = Color3.fromRGB(82, 82, 82)})
					end
				end)

				uis.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
						Button.MouseDown = true
						Daily:tween(Button["1d"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Daily:tween(Button["1f"], {Color = Color3.fromRGB(200, 200, 200)})
						options.callback()
					end
				end)

				uis.InputEnded:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Button.MouseDown = false

						if Button.Hover then
							Daily:tween(Button["1d"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(Button["1f"], {Color = Color3.fromRGB(102, 102, 102)})
						else
							Daily:tween(Button["1d"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(Button["1f"], {Color = Color3.fromRGB(82, 82, 82)})
						end
					end
				end)
			end

			return Button
		end

		function Tab:Warning(options)
			options = Daily:validate({
				Text = "Daily Warning",
				Icon = Icons.DefaultIcon.Warning
			}, options or {})

			local Warning = {}

			-- Render
			do
				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Warning
				Warning["25"] = Instance.new("Frame", Tab["1c"]);
				Warning["25"]["BorderSizePixel"] = 0;
				Warning["25"]["BackgroundColor3"] = Color3.fromRGB(153, 153, 31);
				Warning["25"]["Size"] = UDim2.new(1, 0, 0, 26);
				Warning["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Warning["25"]["Name"] = options.Text
				Warning["25"]["BackgroundTransparency"] = 0.3;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Warning.UICorner
				Warning["26"] = Instance.new("UICorner", Warning["25"]);
				Warning["26"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Warning.UIStroke
				Warning["27"] = Instance.new("UIStroke", Warning["25"]);
				Warning["27"]["Transparency"] = 0.3;
				Warning["27"]["Color"] = Color3.fromRGB(223, 255, 50);
				Warning["27"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Warning.Title
				Warning["28"] = Instance.new("TextLabel", Warning["25"]);
				Warning["28"]["TextWrapped"] = false;
				Warning["28"]["BorderSizePixel"] = 0;
				Warning["28"]["TextSize"] = 14;
				Warning["28"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Warning["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Warning["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Warning["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Warning["28"]["BackgroundTransparency"] = 1;
				Warning["28"]["Size"] = UDim2.new(1, -24, 1, 0);
				Warning["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Warning["28"]["Text"] = options.Text;
				Warning["28"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Warning["28"]["TextWrapped"] = true;
				Warning["28"]["Name"] = [[Title]];
				Warning["28"]["Position"] = UDim2.new(0, 24, 0, 0);
				Warning["28"]["TextYAlignment"] = Enum.TextYAlignment.Top;

				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Warning.UIPadding
				Warning["29"] = Instance.new("UIPadding", Warning["25"]);
				Warning["29"]["PaddingTop"] = UDim.new(0, 6);
				Warning["29"]["PaddingRight"] = UDim.new(0, 6);
				Warning["29"]["PaddingLeft"] = UDim.new(0, 6);
				Warning["29"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Warning.Icon
				Warning["2a"] = Instance.new("ImageLabel", Warning["25"]);
				Warning["2a"]["BorderSizePixel"] = 0;
				Warning["2a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Warning["2a"]["AnchorPoint"] = Vector2.new(1, 0);
				Warning["2a"]["Image"] = options.Icon;
				Warning["2a"]["Size"] = UDim2.new(0, 20, 0, 20);
				Warning["2a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Warning["2a"]["BackgroundTransparency"] = 1;
				Warning["2a"]["Name"] = [[Icon]];
				Warning["2a"]["Position"] = UDim2.new(0, 20, 0, -2);
			end

			-- Methods
			function Warning:SetText(text)
				options.Text = text
				Warning:_update()
			end

			function Warning:_update()
				Warning["28"].Text = options.Text

				task.wait()

				Warning["28"].Size = UDim2.new(Warning["28"].Size.X.Scale, Warning["28"].Size.X.Offset, 0, math.huge)
				task.wait()
				if Warning["28"].TextBounds.Y > 14 then
					Warning["28"].TextSize = 12
					task.wait()
				end

				Warning["28"].Size = UDim2.new(Warning["28"].Size.X.Scale, Warning["28"].Size.X.Offset, 0, Warning["28"].TextBounds.Y)
				Warning["25"].Size = UDim2.new(Warning["25"].Size.X.Scale, Warning["25"].Size.X.Offset, 0, Warning["28"].TextBounds.Y + 12)
				Daily:tween(Warning["25"], {Size = UDim2.new(Warning["25"].Size.X.Scale, Warning["25"].Size.X.Offset, 0, Warning["28"].TextBounds.Y + 12)})
			end

			Warning:_update()
			return Warning
		end

		function Tab:Info(options)
			options = Daily:validate({
				Text = "Daily Info",
				Icon = Icons.DefaultIcon.Info
			}, options or {})

			local Info = {}

			-- Render
			do

				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Info
				Info["2b"] = Instance.new("Frame", Tab["1c"]);
				Info["2b"]["BorderSizePixel"] = 0;
				Info["2b"]["BackgroundColor3"] = Color3.fromRGB(71, 176, 166);
				Info["2b"]["Size"] = UDim2.new(1, 0, 0, 26);
				Info["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Info["2b"]["Name"] = options.Text
				Info["2b"]["BackgroundTransparency"] = 0.3;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Info.UICorner
				Info["2c"] = Instance.new("UICorner", Info["2b"]);
				Info["2c"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Info.UIStroke
				Info["2d"] = Instance.new("UIStroke", Info["2b"]);
				Info["2d"]["Color"] = Color3.fromRGB(46, 205, 218);
				Info["2d"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Info.Title
				Info["2e"] = Instance.new("TextLabel", Info["2b"]);
				Info["2e"]["TextWrapped"] = true;
				Info["2e"]["BorderSizePixel"] = 0;
				Info["2e"]["TextSize"] = 14;
				Info["2e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Info["2e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Info["2e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Info["2e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Info["2e"]["BackgroundTransparency"] = 1;
				Info["2e"]["Size"] = UDim2.new(1, -24, 1, 0);
				Info["2e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Info["2e"]["Text"] = options.Text;
				Info["2e"]["Name"] = [[Title]];
				Info["2e"]["Position"] = UDim2.new(0, 24, 0, 0);
				Info["2e"]["TextYAlignment"] = Enum.TextYAlignment.Top;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Info.UIPadding
				Info["2f"] = Instance.new("UIPadding", Info["2b"]);
				Info["2f"]["PaddingTop"] = UDim.new(0, 6);
				Info["2f"]["PaddingRight"] = UDim.new(0, 6);
				Info["2f"]["PaddingLeft"] = UDim.new(0, 6);
				Info["2f"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Info.Icon
				Info["30"] = Instance.new("ImageLabel", Info["2b"]);
				Info["30"]["BorderSizePixel"] = 0;
				Info["30"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Info["30"]["AnchorPoint"] = Vector2.new(1, 0);
				Info["30"]["Image"] = options.Icon;
				Info["30"]["Size"] = UDim2.new(0, 20, 0, 20);
				Info["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Info["30"]["BackgroundTransparency"] = 1;
				Info["30"]["Name"] = [[Icon]];
				Info["30"]["Position"] = UDim2.new(0, 20, 0, -2);
			end

			-- Methods
			function Info:SetText(text)
				options.Text = text
				Info:_update()
			end

			function Info:_update()
				Info["2e"].Text = options.Text

				task.wait()

				Info["2e"].Size = UDim2.new(Info["2e"].Size.X.Scale, Info["2e"].Size.X.Offset, 0, math.huge)
				task.wait()
				if Info["2e"].TextBounds.Y > 14 then
					Info["2e"].TextSize = 12
					task.wait()
				end

				Info["2e"].Size = UDim2.new(Info["2e"].Size.X.Scale, Info["2e"].Size.X.Offset, 0, Info["2e"].TextBounds.Y)
				Info["2b"].Size = UDim2.new(Info["2b"].Size.X.Scale, Info["2b"].Size.X.Offset, 0, Info["2e"].TextBounds.Y + 12)
				Daily:tween(Info["2b"], {Size = UDim2.new(Info["2b"].Size.X.Scale, Info["2b"].Size.X.Offset, 0, Info["2e"].TextBounds.Y + 12)})
			end

			Info:_update()
			return Info
		end

		function Tab:Label(options)
			options = Daily:validate({
				Text = "Daily Label",
				Icon = Icons.DefaultIcon.Label
			}, options or {})

			local Label = {}

			-- Render
			do
				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Label
				Label["31"] = Instance.new("Frame", Tab["1c"]);
				Label["31"]["BorderSizePixel"] = 0;
				Label["31"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				Label["31"]["Size"] = UDim2.new(1, 0, 0, 26);
				Label["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Label["31"]["Name"] = options.Text
				Label["31"]["BackgroundTransparency"] = 0.3;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Label.UICorner
				Label["32"] = Instance.new("UICorner", Label["31"]);
				Label["32"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Label.UIStroke
				Label["33"] = Instance.new("UIStroke", Label["31"]);
				Label["33"]["Color"] = Color3.fromRGB(82, 82, 82);
				Label["33"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Label.Title
				Label["34"] = Instance.new("TextLabel", Label["31"]);
				Label["34"]["TextWrapped"] = true;
				Label["34"]["BorderSizePixel"] = 0;
				Label["34"]["TextSize"] = 14;
				Label["34"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Label["34"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Label["34"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Label["34"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Label["34"]["BackgroundTransparency"] = 1;
				Label["34"]["Size"] = UDim2.new(1, -24, 1, 0);
				Label["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Label["34"]["Text"] = options.Text;
				Label["34"]["Name"] = [[Title]];
				Label["34"]["Position"] = UDim2.new(0, 24, 0, 0);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Label.UIPadding
				Label["35"] = Instance.new("UIPadding", Label["31"]);
				Label["35"]["PaddingTop"] = UDim.new(0, 6);
				Label["35"]["PaddingRight"] = UDim.new(0, 6);
				Label["35"]["PaddingLeft"] = UDim.new(0, 6);
				Label["35"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Label.Icon
				Label["36"] = Instance.new("ImageLabel", Label["31"]);
				Label["36"]["BorderSizePixel"] = 0;
				Label["36"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Label["36"]["AnchorPoint"] = Vector2.new(1, 0);
				Label["36"]["Image"] = options.Icon;
				Label["36"]["Size"] = UDim2.new(0, 20, 0, 20);
				Label["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Label["36"]["BackgroundTransparency"] = 1;
				Label["36"]["Name"] = [[Icon]];
				Label["36"]["Position"] = UDim2.new(0, 20, 0, -2);

			end

			-- Methods
			function Label:SetText(text)
				options.Text = text
				Label:_update()
			end

			function Label:_update()
				Label["34"].Text = options.Text

				task.wait()

				Label["34"].Size = UDim2.new(Label["34"].Size.X.Scale, Label["34"].Size.X.Offset, 0, math.huge)
				task.wait()
				if Label["34"].TextBounds.Y > 14 then
					Label["34"].TextSize = 12
					task.wait()
				end

				Label["34"].Size = UDim2.new(Label["34"].Size.X.Scale, Label["34"].Size.X.Offset, 0, Label["34"].TextBounds.Y)
				Label["31"].Size = UDim2.new(Label["31"].Size.X.Scale, Label["31"].Size.X.Offset, 0, Label["34"].TextBounds.Y + 12)
				Daily:tween(Label["31"], {Size = UDim2.new(Label["31"].Size.X.Scale, Label["31"].Size.X.Offset, 0, Label["34"].TextBounds.Y + 12)})
			end

			Label:_update()
			return Label
		end

		function Tab:Toggle(options)
			options = Daily:validate({
				Text = "Daily Toggle",
				Icon = Icons.DefaultIcon.Toggle,
				callback = function() end
			}, options or {})

			local Toggle = {
				Hover = false,
				MouseDown = false,
				State = false,
			}

			-- Render
			do
				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive
				Toggle["53"] = Instance.new("Frame", Tab["1c"]);
				Toggle["53"]["BorderSizePixel"] = 0;
				Toggle["53"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				Toggle["53"]["Size"] = UDim2.new(1, 0, 0, 32);
				Toggle["53"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Toggle["53"]["Name"] = options.Text


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive.UICorner
				Toggle["54"] = Instance.new("UICorner", Toggle["53"]);
				Toggle["54"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive.UIStroke
				Toggle["55"] = Instance.new("UIStroke", Toggle["53"]);
				Toggle["55"]["Color"] = Color3.fromRGB(82, 82, 82);
				Toggle["55"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive.Title
				Toggle["56"] = Instance.new("TextLabel", Toggle["53"]);
				Toggle["56"]["TextWrapped"] = true;
				Toggle["56"]["BorderSizePixel"] = 0;
				Toggle["56"]["TextSize"] = 14;
				Toggle["56"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Toggle["56"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Toggle["56"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Toggle["56"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Toggle["56"]["BackgroundTransparency"] = 1;
				Toggle["56"]["Size"] = UDim2.new(1, -26, 1, 0);
				Toggle["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Toggle["56"]["Text"] = options.Text;
				Toggle["56"]["Name"] = [[Title]];


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive.UIPadding
				Toggle["57"] = Instance.new("UIPadding", Toggle["53"]);
				Toggle["57"]["PaddingTop"] = UDim.new(0, 6);
				Toggle["57"]["PaddingRight"] = UDim.new(0, 6);
				Toggle["57"]["PaddingLeft"] = UDim.new(0, 6);
				Toggle["57"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive.CheckmarkHolder
				Toggle["58"] = Instance.new("Frame", Toggle["53"]);
				Toggle["58"]["BorderSizePixel"] = 0;
				Toggle["58"]["BackgroundColor3"] = Color3.fromRGB(64, 64, 64);
				Toggle["58"]["AnchorPoint"] = Vector2.new(1, 0.5);
				Toggle["58"]["Size"] = UDim2.new(0, 16, 0, 16);
				Toggle["58"]["Position"] = UDim2.new(1, -3, 0.5, 0);
				Toggle["58"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Toggle["58"]["Name"] = [[CheckmarkHolder]];


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive.CheckmarkHolder.UICorner
				Toggle["59"] = Instance.new("UICorner", Toggle["58"]);
				Toggle["59"]["CornerRadius"] = UDim.new(0, 2);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive.CheckmarkHolder.UIStroke
				Toggle["5a"] = Instance.new("UIStroke", Toggle["58"]);
				Toggle["5a"]["Color"] = Color3.fromRGB(82, 82, 82);
				Toggle["5a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.ToggleInactive.CheckmarkHolder.Checkmark
				Toggle["5b"] = Instance.new("ImageLabel", Toggle["58"]);
				Toggle["5b"]["BorderSizePixel"] = 0;
				Toggle["5b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Toggle["5b"]["ImageTransparency"] = 1;
				Toggle["5b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Toggle["5b"]["Image"] = options.Icon;
				Toggle["5b"]["Size"] = UDim2.new(1, -2, 1, -2);
				Toggle["5b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Toggle["5b"]["BackgroundTransparency"] = 1;
				Toggle["5b"]["Name"] = [[Checkmark]];
				Toggle["5b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
			end

			-- Methods
			do
				function Toggle:Toggle(b)
					if b == nil then
						Toggle.State = not Toggle.State
					else
						Toggle.State = b
					end

					if Toggle.State then
						Daily:tween(Toggle["58"], {BackgroundColor3 = Color3.fromRGB(115, 191, 92)})
						Daily:tween(Toggle["5b"], {ImageTransparency = 0})
					else
						Daily:tween(Toggle["58"], {BackgroundColor3 = Color3.fromRGB(64, 64, 64)})
						Daily:tween(Toggle["5b"], {ImageTransparency = 1})
					end

					options.callback(Toggle.State)
				end
			end

			-- Logic
			do
				Toggle["53"].MouseEnter:Connect(function()
					Toggle.Hover = true

					Daily:tween(Toggle["55"], {Color = Color3.fromRGB(102, 102, 102)})
				end)

				Toggle["53"].MouseLeave:Connect(function()
					Toggle.Hover = false

					if not Toggle.MouseDown then
						Daily:tween(Toggle["55"], {Color = Color3.fromRGB(82, 82, 82)})
					end
				end)

				uis.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
						Toggle.MouseDown = true
						Daily:tween(Toggle["53"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Daily:tween(Toggle["55"], {Color = Color3.fromRGB(200, 200, 200)})
						Toggle:Toggle()
					end
				end)

				uis.InputEnded:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Toggle.MouseDown = false

						if Toggle.Hover then
							Daily:tween(Toggle["53"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(Toggle["55"], {Color = Color3.fromRGB(102, 102, 102)})
						else
							Daily:tween(Toggle["53"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(Toggle["55"], {Color = Color3.fromRGB(82, 82, 82)})
						end
					end
				end)
			end


			return Toggle
		end

		function Tab:Slider(options)
			options = Daily:validate({
				Text = "Daily Slider",
				Min = 0,
				Max = 100,
				default = 50,
				callback = function(v) print(v) end
			}, options or {})

			local Slider = {
				MouseDown = false,
				Hover = false,
				Connection = nil,
				Options = options
			}

			-- Render
			do
				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider
				Slider["37"] = Instance.new("Frame", Tab["1c"]);
				Slider["37"]["BorderSizePixel"] = 0;
				Slider["37"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				Slider["37"]["Size"] = UDim2.new(1, 0, 0, 38);
				Slider["37"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Slider["37"]["Name"] = options.Text


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.UICorner
				Slider["38"] = Instance.new("UICorner", Slider["37"]);
				Slider["38"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.UIStroke
				Slider["39"] = Instance.new("UIStroke", Slider["37"]);
				Slider["39"]["Color"] = Color3.fromRGB(82, 82, 82);
				Slider["39"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.Title
				Slider["3a"] = Instance.new("TextLabel", Slider["37"]);
				Slider["3a"]["TextWrapped"] = true;
				Slider["3a"]["BorderSizePixel"] = 0;
				Slider["3a"]["TextSize"] = 14;
				Slider["3a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Slider["3a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["3a"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Slider["3a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["3a"]["BackgroundTransparency"] = 1;
				Slider["3a"]["Size"] = UDim2.new(1, -24, 1, -10);
				Slider["3a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Slider["3a"]["Text"] = options.Text;
				Slider["3a"]["Name"] = [[Title]];


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.UIPadding
				Slider["3b"] = Instance.new("UIPadding", Slider["37"]);
				Slider["3b"]["PaddingTop"] = UDim.new(0, 6);
				Slider["3b"]["PaddingRight"] = UDim.new(0, 6);
				Slider["3b"]["PaddingLeft"] = UDim.new(0, 6);
				Slider["3b"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.Value
				Slider["3c"] = Instance.new("TextLabel", Slider["37"]);
				Slider["3c"]["TextWrapped"] = true;
				Slider["3c"]["BorderSizePixel"] = 0;
				Slider["3c"]["TextSize"] = 14;
				Slider["3c"]["TextXAlignment"] = Enum.TextXAlignment.Right;
				Slider["3c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["3c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				Slider["3c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Slider["3c"]["BackgroundTransparency"] = 1;
				Slider["3c"]["AnchorPoint"] = Vector2.new(1, 0);
				Slider["3c"]["Size"] = UDim2.new(0, 24, 1, -10);
				Slider["3c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Slider["3c"]["Text"] = tostring(options.default);
				Slider["3c"]["Name"] = [[Value]];
				Slider["3c"]["Position"] = UDim2.new(1, 0, 0, 0);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.SliderBack
				Slider["3d"] = Instance.new("Frame", Slider["37"]);
				Slider["3d"]["BorderSizePixel"] = 0;
				Slider["3d"]["BackgroundColor3"] = Color3.fromRGB(17, 17, 17);
				Slider["3d"]["AnchorPoint"] = Vector2.new(0, 1);
				Slider["3d"]["Size"] = UDim2.new(1, 0, 0, 4);
				Slider["3d"]["Position"] = UDim2.new(0, 0, 1, 0);
				Slider["3d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Slider["3d"]["Name"] = [[SliderBack]];


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.SliderBack.UICorner
				Slider["3e"] = Instance.new("UICorner", Slider["3d"]);
				Slider["3e"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.SliderBack.UIStroke
				Slider["3f"] = Instance.new("UIStroke", Slider["3d"]);
				Slider["3f"]["Color"] = Color3.fromRGB(64, 64, 64);
				Slider["3f"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.SliderBack.Draggable
				Slider["40"] = Instance.new("Frame", Slider["3d"]);
				Slider["40"]["BorderSizePixel"] = 0;
				Slider["40"]["BackgroundColor3"] = Color3.fromRGB(57, 57, 57);
				Slider["40"]["Size"] = UDim2.new(0.5, 0, 1, 0);
				Slider["40"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				Slider["40"]["Name"] = [[Draggable]];


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Slider.SliderBack.Draggable.UICorner
				Slider["41"] = Instance.new("UICorner", Slider["40"]);
				Slider["41"]["CornerRadius"] = UDim.new(0, 4);
			end

			-- Methods
			function Slider:SetValue(v)
				if v == nil then
					local percentage = math.clamp((mouse.X - Slider["3d"].AbsolutePosition.X) / (Slider["3d"].AbsoluteSize.X), 0, 1)
					local value = math.floor(((options.Max - options.Min) * math.clamp(percentage, 0, 1)) + options.Min)

					Slider["3c"].Text = tostring(value)
					Slider["40"].Size = UDim2.fromScale(percentage, 1)

				else
					Slider["3c"].Text = tostring(v)
					Slider["40"].Size = UDim2.fromScale(((v - options.Min) / (options.Max - options.Min)), 1)
				end
				options.callback(Slider:GetValue())
			end

			function Slider:GetValue()
				return tostring(Slider["3c"].Text)
			end

			-- Logic
			do
				Slider["37"].MouseEnter:Connect(function()
					Slider.Hover = true

					Daily:tween(Slider["39"], {Color = Color3.fromRGB(102, 102, 102)})
					Daily:tween(Slider["3f"], {Color = Color3.fromRGB(102, 102, 102)})
					Daily:tween(Slider["40"], {BackgroundColor3 = Color3.fromRGB(102, 102, 102)})
				end)

				Slider["37"].MouseLeave:Connect(function()
					Slider.Hover = false

					if not Slider.MouseDown then
						Daily:tween(Slider["39"], {Color = Color3.fromRGB(82, 82, 82)})
						Daily:tween(Slider["3f"], {Color = Color3.fromRGB(82, 82, 82)})
						Daily:tween(Slider["40"], {BackgroundColor3 = Color3.fromRGB(82, 82, 82)})
					end
				end)

				uis.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Hover then
						Slider.MouseDown = true
						Daily:tween(Slider["37"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Daily:tween(Slider["39"], {Color = Color3.fromRGB(200, 200, 200)})
						Daily:tween(Slider["3f"], {Color = Color3.fromRGB(200, 200, 200)})
						Daily:tween(Slider["40"], {BackgroundColor3 = Color3.fromRGB(200, 200, 200)})


						if not Slider.Connection then
							Slider.Connection = RunService.RenderStepped:Connect(function()
								Slider:SetValue()
							end)
						end
					end
				end)

				uis.InputEnded:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Slider.MouseDown = false

						if Slider.Hover then
							Daily:tween(Slider["37"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(Slider["39"], {Color = Color3.fromRGB(102, 102, 102)})
							Daily:tween(Slider["3f"], {Color = Color3.fromRGB(102, 102, 102)})
							Daily:tween(Slider["40"], {BackgroundColor3 = Color3.fromRGB(102, 102, 102)})
						else
							Daily:tween(Slider["37"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(Slider["39"], {Color = Color3.fromRGB(82, 82, 82)})
							Daily:tween(Slider["3f"], {Color = Color3.fromRGB(82, 82, 82)})
							Daily:tween(Slider["40"], {BackgroundColor3 = Color3.fromRGB(82, 82, 82)})
						end

						if Slider.Connection then Slider.Connection:Disconnect() end
						Slider.Connection = nil
					end
				end)
			end



			return Slider
		end

		function Tab:Dropdown(options)
			options = Daily:validate({
				Text = "Daily Dropdown",
				Icon = Icons.DefaultIcon.Down,
				items = {},
				callback = function() end
			}, options or {})

			local DropDown = {
				Items = {
					["id"] = {	
						instance = {},
						"value"
					}
				},
				Open = false,
				MouseDown = false,
				Hover = false,
				HoveringItem = false
			}

			-- Render
			do
				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown
				DropDown["42"] = Instance.new("Frame", Tab["1c"]);
				DropDown["42"]["BorderSizePixel"] = 0;
				DropDown["42"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
				DropDown["42"]["ClipsDescendants"] = true;
				DropDown["42"]["Size"] = UDim2.new(1, 0, 0, 30);
				DropDown["42"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				DropDown["42"]["Name"] = options.Text


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.UICorner
				DropDown["43"] = Instance.new("UICorner", DropDown["42"]);
				DropDown["43"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.UIStroke
				DropDown["44"] = Instance.new("UIStroke", DropDown["42"]);
				DropDown["44"]["Color"] = Color3.fromRGB(82, 82, 82);
				DropDown["44"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.Title
				DropDown["45"] = Instance.new("TextLabel", DropDown["42"]);
				DropDown["45"]["TextWrapped"] = true;
				DropDown["45"]["BorderSizePixel"] = 0;
				DropDown["45"]["TextSize"] = 14;
				DropDown["45"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				DropDown["45"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				DropDown["45"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				DropDown["45"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				DropDown["45"]["BackgroundTransparency"] = 1;
				DropDown["45"]["Size"] = UDim2.new(1, -20, 0, 20);
				DropDown["45"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				DropDown["45"]["Text"] = options.Text;
				DropDown["45"]["Name"] = [[Title]];


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.UIPadding
				DropDown["46"] = Instance.new("UIPadding", DropDown["42"]);
				DropDown["46"]["PaddingTop"] = UDim.new(0, 6);
				DropDown["46"]["PaddingRight"] = UDim.new(0, 6);
				DropDown["46"]["PaddingLeft"] = UDim.new(0, 6);
				DropDown["46"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.Icon
				DropDown["47"] = Instance.new("ImageLabel", DropDown["42"]);
				DropDown["47"]["BorderSizePixel"] = 0;
				DropDown["47"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				DropDown["47"]["AnchorPoint"] = Vector2.new(1, 0);
				DropDown["47"]["Image"] = options.Icon;
				DropDown["47"]["Size"] = UDim2.new(0, 20, 0, 20);
				DropDown["47"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				DropDown["47"]["BackgroundTransparency"] = 1;
				DropDown["47"]["Name"] = [[Icon]];
				DropDown["47"]["Position"] = UDim2.new(1, 0, 0, 0);


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.OptionHolder
				DropDown["48"] = Instance.new("Frame", DropDown["42"]);
				DropDown["48"]["Visible"] = false;
				DropDown["48"]["BorderSizePixel"] = 0;
				DropDown["48"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				DropDown["48"]["Size"] = UDim2.new(1, 0, 1, -24);
				DropDown["48"]["Position"] = UDim2.new(0, 0, 0, 26);
				DropDown["48"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				DropDown["48"]["Name"] = [[OptionHolder]];
				DropDown["48"]["BackgroundTransparency"] = 1;


				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.OptionHolder.UIListLayout
				DropDown["49"] = Instance.new("UIListLayout", DropDown["48"]);
				DropDown["49"]["Padding"] = UDim.new(0, 4);
				DropDown["49"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
			end

			-- Methods
			function DropDown:Add(id, value)
				local Item = {
					Hover = false,
					MouseDown = false
				}

				if DropDown.Items[id] ~= nil then 
					warn("Dropdown already has item with id: " .. id)
					return 
				end

				DropDown.Items[id] = {
					instance = {},
					value = value
				}

				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.OptionHolder.Inactive Option
				DropDown.Items[id].instance["4a"] = Instance.new("TextLabel", DropDown["48"])
				DropDown.Items[id].instance["4a"].BorderSizePixel = 0
				DropDown.Items[id].instance["4a"].TextSize = 12
				DropDown.Items[id].instance["4a"].BackgroundColor3 = Color3.fromRGB(57, 57, 57)
				DropDown.Items[id].instance["4a"].FontFace = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				DropDown.Items[id].instance["4a"].TextColor3 = Color3.fromRGB(203, 203, 203)
				DropDown.Items[id].instance["4a"].Size = UDim2.new(1, 0, 0, 16)
				DropDown.Items[id].instance["4a"].BorderColor3 = Color3.fromRGB(0, 0, 0)
				DropDown.Items[id].instance["4a"].Text = id
				DropDown.Items[id].instance["4a"].Name = id

				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.OptionHolder.Inactive Option.UIStroke
				DropDown.Items[id].instance["4b"] = Instance.new("UIStroke", DropDown.Items[id].instance["4a"])
				DropDown.Items[id].instance["4b"].Color = Color3.fromRGB(82, 82, 82)
				DropDown.Items[id].instance["4b"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				-- StarterGui.CraftGui.Main.ConentContainer.HomeTab.Dropdown.OptionHolder.Inactive Option.UICorner
				DropDown.Items[id].instance["4c"] = Instance.new("UICorner", DropDown.Items[id].instance["4a"])
				DropDown.Items[id].instance["4c"].CornerRadius = UDim.new(0, 2)

				DropDown.Items[id].instance["4a"].MouseEnter:Connect(function()
					Item.Hover = true
					DropDown.HoveringItem = true

					if Item.Hover then
						Daily:tween(DropDown.Items[id].instance["4b"], {Color = Color3.fromRGB(102, 102, 102)})
						Daily:tween(DropDown.Items[id].instance["4a"], {BackgroundColor3 = Color3.fromRGB(82, 82, 82)})
					end
				end)

				DropDown.Items[id].instance["4a"].MouseLeave:Connect(function()
					DropDown.HoveringItem = false
					Item.Hover = false
					if not Item.MouseDown then
						Daily:tween(DropDown.Items[id].instance["4b"], {Color = Color3.fromRGB(82, 82, 82)})
						Daily:tween(DropDown.Items[id].instance["4a"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
					end
				end)

				uis.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if DropDown.Items[id] == nil then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover then
						Item.MouseDown = true
						DropDown.HoveringItem = true
						Daily:tween(DropDown.Items[id].instance["4a"], {BackgroundColor3 = Color3.fromRGB(102, 102, 102)})
						Daily:tween(DropDown.Items[id].instance["4b"], {Color = Color3.fromRGB(102, 102, 102)})
						options.callback(value)
					end
				end)

				uis.InputEnded:Connect(function(input, gpe)
					if gpe then return end

					if DropDown.Items[id] == nil then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						Item.MouseDown = false
						if Item.Hover then
							Daily:tween(DropDown.Items[id].instance["4a"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(DropDown.Items[id].instance["4b"], {Color = Color3.fromRGB(102, 102, 102)})
						else
							Daily:tween(DropDown.Items[id].instance["4a"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(DropDown.Items[id].instance["4b"], {Color = Color3.fromRGB(82, 82, 82)})
						end
					end
				end)
			end

			function DropDown:Remove(id)
				if DropDown.Items[id] ~= nil then
					if DropDown.Items[id].instance ~= nil then

						if DropDown.Open then
							DropDown["48"].Visible = false
							Daily:tween(DropDown["42"], {Size = UDim2.new(1, 0, 0, 1)})
							task.wait(0.1)
							Daily:tween(DropDown["42"], {Size = UDim2.new(1, 0, 0, 30)})
						end

						for i, v in pairs(DropDown.Items[id].instance) do
							if v then
								v:Destroy()
							end
						end

					end

					DropDown.Items[id] = nil
				end
			end

			function DropDown:Clear()
				for i, v in pairs(DropDown.Items) do
					DropDown:Remove(i)
				end
			end


			function DropDown:Toggle()
				if DropDown.Open then
					Daily:tween(DropDown["42"], {Size = UDim2.new(1, 0, 0, 30)}, function()
						DropDown["48"].Visible = false
					end)
				else
					local count = 0
					for i, v in pairs(DropDown.Items) do
						if v ~= nil then
							count += 1
						end
					end

					DropDown["48"].Visible = true
					Daily:tween(DropDown["42"], {Size = UDim2.new(1, 0, 0, 30 + (count * 16) + 1)})
				end
				DropDown.Open = not DropDown.Open
			end



			-- Logic
			do
				DropDown["42"].MouseEnter:Connect(function()
					DropDown.Hover = true

					Daily:tween(DropDown["44"], {Color = Color3.fromRGB(200, 200, 200)})
				end)

				DropDown["42"].MouseLeave:Connect(function()
					DropDown.Hover = false

					if not DropDown.MouseDown then
						Daily:tween(DropDown["44"], {Color = Color3.fromRGB(82, 82, 82)})
					end
				end)

				uis.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 and DropDown.Hover then
						DropDown.MouseDown = true
						Daily:tween(DropDown["42"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Daily:tween(DropDown["44"], {Color = Color3.fromRGB(200, 200, 200)})
						if not DropDown.HoveringItem then
							DropDown:Toggle()
						end
					end
				end)

				uis.InputEnded:Connect(function(input, gpe)
					if gpe then return end

					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						DropDown.MouseDown = false

						if DropDown.Hover then
							Daily:tween(DropDown["42"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(DropDown["44"], {Color = Color3.fromRGB(200, 200, 200)})
						else
							Daily:tween(DropDown["42"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Daily:tween(DropDown["44"], {Color = Color3.fromRGB(82, 82, 82)})
						end
					end
				end)
			end

			DropDown.CanClose = true

			return DropDown
		end

		function Tab:TextBox(options)
			options = Daily:validate({
				Text = "Daily Textbox",
				EmptyText = "Click to enter text",
				callback = function() end
			}, options or {})

			local TextBox = {}

			-- Render
			do
				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox
				TextBox["60"] = Instance.new("Frame", Tab["1c"]);
				TextBox["60"]["BorderSizePixel"] = 0;
				TextBox["60"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
				TextBox["60"]["Size"] = UDim2.new(1, 0, 0, 38);
				TextBox["60"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				TextBox["60"]["Name"] = options.Text


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.UICorner
				TextBox["6a"] = Instance.new("UICorner", TextBox["60"]);
				TextBox["6a"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.UIStroke
				TextBox["61"] = Instance.new("UIStroke", TextBox["60"]);
				TextBox["61"]["Color"] = Color3.fromRGB(83, 83, 83);
				TextBox["61"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.UIPadding
				TextBox["62"] = Instance.new("UIPadding", TextBox["60"]);
				TextBox["62"]["PaddingTop"] = UDim.new(0, 6);
				TextBox["62"]["PaddingRight"] = UDim.new(0, 6);
				TextBox["62"]["PaddingLeft"] = UDim.new(0, 6);
				TextBox["62"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.TextBox
				TextBox["63"] = Instance.new("TextBox", TextBox["60"]);
				TextBox["63"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				TextBox["63"]["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255);
				TextBox["63"]["BorderSizePixel"] = 0;
				TextBox["63"]["TextSize"] = 14;
				TextBox["63"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				TextBox["63"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				TextBox["63"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				TextBox["63"]["PlaceholderText"] = options.EmptyText;
				TextBox["63"]["Size"] = UDim2.new(1, 0, 1, 0);
				TextBox["63"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				TextBox["63"]["Text"] = options.Text;
				TextBox["63"]["BackgroundTransparency"] = 1;


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.TextBox.UIPadding
				TextBox["64"] = Instance.new("UIPadding", TextBox["63"]);
				TextBox["64"]["PaddingLeft"] = UDim.new(0, 10);


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.Line1
				TextBox["65"] = Instance.new("Frame", TextBox["60"]);
				TextBox["65"]["BorderSizePixel"] = 0;
				TextBox["65"]["BackgroundColor3"] = Color3.fromRGB(83, 83, 83);
				TextBox["65"]["Size"] = UDim2.new(1, 0, 0, 1);
				TextBox["65"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				TextBox["65"]["Name"] = [[Line1]];


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.Line2
				TextBox["66"] = Instance.new("Frame", TextBox["60"]);
				TextBox["66"]["BorderSizePixel"] = 0;
				TextBox["66"]["BackgroundColor3"] = Color3.fromRGB(83, 83, 83);
				TextBox["66"]["AnchorPoint"] = Vector2.new(0, 1);
				TextBox["66"]["Size"] = UDim2.new(1, 0, 0, 1);
				TextBox["66"]["Position"] = UDim2.new(0, 0, 1, 0);
				TextBox["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				TextBox["66"]["Name"] = [[Line2]];


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.Line3
				TextBox["67"] = Instance.new("Frame", TextBox["60"]);
				TextBox["67"]["BorderSizePixel"] = 0;
				TextBox["67"]["BackgroundColor3"] = Color3.fromRGB(83, 83, 83);
				TextBox["67"]["Size"] = UDim2.new(0, 1, 1, 0);
				TextBox["67"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				TextBox["67"]["Name"] = [[Line3]];


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.TextBox.Line4
				TextBox["68"] = Instance.new("Frame", TextBox["60"]);
				TextBox["68"]["BorderSizePixel"] = 0;
				TextBox["68"]["BackgroundColor3"] = Color3.fromRGB(83, 83, 83);
				TextBox["68"]["AnchorPoint"] = Vector2.new(1, 0);
				TextBox["68"]["Size"] = UDim2.new(0, 1, 1, 0);
				TextBox["68"]["Position"] = UDim2.new(1, 0, 0, 0);
				TextBox["68"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				TextBox["68"]["Name"] = [[Line4]];
			end

			-- Logic
			TextBox["63"].FocusLost:Connect(function(enterPressed)
				if enterPressed then
					options.callback(TextBox["63"].Text)
				end
			end)

			return TextBox
		end

		function Tab:KeyBind(options)
			options = Daily:validate({
				Text = "Daily KeyBind",
				Input = nil,
				callback = function() end
			}, options or {})

			local KeyBind = {}
			local waiting = false
			local currentKey = options.Input

			do
				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.KeyBind
				KeyBind["69"] = Instance.new("Frame", Tab["1c"]);
				KeyBind["69"]["BorderSizePixel"] = 0;
				KeyBind["69"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
				KeyBind["69"]["Size"] = UDim2.new(1, 0, 0, 38);
				KeyBind["69"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				KeyBind["69"]["Name"] = options.Text


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.KeyBind.UICorner
				KeyBind["70"] = Instance.new("UICorner", KeyBind["69"]);
				KeyBind["70"]["CornerRadius"] = UDim.new(0, 4);


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.KeyBind.UIStroke
				KeyBind["7a"] = Instance.new("UIStroke", KeyBind["69"]);
				KeyBind["7a"]["Color"] = Color3.fromRGB(83, 83, 83);
				KeyBind["7a"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.KeyBind.Title
				KeyBind["7b"] = Instance.new("TextLabel", KeyBind["60"]);
				KeyBind["7b"]["TextWrapped"] = true;
				KeyBind["7b"]["BorderSizePixel"] = 0;
				KeyBind["7b"]["TextSize"] = 14;
				KeyBind["7b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				KeyBind["7b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				KeyBind["7b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				KeyBind["7b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				KeyBind["7b"]["BackgroundTransparency"] = 1;
				KeyBind["7b"]["Size"] = UDim2.new(1, 0, 1, 0);
				KeyBind["7b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				KeyBind["7b"]["Text"] = options.Text;
				KeyBind["7b"]["Name"] = [[Title]];


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.KeyBind.UIPadding
				KeyBind["7c"] = Instance.new("UIPadding", KeyBind["60"]);
				KeyBind["7c"]["PaddingTop"] = UDim.new(0, 6);
				KeyBind["7c"]["PaddingRight"] = UDim.new(0, 6);
				KeyBind["7c"]["PaddingLeft"] = UDim.new(0, 6);
				KeyBind["7c"]["PaddingBottom"] = UDim.new(0, 6);


				-- StarterGui.CraftGui.Main.ConentContainer.MainTab.KeyBind.BindText
				KeyBind["7d"] = Instance.new("TextLabel", KeyBind["69"]);
				KeyBind["7d"]["TextWrapped"] = true;
				KeyBind["7d"]["BorderSizePixel"] = 0;
				KeyBind["7d"]["TextSize"] = 14;
				KeyBind["7d"]["TextXAlignment"] = Enum.TextXAlignment.Right;
				KeyBind["7d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				KeyBind["7d"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
				KeyBind["7d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				KeyBind["7d"]["BackgroundTransparency"] = 1;
				KeyBind["7d"]["AnchorPoint"] = Vector2.new(1, 0);
				KeyBind["7d"]["Size"] = UDim2.new(1, 0, 1, 0);
				KeyBind["7d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
				KeyBind["7d"]["Text"] = options.Text;
				KeyBind["7d"]["Name"] = [[BindText]];
				KeyBind["7d"]["Position"] = UDim2.new(1, 0, 0, 0);

			end

			if currentKey then
				KeyBind["7d"].Text = currentKey.Name
			end

			KeyBind["69"].InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					waiting = true
					KeyBind["7d"].Text = "..."
				end
			end)

			uis.InputBegan:Connect(function(input, gpe)
				if gpe then return end

				if waiting and input.UserInputType == Enum.UserInputType.Keyboard then
					waiting = false
					currentKey = input.KeyCode
					KeyBind["7d"].Text = currentKey.Name
					return
				end

				if currentKey and input.KeyCode == currentKey then
					options.callback(currentKey)
				end
			end)

			function KeyBind:Switch()
				if KeyBind.Connection then return end

				KeyBind.Connection = uis.InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if input.KeyCode == currentKey then
						GUI.ClosedState = not GUI.ClosedState
						GUI["2"].Visible = not GUI.ClosedState

						if options.callback then
							options.callback()
						end
					end
				end)
			end
			return KeyBind
		end




		return Tab
	end
	
	function GUI:Popup(options)
		options = Daily:validate({
			Text = "Are you sure?",
			Confirm = "Yes",
			Cancel = "No",
			Confirmcallback = function() end,
			Cancelcallback = function() end
		}, options or {})

		local Popup = {}
		
		-- Render
		do
			-- StarterGui.Daily UI.Main.Popup
			Popup["71"] = Instance.new("Frame", GUI["2"]);
			Popup["71"]["BorderSizePixel"] = 0;
			Popup["71"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Popup["71"]["Size"] = UDim2.new(0, 400, 0, 300);
			Popup["71"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Popup["71"]["Name"] = [[Popup]];
			Popup["71"]["BackgroundTransparency"] = 1;


			-- StarterGui.Daily UI.Main.Popup.Darkness
			Popup["72"] = Instance.new("Frame", Popup["71"]);
			Popup["72"]["BorderSizePixel"] = 0;
			Popup["72"]["BackgroundColor3"] = Color3.fromRGB(213, 215, 215);
			Popup["72"]["Size"] = UDim2.new(0, 400, 0, 300);
			Popup["72"]["Position"] = UDim2.new(0.01, 0, 0, 0);
			Popup["72"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Popup["72"]["Name"] = [[Darkness]];
			Popup["72"]["BackgroundTransparency"] = 0.3;


			-- StarterGui.Daily UI.Main.Popup.Darkness.UIGradient
			Popup["73"] = Instance.new("UIGradient", Popup["72"]);
			Popup["73"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0.3),NumberSequenceKeypoint.new(1.000, 0.3)};
			Popup["73"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(54, 54, 54)),ColorSequenceKeypoint.new(0.567, Color3.fromRGB(158, 159, 161)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(161, 163, 163))};


			-- StarterGui.Daily UI.Main.Popup.PopupHolder
			Popup["74"] = Instance.new("Frame", Popup["71"]);
			Popup["74"]["BorderSizePixel"] = 0;
			Popup["74"]["BackgroundColor3"] = Color3.fromRGB(100, 102, 102);
			Popup["74"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			Popup["74"]["Size"] = UDim2.new(0, 270, 0, 150);
			Popup["74"]["Position"] = UDim2.new(0.55, 0, 0.5, 0);
			Popup["74"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Popup["74"]["Name"] = [[PopupHolder]];
			Popup["74"]["BackgroundTransparency"] = 0.3;


			-- StarterGui.Daily UI.Main.Popup.PopupHolder.UIGradient
			Popup["7e"] = Instance.new("UIGradient", Popup["74"]);
			Popup["7e"]["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0.3),NumberSequenceKeypoint.new(1.000, 0.3)};
			Popup["7e"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(54, 54, 54)),ColorSequenceKeypoint.new(0.567, Color3.fromRGB(158, 159, 161)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(161, 163, 163))};


			-- StarterGui.Daily UI.Main.Popup.PopupHolder.Title
			Popup["7f"] = Instance.new("TextLabel", Popup["74"]);
			Popup["7f"]["TextWrapped"] = true;
			Popup["7f"]["BorderSizePixel"] = 0;
			Popup["7f"]["TextSize"] = 14;
			Popup["7f"]["TextScaled"] = true;
			Popup["7f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Popup["7f"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Popup["7f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Popup["7f"]["BackgroundTransparency"] = 1;
			Popup["7f"]["Size"] = UDim2.new(0, 270, 0, 35);
			Popup["7f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Popup["7f"]["Text"] = options.Text;
			Popup["7f"]["Name"] = options.Text;


			-- StarterGui.Daily UI.Main.Popup.PopupHolder.No
			Popup["7g"] = Instance.new("TextLabel", Popup["74"]);
			Popup["7g"]["TextWrapped"] = true;
			Popup["7g"]["BorderSizePixel"] = 0;
			Popup["7g"]["TextSize"] = 14;
			Popup["7g"]["TextScaled"] = true;
			Popup["7g"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
			Popup["7g"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Popup["7g"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Popup["7g"]["Size"] = UDim2.new(0, 83, 0, 45);
			Popup["7g"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Popup["7g"]["Text"] = options.Cancel;
			Popup["7g"]["Name"] = options.Cancel;
			Popup["7g"]["Position"] = UDim2.new(0, 0, 0.58, 0);


			-- StarterGui.Daily UI.Main.Popup.PopupHolder.Yes
			Popup["7h"] = Instance.new("TextLabel", Popup["74"]);
			Popup["7h"]["TextWrapped"] = true;
			Popup["7h"]["BorderSizePixel"] = 0;
			Popup["7h"]["TextSize"] = 14;
			Popup["7h"]["TextScaled"] = true;
			Popup["7h"]["BackgroundColor3"] = Color3.fromRGB(49, 255, 38);
			Popup["7h"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Popup["7h"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			Popup["7h"]["Size"] = UDim2.new(0, 83, 0, 45);
			Popup["7h"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			Popup["7h"]["Text"] = options.Confirm
			Popup["7h"]["Name"] = options.Confirm
			Popup["7h"]["Position"] = UDim2.new(0.69259, 0, 0.58, 0);
		end
		
		Popup["7g"].InputBegan:Connect(function(input, gpe)
			if gpe then return end
			
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Popup["71"].Visible = false
				options.Confirmcallback()
			end
		end)
		
		Popup["7h"].InputBegan:Connect(function(input, gpe)
			if gpe then return end

			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Popup["71"].Visible = false
				options.Cancelcallback()
			end
		end)
			

		return Popup
	end
	
	return GUI
end

function Daily:Notify(firstArg, secondArg, thirdArg, fourthArg, ...)
	local options

	if typeof(firstArg) == "table" then
		options = firstArg
	else
		options = {
			Title   = firstArg,
			Text    = secondArg,
			Time    = thirdArg,
			SoundID = fourthArg,
		}
	end

	local Title = options.Title or "Notification"
	local Text = options.Text or "Message"
	local Time = options.Time or 3
	local SoundID = options.SoundID or Sounds.Default.Notify1
	local Volume  = options.Volume or 0.5

	if typeof(Title) ~= "string" then Title = tostring(Title) or "Notification" end
	if typeof(Text) ~= "string" then Text = tostring(Text) or "Message"	end
	if typeof(Time) ~= "number" then Time = 3	end
	if typeof(Volume) ~= "number" then Volume = 0.5	end

	local Notify = {}

	do
		-- StarterGui.CraftNotify
		Notify["1"] = Instance.new("ScreenGui", RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui") or coreGui);
		Notify["1"]["IgnoreGuiInset"] = true;
		Notify["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
		Notify["1"]["Name"] = [[CraftNotify]];
		Notify["1"]["ResetOnSpawn"] = false;

		Notify["2"] = Instance.new("Frame", Notify["1"]);
		Notify["2"]["BorderSizePixel"] = 0;
		Notify["2"]["BackgroundColor3"] = Color3.fromRGB(171, 171, 171);
		Notify["2"]["AnchorPoint"] = Vector2.new(1, 1);
		Notify["2"]["Size"] = UDim2.new(0, 250, 0, 200);
		Notify["2"]["Position"] = UDim2.new(1, 300, 1, -10);
		Notify["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notify["2"]["Name"] = [[Main]];
		Notify["2"]["BackgroundTransparency"] = 1;

		Notify["3"] = Instance.new("UICorner", Notify["2"]);
		Notify["3"]["CornerRadius"] = UDim.new(0, 4);

		Notify["4"] = Instance.new("TextLabel", Notify["2"]);
		Notify["4"]["BorderSizePixel"] = 0;
		Notify["4"]["TextSize"] = 14;
		Notify["4"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		Notify["4"]["TextYAlignment"] = Enum.TextYAlignment.Top;
		Notify["4"]["BackgroundColor3"] = Color3.fromRGB(171, 171, 171);
		Notify["4"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Notify["4"]["TextColor3"] = Color3.fromRGB(201, 201, 201);
		Notify["4"]["BackgroundTransparency"] = 1;
		Notify["4"]["Size"] = UDim2.new(0, 250, 0, 30);
		Notify["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notify["4"]["Text"] = Title;
		Notify["4"]["Name"] = [[Title]];
		Notify["4"]["TextTransparency"] = 1;

		Notify["5"] = Instance.new("UIPadding", Notify["4"]);
		Notify["5"]["PaddingTop"] = UDim.new(0, 4);
		Notify["5"]["PaddingLeft"] = UDim.new(0, 8);

		Notify["6"] = Instance.new("TextLabel", Notify["2"]);
		Notify["6"]["TextWrapped"] = true;
		Notify["6"]["BorderSizePixel"] = 0;
		Notify["6"]["TextSize"] = 14;
		Notify["6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		Notify["6"]["TextYAlignment"] = Enum.TextYAlignment.Top;
		Notify["6"]["BackgroundColor3"] = Color3.fromRGB(171, 171, 171);
		Notify["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Notify["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		Notify["6"]["BackgroundTransparency"] = 1;
		Notify["6"]["Size"] = UDim2.new(0, 250, 0, 170);
		Notify["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notify["6"]["Text"] = Text;
		Notify["6"]["Name"] = [[Text]];
		Notify["6"]["Position"] = UDim2.new(0, 0, 0, 30);
		Notify["6"]["TextTransparency"] = 1;

		Notify["7"] = Instance.new("UIPadding", Notify["6"]);
		Notify["7"]["PaddingTop"] = UDim.new(0, 4);
		Notify["7"]["PaddingLeft"] = UDim.new(0, 8);

		Notify["8"] = Instance.new("Frame", Notify["2"]);
		Notify["8"]["BorderSizePixel"] = 0;
		Notify["8"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		Notify["8"]["Size"] = UDim2.new(1, 0, 0, 1);
		Notify["8"]["Position"] = UDim2.new(0, 0, 0, 31);
		Notify["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notify["8"]["Name"] = [[Line1]];

		Notify["9"] = Instance.new("UICorner", Notify["8"]);
		Notify["9"]["CornerRadius"] = UDim.new(0, 4);

		Notify["a"] = Instance.new("Frame", Notify["2"]);
		Notify["a"]["BorderSizePixel"] = 0;
		Notify["a"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		Notify["a"]["Size"] = UDim2.new(0, -1, 0, 200);
		Notify["a"]["Position"] = UDim2.new(0.004, 0, 0, 0);
		Notify["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notify["a"]["Name"] = [[Line2]];

		Notify["b"] = Instance.new("UICorner", Notify["a"]);
		Notify["b"]["CornerRadius"] = UDim.new(0, 4);

		Notify["c"] = Instance.new("Frame", Notify["2"]);
		Notify["c"]["BorderSizePixel"] = 0;
		Notify["c"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		Notify["c"]["Size"] = UDim2.new(0, 250, 0, 1);
		Notify["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notify["c"]["Name"] = [[Line3]];

		Notify["d"] = Instance.new("UICorner", Notify["c"]);
		Notify["d"]["CornerRadius"] = UDim.new(0, 4);

		Notify["e"] = Instance.new("Frame", Notify["2"]);
		Notify["e"]["BorderSizePixel"] = 0;
		Notify["e"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		Notify["e"]["Size"] = UDim2.new(0, 250, 0, 1);
		Notify["e"]["Position"] = UDim2.new(0, 0, 1, 0);
		Notify["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notify["e"]["Name"] = [[Line4]];

		Notify["f"] = Instance.new("UICorner", Notify["e"]);
		Notify["f"]["CornerRadius"] = UDim.new(0, 4);

		Notify["10"] = Instance.new("Frame", Notify["2"]);
		Notify["10"]["BorderSizePixel"] = 0;
		Notify["10"]["BackgroundColor3"] = Color3.fromRGB(82, 82, 82);
		Notify["10"]["Size"] = UDim2.new(0, 1, 1, 0);
		Notify["10"]["Position"] = UDim2.new(1, 0, 0, 0);
		Notify["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		Notify["10"]["Name"] = [[Line5]];

		Notify["11"] = Instance.new("UICorner", Notify["10"]);
		Notify["11"]["CornerRadius"] = UDim.new(0, 4);

		Notify["12"] = Instance.new("Sound", Notify["2"]);

		local finalSoundID
		if typeof(SoundID) == "string" or typeof(SoundID) == "number" then
			finalSoundID = tostring(SoundID)
		else
			finalSoundID = Sounds.Default.Notify1 or Sounds.Notify.Notify1 or "6026984224"
		end

		Notify["12"].SoundId = "rbxassetid://" .. finalSoundID
		Notify["12"].Volume = math.clamp(Volume, 0, 2)
		Notify["12"].Name = "Notify1"
		Notify["12"]:Play()
		game:GetService("Debris"):AddItem(Notify["12"], 6)

		Daily:tween(Notify["2"], {
			Position = UDim2.new(1, -10, 1, -10),
			BackgroundTransparency = 0.6
		})
		Daily:tween(Notify["4"], {TextTransparency = 0})
		Daily:tween(Notify["6"], {TextTransparency = 0})

		task.delay(Time, function()
			Daily:tween(Notify["2"], {BackgroundTransparency = 1})
			task.delay(0.4, function()
				Daily:tween(Notify["4"], {TextTransparency = 1})
				Daily:tween(Notify["6"], {TextTransparency = 1})
			end)
			task.delay(1, function()
				if Notify["1"] and Notify["1"].Parent then
					Notify["1"]:Destroy()
				end
			end)
		end)
	end

	return Notify
end

return Daily

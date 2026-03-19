local Craft = loadstring(game:HttpGet("https://raw.githubusercontent.com/wdesadwdaws/Craft-UI/refs/heads/main/Src.lua"))()

local Main = Craft:Init({
    Title = "Testing ahh Title"
})

local Tab = Main:CreateTab({
	Title = "AHH TAB TOO OMG"
})

local Warning = Tab:Warning({
	Text = "no more ahh lol"
})

local Info = Tab:Info({
	Text = "Info"
})

local Label = Tab:Label({
	Text = "Label"
})


local Slider = Tab:Slider({
	callback = function(value) 
		lp.Character.Humanoid.WalkSpeed = value
	end,
})

local Toggle = Tab:Toggle({
	callback = function(value)
		print(value)
	end,
})

local Dropdown = Tab:Dropdown({
	Text = "Testing",
	callback = function(v)
		print(v .. " was clicked")
	end,
})

local Keybind = Tab:Keybind({
	Text = "Keybind",
	input = Enum.KeyCode.Q,
	callback = function(key)
		print("user pressed" .. " key")
	end,
})
Dropdown:Add("1", 1)
Dropdown:Add("2", 2)
Dropdown:Add("3", 3)
Dropdown:Add("4", 4)

local TextBox = Tab:TextBox({
	Text = "Type something",
	callback = function(value)
		print("New Text: " .. value)
		if value == "Hello" then
			print("Hello was typed")
		end
	end,
})




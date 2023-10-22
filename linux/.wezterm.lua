local wezterm = require("wezterm")

-- maximize at startup
local mux = wezterm.mux
wezterm.on("gui-attached", function(domain)
	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:gui_window():maximize()
		end
	end
end)

-- customize settings
local config = {}

-- error reporting
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- setting environment variables
-- config.set_environment_variables = {
--   setting the default shell
--   SHELL = '/home/linuxbrew/.linuxbrew/bin/nu',
-- }

-- disable missing glyphs warning
config.warn_about_missing_glyphs = false

-- default shell
config.default_prog = { "/home/linuxbrew/.linuxbrew/bin/fish" }

-- default cursor style
config.default_cursor_style = "SteadyBar"
-- config.animation_fps = 1
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"

-- font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })
config.font_size = 13

-- disabling wayland
-- config.enable_wayland = false

-- disabling window decorations
config.window_decorations = "RESIZE"

-- disabling the new tab (+) button
config.show_new_tab_button_in_tab_bar = false

-- theme
config.color_scheme = "Tokyo Night Storm"
config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = true

-- the window frame is the tab bar
config.window_frame = {
	-- the font size for tab labels
	font_size = 13.0,

	-- the background color when the window is focused
	active_titlebar_bg = "#222436",

	-- the background color when the window is not focused
	inactive_titlebar_bg = "#222436",
}

-- more tab bar colors and font settings
config.colors = {
	background = "#222436",
	tab_bar = {
		active_tab = {
			-- the color of the background area for the tab
			bg_color = "#222436",

			-- the color of the text for the tab
			fg_color = "#c0caf5",
		},

		-- inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#222436",
			fg_color = "#9aa5ce",
		},

		-- the color of the inactive tab bar edge/divider
		inactive_tab_edge = "#222436",

		-- you can configure styling when the mouse hovers over inactive tabs
		inactive_tab_hover = {
			bg_color = "#222436",
			fg_color = "#c0caf5",
		},

		-- the new tab button (+) that let you create new tabs
		new_tab = {
			bg_color = "#222436",
			fg_color = "#9aa5ce",
		},

		-- you can configure styling when the mouse hovers over inactive tabs
		new_tab_hover = {
			bg_color = "#222436",
			fg_color = "#c0caf5",
		},
	},
}

-- key binding
config.keys = {
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "PageUp",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "PageDown",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "LeftArrow",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
}

return config

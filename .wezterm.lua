local wezterm = require("wezterm")

-- customize settings
local config = {}

-- error reporting
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.initial_rows = 100
config.initial_cols = 100

-- make window slightly transparent
config.window_background_opacity = 0.90

-- disable missing glyphs warning
config.warn_about_missing_glyphs = false

-- default shell
config.default_prog = { "fish" }

-- default cursor style
config.default_cursor_style = "SteadyBlock"
-- config.animation_fps = 1
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"
config.hide_mouse_cursor_when_typing = false

-- font
config.font = wezterm.font({
	family = "UbuntuSansMono Nerd Font Mono",
	weight = "Medium",
	-- disable ligatures
	-- harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 15

-- enabling wayland
config.enable_wayland = true

-- disabling window decorations
config.window_decorations = "RESIZE"

-- disabling the new tab (+) button
config.show_new_tab_button_in_tab_bar = false

-- theme
config.color_scheme = "Catppuccin Mocha"
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

-- key bindings
config.leader = { key = 'k', mods = "CTRL"}
config.keys = {
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SpawnTab "CurrentPaneDomain",
	},
	{
		key = "t",
		mods = "SUPER",
		action = wezterm.action.DisableDefaultAssignment,
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
		key = "T",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config

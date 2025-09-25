local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("FiraMono Nerd Font")
-- config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 28.6
config.line_height = 1

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.color_scheme = "rose-pine-moon"

config.colors = {
	foreground = "#e0def4",
	background = "#000000",

	cursor_bg = "#e0def4",
	cursor_fg = "#000000",
	cursor_border = "#e0def4",

	selection_fg = "#e0def4",
	selection_bg = "#403d52",

	scrollbar_thumb = "#26233a",
	split = "#403d52",

	ansi = {
		"#393552", -- overlay
		"#eb6f92", -- red (love)
		"#3e8fb0", -- green (pine)
		"#e0c797", -- yellow (gold)
		"#b0c6d5", -- blue (foam)
		"#c4a7e7", -- magenta (iris)
		"#ebbcba", -- cyan (rose)
		"#e0def4", -- white (text)
	},

	brights = {
		"#6e6a86", -- bright black (muted)
		"#eb6f92", -- bright red
		"#3e8fb0", -- bright green
		"#e0c797", -- bright yellow
		"#b0c6d5", -- bright blue
		"#c4a7e7", -- bright magenta
		"#ebbcba", -- bright cyan
		"#e0def4", -- bright white
	},
}

config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
}

config.native_macos_fullscreen_mode = true

-- rose = "#ebbcba",
-- gold = "#e0c797",
-- foam = "#b0c6d5",

return config

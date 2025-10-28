local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config.font = wezterm.font("ComicShannsMono Nerd Font Mono")
config.font = wezterm.font("Comic Code", { weight = "Regular" })
-- config.font = wezterm.font("FiraMono Nerd Font Mono")
-- config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")

-- config.font = wezterm.font("Unifont")
config.cell_width = 1

config.font_size = 29.5
config.line_height = 1

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- vague
local vague = {
	foreground = "#cdcdcd",
	background = "#000000",

	cursor_bg = "#e0def4",
	cursor_fg = "#000000",
	cursor_border = "#e0def4",

	selection_fg = "#e0def4",
	selection_bg = "#403d52",

	scrollbar_thumb = "#26233a",
	split = "#403d52",

	brights = {
		"#252530",
		"#d8647e",
		"#7fa563",
		"#f3be7c",
		"#6e94b2",
		"#bb9dbd",
		"#aeaed1",
		"#cdcdcd",
	},

	ansi = {
		"#606079",
		"#e08398",
		"#99b782",
		"#f5cb96",
		"#8ba9c1",
		"#c9b1ca",
		"#bebeda",
		"#d7d7d7",
	},
}

local rose_pine = {
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
		"#000000",
		"#eb6f92",
		"#3e8fb0",
		"#e0c797",
		"#b0c6d5",
		"#c4a7e7",
		"#ebbcba",
		"#e0def4",
	},

	brights = {
		"#000000",
		"#eb6f92",
		"#3e8fb0",
		"#e0c797",
		"#b0c6d5",
		"#c4a7e7",
		"#ebbcba",
		"#e0def4",
	},
}

config.colors = vague

config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
}

config.native_macos_fullscreen_mode = true

return config

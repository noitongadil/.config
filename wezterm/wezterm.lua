local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("FiraMono Nerd Font")
-- config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 22.8
config.line_height = 1

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- config.color_scheme = "rose-pine-moon"
-- config.colors = {
-- 	foreground = "#e0def4",
-- 	background = "#000000",
--
-- 	cursor_bg = "#e0def4",
-- 	cursor_fg = "#000000",
-- 	cursor_border = "#e0def4",
--
-- 	selection_fg = "#e0def4",
-- 	selection_bg = "#403d52",
--
-- 	scrollbar_thumb = "#26233a",
-- 	split = "#403d52",
--
-- 	ansi = {
-- 		"#393552", -- overlay
-- 		"#eb6f92", -- red (love)
-- 		"#3e8fb0", -- green (pine)
-- 		"#e0c797", -- yellow (gold)
-- 		"#b0c6d5", -- blue (foam)
-- 		"#c4a7e7", -- magenta (iris)
-- 		"#ebbcba", -- cyan (rose)
-- 		"#e0def4", -- white (text)
-- 	},
--
-- 	brights = {
-- 		"#6e6a86", -- bright black (muted)
-- 		"#eb6f92", -- bright red
-- 		"#3e8fb0", -- bright green
-- 		"#e0c797", -- bright yellow
-- 		"#b0c6d5", -- bright blue
-- 		"#c4a7e7", -- bright magenta
-- 		"#ebbcba", -- bright cyan
-- 		"#e0def4", -- bright white
-- 	},
-- }

config.colors = {
	foreground = "#cdcdcd",
	background = "#000000",
	cursor_bg = "#cdcdcd",
	cursor_border = "#cdcdcd",
	cursor_fg = "#000000",
	selection_bg = "#405065", -- using search color for selection
	selection_fg = "#cdcdcd",

	ansi = {
		"#000000", -- black
		"#d8647e", -- red (error)
		"#7fa563", -- green (plus)
		"#f3be7c", -- yellow (warning/delta)
		"#7e98e8", -- blue (hint)
		"#bb9dbd", -- magenta (parameter)
		"#b4d4cf", -- cyan (builtin)
		"#cdcdcd", -- white (fg)
	},

	brights = {
		"#606079", -- bright black (comment)
		"#c48282", -- bright red (lighter error)
		"#9bb4bc", -- bright green (type)
		"#e8b589", -- bright yellow (string)
		"#6e94b2", -- bright blue (keyword)
		"#c48282", -- bright magenta (func)
		"#90a0b5", -- bright cyan (operator)
		"#ffffff", -- bright white
	},

	indexed = {
		[16] = "#e0a363", -- number
		[17] = "#c3c3d5", -- property
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

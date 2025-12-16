-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local wez = wezterm

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local tabBarConfig = {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 1,
		right = 1,
	},
	separator = {
		space = 0.5,
		left_icon = wez.nerdfonts.fa_long_arrow_right,
		right_icon = wez.nerdfonts.fa_long_arrow_left,
		field_icon = wez.nerdfonts.indent_line,
	},
	modules = {
		tabs = {
			active_tab_fg = 4,
			inactive_tab_fg = 6,
		},
		workspace = {
			enabled = true,
			icon = wez.nerdfonts.cod_window,
			color = 8,
		},
		leader = {
			enabled = true,
			icon = wez.nerdfonts.oct_rocket,
			color = 2,
		},
		pane = {
			enabled = true,
			icon = wez.nerdfonts.cod_multiple_windows,
			color = 7,
		},
		username = {
			enabled = true,
			icon = wez.nerdfonts.fa_user,
			color = 6,
		},
		hostname = {
			enabled = true,
			icon = wez.nerdfonts.cod_server,
			color = 8,
		},
		clock = {
			enabled = false,
			icon = wez.nerdfonts.md_calendar_clock,
			color = 5,
		},
		cwd = {
			enabled = false,
			icon = wez.nerdfonts.oct_file_directory,
			color = 7,
		},
	},
}

bar.apply_to_config(config, tabBarConfig)

config.font_size = 19
config.color_scheme = "Catpuccin Macchiato"

config.enable_tab_bar = true
config.window_decorations = "RESIZE"

config.window_background_opacity = 1
config.macos_window_background_blur = 9

config.keys = {
	{
		key = "q",
		mods = "CTRL",
		action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
	},
}

config.window_background_image = "/Users/drpoindexter/dotfiles/danbo-rain.jpg"

config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 0.15,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.0,

	-- You can adjust the saturation also.
	saturation = 1.0,
}

-- and finally, return the configuration to wezterm
return config

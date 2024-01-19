-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Freecodecamp dark theme"

config.font = wezterm.font("FiraCode Nerd Font", { weight = "DemiBold" })
config.font_size = 14
config.line_height = 1.2

config.window_background_opacity = 0.9
config.macos_window_background_blur = 15

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.hide_tab_bar_if_only_one_tab = true

local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local _, servers_pane, window = mux.spawn_window({
		cwd = wezterm.home_dir,
	})
	servers_pane:window():gui_window():toggle_fullscreen()

	servers_pane:send_text("cd Documents/projects/jooxter/jooxter-webapp-react\n")
	servers_pane:window():gui_window():maximize()
	local fa_server_pane = servers_pane:split({
		direction = "Right",
		size = 0.333,
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/front-analytics",
	})

	servers_pane:split({
		direction = "Bottom",
		size = 0.333,
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/jooxter-webapp-angular",
	})
	servers_pane:split({
		direction = "Bottom",
		size = 0.5,
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/jooxter-mobile",
	})
	fa_server_pane:split({
		direction = "Bottom",
		size = 0.5,
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/spacex-mw",
	})
	fa_server_pane:split({
		direction = "Bottom",
		size = 0.5,
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/iot-managment",
	})

	window:spawn_tab({
		direction = "Right",
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/jooxter-webapp-react",
	})
	window:spawn_tab({
		direction = "Right",
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/jooxter-webapp-angular",
	})
	window:spawn_tab({
		direction = "Right",
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/jooxter-mobile",
	})
	window:spawn_tab({
		direction = "Right",
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/front-analytics",
	})
	window:spawn_tab({
		direction = "Right",
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/spacex-mw",
	})
	window:spawn_tab({
		direction = "Right",
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/iot-managment",
	})
end)

-- and finally, return the configuration to wezterm
return config

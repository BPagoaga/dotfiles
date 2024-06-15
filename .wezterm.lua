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
-- config.color_scheme = "Freecodecamp dark theme"
config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("FiraCode Nerd Font", { weight = "DemiBold" })
config.font_size = 12
config.line_height = 1.2
config.native_macos_fullscreen_mode = false

config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.hide_tab_bar_if_only_one_tab = true
config.tab_and_split_indices_are_zero_based = false

local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local servers_tab, servers_pane, window = mux.spawn_window({
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
		cwd = wezterm.home_dir .. "/Documents/projects/jooxter/iot-managment",
	})
	servers_tab:set_title("npm")

	window
		:spawn_tab({
			direction = "Right",
			cwd = wezterm.home_dir .. "/Documents/projects/jooxter/jooxter-webapp-react",
		})
		:set_title("JWR")
	window
		:spawn_tab({
			direction = "Right",
			cwd = wezterm.home_dir .. "/Documents/projects/jooxter/jooxter-webapp-angular",
		})
		:set_title("JWA")
	window
		:spawn_tab({
			direction = "Right",
			cwd = wezterm.home_dir .. "/Documents/projects/jooxter/jooxter-mobile",
		})
		:set_title("JM")
	window
		:spawn_tab({
			direction = "Right",
			cwd = wezterm.home_dir .. "/Documents/projects/jooxter/front-analytics",
		})
		:set_title("FA")
	window
		:spawn_tab({
			direction = "Right",
			cwd = wezterm.home_dir .. "/Documents/projects/jooxter/iot-managment",
		})
		:set_title("IOT")
	window
		:spawn_tab({
			direction = "Right",
			cwd = wezterm.home_dir .. "/.config/nvim",
		})
		:set_title("Neovim Config")
	window
		:spawn_tab({
			direction = "Right",
			cwd = wezterm.home_dir,
		})
		:set_title("Home")
	local htopTab = window:spawn_tab({
		direction = "Right",
		args = {
			os.getenv("SHELL"),
			"-c",
			"btop",
		},
		cwd = wezterm.home_dir,
	})
	htopTab:set_title("btop")
end)

-- tab bar style
-- -- The filled in variant of the < symbol
-- local SOLID_LEFT_ARROW = wezterm.nerdfonts.nf_ple_upper_left_triangle
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle

-- The filled in variant of the > symbol
-- local SOLID_RIGHT_ARROW = wezterm.nerdfonts.nf_ple_upper_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local SLASH = wezterm.nerdfonts.fae_slash
local ARROW_EXPAND_RIGHT = wezterm.nerdfonts.md_arrow_expand_right

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end
config.use_fancy_tab_bar = false
config.tab_max_width = 1600

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
	local edge_background = "#2a2a40"
	local background = "#2a2a40"
	local foreground = "#808080"

	if tab.is_active then
		background = "#0a0a23"
		foreground = "#c0c0c0"
	elseif hover then
		background = "#1b1b32"
		foreground = "#909090"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = "  " .. tab.tab_index + 1 .. " " .. ARROW_EXPAND_RIGHT .. " " .. title .. "  " },
		{ Background = { Color = edge_foreground } },
		{ Foreground = { Color = "#909090" } },
		{ Text = SLASH },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

-- and finally, return the configuration to wezterm
return config

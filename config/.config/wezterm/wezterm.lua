local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12

-- Theme
config.color_scheme = "Catppuccin Macchiato"
config.window_background_opacity = 0.95

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.colors = {
	cursor_fg = "#1e1e2e",
	cursor_bg = "#b4befe",
}

-- Window
config.enable_tab_bar = false
-- Let i3 handle window decorations
-- config.window_decorations = "NONE"
config.window_padding = {
	left = 16,
	right = 16,
	top = 16,
	bottom = 16,
}
config.scrollback_lines = 5000

-- Pane focus highlight
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}
config.colors.split = "#f38ba8"
config.command_palette_bg_color = "#1e1e2e"
config.command_palette_fg_color = "#cdd6f4"
config.pane_focus_follows_mouse = true

-- Leader key: Ctrl+s
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }

local act = wezterm.action
config.keys = {
	-- Pane splits
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- Pane navigation
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	-- Pane zoom and close
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	-- Tabs
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
}

return config

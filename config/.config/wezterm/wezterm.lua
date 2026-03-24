local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12

-- Theme
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 1.0

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

return config

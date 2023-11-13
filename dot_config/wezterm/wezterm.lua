-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Pull in any extra config modules
local profiles = require("profiles")

-- use config_builder for clearer error messages
local config = wezterm.config_builder()

profiles.apply_to_config(config)

-- if this looks weird, try the official "Catppuccin Macchiato"
config.color_scheme = "catppuccin-macchiato"

-- NOTE: backup font is by default JetBrains Mono w/ Nerdfonts glyphs, so term glyhphs should always work
config.font = wezterm.font("MesloLGM Nerd Font")
config.font_size = 10

---- QoL Fixes ----

-- NOTE: I die a little every time I hear this bell sound
config.audible_bell = "Disabled"
config.max_fps = 144

-- <C-T> = new tab
config.hide_tab_bar_if_only_one_tab = true

config.mouse_bindings = {
	-- C-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}
-- Standardize on CarriageReturn on all systems; No more ^M symbols!
config.canonicalize_pasted_newlines = "CarriageReturn"

return config

-- TODO: use chezmoi to manage this config even for windows

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
--config.font = wezterm.font("MesloLGM Nerd Font")
config.font = wezterm.font({
	family = "Iosevka Nerd Font",
	-- ligatures: --> != ~~>
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 11

---- QoL Fixes ----

-- NOTE: I die a little every time I hear this bell sound
config.audible_bell = "Disabled"
config.max_fps = 144

-- <C-T> = new tab
config.hide_tab_bar_if_only_one_tab = true

-- Standardize on CarriageReturn on all systems; No more ^M symbols!
config.canonicalize_pasted_newlines = "CarriageReturn"

config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
}

-- Keybindings

config.mouse_bindings = {
	-- C-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}
config.keys = {
	-- Create a tab in a named domain
	{
		key = "l",
		mods = "SHIFT|CTRL",
		action = wezterm.action.SpawnTab({
			DomainName = "dan@WSL:Ubuntu",
		}),
	},
}

return config

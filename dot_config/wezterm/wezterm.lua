-- TODO: use chezmoi to manage this config even for windows

-- Pull in the wezterm API and config
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- if this looks weird, try the official "Catppuccin Macchiato"
config.color_scheme = "catppuccin-macchiato"

-- NOTE: backup font is by default JetBrains Mono w/ Nerdfonts glyphs, so term glyhphs should always work
--config.font = wezterm.font("MesloLGM Nerd Font")
config.font = wezterm.font({
	family = "IosevkaTerm Nerd Font",
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

-- Declare before modifying below
config.keys = {
	{
		key = "l",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.ShowLauncher,
	},
	{
		key = "V",
		mods = "CTRL",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
}

config.launch_menu = {
	{
		args = { "top" },
	},
	{
		-- Optional label to show in the launcher. If omitted, a label
		-- is derived from the `args`
		label = "WSL",
		-- The argument array to spawn.  If omitted the default program
		-- will be used as described in the documentation above
		args = { "wsl.exe", "~" },
	},
}

-- NOTE: I put profile/OS-level config here because wezterm struggles with at loading
-- modules outside of { ~/.wezterm,  ~/.config/wezterm}
-- https://wezfurlong.org/wezterm/config/files.html?h=module#making-your-own-lua-modules
-- E.g. require("profiles") does not pick up ./profiles.lua, probably when using using
-- $WEZTERM_CONFIG_FILE
-- E.g. this doesn't work either even though the path is correct, possible because due
-- to permissions?
-- local profiles = require(wezterm.config_dir .. "\\profiles.lua")
local profiles = {}

function profiles.apply_windows_config(config)
	-- see: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
	config.wsl_domains = {
		{
			name = "dan@WSL:Ubuntu",
			distribution = "Ubuntu-22.04",
			default_cwd = "~/",
			-- default_prog = { "zsh" },
		},
	}
	-- see: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
	config.ssh_domains = {}
	-- see: https://wezfurlong.org/wezterm/shell-integration.html?h=shell#using-clink-on-windows-systems
	config.set_environment_variables = {}

	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		-- Use OSC 7 as per the above example
		config.set_environment_variables["prompt"] =
			"$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m "
		-- use a more ls-like output format for dir
		config.set_environment_variables["DIRCMD"] = "/d"
		-- NOTE: use cmder as cmd.exe (requires %cmder_root% env var set globally)
		config.default_prog = { "cmd.exe", "/s", "/k", "%cmder_root%/vendor/init.bat" }
	end

	local added_keys = {
		-- NOTE: replaced by ShowLauncher above
		-- Create a tab in a named domain
		-- {
		-- 	key = "L",
		-- 	mods = "CTRL|ALT|SHIFT",
		-- 	action = wezterm.action.SpawnTab({
		-- 		DomainName = "dan@WSL:Ubuntu",
		-- 	}),
		-- },
	}

	for i, key in ipairs(added_keys) do
		table.insert(config.keys, key)
	end
end

function profiles.apply_linux_config(config)
	config.ssh_domains = {}
	config.set_environment_variables = {}
end

if os.getenv("OS") == "Windows_NT" then
	profiles.apply_windows_config(config)
else
	profiles.apply_linux_config(config)
end

return config

local wezterm = require("wezterm")

---- Profiles ----

local M = {}

function M.apply_to_config(config)
	-- see: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
	config.wsl_domains = {
		{
			name = "dan@WSL:Ubuntu",
			-- The name of the distribution.  This identifies the WSL distribution.
			-- It must match a valid distribution from your `wsl -l -v` output in
			-- order for the domain to be useful.
			distribution = "Ubuntu-22.04",
			default_cwd = "~/",
			-- default_prog = { "zsh" },
		},
	}

	-- see: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
	config.ssh_domains = {}

	-- Improve make cmd.exe
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
		-- NOTE: normal cmd w/ clink
		-- config.default_prog = { "cmd.exe", "/s", "/k", "c:/clink/clink_x64.exe", "inject", "-q" }
		-- NOTE: if all else fails: use normal cmd
		-- config.default_prog = { "cmd.exe" }
	end
end

return M

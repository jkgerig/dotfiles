-----------------------------------------------------------------------------------------------------------------------
-- $XDG_CONFIG_HOME/wezterm/wezterm.lua
-----------------------------------------------------------------------------------------------------------------------

-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

-- Build a fresh configuration object (inherits sensible defaults)
local config = wezterm.config_builder()

-----------------------------------------------------------------------------------------------------------------------
-- Front-end
-----------------------------------------------------------------------------------------------------------------------

-- Use Metal/WebGPU on the integrated GPU (faster)
config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower" -- stay on iGPU for better battery

-----------------------------------------------------------------------------------------------------------------------
-- Fonts
-----------------------------------------------------------------------------------------------------------------------

-- Font discovery: point WezTerm at ONE trimmed directory
local home = os.getenv("HOME")
config.font_dirs = {
	home .. "/.local/share/fonts/wezterm",
}

-- Primary UI font and explicit rules for bold / italic faces
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })

config.font_rules = {
	{ -- Bold
		italic = false,
		intensity = "Bold",
		font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" }),
	},
	{ -- Italic
		italic = true,
		intensity = "Normal",
		font = wezterm.font("JetBrainsMono Nerd Font", { style = "Italic" }),
	},
	{ -- Bold-Italic
		italic = true,
		intensity = "Bold",
		font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", style = "Italic" }),
	},
}

-- Font size
config.font_size = 18.0

-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-----------------------------------------------------------------------------------------------------------------------
-- Window/Display
-----------------------------------------------------------------------------------------------------------------------

-- Window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 8,
	right = 0,
	top = 8,
	bottom = 0,
}

-- Maximize window (see https://github.com/wez/wezterm/issues/284)
wezterm.on("gui-startup", function(cmd)
	local tab, pane, mux_win = mux.spawn_window(cmd or {})
	local gui_win = mux_win:gui_window()
	if gui_win then
		gui_win:maximize()
	end
end)

-- Color scheme
config.color_scheme = "Catppuccin Mocha"

-- Cursor
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 600
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-----------------------------------------------------------------------------------------------------------------------
-- IO
-----------------------------------------------------------------------------------------------------------------------

-- Option/Alt key behavior: Left Alt sends escape sequences for terminal apps
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true -- Keep right alt for special chars (ñ, ∆, etc.)

-- Key Assignments
config.keys = {
	-- Disable hide application
	{
		key = "h",
		mods = "SUPER",
		action = act.DisableDefaultAssignment,
	},
	-- Pass through Ctrl+hjkl for smart-splits navigation
	{ key = "h", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "j", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "k", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "l", mods = "CTRL", action = act.DisableDefaultAssignment },
}

-- Bell
config.audible_bell = "Disabled"

-----------------------------------------------------------------------------------------------------------------------
-- Local overrides (gitignored)
-----------------------------------------------------------------------------------------------------------------------

local ok, local_config = pcall(require, "local")
if ok and type(local_config) == "table" then
	for k, v in pairs(local_config) do
		config[k] = v
	end
end

-----------------------------------------------------------------------------------------------------------------------
-- Return the fully-assembled configuration table to WezTerm
-----------------------------------------------------------------------------------------------------------------------
return config

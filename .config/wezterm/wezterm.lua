-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.hide_tab_bar_if_only_one_tab = true

-- Darkpuccin
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "rgba(19, 16, 32, 0.7)"
custom.tab_bar.background = "#040404"
custom.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom.tab_bar.new_tab.bg_color = "#080808"

config.color_schemes = { ["Darkpuccin"] = custom }
config.color_scheme = "Darkpuccin"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.warn_about_missing_glyphs = false

-- maclike copy and paste
config.keys = {
	{ key = "c", mods = "ALT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "ALT", action = wezterm.action.PasteFrom("Clipboard") },
}
-- and finally, return the configuration to wezterm
return config

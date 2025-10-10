-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.tab_bar_at_bottom = true

config.font = wezterm.font_with_fallback({
	"Monaspace Neon NF",
	"Symbol Nerd Font Mono",
	"Apple Color Emoji",
})

config.color_scheme = "Gruvbox light, medium (base16)"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.warn_about_missing_glyphs = false

config.font_size = 13
config.window_decorations = "RESIZE"

-- imitating tmux
local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(key)
	return {
		key = key,
		action = wezterm.action_callback(function(win, pane)
			if "true" == "true" then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = "CTRL + w" },
				}, pane)
			else
				win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
			end
		end),
	}
end

local action = wezterm.action

config.keys = {
	{ key = "c", mods = "ALT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "ALT", action = wezterm.action.PasteFrom("Clipboard") },
	-- LEADER
	{
		key = "a",
		mods = "CTRL",
		action = wezterm.action.ActivateKeyTable({
			name = "leader",
			one_shot = false,
			replace_current = false,
			until_unknown = true,
			timeout_milliseconds = 700,
		}),
	},
}

config.key_tables = {
	leader = {
		{ key = "Escape", action = "PopKeyTable" },
		split_nav("h"),
		split_nav("j"),
		split_nav("k"),
		split_nav("l"),
		{
			key = "v",
			action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "s",
			action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			action = action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			action = action.ActivatePaneDirection("Right"),
		},
		{
			key = "j",
			action = action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			action = action.ActivatePaneDirection("Up"),
		},
		{
			key = "H",
			action = action.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "L",
			action = action.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "J",
			action = action.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "K",
			action = action.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "z",
			action = action.TogglePaneZoomState,
		},
		{ key = "[", action = action.ActivateCopyMode },
		{
			key = "c",
			action = action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "p",
			action = action.ActivateTabRelative(-1),
		},
		{
			key = "n",
			action = action.ActivateTabRelative(1),
		},
	},
}

-- tab access
for i = 1, 9 do
	table.insert(config.key_tables.leader, {
		key = tostring(i),
		action = action.ActivateTab(i - 1),
	})
end

config.force_reverse_video_cursor = true

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config

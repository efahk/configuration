local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.default_prog = { "C:\\Program Files\\WindowsApps\\Microsoft.PowerShell_7.4.2.0_x64__8wekyb3d8bbwe\\pwsh" }

-- Color schemes I like :
-- arcoiris
config.color_scheme = "rose-pine-moon"

-- Horizon Dark (Gogh)
-- rose-pine-moon

config.window_padding = {
	left = 25,
	right = 2,
	top = 10,
	bottom = 10,
}

config.font = wezterm.font_with_fallback({
	"Hack Nerd Font Mono",
})

config.window_background_image = "C:\\Users\\kefah\\.config\\wezterm\\backgrounds\\mountains.jpg"
-- NOTE: Background
config.window_background_image_hsb = {
	brightness = 0.03,
}

-- config.window_background_opacity = 0
-- config.win32_system_backdrop = "Tabbed" -- Tabbed is cool - I should use this on windows if I"m not vibing with a background"

-- NOTE: TAB BAR
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = "RESIZE"

function tab_title(tab_info)
	local title = tab_info.tab_title

	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end

	final_title = tab_info.active_pane.title

	-- Full government names, please.
	if final_title == "pwsh.exe" then
		final_title = "Powershell"
	end

	-- Otherwise, use the title from the active pane
	-- in that tab
	return final_title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	if tab.is_active then
		return {
			{ Background = { Color = "#2F5323" } },
			{ Text = title },
		}
	end
	return title
end)

-- NOTE: WINDOW BAR
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local workspace = wezterm.mux.get_active_workspace()

	return zoomed .. workspace
end)

wezterm.on("update-status", function(window, pane)
	window:set_left_status(window:active_workspace())
	window:set_right_status(wezterm.time.now():format("%H:%M:%S"))
end)

-- NOTE: KEY MAPS

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Pane Management
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "_",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "y",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Next"),
	},
	{
		key = "o",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Prev"),
	},

	-- Tab Management
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(wezterm.action.SwitchToWorkspace({
						name = line,
					}))
				end
			end),
		}),
	},
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = true }), -- Confirm renders an overlay to ask if I really want to close the tab
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},

	-- Workspace Management
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action.SwitchToWorkspace({
			name = "interpeter-work",
		}),
	},
	{
		key = "h",
		mods = "LEADER|CTRL",
		action = wezterm.action.SwitchWorkspaceRelative(-1),
	},
	{
		key = "l",
		mods = "LEADER|CTRL",
		action = wezterm.action.SwitchWorkspaceRelative(1),
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(wezterm.action.SwitchToWorkspace({
						name = line,
					}))
				end
			end),
		}),
	},
	-- Not too sure what this done, but looks useful.
	{
		key = "1",
		mods = "LEADER",
		action = wezterm.action.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},

	-- Send Ctrl-A to the terminal when pressing Ctrl-A Ctrl-A (To get around the leader)
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
}

return config

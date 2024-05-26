local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.default_prog = { "C:\\Program Files\\WindowsApps\\Microsoft.PowerShell_7.4.2.0_x64__8wekyb3d8bbwe\\pwsh" }

-- Color schemes I like :
-- arcoiris
config.color_scheme = "Atelierseaside (dark) (terminal.sexy)"
-- Horizon Dark (Gogh)
-- rose-pine-moon
config.enable_tab_bar = false
-- config.window_decorations = "NONE"

config.window_padding = {
	left = 25,
	right = 2,
	top = 10,
	bottom = 10,
}

config.font = wezterm.font_with_fallback({
	"Hack Nerd Font Mono",
})

config.window_background_image = "C:\\Users\\kefah\\.config\\wezterm\\backgrounds\\monsterav2.jpg"
config.window_background_image_hsb = {
	brightness = 0.1,
}

return config

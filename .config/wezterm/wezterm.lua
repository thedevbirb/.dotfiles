local wezterm = require("wezterm")

local opaque_bg = 1.0
local transparent_bg = 0.7
local is_transparent = false

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Frappe"
	else
		return "Catppuccin Latte"
	end
end

wezterm.on("toggle-opacity", function(window, pane)
	is_transparent = not is_transparent
	local overrides = window:get_config_overrides() or {}
	if is_transparent then
		overrides.window_background_opacity = transparent_bg
	else
		overrides.window_background_opacity = opaque_bg
	end
	window:set_config_overrides(overrides)
end)

return {
	-- ...your existing config
	color_scheme = scheme_for_appearance(get_appearance()), -- or Macchiato, Frappe, Latte
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	keys = { {
		key = "o",
		mods = "CMD",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	} },
	font = wezterm.font_with_fallback({
		"Berkeley Mono",
		"JetBrains Mono",
	}),
}

local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return { 
	default_cwd = [[C:\Dev\nea_project]],
	font = wezterm.font("JetBrains Mono", { weight = 'Medium' }),
	font_size = 13.5,
    window_close_confirmation = "NeverPrompt",
	use_fancy_tab_bar = false,
    color_scheme = "Gruvbox dark, hard (base16)",

    window_padding = {
      left = 8,
      right = 8,
      top = 8,
      bottom = 0,
    },
	keys = {
		{
		    key = 'F11', action = wezterm.action.ToggleFullScreen,
		},
		{
			key = 'l', mods='SHIFT|CTRL', action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = 'h', mods='SHIFT|CTRL', action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = 's', mods='SHIFT|CTRL', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
		},
		{
			key = 'v', mods='SHIFT|CTRL', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
		},
		{
		  key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left',
		},
		{
		  key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right', },
		{
		  key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up', },
		{
		  key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down',
		},

	}

}

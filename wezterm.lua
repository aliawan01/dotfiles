local wezterm = require('wezterm')

local black  = "#000000"
local brown  = "#8A3324"
local red	 = "#DB5B4F"
local green	 = "#008e07"
local yellow = "#ffffd7"
local blue   = "#2f0dc9"
local purple = "#CA27B4"
local white	 = "#FFFFFF"

return {
	font = wezterm.font("Liberation Mono"),
	font_size = 13,

	use_fancy_tab_bar = true,
    window_close_confirmation = "NeverPrompt",
    enable_tab_bar = false,

    window_padding = {
      left = 5,
      right = 0,
      top = 0,
      bottom = 0,
    },

    colors = {
      foreground = black,
      background = yellow,

      cursor_bg = black,
      cursor_fg = white,

      selection_fg = black,
      selection_bg = yellow,

      split = "#444444",

      ansi = {black, brown, green, "olive", blue, purple, "teal", "silver"},
      brights = {"grey", "red", "lime", "yellow", "blue", "fuchsia", "aqua", "white"},
    }
}

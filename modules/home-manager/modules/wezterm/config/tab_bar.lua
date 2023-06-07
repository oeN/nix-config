local wezterm = require 'wezterm'

local module = {}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider


function module.apply_to_config(config)
  config.tab_bar_at_bottom = true

  config.window_frame = {
    font_size = 18.0,
  }

  -- config.tab_bar_style = {
  --   active_tab_left = wezterm.format {
  --     { Text = SOLID_LEFT_ARROW },
  --   },
  --   active_tab_right = wezterm.format {
  --     { Text = SOLID_RIGHT_ARROW },
  --   },
  --   inactive_tab_left = wezterm.format {
  --     { Text = SOLID_LEFT_ARROW },
  --   },
  --   inactive_tab_right = wezterm.format {
  --     { Text = SOLID_RIGHT_ARROW },
  --   },
  -- }

end

return module

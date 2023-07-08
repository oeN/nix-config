local wezterm = require 'wezterm'

local module = {}

local act = wezterm.action

function module.apply_to_config(config)
  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
  config.keys = {
    {
      key = '|',
      mods = 'LEADER|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '-',
      mods = 'LEADER',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    { key = 's', mods = 'LEADER', action = act.PaneSelect },
    { key = 'a', mods = 'ALT', action = act.ActivatePaneByIndex(0) },
    { key = 's', mods = 'ALT', action = act.ActivatePaneByIndex(1) },
    { key = 'd', mods = 'ALT', action = act.ActivatePaneByIndex(2) },
    { key = 'f', mods = 'ALT', action = act.ActivatePaneByIndex(3) },
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {
      key = 'a',
      mods = 'LEADER|CTRL',
      action = act.SendKey { key = 'a', mods = 'CTRL' },
    },
  }
end

return module

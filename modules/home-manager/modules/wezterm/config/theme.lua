local wezterm = require 'wezterm'

local module = {}


-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Ocean Dark (Gogh)'
  else
    return 'Ocean (light) (terminal.sexy)'
  end
end

function module.apply_to_config(config)
  config.color_scheme = scheme_for_appearance(get_appearance())

  config.font = wezterm.font 'JetBrains Mono'
  config.font_size = 20.0
end

return module

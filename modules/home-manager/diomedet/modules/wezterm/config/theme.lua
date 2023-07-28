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

local function get_active_screen()
  if wezterm.gui then
    local screens = wezterm.gui.screens()
    if screens then
      return screens.active
    end
  end
  return { name = 'Generic' }
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Ocean Dark (Gogh)'
  else
    return 'Ocean (light) (terminal.sexy)'
  end
end

local function font_size_for_screen(active_screen)
  if active_screen.name:find 'Built-in' then
    return 16.0
  end
  return 20.0
end

function module.apply_to_config(config)
  config.color_scheme = scheme_for_appearance(get_appearance())
  -- config.font_size = font_size_for_screen(get_active_screen())
  config.font_size = 20.0

  config.font = wezterm.font 'JetBrains Mono'
end

return module

local wezterm = require 'wezterm'

local module = {}

local default_font_size = 20.0 -- my default monitor is big enough for this


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
  return { name = 'Generic', effective_dpi = 96 }
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    -- return 'Ocean Dark (Gogh)'
    return 'Catppuccin Macchiato'
  else
    -- return 'Violet Light'
    return 'Catppuccin Latte'
  end
end

local function font_size_for_screen(active_screen)
  dpi = active_screen.effective_dpi
  if dpi and dpi <= 96 then
    return 16.0
  end
  return default_font_size
end

function module.apply_to_config(config)
  config.color_scheme = scheme_for_appearance(get_appearance())
  -- config.font_size = font_size_for_screen(get_active_screen())
  config.font_size = default_font_size
  config.command_palette_font_size = default_font_size

  config.font = wezterm.font 'JetBrainsMono Nerd Font'
end

return module

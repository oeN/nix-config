local wezterm = require 'wezterm'

local module = {}


-- The powerline < symbol
local LEFT_ARROW = utf8.char(0xe0b3)
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- Color palette for the backgrounds of each cell
local colors = {
  '#3c1361',
  '#52307c',
  '#663a82',
  '#7c5295',
  '#b491c8',
}

-- Foreground color for the text across the fade
local text_fg = '#c0c0c0'


function module.apply_to_config(config)
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = true

  config.window_frame = {
    font_size = 18.0,

    inactive_titlebar_bg = colors[1],
    active_titlebar_bg = colors[1],
    inactive_titlebar_fg = text_fg,
    active_titlebar_fg = text_fg,
    button_fg = '#cccccc',
    button_bg = colors[5],
    button_hover_fg = '#ffffff',
    button_hover_bg = colors[5],

  }

  -- config.tab_bar_style = {
  --   active_tab_left = wezterm.format {
  --     { Background = { Color = '#0b0022' } },
  --     { Foreground = { Color = '#2b2042' } },
  --     { Text = SOLID_LEFT_ARROW },
  --   },
  --   active_tab_right = wezterm.format {
  --     { Background = { Color = '#0b0022' } },
  --     { Foreground = { Color = '#2b2042' } },
  --     { Text = SOLID_RIGHT_ARROW },
  --   },
  --   inactive_tab_left = wezterm.format {
  --     { Background = { Color = '#0b0022' } },
  --     { Foreground = { Color = '#1b1032' } },
  --     { Text = SOLID_LEFT_ARROW },
  --   },
  --   inactive_tab_right = wezterm.format {
  --     { Background = { Color = '#0b0022' } },
  --     { Foreground = { Color = '#1b1032' } },
  --     { Text = SOLID_RIGHT_ARROW },
  --   },
  -- }


end

wezterm.on('update-right-status', function(window, pane)
  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {}

  -- Figure out the cwd and host of the current pane.
  -- This will pick up the hostname for the remote host if your
  -- shell is using OSC 7 on the remote host.
  local cwd_status, cwd_uri = pcall(pane:get_current_working_dir())
  if cwd_status then
    cwd_uri = cwd_uri:sub(8)
    local slash = cwd_uri:find '/'
    local cwd = ''
    local hostname = ''
    if slash then
      hostname = cwd_uri:sub(1, slash - 1)
      -- Remove the domain name portion of the hostname
      local dot = hostname:find '[.]'
      if dot then
        hostname = hostname:sub(1, dot - 1)
      end
      -- and extract the cwd from the uri
      cwd = cwd_uri:sub(slash)

      table.insert(cells, cwd)
      table.insert(cells, hostname)
    end
  end

  -- I like my date/time in this style: "Wed Mar 3 08:14"
  local date = wezterm.strftime '%a %b %-d %H:%M'
  table.insert(cells, date)

  -- An entry for each battery (typically 0 or 1 battery)
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end


  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end)


return module

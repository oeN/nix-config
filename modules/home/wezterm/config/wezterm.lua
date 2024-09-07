-- Pull in the wezterm API
local wezterm = require 'wezterm'
local keys = require 'keys'
local theme = require 'theme'
local tab_bar = require 'tab_bar'
local multiplexing = require 'multiplexing'

local modules = { 
  keys, 
  theme, 
  tab_bar, 
  multiplexing 
}

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

for i, module in ipairs(modules) do
  module.apply_to_config(config)
end

config.front_end = "WebGpu"

-- and finally, return the configuration to wezterm
return config

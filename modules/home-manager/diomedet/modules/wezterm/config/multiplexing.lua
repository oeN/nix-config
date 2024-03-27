local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.ssh_domains = {
    {
      name = "heracross",
      remote_address = "heracross",
      username = "diomedet"
    }
  }
end

return module

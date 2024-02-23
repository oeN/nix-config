local wk = require("which-key")

require('trouble').setup {}

wk.register({
  x = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<cr>", "Toggle" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Toggle [Q]uickfixes" },
  }
}, { prefix = '<leader>' })

local tree = require('neo-tree')
local wk = require("which-key")


wk.register({
  t = {
    name = "Tree",
    t = { "<cmd>:Neotree toggle left show<cr>", "[T]ree [T]oggle" },
    f = { "<cmd>:Neotree left reveal_force_cwd<cr>", "[T]ree [F]ind current file" },
  }
}, { prefix = '<leader>' })


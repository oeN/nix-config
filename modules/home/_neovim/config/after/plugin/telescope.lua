local telescope = require('telescope')
local builtin = require('telescope.builtin')
local wk = require("which-key")

telescope.setup {}

telescope.load_extension('fzf')

wk.register({
  f = {
    name = "Find Files",
    f = { builtin.find_files, "[F]ind [F]iles" },
    b = { builtin.buffers, "[F]ind [B]uffers" },
    g = { builtin.live_grep, "[F]ind strin[g]" },
    G = { builtin.grep_string, "[F]ind current string[G]" },
  }
}, { prefix = '<leader>' })

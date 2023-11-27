return {
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    cmd = 'TSUpdate',
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = "make",
  },
  { -- like CtrlP but better
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-lualine/lualine.nvim',
}

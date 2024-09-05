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
  'folke/trouble.nvim',
  'neovim/nvim-lspconfig',
  'williamboman/mason-lspconfig.nvim',
  {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
  },
  'nvim-lualine/lualine.nvim',
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  'f-person/auto-dark-mode.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'j-hui/fidget.nvim',
  'simrat39/rust-tools.nvim',
}

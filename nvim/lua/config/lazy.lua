-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup( {
  -- Performance
  -- { 'lewis6991/impatient.nvim' },
  {
    'goolord/alpha-nvim',
    config = function ()
      require('config.alpha')
    end
  },
  {
    "nvim-neorg/neorg",
    config = function()
      require('config.neorg')
    end,
    dependencies = "nvim-lua/plenary.nvim",
    ft = "norg",
    cmd = 'Neorg',
    build = ":Neorg sync-parsers",
  },
  -- utilities
  {
    'tpope/vim-vinegar',
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'tpope/vim-surround',
    'tpope/vim-repeat'
  },

  {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function() require('config.gitsigns') end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require('config.catppuccin')
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('config.lualine') end
  },

  {
    'nvim-treesitter/playground',
    after = 'nvim-treesitter',
  },

  { 'NoahTheDuke/vim-just',
    after = 'nvim-treesitter',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    after = 'nvim-treesitter',
    lazy = true,
  },

  { 'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'NoahTheDuke/vim-just'
    },
    config = function()
      require('config.treesitter')
    end,
  },


  -- Editing features
  --  { "kylechui/nvim-surround",
  --   tag = "*",
  --   config = function()
  --     require("config.nvim-surround")
  --   end,
  -- },

  {
    'windwp/nvim-autopairs',
    config = function() require('config.autopairs') end,
    event = "InsertEnter",
    lazy = true
  },

  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
    config = function() require('config.comment') end,
    keys = 'g'
  },

  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'InsertEnter',
    config = function() require('config.ts-autotags') end
  },

  { "akinsho/toggleterm.nvim",
    tag = '2.3.0',
    config = function()
      require("config.toggleterm")
    end
  },

  { 'neovim/nvim-lspconfig',
    dependencies = {
      -- LSP
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp', -- cannot lazyload beca of this plugin
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip',
      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function() require('config.cmp') end,
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    -- after = { 'telescope-fzf-native.nvim' },
    setup = function()
      require("setup.telescope")
    end,
    config = function()
      vim.cmd("PackerLoad telescope-fzf-native.nvim")
      require('config.telescope')
    end,
    cmd = 'Telescope',
    keys = '<leader>f'
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    lazy = true,
  },

  --{
  --  disable = true,
  --  'folke/tokyonight.nvim',
  --  config = function() require('config.tokyonight') end
  --},

  {
    "kyazdani42/nvim-web-devicons"
  },

  --{
  --  disable = true,
  --  "folke/trouble.nvim",
  --  config = function() require("config.trouble") end
  --},

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("config.lsp-saga")
    end,
  },

  -- file-type plugins
  {
    'mechatroner/rainbow_csv',
    ft = 'csv'
  },
})
-- Automatically set up your -- configuration after cloning packer.nvim
-- Put this at the end after all plugins

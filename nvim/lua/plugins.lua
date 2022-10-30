local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

--
-- plugin -- configuration
return require('packer').startup({ function(use)
  -- packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Performance
  use { 'lewis6991/impatient.nvim' }
  use {
    'glepnir/dashboard-nvim',
    config = function() require('config.dashboard') end
  }

  -- utilities
  use {
    'tpope/vim-vinegar',
    'tpope/vim-fugitive'
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function() require('config.treesitter') end
  }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  -- Editing features
  use {
    'tpope/vim-surround',
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require('config.autopairs') end,
    event = "InsertEnter",
    opt = true
  }

  use {
    'numToStr/Comment.nvim',
    config = function() require('config.comment') end,
    keys = 'g'
  }

  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
    event = 'InsertEnter',
    config = function() require('config.ts_autotags') end
  }

  -- LSP and Completion
  -- use {
  --   'williamboman/mason.nvim',
  --   'williamboman/mason-lspconfig.nvim',
  --   'neovim/nvim-lspconfig',
  --   config = function() require('config.mason') end
  -- }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp', -- cannot lazyload because of this plugin
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function() require('config.cmp') end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { 'nvim-lua/plenary.nvim' },
    after = 'telescope-fzf-native.nvim',
    config = function() require('config.telescope') end,
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    keys = '<leader>f',
    cmd = { 'Telescope', 'Telescope find_files', 'Telescope live_grep' },
    run = 'make'
  }

  use {
    'folke/tokyonight.nvim',
    config = function() require('config.tokyonight') end
  }

  use {
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function() require("config.trouble") end
  }

  -- file-type plugins
  use { 'mechatroner/rainbow_csv',
    ft = 'csv'
  }

  -- Automatically set up your -- configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  } })

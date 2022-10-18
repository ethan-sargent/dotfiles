local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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
  use 'lewis6991/impatient.nvim'

  -- Interface 
  -- use 'arzg/vim-colors-xcode'
  use {
    'sam4llis/nvim-tundra',
    'kyazdani42/nvim-web-devicons',
    'feline-nvim/feline.nvim',
    'folke/trouble.nvim',
    -- config = function() require('config._tundra') end
  }

  use { 'tpope/vim-vinegar' }

  use { 'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    -- config = function() require('config._treesitter') end
  }

  -- Editing features 
  use {
    'tpope/vim-surround',
    'numToStr/Comment.nvim',
    'windwp/nvim-autopairs',
    -- opt = true
  }
  use {
    'windwp/nvim-ts-autotag',
    -- config = function() require('config._ts_autotags') end
  }

  -- LSP and Completion
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    -- opt = true,
  }

  use { 'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { 'nvim-lua/plenary.nvim' },
    -- config = function() require('config._telescope') end,
    -- opt = true
  }

  use { 'nvim-telescope/telescope-fzf-native.nvim',
    -- opt = true,
    run = 'make'
  }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      -- opt = true
    },
    -- config = function() require('config._cmp') end,
    -- opt = true
  }

  -- file-specific enhancements
  use { 'mechatroner/rainbow_csv',
    -- opt = true
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
}})

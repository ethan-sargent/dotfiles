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


local alpha_filetype = function()
  return vim.bo.filetype == 'alpha';
end

return require('packer').startup({ function(use)
  -- packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Performance
  use { 'lewis6991/impatient.nvim' }

  use {
    'goolord/alpha-nvim',
    config = function ()
        require('config.alpha')
    end
  }
  use {
    "nvim-neorg/neorg",
    config = function()
        require('config.neorg')
    end,
    requires = "nvim-lua/plenary.nvim",
    ft = "norg",
    cmd = 'Neorg*',
    run = ":Neorg sync-parsers",
  }
  -- utilities
  use {
    'tpope/vim-vinegar',
    'tpope/vim-fugitive'
  }

  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function() require('config.gitsigns') end,
  }

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require('config.catppuccin')
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('config.lualine') end
  }

  use {
    'nvim-treesitter/playground',
    after = 'nvim-treesitter',
    cmd = 'TSPlaygroundToggle'
  }

  use { 'NoahTheDuke/vim-just',
    after = 'nvim-treesitter',
  }
  use {
    'nvim-treesitter/nvim-treesitter-context',
    after = 'nvim-treesitter',
    opt = true,
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
      vim.cmd("PackerLoad nvim-treesitter-context")
      vim.cmd("PackerLoad vim-just")
      require('config.treesitter')
    end,
  }


  -- Editing features
  use { "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("config.nvim-surround")
    end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require('config.autopairs') end,
    event = "InsertEnter",
    opt = true
  }

  use {
    'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
    config = function() require('config.comment') end,
    keys = 'g'
  }

  use {
    'windwp/nvim-ts-autotag',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    event = 'InsertEnter',
    config = function() require('config.ts-autotags') end
  }

  use { "akinsho/toggleterm.nvim",
    tag = '2.3.0',
    config = function()
      require("config.toggleterm")
    end
  }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp', -- cannot lazyload because of this plugin
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
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
    requires = {
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
    cmd = 'Telescope*',
    keys = '<leader>f'
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    opt = true,
  }

  -- use {
  --   'nvim-telescope/telescope-fzy-native.nvim',
  --   keys = '<leader>f',
  --   cmd = { 'Telescope', 'Telescope find_files' },
  -- }

  use {
    disable = true,
    'folke/tokyonight.nvim',
    config = function() require('config.tokyonight') end
  }

  use {
    "kyazdani42/nvim-web-devicons"
  }

  use {
    disable = true,
    "folke/trouble.nvim",
    config = function() require("config.trouble") end
  }

  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("config.lsp-saga")
    end,
  }

  -- file-type plugins
  use {
    'mechatroner/rainbow_csv',
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

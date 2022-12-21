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
    'tpope/vim-rhubarb',
  },
  {
    'tpope/vim-fugitive',
    cmd = "G"
  },
  {
    'tpope/vim-repeat',
    keys = '.'
  },
  {
    'tpope/vim-surround',
    event = 'BufReadPre'
  },
  {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function() require('config.gitsigns') end,
    event = 'BufReadPost'
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
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'NoahTheDuke/vim-just',
      'nvim-treesitter/playground'
    },
    config = function()
      require('config.treesitter')
    end,
    event = "BufReadPost",
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
    end,
    cmd = "ToggleTerm"
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('config.mason')
    end,
    event = "BufReadPre",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    config = function()
      require("config.luasnip")
    end,
    lazy = true,
    event = "InsertEnter"
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      'onsails/lspkind.nvim',
    },
    config = function()
      require("config.cmp")
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    init = function()
      require("setup.telescope")
    end,
    config = function()
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
    lazy = true,
    event = "BufReadPost"
  },

  -- file-type plugins
  {
    'mechatroner/rainbow_csv',
    ft = 'csv'
  },
},
  {
    defaults = { lazy = false },
    -- dev = { patterns = jit.os:find("Windows") and {} or { "folke" } },
    -- install = { colorscheme = { "tokyonight", "habamax" } },
    -- checker = { enabled = true },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          -- "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })

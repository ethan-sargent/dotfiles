local _M = {
  {
    "nvim-neorg/neorg",
    config = function()
      require('config.plugins.neorg')
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
    config = function() require('config.plugins.gitsigns') end,
    event = 'BufReadPost'
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('config.plugins.lualine') end,
    event = "VeryLazy",
  },
  {
    'NoahTheDuke/vim-just',
    ft = "just"
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/playground'
    },
    config = function()
      require('config.plugins.treesitter')
    end,
    event = "BufReadPost",
  },


  -- Editing features
  --  { "kylechui/nvim-surround",
  --   tag = "*",
  --   config = function()
  --     require("config.plugins.nvim-surround")
  --   end,
  -- },

  {
    'windwp/nvim-autopairs',
    config = function() require('config.plugins.autopairs') end,
    event = "InsertEnter",
    lazy = true
  },

  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring'
    },
    config = function() require('config.plugins.comment') end,
    -- lazy = true
    event = "BufReadPre"
  },

  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'InsertEnter',
    config = function() require('config.plugins.ts-autotags') end
  },

  { "akinsho/toggleterm.nvim",
    tag = '2.3.0',
    config = function()
      require("config.plugins.toggleterm")
    end,
    init = function() require("setup.toggleterm") end,
    cmd = "ToggleTerm"
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('config.plugins.mason')
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
      require("config.plugins.luasnip")
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
      require("config.plugins.cmp")
    end
  },
  {
    "hrsh7th/cmp-cmdline",
    dependencies = {
      "hrsh7th/nvim-cmp"
    },
    event = 'CmdlineEnter'

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
      require('config.plugins.telescope')
    end,
    cmd = 'Telescope',
    keys = '<leader>f'
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    lazy = true,
  },

  {
    'folke/tokyonight.nvim',
    config = function() require('config.plugins.tokyonight') end,
    priority = 1000,
    enabled = false
  },

  {
    "kyazdani42/nvim-web-devicons"
  },

  {
    -- disable = true,
    "folke/trouble.nvim",
    config = function() require("config.plugins.trouble") end,
    event = "BufReadPost"
  },

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("config.plugins.lsp-saga")
    end,
    lazy = true,
    event = "BufReadPost"
  },
  -- {
  --   "loctvl842/monokai-pro.nvim",
  --   config = function ()
  --     require("config.plugins.monokai-pro")
  --   end,
  --   lazy = true,
  --   event = "VeryLazy"
  -- },

  -- file-type plugins
  {
    'mechatroner/rainbow_csv',
    ft = 'csv'
  },
}

return _M;

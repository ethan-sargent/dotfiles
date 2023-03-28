local _M = {
  -- utilities
  {
    'tpope/vim-vinegar',
  },
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb'
    },
    event = 'VeryLazy'
  },
  {
    'tpope/vim-repeat',
    keys = '.'
  },
  {
    'tpope/vim-surround',
    event = 'BufRead'
  },
  {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function() require('config.plugins.gitsigns') end,
    event = 'BufReadPost'
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
      'nvim-treesitter/playground',
      'RRethy/nvim-treesitter-endwise',
      {
        'windwp/nvim-ts-autotag',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        event = 'InsertEnter',
        config = function() require('config.plugins.ts-autotags') end,
      },
    },
    config = function()
      require('config.plugins.treesitter')
    end,
    event = "BufReadPost",
  },
  {
    'windwp/nvim-autopairs',
    config = function() require('config.plugins.autopairs') end,
    event = 'InsertEnter'
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
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    -- config = function()
    --   local luasnip = require("luasnip")

    --   luasnip.config.setup({
    --     history = true,
    --     enable_autosnippets = false,
    --     -- Update more often, :h events for more info.
    --     -- updateevents = "TextChanged,TextChangedI",
    --   })

    --   vim.cmd([[
    --   " press <Tab> to expand or jump in a snippet. These can also be mapped separately
    --   " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
    --   imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
    --   " -1 for jumping backwards.
    --   inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
    --   snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
    --   snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
    --   ]])
    --   require("luasnip.loaders.from_vscode").lazy_load({
    --     path = 'snippets',
    --     exclude = { "global", "all"}
    --   })
    -- end,
    config = function ()
      require('config.plugins.luasnip')
    end,
    lazy = true,
    build = "make install_jsregexp"
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = {"InsertEnter", "CmdlineEnter"},
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-cmdline",
  --     "dmitmel/cmp-cmdline-history",
  --     "hrsh7th/cmp-path",
  --     "saadparwaiz1/cmp_luasnip",
  --     'onsails/lspkind.nvim',
  --   },
  --   config = function()
  --     require("config.plugins.cmp")
  --   end
  -- },
  -- {
  --   "hrsh7th/cmp-cmdline",
  --   dependencies = {
  --     "hrsh7th/nvim-cmp"
  --   },
  --   -- event = 'CmdlineEnter'
  --   lazy = true

  -- },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    lazy = true,
  },

  {
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
  -- file-type plugins
  {
    'mechatroner/rainbow_csv',
    ft = 'csv'
  },
}

return _M;

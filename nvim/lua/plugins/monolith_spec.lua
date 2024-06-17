local _M = {
	-- utilities
	{
		"tpope/vim-vinegar",
    event = "VeryLazy"
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim",
		tag = "release",
		config = function()
			require("config.plugins.gitsigns")
		end,
		event = "BufRead",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.plugins.lualine")
		end,
		event = "VeryLazy",
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("config.plugins.autopairs")
		end,
		event = "InsertEnter",
	},

	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("config.plugins.comment")
		end,
		-- lazy = true
		event = "BufReadPre",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
      lazy = true,
		},
		config = function()
			require("config.plugins.luasnip")
		end,
		lazy = true,
		build = "make install_jsregexp",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		-- lazy = true,
	},

	{
		"folke/trouble.nvim",
		config = function()
			require("config.plugins.trouble")
		end,
		event = "BufRead",
	},

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("config.plugins.lsp-saga")
		end,
		lazy = true,
    enabled = false,
		event = "BufReadPost",
	},
	-- file-type plugins
	{
		"mechatroner/rainbow_csv",
		ft = "csv",
	},
}

return _M

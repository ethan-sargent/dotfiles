local _cmp = {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
}
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

_cmp.config = function()
	-- Set up nvim-cmp.cmp
	local lspkind = require("lspkind")
	require("mason").setup()
	require("mason-lspconfig").setup()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspconfig = require("lspconfig")

	cmp.setup({
		enabled = true,
		preselect = cmp.PreselectMode.None,
		view = {
			entries = { name = "custom", selection_order = "near_cursor" },
		},
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			completion = cmp.config.window.bordered({
				col_offset = -1,
			}),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.jump(1)
				else
					fallback()
				end
			end,
			["<S-Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end,
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}, {
			-- { name = 'buffer' }, -- removing buffer suggestions
		}),
		formatting = {
			fields = { "abbr", "menu", "kind" },
			format = function(entry, vim_item)
				local kind = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
				})(entry, vim_item)

				--
				-- local strings = vim.split(kind.kind, "%s", { trimempty = true })
				-- kind.abbr = kind.abbr
				-- kind.kind = strings[1]
				-- kind.menu = "   " .. strings[2]
				return kind
			end,
		},
	})

	-- Set configuration for specific filetype.
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	-- LSPCONFIG
	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		-- vim.keymap.set("n", "<leader>gD", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "<leader>F", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
	end
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	vim.g.completion_enable_snippet = "luasnip"
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	-- rounded border on hover document
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	local lsp_flags = {
		debounce_text_changes = 150,
	}
	lspconfig.rust_analyzer.setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					allFeatures = true,
					overrideCommand = {
						"cargo",
						"clippy",
						"--workspace",
						"--message-format=json",
						"--all-targets",
						"--all-features",
					},
				},
			},
		},
	})
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})
	lspconfig.apex_ls.setup({
		apex_jar_path = "~/.local/share/nvim/mason/packages/apex-language-server/apex-jorje-lsp.jar",
		apex_enable_semantic_errors = false,
		apex_enable_completion_statistics = false,
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "apexcode", "apex", "apexanon" },
	})

	lspconfig.lua_ls.setup({
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				semantic = {
					enable = false, --[[ disable semantic highlights  ]]
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	lspconfig.html.setup({
		capabilities = capabilities,
		flags = lsp_flags,
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
		init_options = {
			provideFormatter = false,
		},
	})

	-- default handlers for language servers installed by Mason that don't have explicit handlers
	require("mason-lspconfig").setup_handlers({
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function(server_name) -- default handler (optional)
			lspconfig[server_name].setup({
				capabilities = capabilities,
				flags = lsp_flags,
				on_attach = on_attach,
			})
		end,
	})
end
return {
	_cmp,
}

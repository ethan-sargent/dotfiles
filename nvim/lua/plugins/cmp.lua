local _cmp = {
	"hrsh7th/nvim-cmp",
	event = { "VeryLazy" },
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
		"mfussenegger/nvim-dap",
		"simrat39/rust-tools.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
}
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

_cmp.config = function()
	local cmp = require("cmp")
	local lspconfig = require("lspconfig")
	local luasnip = require("luasnip")
	vim.g.completion_enable_snippet = "luasnip"
	local lsp_flags = {
		debounce_text_changes = 150,
	}
	-- LSP configuration
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local lspkind = require("lspkind")
	require("mason").setup()
	local handlers = {
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
		["rust_analyzer"] = function()
			local rt = require("rust-tools")
			rt.setup({
				server = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = true,
							check = {
								features = "all",
								command = "clippy",
							},
						},
					},
				},
				on_attach = function(_, bufnr)
					-- Hover actions
					vim.keymap.set("n", "<Leader>K", rt.hover_actions.hover_actions, { buffer = bufnr })
					-- Code action groups
					vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
				end,
			})
		end,
	}
	require("mason-lspconfig").setup({
		automatic_installation = true,
		handlers = handlers,
	})
	require("mason-nvim-dap").setup({
		automatic_setup = true,
	})

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
				elseif luasnip.expand_or_jumpable() then
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
					mode = "text",
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
	vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
	local opts = { noremap = true, silent = true }
	-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>F", function()
		vim.lsp.buf.format({
			async = true,
			filter = function(lspclient)
				return lspclient.name ~= "tsserver" and lspclient.name ~= "html" and lspclient.name ~= "jsonls" and lspclient.name ~= "apex_ls"
			end,
		})
	end, opts)

	-- rounded border on hover document
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

	lspconfig.tsserver.setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
	})

	lspconfig.apex_ls.setup({
		apex_jar_path = vim.fn.stdpath("data")
			.. "/mason/packages/apex-language-server/extension/dist/apex-jorje-lsp.jar",
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
		end,
		init_options = {
			provideFormatter = false,
		},
	})

	require("lspconfig").azure_pipelines_ls.setup({
		settings = {
			yaml = {
				schemas = {
					["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
						"/azure-pipeline*.y*l",
						"/*.azure*",
						"/devops/**/*.y*l",
						"/runbooks/**/*.y*l",
					},
				},
			},
		},
	})

	-- default handlers for language servers installed by Mason that don't have explicit handlers
	-- require("mason-lspconfig").setup_handlers({
	-- 	-- The first entry (without a key) will be the default handler
	-- 	-- and will be called for each installed server that doesn't have
	-- 	-- a dedicated handler.
	-- 	function(server_name) -- default handler (optional)
	-- 		lspconfig[server_name].setup({
	-- 			capabilities = capabilities,
	-- 			flags = lsp_flags,
	-- 			on_attach = on_attach,
	-- 		})
	-- 	end,

	-- 	["apex_ls"] = function()
	-- 		lspconfig.apex_ls.setup({
	-- 			apex_enable_semantic_errors = false,
	-- 			apex_enable_completion_statistics = false,
	-- 			on_attach = on_attach,
	-- 			capabilities = capabilities,
	-- 			filetypes = { "apexcode", "apex", "apexanon" },
	-- 		})
	-- 	end,
	-- })
end
return _cmp

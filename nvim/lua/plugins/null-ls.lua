local _M = {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
}

_M.config = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.diagnostics.eslint_d,
			null_ls.builtins.code_actions.eslint_d,
			null_ls.builtins.formatting.prettierd.with({
				extra_filetypes = { "apex", "apexcode", "apexanon" },
			}),
		},
	})
end

return _M

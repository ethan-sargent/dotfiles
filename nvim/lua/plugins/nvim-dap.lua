local M = {
	"mfussenegger/nvim-dap",
	lazy = true,
}

M.config = function()
	-- config here
	local dap = require("dap")
	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
	vim.keymap.set("n", "<leader>dc", dap.continue, {})
	vim.keymap.set("n", "<leader>do", dap.step_over, {})
	vim.keymap.set("n", "<leader>di", dap.step_into, {})
	vim.keymap.set("n", "<leader>dr", dap.repl.open, {})
end

return M

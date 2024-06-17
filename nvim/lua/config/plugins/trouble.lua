require"trouble".setup {
  auto_jump = {
    "lsp_definitions", "lsp_references"
  },
  auto_refresh = false
}

-- Trouble Keybinds
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble toggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references toggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions toggle<cr>",
  {silent = true, noremap = true}
)

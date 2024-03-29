
local noremap = {noremap = true}
-- launch Lazy plugin manager window
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", noremap);


-- Terminal mode keybinds
-- remap escaping from terminal to something more convenient
vim.keymap.set("t", "<localleader><Esc>", "<C-\\><C-n>" , noremap);
-- Enable buffer navigation out from terminal buffers
vim.keymap.set("t", "<C-w>k", "<cmd>wincmd k<CR>", noremap);
vim.keymap.set("t", "<C-w>j", "<cmd>wincmd j<CR>", noremap);
vim.keymap.set("t", "<C-w>l", "<cmd>wincmd l<CR>", noremap);
vim.keymap.set("t", "<C-w>h", "<cmd>wincmd h<CR>", noremap);
vim.keymap.set("t", "<C-w><C-k>", "<cmd>wincmd k<CR>", noremap);
vim.keymap.set("t", "<C-w><C-j>", "<cmd>wincmd j<CR>", noremap);
vim.keymap.set("t", "<C-w><C-l>", "<cmd>wincmd l<CR>", noremap);
vim.keymap.set("t", "<C-w><C-h>", "<cmd>wincmd h<CR>", noremap);

-- Primeagen
vim.keymap.set("n", "<C-d>", "<C-d>zz", noremap)
vim.keymap.set("n", "<C-u>", "<C-u>zz", noremap)
-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP", noremap)
vim.keymap.set("n", "<C-d>", "<C-d>zz", noremap)
-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>y", "\"+y", noremap)
vim.keymap.set("v", "<leader>y", "\"+y", noremap)
vim.keymap.set("n", "<leader>Y", "\"+y$", noremap)

vim.keymap.set("n", "<leader>d", "\"_d", noremap)
vim.keymap.set("v", "<leader>d", "\"_d", noremap)


local function dataFormat()
  local filetype = vim.bo.filetype
  vim.cmd(string.format([[%%!yq -p %s -o %s -P]], filetype, filetype))
end
vim.keymap.set("n", "<leader>yq", dataFormat);

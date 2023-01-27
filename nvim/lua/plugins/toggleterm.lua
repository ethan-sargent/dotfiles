local _M = {
  "akinsho/toggleterm.nvim",
  tag = '2.3.0',
  cmd = "ToggleTerm"
};

_M.init = function()
  vim.api.nvim_set_keymap("n", "<localleader>t", "<cmd>ToggleTerm direction=horizontal<CR>", {noremap = true});
  vim.api.nvim_set_keymap("n", "<localleader>f", "<cmd>ToggleTerm direction=float<CR>", {});
  vim.api.nvim_set_keymap("t", "<localleader>t", "<cmd>ToggleTerm<CR>", {noremap = true});
  vim.api.nvim_set_keymap("t", "<localleader>f", "<cmd>ToggleTerm<CR>", {noremap = true});
end
_M.config = function()

  require("toggleterm").setup({
    shading_factor = '3'
  })


  vim.api.nvim_set_keymap("n", "<localleader>t", "<cmd>ToggleTerm direction=horizontal<CR>", {noremap = true});
  vim.api.nvim_set_keymap("n", "<localleader>f", "<cmd>ToggleTerm direction=float<CR>", {});
  vim.api.nvim_set_keymap("t", "<localleader>t", "<cmd>ToggleTerm<CR>", {noremap = true});
  vim.api.nvim_set_keymap("t", "<localleader>f", "<cmd>ToggleTerm<CR>", {noremap = true});
end
return _M;

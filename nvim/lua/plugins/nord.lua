local _M = {
  'shaunsingh/nord.nvim',
  priority = 999,
  enabled = true,
}

_M.config = function()
  vim.g.nord_contrast = true
  vim.g.nord_borders = true
  -- vim.g.nord_disable_background = true;
  vim.o.background = 'dark'
  vim.cmd.colorscheme "nord"
end

return _M;

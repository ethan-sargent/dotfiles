local _M = {
  'shaunsingh/nord.nvim',
  priority = 999
}

_M.config = function()
  vim.g.nord_contrast = true
  vim.g.nord_borders = true
  -- vim.g.nord_disable_background = true;
  vim.cmd.colorscheme "nord"
end

return _M;

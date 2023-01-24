local _M = {
  'shaunsingh/nord.nvim',
  priority = 999
}

_M.config = function()
  vim.cmd.colorscheme "nord"
end

return _M;

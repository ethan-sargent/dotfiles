local _M = {
  "rebelot/kanagawa.nvim",
  priority = 999,
  enabled = false,
}

_M.config = function ()
  vim.cmd.colorscheme("kanagawa")
end

return _M;

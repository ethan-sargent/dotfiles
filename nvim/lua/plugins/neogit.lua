local _M = {
  'TimUntersberger/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  event = "VeryLazy",
  enabled = false
}

_M.config = function ()
  require('neogit').setup({})
end

return _M;

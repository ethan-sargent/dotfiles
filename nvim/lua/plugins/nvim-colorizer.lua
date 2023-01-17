local _M = {
  'norcalli/nvim-colorizer.lua',
}

_M.config = function ()
  require'colorizer'.setup()
end

return _M;

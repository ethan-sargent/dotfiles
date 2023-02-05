local _M = {
  'NvChad/nvim-colorizer.lua',
}

_M.config = function ()
  require'colorizer'.setup({
    css = {
      css = true, -- Enable parsing rgb(...) functions in css.
    },
    html = {
      names = false -- Disable parsing "names" like Blue or Gray
    },
    javascript = {
      names = false,
    }
  })
end

return _M;

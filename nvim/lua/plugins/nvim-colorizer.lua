local _M = {
  'NvChad/nvim-colorizer.lua',
  event = "BufRead"
   -- ft = { "css", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" }
}

_M.config = function ()
  require'colorizer'.setup({
    filetypes = { "css", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
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

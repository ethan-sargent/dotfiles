local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true, -- check treesitter for matching pair
})

-- -- Insert `(` after selecting function or method item
local cmp = require("cmp");
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local keymap = vim.keymap.set
local saga = require("lspsaga")

-- local named_colors = require("nord.named_colors");
-- local colors = require('nord.colors');
saga.setup({
  finder_action = {
    open = { "o", "<CR>" },
    vsplit = "s",
    split = "i",
    quit = { 'q', "<esc>" },
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action = {
    keys = {
      quit = "<esc>",
      exec = "<CR>",
    }
  },
  rename = {
    quit = "<esc>"
  },
  hover_doc = {
    quit = { "q", "<esc>" }
  },
  ui = {
     -- currently only round theme
    theme = 'round',
    -- this option only work in neovim 0.9
    title = true,
    -- border type can be single,double,rounded,solid,shadow.
    border = 'rounded',
    winblend = 10,
    -- kind  = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    -- colors = {
    --   normal_bg = named_colors.black,
    --   title_bg = named_colors.white,
    --   red = named_colors.red,
    --   magenta = colors.nord5_gui,
    --   orange = named_colors.orange,
    --   yellow = named_colors.yellow,
    --   green = named_colors.green,
    --   cyan = named_colors.off_blue,
    --   blue = named_colors.blue,
    --   purple = named_colors.purple,
    --   white = named_colors.white,
    --   black = named_colors.black,
    -- }
  },
  symbol_in_winbar = {
    enable = false
  },
})



keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

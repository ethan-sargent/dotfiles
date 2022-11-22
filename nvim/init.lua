local opt = vim.opt
local g = vim.g

-- Plugins
require('impatient')
require('plugins')


opt.completeopt   = "menu,menuone,noselect"
opt.rnu           = true
opt.nu            = true
opt.hlsearch      = false
opt.incsearch     = true
opt.ts            = 2
opt.sts           = 2
opt.sw            = 2
opt.expandtab     = true
opt.signcolumn    = "yes"
opt.autoindent    = true
opt.smartindent   = true
opt.undofile      = true
opt.ignorecase    = true
opt.smartcase     = true
opt.termguicolors = true
opt.wrap          = false
opt.guitablabel   = "[%N] %t %M"
opt.synmaxcol     = 500
opt.mouse         = ""

-- TODO: update this to use native lua commands
vim.cmd([[
nnoremap <SPACE> <Nop>
let mapleader=" "
tnoremap <Esc> <C-\><C-n>
augroup sfdxApex
  au!
  au BufRead,BufNewFile *.cls,*.apex,*.trigger,*.soql set filetype=apexcode
  au BufRead,BufNewFile *.soql set filetype=soql
augroup END

  nnoremap <leader>sd :w  <bar> !sfdx force:source:deploy --sourcepath "%"<Enter>
  nnoremap <leader>sr :!sfdx force:source:retrieve --sourcepath "%"<Enter>
  nnoremap <leader>sq :!sfdx force:data:soql:query  --soqlqueryfile "%" <Enter>
  nnoremap <leader>sae :!sfdx force:apex:execute --apexcodefile "%" <Enter>
  nnoremap <leader>st :!sfdx force:apex:test:run --tests "%:t:r" --synchronous<Enter>
  nnoremap <leader>so :!sfdx force:org:open<Enter>
]])

local function get_visual_selection(preserve_newlines)
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  if next(lines) == nil then
    return nil
  end
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  local separator
  if preserve_newlines then
    separator = '\n'
  else
    separator = ''
  end
  return table.concat(lines, separator)
end

function SFDX_VISUAL_QUERY()
  vim.cmd(string.format('!sfdx force:data:soql:query -q "%s"', get_visual_selection(false)));
end

vim.api.nvim_set_keymap("v", "<leader>sq", "<cmd>:lua SFDX_VISUAL_QUERY()<CR>", {})


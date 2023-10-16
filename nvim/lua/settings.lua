local opt = vim.opt;

opt.autowrite = true -- enable auto write
opt.cmdheight = 1
opt.completeopt   = "menu,menuone,noselect"
opt.rnu           = true
opt.nu            = true
opt.hlsearch      = false
opt.incsearch     = true
opt.ts            = 2
opt.sts           = 2
opt.sw            = 2
opt.shiftround    = true
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.inccommand = "nosplit"
opt.expandtab     = true
opt.smarttab      = true
opt.signcolumn    = "yes"
opt.autoindent    = true
opt.smartindent   = true
opt.undofile      = true
opt.ignorecase    = true
opt.smartcase     = true
opt.termguicolors = true
opt.wrap          = false
opt.synmaxcol     = 500
opt.mouse         = ""
opt.gdefault      = true
opt.scrolloff     = 4 -- lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.lazyredraw    = true
opt.cursorline    = true
opt.mouse = "a" -- enable mouse mode
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.showmode = false -- dont show mode since we have a statusline
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- minimum window width

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess = "filnxtToOFWIcC"
end


-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

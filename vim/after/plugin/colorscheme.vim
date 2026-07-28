vim9script
# Runs after pack/*/start packages join the runtimepath, before the first draw
try
  colorscheme catppuccin_mocha
catch
  silent! colorscheme habamax
endtry

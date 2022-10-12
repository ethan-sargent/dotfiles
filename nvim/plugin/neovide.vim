if exists("g:neovide")
  let g:neovide_transparency=0.0
  let g:transparency = 1
  let g:neovide_background_color = '#111827'.printf('%x', float2nr(255 * g:transparency))
endif

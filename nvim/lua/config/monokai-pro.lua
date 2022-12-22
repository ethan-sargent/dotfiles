require("monokai-pro").setup({
	transparent_background = true,
	italic_comments = true,
	filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
	diagnostic = {
		background = false,
	},
	plugins = {
		bufferline = {
			underline_selected = true,
		},
    toggleterm = {
      background_clear = true,
    },
    telescope = {
      background_clear = true,
    },
	},
})

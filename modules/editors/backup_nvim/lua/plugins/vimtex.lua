return {
	"lervag/vimtex",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			vimtex_view_method = "zathura",
			vimtex_compiler_method = "latexrun",
		})
	end,
}

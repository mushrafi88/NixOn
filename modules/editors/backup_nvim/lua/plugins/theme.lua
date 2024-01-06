return {
	{
		"catppuccin/nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		name = "catppuccin",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("catppuccin").setup({
				compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
				transparent_background = true,
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					treesitter = true,
					ts_rainbow = true,
					lsp_saga = true,
					lsp_trouble = true,
					dap = {
						enable = true,
						enable_ui = true,
					},
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
					indent_blankline = {
						enabled = true,
						colored_indent_levels = false,
					},

					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
				color_overrides = {},
				custom_highlights = {},
			})
			vim.cmd([[colorscheme catppuccin-mocha ]])
		end,
	},
}

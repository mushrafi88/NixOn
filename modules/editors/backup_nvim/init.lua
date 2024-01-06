require("base")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local lazy_theme = "catppuccin"
local opts = {
	install = {
		colorscheme = { lazy_theme },
	},
	ui = {
		size = { width = 1.0, height = 1.0 },
	},
}
require("lazy").setup("plugins", opts)
require("ibl").setup()

local status, plugin = pcall(require,'lervag/vimtex')
if not status then
    print('Error with plugin: ', plugin)
    return
end
plugin.setup({
    vimtex_view_method = "zathura",
	vimtex_compiler_method = "latexrun",
})



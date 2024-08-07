local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
        print([[
Installing lazy.nvim and plugins.....
⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ]])
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    --- Lazy ---
    "folke/lazy.nvim", --Lazy will manage itself

    --- Colorschemes ---
    { "catppuccin/nvim",           name = "catppuccin", lazy = false,   priority = 1000 },
    { 'rose-pine/neovim',          name = 'rose-pine',  lazy = false,   priority = 1000 },
    { "olimorris/onedarkpro.nvim", lazy = false,        priority = 1000 },
    { "Mofiqul/dracula.nvim",      lazy = false,        priority = 1000 },
    { 'folke/tokyonight.nvim',     lazy = false,        priority = 1000 },
    { "ellisonleao/gruvbox.nvim",  lazy = false,        priority = 1000 },

    --- LSP---
    -- "jose-elias-alvarez/null-ls.nvim",
    "neovim/nvim-lspconfig", --LSP

    -- CMP
    "hrsh7th/nvim-cmp",     --Completion
    "hrsh7th/cmp-nvim-lsp", --Completion LSP integration
    "hrsh7th/cmp-path",     --Completion show system paths
    "hrsh7th/cmp-buffer",   --Completion shows text from current buffer
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",                                                               --Completion snippets
   { "L3MON4D3/LuaSnip",                version = "v2.3.0",dependencies = { "rafamadriz/friendly-snippets" },build = "make install_jsregexp"},                  --luasnip
   { "evesdropper/luasnip-latex-snippets.nvim",  },                                                             --latex snippets
    
   --- The Rest ----
    "lervag/vimtex",                                                                                        -- Vimtex
    "lukas-reineke/indent-blankline.nvim",                                                                  --Sexy indent lines
    "windwp/nvim-ts-autotag",                                                                               --Auto tags for HTML
    "norcalli/nvim-colorizer.lua",                                                                          --Visualize Hex/RGB/etc
    "numToStr/Comment.nvim",                                                                                --Easy full line or selection commenting out
    { "folke/which-key.nvim",            event = "VeryLazy" },                                              --Shows key combinations if youre dumb
    { 'windwp/nvim-autopairs',           event = "InsertEnter" },                                           --Automatic pairs for braces, brackets, quotes, etc.
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },                                             --Parser for better highlighting, use :TSUpdate
    { 'akinsho/toggleterm.nvim',         version = "*",                                    config = true }, --Quick toggle terminal in neovim
    { "nvim-tree/nvim-tree.lua",         dependencies = { "nvim-tree/nvim-web-devicons" } },                --File Browser, Devicons need a hack nerd font
    { "akinsho/bufferline.nvim",         dependencies = { "nvim-tree/nvim-web-devicons" } },                --Tabs
    { "nvim-lualine/lualine.nvim",       dependencies = { "nvim-tree/nvim-web-devicons" } },                --Sexy bar at the bottom
    { "nvim-telescope/telescope.nvim",   dependencies = { "nvim-lua/plenary.nvim" } },                      --Plenary needs g++ and gcc
    { 'glepnir/dashboard-nvim',   event = 'VimEnter', dependencies = { 'nvim-tree/nvim-web-devicons' } }, --Dope ass dashboard
    { "jackMort/ChatGPT.nvim", event = "VeryLazy", dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "folke/trouble.nvim", "nvim-telescope/telescope.nvim"  } },
    { "folke/noice.nvim",  event = "VeryLazy", opts = { }, dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", } },
    {  "lewis6991/gitsigns.nvim",                                                                      },        --Shows deletions/additions/modifications if in git repo 
    {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
},

}
local opts = {}
require("lazy").setup(plugins, opts)

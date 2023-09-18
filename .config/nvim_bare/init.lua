vim.g.mapleader = " "

-- add new paths to the runtime path of neovim
-- see :help runtimepath for more and https://www.reddit.com/r/neovim/comments/14bglt6/i_dont_understand_lua_modules/
-- once you add them in your rtp, then you can `require` them
vim.opt.rtp:prepend(vim.fn.expand("~/.config/nvim_bare"))
vim.opt.rtp:prepend(vim.fn.expand("~/.config/nvim_bare/lua/thedevbirb"))
vim.opt.rtp:prepend(vim.fn.expand("~/.config/nvim_bare/after"))

-- plugins
local plugin_site = vim.fn.expand("~/.local/share/nvim/bare/")
vim.opt.rtp:prepend(plugin_site .. "catppuccin")
vim.opt.rtp:prepend(plugin_site .. "plenary.nvim")
vim.opt.rtp:prepend(plugin_site .. "telescope.nvim")
vim.opt.rtp:prepend(plugin_site .. "fzf-lua")
vim.opt.rtp:prepend(plugin_site .. "nvim-treesitter")

require("thedevbirb")

-- load theme immediately
vim.cmd("colorscheme catppuccin-mocha")

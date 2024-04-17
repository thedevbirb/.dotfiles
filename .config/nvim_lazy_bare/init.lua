local lazypath = vim.fn.stdpath("data") .. "/lazy_bare/lazy.nvim"
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

-- vim.opt.runtimepath:remove(vim.fn.expand('~/.config/nvim'))
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.keymap.set("n", "<leader>rtp", "<cmd>= vim.opt.rtp:get()<cr>")

require("lazy").setup({
	{
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,
  },
  { "nvim-lua/plenary.nvim" },
  { -- https://www.lazyvim.org/plugins/treesitter for more choices
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
  {
	  "neovim/nvim-lspconfig"
  }
})

-- require("lazy").setup({}) adds them
vim.opt.runtimepath:remove(vim.fn.expand("~/.config/nvim"))
vim.opt.runtimepath:remove(vim.fn.expand("~/.config/nvim/after"))
vim.opt.runtimepath:remove(vim.fn.expand("~/.config/nvim/after/site"))

-------------------------------------------------------------------------------
-- KEYMAPS (defaults from LazyVim) --------------------------------------------
-------------------------------------------------------------------------------
local opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Scroll down but stay centered
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts);
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts);

-- open netrw on the left
vim.keymap.set("n", "<leader>e", "<cmd>Lexplore<cr>", {silent = true, desc = "Show Lexplorer"});

-- Join lines but do not move cursor
vim.keymap.set("n", "J", "mzJ`z", opts);

-- Center screen when found the pattern
vim.keymap.set("n", "n", "nzzzv", opts);
vim.keymap.set("n", "N", "Nzzzv", opts);

-- delete to the black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts);

-- paste from system clipboard, and replace selection in visual mode
vim.keymap.set("n", "<leader>p", '"+p', opts);
vim.keymap.set("n", "<leader>P", '"+P', opts);
vim.keymap.set({ "x", "v" }, "<leader>p", [["_dp]], opts);
vim.keymap.set({ "x", "v" }, "<leader>P", [["_dP]], opts);

-- faster quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", {silent = true, desc = "Quit all"});

-- yank to system clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>y", [["+y]], opts);
vim.keymap.set("n", "<leader>Y", [["+Y]], opts);

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts);
vim.keymap.set("v", ">", ">gv", opts);

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts);
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts);

-- move between windows easily with ctrl in original position
vim.keymap.set("n", "<A-h>", "<C-w>h", opts);
vim.keymap.set("n", "<A-l>", "<C-w>l", opts);
vim.keymap.set("n", "<A-j>", "<C-w>j", opts);
vim.keymap.set("n", "<A-k>", "<C-w>k", opts);

-- clean swap
vim.keymap.set("n", "<leader>rmswap", "<cmd>!rm -rf ~/.local/state/nvim/swap<cr>", {silent = true, desc = "Remove swap files"});


-------------------------------------------------------------------------------
-- OPTIONS (defaults from LazyVim) --------------------------------------------
-------------------------------------------------------------------------------
local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 50 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0


--
-- personal settings
--

-- I hate dealing with swap files
vim.opt.swapfile = false


vim.g.netrw_banner = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 22


vim.opt.hlsearch = false
vim.opt.incsearch = true

-- do not use system clipboard always
-- see keymaps.lua for specifc access to it
vim.opt.clipboard = ""

-- always keep cursor centered on screen
-- for some reasons, it doesn't lag compared to remapping
-- j,k to jzz, kzz respectively
vim.opt.scrolloff = 999999

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Silent keymap option
local opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Scroll down but stay centered
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- open netrw on the left
vim.keymap.set("n", "<leader>e", "<cmd>Lexplore<cr>");

-- Join lines but do not move cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Center screen when found the pattern
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- delete to the black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- paste from system clipboard, and replace selection in visual mode
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set({ "x", "v" }, "<leader>p", [["_dp]])
vim.keymap.set({ "x", "v" }, "<leader>P", [["_dP]])

-- yank to system clipboard
vim.keymap.set({ "n", "v", "x" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- move between windows easily with ctrl in original position
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-l>", "<C-w>l")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")

-- clean swap
vim.keymap.set("n", "<leader>rmswap", "<cmd>!rm -rf ~/.local/state/nvim/swap<cr>", { silent = true })

-- when things don't work
-- vim.keymap.set("n", "<leader>dio", function()
--   vim.cmd("CellularAutomaton make_it_rain")
--   vim.fn.system("ffplay -nodisp -autoexit ~/Music/el_short.mp3 > /dev/null 2>&1 &")
-- end, opts)
--
-- plugins keymaps
--
-- local telescope_builtin = require("telescope.builtin");
----find
--vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
--vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
--vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {}) -- cool!
--vim.keymap.set("n", "<leader>fr", telescope_builtin.oldfiles, {})
---- search
--vim.keymap.set("n", "<leader>sg", telescope_builtin.live_grep, {})
--vim.keymap.set("n", "<leader>sw", telescope_builtin.grep_string, {})
---- git
--vim.keymap.set("n", "<leader>gc", telescope_builtin.git_commits, {})
--vim.keymap.set("n", "<leader>gs", telescope_builtin.git_status, {})

-- Let's see how it goes
local fzf_lua = require("fzf-lua");
-- FzfLua profiles
fzf_lua.setup({"max-perf"})

--find
vim.keymap.set('n', '<leader>ff', function() fzf_lua.files() end, {})
vim.keymap.set('n', '<leader>fb', function() fzf_lua.buffers() end, {})
vim.keymap.set('n', '<leader>fh', function() fzf_lua.help_tags() end, {}) -- cool!
vim.keymap.set("n", "<leader>fr", function() fzf_lua.oldfiles() end, {})
-- search
vim.keymap.set("n", "<leader>sg", function() fzf_lua.live_grep_native() end, {})
vim.keymap.set("n", "<leader>sl", function() fzf_lua.grep_last() end, {})
vim.keymap.set("n", "<leader>sw", function() fzf_lua.grep_cword() end, {})
-- git
vim.keymap.set("n", "<leader>gc", function() fzf_lua.git_commits() end, {})
vim.keymap.set("n", "<leader>gs", function() fzf_lua.git_status() end, {})

-- lsp
local lsp_opts = { remap = false }
vim.keymap.set("n", "<leader>gi", function() fzf_lua.lsp_implementations() end, lsp_opts)
vim.keymap.set("n", "<leader>gt", function() fzf_lua.lsp_type_definitions() end, lsp_opts)
vim.keymap.set("n", "<leader>gd", function() fzf_lua.lsp_definitions() end, lsp_opts)
vim.keymap.set("n", "<leader>gr", function() fzf_lua.lsp_references() end, lsp_opts)
vim.keymap.set("i", "<tab>", function() vim.lsp.omnifunc() end, lsp_opts)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, lsp_opts)
vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, lsp_opts)
vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, lsp_opts)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, lsp_opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, lsp_opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, lsp_opts)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, lsp_opts)

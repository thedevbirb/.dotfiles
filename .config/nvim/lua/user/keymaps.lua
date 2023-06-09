-- Shorten function name
-- local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Go to next/previous error in file: DOES NOT WORK
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Scroll down but stay centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Go down/up with visual lines, which means soft-wrapped lines are counted
-- as well
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Join lines but do not move cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Avoid Q
vim.keymap.set("n", "Q", "<nop>", opts)

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')

-- Center screen when found the pattern. Why the final `nv` tho?
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Delete and paste to black hole register
vim.keymap.set("n", "<leader>d", "\"_d")

-- Replace all occurences of word under cursor, case sensitive and every occasion on line!
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Insert --

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Better yank and paste
vim.keymap.set("v", "<leader>y", '"+y')

-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Delete and paste to black hole register
vim.keymap.set("v", "<leader>d", "\"_d")

-- Tmux sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

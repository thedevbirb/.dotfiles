-- Remember that :h <anything> is your friend.

---------------- HELPFUL VARS ---------------------------------------------

local sysname = vim.loop.os_uname().sysname

---------------- ENVS ---------------------------------------------------------

-- Make sure that primary commands and utils like 'man' are from the system.
vim.env.PATH = '/usr/bin:' .. vim.env.PATH

---------------- THEME --------------------------------------------------------


-- Set vim.opt.background based on MacOS system appearance
local function macos_appearance()
  -- Fallback: `defaults` returns "Dark" when Dark Mode is on; errors (no key)
  -- when Light
	local res = vim.fn.system({ "defaults", "read", "-g", 
		"AppleInterfaceStyle" })
	if vim.v.shell_error == 0 and tostring(res):match("Dark") then
		return "dark"
	end
	return "light"
end

local uv = vim.uv or vim.loop
if uv and uv.os_uname().sysname == "Darwin" then
	vim.opt.background = macos_appearance()

	-- Optional: re-sync if you switch themes while Neovim is open
	-- (checks on focus return)
	vim.api.nvim_create_autocmd("FocusGained", {
		desc = "Sync background with macOS appearance",
		callback = function()
			vim.schedule(function()
				vim.opt.background = macos_appearance()
			end)
		end
	})
end

---------------- OPTIONS ------------------------------------------------------

-- A good reference to check out from time to time is
-- https://www.lazyvim.org/configuration/general#options

vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 28

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Keep cursor centered when scrolling.
opt.scrolloff = 999
opt.relativenumber = true

opt.tabstop = 8
opt.expandtab = false
opt.shiftwidth = 8
opt.softtabstop = 8

opt.autoindent = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.textwidth = 100
opt.colorcolumn = "100"

-- "**" allows to search in every subdirectory.
opt.path:append("**")

-- TODO: make this wildignore work also for grep, which uses rg underlying.
opt.wildignore:append({"**.git/**", "**/target/**", "**/build/**", 
	"**/.cargo/**", "**/*~" })
opt.wildignore:append("*.swp,*.swo,*.~")

-- WIP: session management
opt.sessionoptions:append({
  "globals","buffers","tabpages","winsize","winpos",
  "curdir","localoptions","folds"
})

-- Allows to load per-project config files like `.nvim.lua`. See manual for `exrc` for more details.
opt.exrc = true
-- Paired with the option above, disable some stuff to prevent running arbitrary scripts.
opt.secure = true

---------------- KEYMAPS ----------------

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", 
	{ desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", 
	{ desc = "Up", expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", 
	{ desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", 
	{ desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", 
	{ desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", 
	{ desc = "Increase Window Width" })

vim.keymap.set("n", "<leader>e", "<cmd>Lex<cr>")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>")
vim.keymap.set({"n", "x", "v"}, "<leader>y", "\"+y")
vim.keymap.set({"n", "x", "v"}, "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>term", "<C-w>s<C-w>j<cmd>term<cr>A");

vim.keymap.set("n", "<leader>ff", ":find ");
vim.keymap.set("n", "<leader>fb", ":buffer ");

-- Copy relative file path to clipboard
vim.keymap.set("n", "<leader>cp", 
	":lua vim.fn.setreg('+', vim.fn.getreg('%'))<cr>");

vim.keymap.set(
	"n", "<leader>sw", "\"zyiw:grep <C-r>z <cr> | :copen 20<cr>", 
	{ silent = true }
);
vim.keymap.set("n", "<leader>sg", ":grep ");

-- Search help for word under cursor
vim.keymap.set("n", "<leader>hw", "\"zyiw:h <C-r>z<cr>");
-- Search in man pages for word under cursor
vim.keymap.set("n", "<leader>mw", "\"zyiw:Man <C-r>z<cr>");
-- Replace word under cursor in buffer
vim.keymap.set("n", "<leader>rw", "\"zyiw:%s/<C-r>z/<C-r>z");

vim.keymap.set(
	"n",
	"<leader>conf",
	"<cmd>e ~/.config/nvim_simple/init.lua<cr>"
);

-- Enter in terminal mode quickly.
vim.keymap.set('n', '<leader>tt', function()
		vim.cmd('hsplit | terminal')
	end, { desc = 'Open terminal (vertical split)' })



-- Join lines but do not move cursor
vim.keymap.set("n", "J", "mzJ`z")
-- Kill highlight after <esc>
vim.keymap.set("n", "<esc>", "<cmd>noh<cr>")

-- Save with no autocommands
vim.keymap.set("n", ",w", "<cmd>noa w<cr>")
vim.keymap.set("n", ",wa", "<cmd>noa wa<cr>")

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Saner changelist mappings, similar to f-<char> next and previous.
-- Now ';' -> next, ',' -> previous
vim.keymap.set("n", "g;", "g,")
vim.keymap.set("n", "g,", "g;")

-- Clean swap
vim.keymap.set(
	"n", 
	"<leader>rmswap", 
	"<cmd>!rm -rf ~/.local/state/nvim/swap<cr>"
)

-- Set the current buffer to be modifiable, useful for example while opened a terminal with :term
-- to modify commands using normal mode commands.
vim.keymap.set("n", "<leader>mo", ":set modifiable<cr>", { desc = "Modifiable term buffer" });

-- INSERT MODE

-- Invoke omnifunction which <C-Space>
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>");

-- TERMINAL MODE

-- Faster way to enter normal mode.
vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", { desc = "Modifiable term buffer" });

---------------- AUTOCOMMANDS -------------------------------------------------

-- A good reference to check from time to time is:
-- https://www.lazyvim.org/configuration/general#auto-commands
--
local function augroup(name)
	return vim.api.nvim_create_augroup("nvim_simple_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
	(vim.hl or vim.highlight).on_yank()
  end,
})

-- Filter quickfix entries to drop backup/swap files (~, ~~)
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	callback = function()
		local qflist = vim.fn.getqflist()
		local filtered = vim.tbl_filter(function(item)
			-- item.bufnr maps to a filename
			local fname = vim.fn.bufname(item.bufnr)
			return not fname:match("~+$")  -- exclude files ending in ~ or ~~
		end, qflist)
		vim.fn.setqflist(filtered, "r")
	end,
})

-- When opening a buffer, jump to last known cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		-- Get the mark for the last cursor position
		local last_pos = vim.api.nvim_buf_get_mark(0, '"')
		local line = last_pos[1]
		local col  = last_pos[2]
		-- if the mark is valid, set the cursor there
		if line > 0 and line <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, { line, col })
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = {"*.c", "*.h"},
	callback = function()
		local current_paths = vim.opt_local.path:get()
		local extra_paths = { "/usr/local/include" }

		if sysname == "Linux" then
			table.insert(extra_paths, "/usr/include")
		end

		if sysname == "Darwin" then
			table.insert(
				extra_paths, 
				"/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include"
			)
		end

		for _, p in ipairs(extra_paths) do 
			if not vim.tbl_contains(current_paths, p) then
				vim.opt_local.path:append(p)
			end
		end
	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = {"*.c", "*.h"},
	callback = function()
		vim.keymap.set("n", "<localleader>f", ":!./lindent %<cr><cr>");
	end
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"help",
		"notify",
		"qf",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
				end, 
				{ buffer = event.buf, silent = true, desc = "Quit buffer", })
		end)
	end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does
-- not exist.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.txt",
	callback = function()
		vim.opt_local.textwidth = 0
		vim.opt_local.linebreak = true
		vim.opt_local.wrap = true
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "markdown",
	callback = function()
		vim.keymap.set(
			"n", 
			"<leader>mp", 
			"<cmd>!markdown_previewer %<cr>", 
			{ silent = true }
		)
	end
})

---------------------- TERMINAL MODE --------------------------------------------------------------


---------------------- C DEVELOPMENT --------------------------------------------------------------

-- TODOs
-- [ ] :find doesn't respect .gitignore
-- [ ] case respectful substitution, find tpope plugin for it.

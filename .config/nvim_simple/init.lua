-- Remember that :h <anything> is your friend.

---------------- HELPFUL VARS ---------------------------------------------

local sysname = vim.loop.os_uname().sysname

---------------- ENVS ---------------------------------------------------------

-- Make sure that primary commands and utils like 'man' are from the system.
vim.env.PATH = '/usr/bin:' .. vim.env.PATH

---------------- GLOBALS --------------------------------------------------------------------------

vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 28

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Orbstack workaround for clipboard: https://github.com/orbstack/orbstack/issues/1799#issuecomment-2719123106
if vim.system({ "uname", "-a" }, { text = true }):wait().stdout:lower():find("orbstack") then
	vim.g.clipboard = {
	  name = 'myClipboard',
	  copy = {
	    ['+'] = { 'pbcopy' },
	    ['*'] = { 'pbcopy' },
	  },
	  paste = {
	    ['+'] = { 'pbpaste' },
	    ['*'] = { 'pbpaste' },
	  },
	  cache_enabled = 1,
	}
end

---------------- alias ---------------------------------------------------------------------------

local opt = vim.opt

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
if sysname == "Darwin" then
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

if sysname == "Linux" then
	vim.opt.background = "dark"

	-- Switch theme quickly, useful when no DE is available. doesnt' work
	vim.keymap.set("n", "<leader>bg", function ()
		if opt.background:get() == "dark" then 
			opt.background = "light"
		else
			opt.background = "dark"
		end
	end)
end

---------------- OPTIONS ------------------------------------------------------

-- A good reference to check out from time to time is
-- https://www.lazyvim.org/configuration/general#options

vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 28

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

-- Show always popup menu, but don't auto-select the first result unless there is only one option.
opt.completeopt = { "menu", "noselect" }

---------------- KEYMAPS --------------------------------------------------------------------------

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Switch theme quickly, useful when no DE is available. doesnt' work
-- vim.keymap.set("n", "<leader>bg", function ()
-- 		if opt.background:get() == "dark" then 
-- 			opt.background:remove()
-- 			opt.background:set("light") 
-- 		else
-- 			opt.background:remove()
-- 			opt.background:set("dark")
-- 		end
-- 	end)

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
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>")

---- Yank and Paste

vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")
vim.keymap.set({"n", "x", "v"}, "<leader>y", "\"+y")
vim.keymap.set({"n", "x", "v"}, "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>term", "<C-w>s<C-w>j<cmd>term<cr>A");
-- Copy relative file path to clipboard
vim.keymap.set("n", "<leader>cp", ":lua vim.fn.setreg('+', vim.fn.getreg('%'))<cr>");

-- Find
vim.keymap.set("n", "<leader>ff", ":find ");
vim.keymap.set("n", "<leader>fb", ":buffer ");

-- Search

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

-- Enter in terminal mode quickly. todo redundant with term
vim.keymap.set('n', '<leader>tt', function()
		vim.cmd('hsplit | terminal')
	end, { desc = 'Open terminal (horizontal split)' })



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

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "c", "lua" },
	callback = function()
		vim.keymap.set(
			"n",
			"<leader>sm",
			[[:grep "^\#define <C-r><C-w>"<cr>]],
			{ desc = "Search for macro declarations (#define) for the work under cursor" }

		)
		vim.keymap.set(
			"n",
			"<leader>sf",
			[[:grep "^<C-r><C-w>\("<cr>]],
			{ desc = "Search for function definition/declaration for the work under cursor. Assumes BSD-style" }

		)
	end
})

-------------------- SIMPLE PLUGINS ---------------------------------------------------------------


-- tree-browser.lua — minimal tree(1) file browser for Neovim
-- Usage: :Tree to toggle | <CR> open file | q close | R refresh

if vim.fn.executable("tree") == 1 then
	-- Plugin-wide global variables containing the current buffer, window and paths.
	local buf, win, paths

	-- tree(1) flags without long equivalents: -n (no color), -f (full path),
	-- -i (no indentation lines), -I (exclude pattern), -a (all files, even dotfiles).
	local flags_common = "--dirsfirst --gitignore -I .git --noreport -a "
	local tree_base = "tree -n " .. flags_common
	local tree_flat = "tree -nfi " .. flags_common

	-- Refresh the current file browser view.
	local function refresh()
		local cwd = vim.fn.shellescape(vim.fn.getcwd())
		-- Two tree calls with identical ordering: the pretty one for display, the
		-- flat one (-fi) for path lookup. 
		-- IMPORTANT: Both produce the same number of lines so cursor line number indexes
		-- directly into the paths table.
		local pretty = vim.fn.systemlist(tree_base .. cwd)
		paths = vim.fn.systemlist(tree_flat .. cwd)

		-- Modify the buffer from start to the end with the pretty tree.
		vim.bo[buf].modifiable = true
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, pretty)
		vim.bo[buf].modifiable = false
	end

	-- Use cursor line number to index into the flat paths table, skip directories,
	-- then jump to the previous window (wincmd p) and open the file there.
	local function open_file()
		local path = paths[vim.api.nvim_win_get_cursor(0)[1]]
		if not path or vim.fn.isdirectory(path) == 1 then return end
		vim.cmd("wincmd p | edit " .. vim.fn.fnameescape(path))
	end

	local function toggle()
		if win and vim.api.nvim_win_is_valid(win) then
			-- Refuse to close the last window (E444); just nil out the handle.
			if #vim.api.nvim_list_wins() > 1 then
				vim.api.nvim_win_close(win, true)
			end
			win = nil
			return
		end

		if not buf or not vim.api.nvim_buf_is_valid(buf) then
			buf = vim.api.nvim_create_buf(false, true)
			vim.bo[buf].filetype = "tree"
			vim.keymap.set("n", "<CR>", open_file, { buffer = buf })
			vim.keymap.set("n", "q", toggle, { buffer = buf })
			vim.keymap.set("n", "R", refresh, { buffer = buf })
		end

		-- Create a vsplit with ~30% size.
		vim.cmd("topleft vsplit")
		vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.3))

		win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(win, buf)

		vim.wo[win].number = false
		vim.wo[win].relativenumber = false
		vim.wo[win].signcolumn = "no"
		vim.wo[win].cursorline = true
		vim.wo[win].winfixwidth = true
		vim.wo[win].wrap = false

		refresh()
	end

	vim.api.nvim_create_user_command("Tree", toggle, {})

	vim.api.nvim_create_autocmd({ "BufWritePost", "FocusGained" }, {
		callback = function()
			if buf and vim.api.nvim_buf_is_valid(buf) and 
			   win and vim.api.nvim_win_is_valid(win) then
				refresh()
			end
		end,
	})
	vim.keymap.set("n", "<leader>e", "<cmd>Tree<cr>")
end

-- fzf-files.lua — minimal fzf file picker for Neovim
-- Usage: :FzfFiles to pick and open a file
if vim.fn.executable("fzf") == 1 then
	-- Architecture:
	--
	-- The plugin opens a short bottom split containing a Neovim :terminal running
	-- fzf.  Because fzf is a TUI program it needs a real TTY, so we cannot simply
	-- call vim.fn.system(); instead we use vim.fn.termopen() which attaches fzf to
	-- a terminal buffer the user can interact with normally.
	--
	-- fzf writes its selection to stdout, which we redirect into a temporary file
	-- (fzf > tmpfile).  When fzf exits, the on_exit callback fires: we read the
	-- temp file to recover the chosen path, tear down the terminal buffer, and
	-- open the file in the window the user was in before invoking :FzfFiles.
	--
	-- For .gitignore-aware file listing we try to pipe fd or rg into fzf as a
	-- source command.  Both respect .gitignore by default.  If neither is
	-- installed, fzf falls back to its built-in find(1) source which does not
	-- filter by .gitignore.
	--
	--   [fd --type file | ] fzf > /tmp/nvimXXX
	--         ^                       ^
	--   optional source          temp file holds the picked path
	--         │                       │
	--         └──── terminal buffer ──┘
	--                    │
	--              on_exit callback
	--                    │
	--         ┌──────────┴──────────┐
	--         │  read tmp -> path   │
	--         │  delete term buf    │
	--         │  open path in prev  │
	--         │  window             │
	--         └─────────────────────┘

	-- Pick the best available file lister.  fd and rg both honour .gitignore out
	-- of the box.  The result is nil when neither is installed, in which case fzf
	-- uses its built-in find(1) walker.  Lua's `and/or` short-circuit: the first
	-- truthy value wins.
	local src = (vim.fn.executable("fd") == 1 and "fd --type file")
		or (vim.fn.executable("rg") == 1 and "rg --files")

	local function fzf_files()
		-- Create a temp file that fzf will write its selection into via shell
		-- redirection (>).  We read it back after fzf exits.
		local tmp = vim.fn.tempname()

		-- Build the shell command.  If a source is available, pipe it into fzf;
		-- otherwise let fzf use its default source.  The selection is redirected
		-- into the temp file so we can retrieve it after the process ends.
		local cmd = (src and (src .. " | ") or "") .. "fzf > " .. vim.fn.shellescape(tmp)

		-- Remember which window the user is in so we can open the picked file
		-- there after fzf exits.
		local prev_win = vim.api.nvim_get_current_win()

		-- Open a small horizontal split at the very bottom for the fzf terminal.
		-- 15 lines is enough for fzf to show a reasonable number of candidates.
		vim.cmd("botright 15new")
		local term_buf = vim.api.nvim_get_current_buf()

		-- Start fzf inside the terminal buffer.  termopen() connects the buffer
		-- to the child process's PTY so the user can type, scroll, and select.
		-- The on_exit callback fires once fzf terminates (selection or cancel).
		vim.fn.termopen(cmd, {
			on_exit = function(_, code)
				-- vim.schedule defers into the main loop because on_exit fires in
				-- a luv callback context where most Neovim API calls are forbidden.
				vim.schedule(function()
					-- Tear down the terminal buffer unconditionally.  pcall guards
					-- against the buffer already being gone (e.g. user ran :q).
					pcall(vim.api.nvim_buf_delete, term_buf, { force = true })

					-- Exit code 0 means the user picked a file; 1 means no match,
					-- 2 means error, 130 means cancelled (Ctrl-C / Esc).
					if code == 0 then
						-- Read the result in the temporary file.
						local file = io.open(tmp)
						if file then
							-- Read exactly one line: the selected file path.
							local pick = file:read("*l")
							file:close()
							-- Only proceed if we got a non-empty path and the
							-- original window still exists (user may have closed
							-- it while fzf was open).
							if pick and pick ~= "" and vim.api.nvim_win_is_valid(prev_win) then
								vim.api.nvim_set_current_win(prev_win)
								vim.cmd("edit " .. vim.fn.fnameescape(pick))
							end
						end
					end

					-- Clean up the temp file regardless of outcome.
					os.remove(tmp)
				end)
			end,
		})

		-- Enter terminal insert mode so keystrokes go straight to fzf instead of
		-- being interpreted as Neovim normal-mode commands.
		vim.cmd("startinsert")
	end

	-- Register the user command.  No arguments, no completion — just run it.
	vim.api.nvim_create_user_command("FzfFiles", fzf_files, {})
	vim.keymap.set("n", "<leader>ff", fzf_files, { desc =  "find files" })
end


-- TODOs
-- [ ] :find doesn't respect .gitignore
-- [ ] case respectful substitution, find tpope plugin for it.

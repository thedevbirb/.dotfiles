-- :help options

---- General options
-- allows neovim to access the system clipboard
vim.opt.clipboard = "unnamedplus"
-- the encoding written to a file
vim.opt.fileencoding = "utf-8"
-- having longer update time leads to noticeable delays and poor UX
vim.opt.updatetime = 50


---- Search options
-- highlight all matches on previous search pattern
vim.opt.hlsearch = false
-- ignore case in search patterns
vim.opt.ignorecase = true
-- show search options while you type
vim.opt.incsearch = true
-- if search begins with upper case, consider it
vim.opt.smartcase = true


---- Tab, spaces and indentation
-- in insert mode: convert tabs into spaces
vim.opt.expandtab = true
-- number of spaces that a <Tab> counts for while performing editing operations
vim.opt.softtabstop = 2
-- number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2
-- enable smart indentation
vim.opt.smartindent = true
-- number of spaces that a <Tab> in the file counts for
vim.opt.tabstop = 2


---- Mouse support
-- enable mouse support
vim.opt.mouse = "a"


---- Line numbering
-- enable line numbering
vim.opt.number = true
-- enable relative numbering
vim.opt.relativenumber = true


---- Colors
-- set term gui colors (most terminals support this)
vim.opt.termguicolors = true
-- show a colored column line at 80 characters
vim.opt.colorcolumn = "80"


---- Window management
-- force all horizontal splits to go below current window
vim.opt.splitbelow = true
-- force all vertical splits to go to the right of current window
vim.opt.splitright = true


---- Backup files etc
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true


---- Miscellaneous
-- give more space for displaying messages
vim.opt.cmdheight = 1
-- minimal number of lines to scroll when the cursor gets off the screen
vim.opt.scrolloff = 8
-- adds a column on the left of line numbering to display info
vim.opt.signcolumn = "yes"
-- don't pass messages to |ins-completion-menu|
vim.opt.shortmess:append("c")

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local fb_actions = require "telescope._extensions.file_browser.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    initial_mode = "insert",

    mappings = {
      n = {
        ['d'] = require('telescope.actions').delete_buffer
      },
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    file_browser = {
      -- theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["h"] = fb_actions.goto_parent_dir,
          ["l"] = fb_actions.change_cwd,
        },
      },
    },
  },
}

-- use compiled sorter to improve performance
telescope.load_extension("fzy_native")
telescope.load_extension("file_browser")

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>fg", ":Telescope git_files<CR>", opts)
vim.keymap.set("n", "<leader>faf", ":Telescope find_files hidden=true no_ignore=true<CR>", opts) -- find all files
vim.keymap.set("n", "<leader>ft", ":Telescope live_grep<CR>", opts) -- find text
vim.keymap.set("n", "<leader>fw", ":Telescope grep_string word_match=-w<CR>", opts) -- find exact word under cursor
vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>fB", ":Telescope file_browser<CR>", opts)
vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", opts) -- List vim marks and their value
vim.keymap.set("n", "<leader>fr", ":Telescope registers<CR>", opts) -- List vim marks and their value

-- lsp
vim.keymap.set("n", "<leader>lr", ":Telescope lsp_references<CR>", opts)
vim.keymap.set("n", "<leader>ld", ":Telescope lsp_definitions<CR>", opts)
vim.keymap.set("n", "<leader>ltd", ":Telescope lsp_type_definitions<CR>", opts)
vim.keymap.set("n", "<leader>lD", ":Telescope diagnostics bufnr=0<CR>", opts)
vim.keymap.set("n", "<leader>laD", ":Telescope diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>lws", ":Telescope lsp_workspace_symbols<CR>", opts)

-- git
vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", opts)

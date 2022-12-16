local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  -- A 'picker' is a the central UI dedicated to varying use cases 
  --    (finding files, grepping, diagnostics, etc.)
  pickers = {
    -- example:
    -- picker_name = {
    --    picker_config_key = value,
    --    ...
    -- }
    -- Now the picker_config_key will be applid every time you call this 
    -- builtin picker. For example, calling telescope.builtin.find_files()
    -- will use the following options.
    find_files = {
      -- See keymaps.lua
      -- show dotfiles
      -- hidden = true,
      -- show also gitignored files
      -- no_ignore = true,
    }
  }
}

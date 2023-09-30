vim.lsp.start({
  name = "typescript-language-server",
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = vim.fs.dirname(vim.fs.find({ "tsconfig.json" }, { upward = true })[1]),
})

-- Define the Prettier formatting function
local function prettier_format()
  local file_path = vim.fn.expand("%:p")
  local command = string.format("prettier --write %s", file_path)
  vim.fn.jobstart(command, {
    on_exit = function(_, code)
      if code == 0 then
        vim.cmd("e") -- Reload the buffer to reflect the changes
        print("Prettier formatting successful")
      else
        print("Prettier formatting failed")
      end
    end
  })
end

local utils = require("thedevbirb.utils");

vim.keymap.set("n", "<space>cf", function()
  vim.cmd([[write]]);
  utils.prettier_format();
  vim.cmd([[write]]);
end, { silent = true })

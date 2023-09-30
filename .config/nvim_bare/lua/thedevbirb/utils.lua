-- Define the Prettier formatting function

local M = {}

function M.prettier_format()
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

return M

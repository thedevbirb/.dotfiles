-- Automatic Setup is a need feature that removes the need to configure null-ls 
-- for supported sources. Sources found installed in mason will automatically be
-- setup for null-ls.
local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not status_ok then
  return
end

mason_null_ls.setup({
  automatic_setup = true,
})

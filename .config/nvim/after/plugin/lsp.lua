local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
  print("lsp-zero not loaded")
  return
end

lsp.preset("recommended")

lsp.ensure_installed({
  "tsserver",
  "sumneko_lua",
  "cssls",
  "html",
  "jsonls",
  "bashls",
  "solidity",
  "tailwindcss",
  "prismals",
  "rust_analyzer",
})

local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  print("cmp not loaded")
  return
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
  sign_icons = {}
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "lj", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "lk", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

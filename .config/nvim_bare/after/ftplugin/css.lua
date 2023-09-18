vim.lsp.start({
  name = "tailwindcss-language-server",
  cmd = {"tailwindcss-language-server", "--stdio"},
  root_dir = vim.fs.dirname(vim.fs.find({"tsconfig.json"}, { upward = true })[1]),
})

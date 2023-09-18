vim.lsp.start({
  name = 'lua-language-server',
  cmd = {'lua-language-server-3.7.0'},
  root_dir = vim.fs.dirname(vim.fs.find({'init.lua'}, { upward = true })[1]),
})

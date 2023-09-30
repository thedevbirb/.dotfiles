vim.cmd([[
  augroup NetrwFollow
    autocmd!
    autocmd BufEnter * if &filetype == 'netrw' | wincmd p | endif
  augroup END
]])

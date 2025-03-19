-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.list = false
vim.opt.mouse = "a"

vim.opt.number = true -- Enable absolute line numbers
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.cursorline = true
vim.cmd([[autocmd VimEnter * highlight CursorLine guibg=None]])
vim.cmd([[autocmd VimEnter * highlight CursorLineNr cterm=None gui=None guibg=None guifg=#555555]])

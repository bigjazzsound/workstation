require('init')
require('plugins')

vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]
vim.o.signcolumn = "yes"
vim.cmd[[ colorscheme onedark ]]

require('init')
require('plugins')

vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]
vim.o.statusline = [[ [%n] %f%h%w%m%r %{fugitive#head()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft} %{luaeval("require('lsp-status').status()")} %l/%L  %P ]]
vim.o.signcolumn = "yes"
vim.cmd[[ colorscheme onedark ]]

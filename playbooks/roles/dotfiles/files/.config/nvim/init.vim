let g:vimsyn_embed = 'l' " enable embedded lua syntax highlighting

if has("nvim")
lua <<EOF
require('init')
require('plugins')
vim.o.statusline = [[ [%n] %f%h%w%m%r %{fugitive#head()} %= %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""} %{&ft} %{luaeval("require('lsp-status').status()")} %l/%L  %P ]]
EOF
endif

" This is not working in lua, so putting it here
set signcolumn=yes

colorscheme gruvbox

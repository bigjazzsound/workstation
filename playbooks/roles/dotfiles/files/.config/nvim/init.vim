lua <<EOF
require('init')
require('plugins')
EOF

" You cannot import nvim_lsp in lua files currently, so
" lsp setup needs to be done here.
if has("nvim-0.5.0")
lua <<EOF
require('lsp')
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF
endif

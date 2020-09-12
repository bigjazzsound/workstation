if has("nvim")
lua <<EOF
require('init')
require('plugins')
require('lsp')
EOF
endif

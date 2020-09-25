if has("nvim")
lua <<EOF
require('init')
require('plugins')
EOF
endif

" This is not working in lua, so putting it here
set signcolumn=yes

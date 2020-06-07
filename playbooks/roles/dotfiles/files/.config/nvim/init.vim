lua <<EOF
require('init')
require('plugins')
EOF

" You cannot import nvim_lsp in lua files currently, so
" lsp setup needs to be done here.
if has("nvim-0.5.0")
lua <<EOF
require('lsp')
lsp = require('nvim_lsp')

lsp.bashls.setup{}
lsp.dockerls.setup{}
lsp.gopls.setup{}
lsp.jsonls.setup{}
lsp.pyls_ms.setup{
  interpreter = {
    properties = {
      InterpreterPath = "/usr/local/opt/python@3.8/bin/python3",
      Version = "3.8"
    }
  }
}
lsp.sumneko_lua.setup{}
lsp.terraformls.setup{}
lsp.vimls.setup{}
lsp.yamlls.setup{}

local nvimux = require('nvimux')

-- Nvimux configuration
nvimux.config.set_all{
  prefix = '<C-Space>',
  new_window = 'enew', -- Use 'term' if you want to open a new term for every new window
  new_tab = nil, -- Defaults to new_window. Set to 'term' if you want a new term for every new tab
  new_window_buffer = 'single',
  quickterm_direction = 'botright',
  quickterm_orientation = 'vertical',
  quickterm_scope = 't', -- Use 'g' for global quickterm
  quickterm_size = '80',
}

-- Nvimux custom bindings
nvimux.bindings.bind_all{
  {'s', ':NvimuxHorizontalSplit', {'n', 'v', 'i', 't'}},
  {'v', ':NvimuxVerticalSplit', {'n', 'v', 'i', 't'}},
  {'<C-l>', 'gt', {'n'}},
  {'<C-h>', 'gT', {'n'}},
}

-- Required so nvimux sets the mappings correctly
nvimux.bootstrap()
EOF
endif

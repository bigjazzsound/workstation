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
lsp.pyls.setup{
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

require('nvim_lsp').bashls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').dockerls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').gopls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').jsonls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').pyls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').sumneko_lua.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').vimls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').yamlls.setup{on_attach=require('completion').on_attach}

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
  {'x', ':belowright Tnew', {'n', 'v', 'i', 't'}},
  {'v', ':vertical Tnew', {'n', 'v', 'i', 't'}},
  {'<C-l>', 'gt', {'n', 'v', 'i', 't'}},
  {'<C-h>', 'gT', {'n', 'v', 'i', 't'}},
  {'c', ':tab Tnew', {'n', 'v', 'i', 't'}},
}

-- Required so nvimux sets the mappings correctly
nvimux.bootstrap()

vim.g.neoterm_autoinsert = 1
vim.g.neoterm_clear_cmd = { "clear", "" }
vim.g.neoterm_default_mod = "vertical"

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF
endif

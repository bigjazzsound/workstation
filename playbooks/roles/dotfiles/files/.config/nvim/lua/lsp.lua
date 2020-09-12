require('nvim_lsp').bashls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').dockerls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').gopls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').jsonls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').pyls.setup{on_attach=require('completion').on_attach}
require('nlua.lsp.nvim').setup(require('nvim_lsp'), {
  on_attach = require('completion').on_attach,

  globals = {
    "api",
    "env",
    "set_keymap",
    "home",
  }
})
require('nvim_lsp').vimls.setup{on_attach=require('completion').on_attach}
require('nvim_lsp').yamlls.setup{on_attach=require('completion').on_attach}

api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
api.nvim_command[[autocmd BufEnter * lua require'completion'.on_attach()]]
vim.o.completeopt = "menuone,noinsert,noselect"

set_keymap('n', 'gd',    ':lua vim.lsp.buf.declaration()<CR>',     DEFAULT_KEYMAP)
set_keymap('n', '<c-]>', ':lua vim.lsp.buf.definition()<CR>',      DEFAULT_KEYMAP)
set_keymap('n', 'K',     ':lua vim.lsp.buf.hover()<CR>',           DEFAULT_KEYMAP)
set_keymap('n', 'gD',    ':lua vim.lsp.buf.implementation()<CR>',  DEFAULT_KEYMAP)
set_keymap('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>',  DEFAULT_KEYMAP)
set_keymap('n', '1gD',   ':lua vim.lsp.buf.type_definition()<CR>', DEFAULT_KEYMAP)
set_keymap('n', 'gr',    ':lua vim.lsp.buf.references()<CR>',      DEFAULT_KEYMAP)
set_keymap('n', 'g0',    ':lua vim.lsp.buf.document_symbol()<CR>', DEFAULT_KEYMAP)

vim.cmd[[command Format :lua vim.lsp.buf.formatting()]]

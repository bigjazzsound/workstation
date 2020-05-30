local api = vim.api
local set_keymap = api.nvim_set_keymap

set_keymap('n', 'gd',    ':lua vim.lsp.buf.declaration()<CR>',     DEFAULT_KEYMAP)
set_keymap('n', '<c-]>', ':lua vim.lsp.buf.definition()<CR>',      DEFAULT_KEYMAP)
set_keymap('n', 'K',     ':lua vim.lsp.buf.hover()<CR>',           DEFAULT_KEYMAP)
set_keymap('n', 'gD',    ':lua vim.lsp.buf.implementation()<CR>',  DEFAULT_KEYMAP)
set_keymap('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>',  DEFAULT_KEYMAP)
set_keymap('n', '1gD',   ':lua vim.lsp.buf.type_definition()<CR>', DEFAULT_KEYMAP)
set_keymap('n', 'gr',    ':lua vim.lsp.buf.references()<CR>',      DEFAULT_KEYMAP)
set_keymap('n', 'g0',    ':lua vim.lsp.buf.document_symbol()<CR>', DEFAULT_KEYMAP)

api.nvim_command [[command Format :lua vim.lsp.buf.formatting()]]

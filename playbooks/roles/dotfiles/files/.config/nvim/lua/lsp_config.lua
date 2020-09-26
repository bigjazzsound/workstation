local nvim_lsp = require('nvim_lsp')
local lsp_status = require('lsp-status')

lsp_status.register_progress()
lsp_status.config({
  status_symbol = '',
  indicator_errors = 'E',
  indicator_warnings = 'W',
  indicator_info = 'I',
  indicator_hint = 'H',
  indicator_ok = 'OK',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})

local on_attach = function(client)
  require('completion').on_attach(client)
  require('diagnostic').on_attach(client)
end

nvim_lsp.bashls.setup{
  on_attach = on_attach,
  filetypes = {
    "sh",
    "zsh",
  }
}

nvim_lsp.dockerls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

nvim_lsp.gopls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

nvim_lsp.jsonls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

nvim_lsp.pyls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

require('nlua.lsp.nvim').setup(nvim_lsp, {
  on_attach = on_attach,
  globals = {
    "home",
    "set_keymap",
    "use"
  }
})

nvim_lsp.vimls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

nvim_lsp.yamlls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.cmd [[ autocmd BufEnter * lua require('completion').on_attach() ]]
vim.o.completeopt = "menuone,noinsert,noselect"

set_keymap('n', 'gd',    ':lua vim.lsp.buf.declaration()<CR>',     DEFAULT_KEYMAP)
set_keymap('n', '<c-]>', ':lua vim.lsp.buf.definition()<CR>',      DEFAULT_KEYMAP)
set_keymap('n', 'K',     ':lua vim.lsp.buf.hover()<CR>',           DEFAULT_KEYMAP)
set_keymap('n', 'gD',    ':lua vim.lsp.buf.implementation()<CR>',  DEFAULT_KEYMAP)
set_keymap('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>',  DEFAULT_KEYMAP)
set_keymap('n', '1gD',   ':lua vim.lsp.buf.type_definition()<CR>', DEFAULT_KEYMAP)
set_keymap('n', 'gr',    ':lua vim.lsp.buf.references()<CR>',      DEFAULT_KEYMAP)
set_keymap('n', 'g0',    ':lua vim.lsp.buf.document_symbol()<CR>', DEFAULT_KEYMAP)

vim.cmd [[ command! Format :lua vim.lsp.buf.formatting() ]]

-- Visualize diagnostics
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_trimmed_virtual_text = '40'
-- Don't show diagnostics while in insert mode
vim.g.diagnostic_insert_delay = 1

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.o.updatetime = 300
-- Show diagnostic popup on cursor hold
vim.cmd [[ autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics() ]]

-- Goto previous/next diagnostic warning/error
set_keymap('n' , 'g[', '<cmd>PrevDiagnosticCycle<cr>', DEFAULT_KEYMAP)
set_keymap('n' , 'g]', '<cmd>NextDiagnosticCycle<cr>', DEFAULT_KEYMAP)

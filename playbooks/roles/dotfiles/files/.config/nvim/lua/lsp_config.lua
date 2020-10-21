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
  lsp_status.on_attach(client)

  set_keymap('n', 'K',          ':lua vim.lsp.buf.hover()<CR>',           DEFAULT_KEYMAP)
  set_keymap('n', '<leader>gd', ':lua vim.lsp.buf.declaration()<CR>',     DEFAULT_KEYMAP)
  set_keymap('n', '<leader>gD', ':lua vim.lsp.buf.definition()<CR>',      DEFAULT_KEYMAP)
  set_keymap('n', '<leader>gr', ':lua vim.lsp.buf.references()<CR>',      DEFAULT_KEYMAP)
  set_keymap('n', '<leader>gt', ':lua vim.lsp.buf.document_symbol()<CR>', DEFAULT_KEYMAP)
  set_keymap('n', 'g[',         '<cmd>PrevDiagnosticCycle<cr>',           DEFAULT_KEYMAP)
  set_keymap('n', 'g]',         '<cmd>NextDiagnosticCycle<cr>',           DEFAULT_KEYMAP)
  set_keymap('n', '<leader>lf', ':lua vim.lsp.buf.formatting()<CR>',      DEFAULT_KEYMAP)
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

nvim_lsp.terraformls.setup{
  -- Currently breaks insert mode
  -- on_attach = on_attach,
  capabilities = lsp_status.capabilities,
  cmd = {'terraform-ls', 'serve'},
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
vim.o.completeopt = "menuone,noinsert,noselect"

vim.cmd [[ command! Format :lua vim.lsp.buf.formatting() ]]

-- Visualize diagnostics
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_trimmed_virtual_text = '40'
vim.g.completion_matching_ignore_case = 1
vim.g.completion_matching_strategy_list = {'exact', 'fuzzy', 'substring', 'all'}
-- Don't show diagnostics while in insert mode
vim.g.diagnostic_insert_delay = 1

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.o.updatetime = 300
-- Show diagnostic popup on cursor hold
vim.cmd [[ autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics() ]]

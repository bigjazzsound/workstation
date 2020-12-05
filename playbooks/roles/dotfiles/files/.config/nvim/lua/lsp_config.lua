local lsp = require("lspconfig")
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
  lsp_status.on_attach(client)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    }
  )

  vim.api.nvim_buf_set_keymap(0, 'n', 'K',          ':lua vim.lsp.buf.hover()<CR>',                    DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gd', ':lua vim.lsp.buf.declaration()<CR>',              DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gD', ':lua vim.lsp.buf.definition()<CR>',               DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gr', ':lua vim.lsp.buf.references()<CR>',               DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gt', ':lua vim.lsp.buf.document_symbol()<CR>',          DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>dn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',     DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>dp', '<cmd>lua vim.lsp.diagnostic.goto_previous()<CR>', DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>dl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',   DEFAULT_KEYMAP)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>', DEFAULT_KEYMAP)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_command [[ au CursorHold <buffer> lua vim.lsp.buf.document_highlight() ]]
    vim.api.nvim_command [[ au CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]]
  end

  -- Show diagnostic popup on cursor hold
  vim.cmd [[ autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics() ]]

  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
  vim.o.completeopt = "menuone,noinsert,noselect"
  vim.g.completion_matching_ignore_case = 1
  vim.g.completion_matching_strategy_list = {'exact', 'fuzzy', 'substring', 'all'}
  vim.o.updatetime = 300

end

lsp.clangd.setup{
  on_attach = on_attach,
  cmd = {
    'clangd',
    '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
    '--suggest-missing-includes', '--cross-file-rename'
  },
  handlers = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true
  }
}

lsp.bashls.setup{
  on_attach = on_attach,
  filetypes = {
    "sh",
    "zsh",
  }
}

lsp.dockerls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

lsp.gopls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

lsp.jsonls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

lsp.pyls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

lsp.terraformls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

require('nlua.lsp.nvim').setup(lsp, {
  on_attach = on_attach,
  globals = {
    "home",
    "set_keymap",
    "use"
  }
})

lsp.vimls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

lsp.yamlls.setup{
  on_attach = on_attach,
  capabilities = lsp_status.capabilities,
}

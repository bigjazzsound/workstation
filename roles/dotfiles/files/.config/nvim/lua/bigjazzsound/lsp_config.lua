local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    }
  )

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',          '<CMD>lua vim.lsp.buf.hover()<CR>',                DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<CMD>lua vim.lsp.buf.declaration()<CR>',          DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<CMD>lua vim.lsp.buf.definition()<CR>',           DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<CMD>lua vim.lsp.buf.references()<CR>',           DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<CMD>lua vim.lsp.buf.document_symbol()<CR>',      DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d',         '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>',     DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d',         '<CMD>lua vim.lsp.diagnostic.goto_previous()<CR>', DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dl', '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>',   DEFAULT_KEYMAP)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf', '<CMD>lua vim.lsp.buf.formatting()<CR>', DEFAULT_KEYMAP)
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.clangd.setup{
  on_attach = on_attach,
  cmd = {
    'clangd',
    '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
    '--suggest-missing-includes', '--cross-file-rename'
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true
  }
}

nvim_lsp.bashls.setup{
  on_attach = on_attach,
  filetypes = {
    "sh",
    "zsh",
  }
}

nvim_lsp.dockerls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.jsonls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.rls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.terraformls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {'hcl'}
}

nvim_lsp.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    vim.env.HOME .. string.format(
      "/playground/lua-language-server/bin/%s/lua-language-server",
      function()
        if vim.fn.has('mac') == 1 then
          return 'macOS'
        else
          return 'Linux'
        end
      end
    ),
    "-E",
    vim.env.HOME .. "/playground/lua-language-server/main.lua"
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        globals = {
          'vim',
        },
      },
      workspace = {
        library = {
          [vim.env['VIMRUNTIME']..'lua'] = true,
          [vim.env['VIMRUNTIME']..'lua/vim/lsp'] = true,
        },
      },
    }
  },
}

nvim_lsp.vimls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.yamlls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

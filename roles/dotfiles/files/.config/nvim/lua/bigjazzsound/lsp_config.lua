local lspconfig = require "lspconfig"
local saga = require "lspsaga"
local luadev = require "lua-dev".setup {
  lspconfig = {
    cmd = require "lspcontainers".command "sumneko_lua",
  },
}

local on_attach = function(client, bufnr)
  saga.init_lsp_saga()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gr", "<CMD>lua vim.lsp.buf.references()<CR>", DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gt", "<CMD>lua vim.lsp.buf.document_symbol()<CR>", DEFAULT_KEYMAP)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dl", "<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>", DEFAULT_KEYMAP)

  -- lspsaga maps
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "K",
    '<CMD>lua require("lspsaga.hover").render_hover_doc()<CR>',
    DEFAULT_KEYMAP
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>lR",
    '<CMD>lua require("lspsaga.rename").rename()<CR>',
    DEFAULT_KEYMAP
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gd",
    '<CMD>lua require("lspsaga.provider").preview_definition()<CR>',
    DEFAULT_KEYMAP
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gs",
    '<CMD>lua require("lspsaga.signaturehelp").signature_help()<CR>',
    DEFAULT_KEYMAP
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "]d",
    [[<CMD>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>]],
    DEFAULT_KEYMAP
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "[d",
    [[<CMD>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>]],
    DEFAULT_KEYMAP
  )

  vim.cmd [[au CursorHold <buffer> lua require('lspsaga.diagnostic').show_line_diagnostics()]]

  if client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<leader>lf",
      '<CMD>lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})<CR>',
      DEFAULT_KEYMAP
    )
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<CMD>lua vim.lsp.buf.formatting()<CR>", DEFAULT_KEYMAP)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_command [[ au CursorHold <buffer> lua vim.lsp.buf.document_highlight() ]]
    vim.api.nvim_command [[ au CursorMoved <buffer> lua vim.lsp.buf.clear_references() ]]
  end

  vim.o.completeopt = "menuone,noselect"
  vim.g.completion_matching_ignore_case = 1
  vim.g.completion_matching_strategy_list = { "exact", "fuzzy", "substring", "all" }
  vim.o.updatetime = 300
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.clangd.setup {
  on_attach = on_attach,
  cmd = {
    "clangd",
    "--clang-tidy",
    "--completion-style=bundled",
    "--header-insertion=iwyu",
    "--suggest-missing-includes",
    "--cross-file-rename",
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  filetypes = {
    "sh",
    "zsh",
  },
}

lspconfig.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = require "lspcontainers".command "gopls",
}

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
      end,
    },
  },
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  cmd = require "lspcontainers".command "rust_analyzer",
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "hcl", "terraform" },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.sumneko_lua.setup(luadev)

lspconfig.vimls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.yamlls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
  cmd = require "lspcontainers".command "yamlls",
  root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        kubernetes = {"*.yml"},
        ["https://json.schemastore.org/ansible-playbook.json"] = {"main.yml"},
      }
    }
  }
}

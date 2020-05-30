local nvim_lsp = require('nvim_lsp')

nvim_lsp.bashls.setup{}
nvim_lsp.dockerls.setup{}
nvim_lsp.gopls.setup{}
nvim_lsp.jsonls.setup{}
nvim_lsp.pyls_ms.setup{
  interpreter = {
    properties = {
      InterpreterPath = "/usr/local/opt/python@3.8/bin/python3",
      Version = "3.8"
    }
  }
}
nvim_lsp.sumneko_lua.setup{}
nvim_lsp.terraformls.setup{}
nvim_lsp.vimls.setup{}
nvim_lsp.yamlls.setup{
  settings = {
    schemas = {
      "http://json.schemastore.org/ansible-stable-2.9",
    }
  }
}

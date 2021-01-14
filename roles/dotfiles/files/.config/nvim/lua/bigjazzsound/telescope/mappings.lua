local map_tele = function(key, f, options, buffer)
  local mode = "n"
  local rhs = string.format(
    "<cmd>lua require('bigjazzsound.telescope')['%s'](%s)<CR>",
    f,
    options and vim.inspect(options, { newline = '' }) or ''
  )
  local options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, options)
  end
end

map_tele('<leader>bl', 'show_all_buffers')
map_tele('<leader>fB', 'builtin')
map_tele('<leader>fC', 'command_history')
map_tele('<leader>fb', 'current_buffer_fuzzy_find')
map_tele('<leader>fc', 'commands')
map_tele('<leader>fd', 'find_dotfiles')
map_tele('<leader>ff', 'fd')
map_tele('<leader>fg', 'live_grep')
map_tele('<leader>fh', 'help_tags')
map_tele('<leader>fl', 'current_buffer_fuzzy_find')
map_tele('<leader>fo', 'oldfiles')
map_tele('<leader>ft', 'filetypes')
map_tele('<leader>la', 'lsp_code_actions')
map_tele('<leader>ld', 'lsp_document_symbols')
map_tele('<leader>lr', 'lsp_references')
map_tele('<leader>lw', 'lsp_workspace_symbols')

return map_tele

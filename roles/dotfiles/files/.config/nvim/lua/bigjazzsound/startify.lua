if vim.fn.executable('figlet') then
  vim.g.startify_custom_header = vim.fn['startify#pad'](
    vim.fn.split(vim.fn.system[[ figlet -f 3D-ASCII "Neovim" ]], '\n')
  )
end

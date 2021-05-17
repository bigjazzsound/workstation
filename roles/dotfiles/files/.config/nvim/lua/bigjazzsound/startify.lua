local result, output = pcall(vim.fn.system, [[figlet -f 3D-ASCII "Neovim"]])
if result then
  vim.g.startify_custom_header = vim.fn["startify#pad"](vim.fn.split(output, "\n"))
end

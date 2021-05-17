local colors = {
  fg = "#282c34",
  bg = "#282c34",
}

require "indent_guides".setup {
  exclude_filetypes = {
    "FTerm",
    "NeogitGitCommandHistory",
    "NeogitStatus",
    "help",
    "packer",
    "startify",
    "toggleterm",
  },
  even_colors = colors,
  odd_colors = colors,
}

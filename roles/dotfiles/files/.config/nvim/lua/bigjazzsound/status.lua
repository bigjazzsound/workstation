local condition = require('galaxyline.condition')
local section = require('galaxyline').section

local colors = {
  fg             = "#ABB2BF",
  bg             = "#1E2127",
  red            = "#E06C75",
  error_red      = "#F44747",
  green          = "#98C379",
  yellow         = "#E5C07B",
  orange         = "#D19A66",
  blue           = "#61AFEF",
  purple         = "#C586C0",
  cyan           = "#56B6C2",
  white          = "#ABB2BF",
  black          = "#1E1E1E",
  line_grey      = "#5C6370",
  gutter_fg_grey = "#4B5263",
  cursor_grey    = "#2C323C",
  visual_grey    = "#3E4452",
  menu_grey      = "#282C34",
  special_grey   = "#3B4048",
  vertsplit      = "#181A1F",
}

local colors = {
  mono_1        = "#abb2bf",
  mono_2        = "#828997",
  mono_3        = "#5c6370",
  mono_4        = "#4b5263",
  hue_1         = "#56b6c2",
  hue_2         = "#61afef",
  hue_3         = "#c678dd",
  hue_4         = "#98c379",
  hue_5         = "#e06c75",
  hue_5_2       = "#be5046",
  hue_6         = "#d19a66",
  hue_6_2       = "#e5c07b",
  syntax_bg     = "#282c34",
  syntax_gutter = "#636d83",
  syntax_cursor = "#2c323c",
  syntax_accent = "#528bff",
  vertsplit     = "#181a1f",
  special_grey  = "#3b4048",
  visual_grey   = "#3e4452",
  pmenu         = "#333841",
  term_black    = "#282c34",
  term_blue     = "#61afef",
  term_cyan     = "#56b6c2",
  term_white    = "#dcdfe4",
  term_8        = "#5d677a",
  syntax_color_added    = "#43d08a",
  syntax_color_modified = "#e0c285",
  syntax_color_removed  = "#e05252",
  red         = "#e88388",
  darkred     = "#e06c75",
  blue        = "#61afef",
  darkblue    = "#528bff",
  green       = "#98c379",
  darkgreen   = "#50a14f",
  orange      = "#d19a66",
  darkorange  = "#c18401",
  yellow      = "#e5c07b",
  darkyellow  = "#986801",
  purple      = "#a626a4",
  violet      = "#b294bb",
  magenta     = "#ff80ff",
  darkmagenta = "#a626a4",
  black       = "#333841",
  grey        = "#636d83",
  white       = "#f2e5bc",
  cyan        = "#8abeb7",
  darkcyan    = "#80a0ff",
  aqua        = "#8ec07c",
}

local min_status = {
  BufNr = {
    provider = function() return '  [' .. vim.api.nvim_get_current_buf() .. '] ' end,
    highlight = { colors.blue, colors.bg, 'bold' },
  },
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg },
  },
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = { colors.magenta, colors.bg, 'bold' }
  },
  WhiteSpace = {
    provider = 'WhiteSpace',
    highlight = { colors.blue, colors.menu_grey },
  }
}

local status = {
  left = {
    {
      BufNr = {
        provider = function() return '  [' .. vim.api.nvim_get_current_buf() .. '] ' end,
        highlight = { colors.blue, colors.bg, 'bold' },
      },
    },
    {
      FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg },
      },
    },
    {
      FileName = {
        provider = 'FileName',
        condition = condition.buffer_not_empty,
        highlight = { colors.magenta, colors.bg, 'bold' }
      },
    },
    {
      WhiteSpace = {
        provider = 'WhiteSpace',
        highlight = { colors.blue, colors.menu_grey },
      },
    },
    {
      DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  E ',
        highlight = { colors.red, colors.menu_grey }
      }
    },
    {
      DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  W ',
        highlight = { colors.yellow, colors.menu_grey },
      }
    },
    {
      DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '  H ',
        highlight = { colors.blue, colors.menu_grey },
      }
    },
    {
      DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  I ',
        highlight = { colors.blue, colors.menu_grey },
      }
    },
    {
      WhiteSpace = {
        provider = 'WhiteSpace',
        highlight = { colors.blue, colors.menu_grey },
      }
    },
  },
  right = {
    {
      DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  +',
        highlight = { colors.green, colors.menu_grey },
      }
    },
    {
      DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' ~',
        highlight = { colors.yellow, colors.menu_grey },
      }
    },
    {
      DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = ' -',
        highlight = { colors.red, colors.menu_grey },
      }
    },
    {
      GitIcon = {
        provider = function() return '   ' end,
        condition = condition.check_git_workspace,
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.blue, colors.bg, 'bold' },
      }
    },
    {
      GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        highlight = { colors.blue, colors.bg, 'bold' },
      }
    },
  },
  short_line_left = {
    {
      BufNr = {
        provider = function() return '  [' .. vim.api.nvim_get_current_buf() .. '] ' end,
        highlight = { colors.blue, colors.bg, 'bold' },
      },
    },
    {
      FileIcon = {
        provider = 'FileIcon',
        condition = condition.buffer_not_empty,
        highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg },
      },
    },
    {
      FileName = {
        provider = 'FileName',
        condition = condition.buffer_not_empty,
        highlight = { colors.magenta, colors.bg, 'bold' }
      },
    },
    {
      WhiteSpace = {
        provider = 'WhiteSpace',
        highlight = { colors.blue, colors.menu_grey },
      },
    },
  }
}

for side, settings in pairs(status) do
  section[side] = settings
end

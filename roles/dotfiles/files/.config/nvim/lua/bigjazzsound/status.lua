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
    highlight = { colors.purple, colors.bg, 'bold' }
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

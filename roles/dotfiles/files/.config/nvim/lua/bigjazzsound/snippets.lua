require "snippets".use_suggested_mappings()

local snippets = require "snippets"
local U = require "snippets.utils"

snippets.snippets = {
  -- TODO
  lua = {
    req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require '$1']],
    func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]],
    ["local"] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}]],
    -- Match the indentation of the current line for newlines.
    ["for"] = U.match_indentation [[
for ${1:i}, ${2:v} in ipairs(${3:t}) do
  $0
end]],
  },

  _global = {},

  sls = {
    ["if"] = [[
{% if $0 %}
{% endif %}]],
    ["for"] = [[
{% for $0 %}
{% endif %}]],
  },

  hcl = {
    ["res"] = [[resource "$1" "$2" {
  $0
}]],
    mod = [[module "$1" {
  source = ""
  $0
}]],
  },
}
